"""Pure producer/consumer fixtures; no native application is executed here."""
import importlib.util
import importlib.abc
import io
import json
import plistlib
import hashlib
from types import SimpleNamespace
import os
import tarfile
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

spec = importlib.util.spec_from_file_location('apple', Path(__file__).with_name('test-apple-build-artifacts.py'))
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
OLD, IOS, NEW = 43328101727, 43328101736, 43349642502
LATEST_MAC = 43493359962
LATEST_MAC_SOURCE = '723dd19b0d6a1cab4a0342686880c61ec6db2cd0'
LATEST_IOS = 43456846629
LATEST_IOS_SOURCE = 'a41163b1da96015c05618b30a68d0af6c1929471'
CURRENT_IOS = 43442916442
CURRENT_IOS_SOURCE = 'a94e222694c2875e0864e561905e7e4552a49107'
BLUEPRINT = 43377825284
BLUEPRINT_SOURCE = 'ab9ce22d10c8d947be437b584f4f9a73a48e1db6'
BLUEPRINT_APP = 'primecare_enterprise_blueprint'
BLUEPRINT_ARTIFACT = 14016450032
APP = 'primecare_clinic'
NEW_SOURCE = '89273fca8fd30463a8b4c80f66106b8693601fa2'


def artifact(run):
    platform = 'ios' if run in (IOS, BLUEPRINT, CURRENT_IOS, LATEST_IOS) else 'macos'
    return {'id': BLUEPRINT_ARTIFACT if run == BLUEPRINT else run + 100,
            'name': 'ios-blueprint-unsigned-' + BLUEPRINT_SOURCE if run == BLUEPRINT else f'{platform}-build-{APP}', 'expired': False,
            'size_in_bytes': 1, 'workflow_run': {'id': run,
            'head_sha': LATEST_MAC_SOURCE if run == LATEST_MAC else LATEST_IOS_SOURCE if run == LATEST_IOS else CURRENT_IOS_SOURCE if run == CURRENT_IOS else BLUEPRINT_SOURCE if run == BLUEPRINT else NEW_SOURCE if run == NEW else m.SOURCE,
            'head_branch': 'main', 'repository_id': 7, 'head_repository_id': 7}}


def api(path):
    run = int(path.split('/')[2])
    platform = 'ios' if run in (IOS, BLUEPRINT, CURRENT_IOS, LATEST_IOS) else 'macos'
    if '/artifacts?' in path:
        return {'total_count': 1, 'artifacts': [artifact(run)]}
    if '/jobs?' in path:
        return {'total_count': 1, 'jobs': [{'name': 'unsigned_blueprint' if run == BLUEPRINT else f'build_{platform} ({APP})',
                                         'status': 'completed', 'conclusion': 'success'}]}
    return {'head_sha': LATEST_MAC_SOURCE if run == LATEST_MAC else LATEST_IOS_SOURCE if run == LATEST_IOS else CURRENT_IOS_SOURCE if run == CURRENT_IOS else BLUEPRINT_SOURCE if run == BLUEPRINT else NEW_SOURCE if run == NEW else m.SOURCE, 'head_branch': 'main',
            'path': '.github/workflows/ios-blueprint-diagnostic.yml' if run == BLUEPRINT else f'.github/workflows/build_{platform}.yml',
            'repository': {'full_name': m.REPOSITORY}, 'head_repository': {'full_name': m.REPOSITORY}}


class Scope(unittest.TestCase):
    def inventory(self, selected=''):
        with tempfile.TemporaryDirectory() as temporary:
            previous = Path.cwd()
            try:
                os.chdir(temporary)
                with patch.dict(os.environ, {'BUILD_RUN_ID': selected, 'GITHUB_OUTPUT': str(Path(temporary)/'output')}), patch.object(m, 'api', side_effect=api):
                    with patch('sys.stdout', new=io.StringIO()):
                        m.discover()
                report = json.loads(Path('apple-artifact-coverage.json').read_text())
                matrix = json.loads(Path('output').read_text().splitlines()[0].removeprefix('matrix='))['include']
                return report, matrix
            finally:
                os.chdir(previous)

    def test_new_producer_is_inventoried_without_relabeling_historical_sources(self):
        report, matrix = self.inventory()
        self.assertEqual(len(report['coverage']), 55)
        self.assertEqual(len(matrix), 7)
        self.assertEqual({item['run'] for item in matrix}, {OLD, IOS, NEW, BLUEPRINT, CURRENT_IOS, LATEST_IOS, LATEST_MAC})
        self.assertEqual(next(item for item in matrix if item['run'] == NEW)['source'], NEW_SOURCE)
        self.assertEqual(next(item for item in matrix if item['run'] == OLD)['source'], m.SOURCE)
        self.assertFalse(report['runtimeAcceptance'])

    def test_completed_producer_selection_does_not_schedule_old_artifacts(self):
        report, matrix = self.inventory(str(NEW))
        self.assertEqual(len(report['coverage']), 55)
        self.assertEqual([item['run'] for item in matrix], [NEW])
        self.assertEqual(report['artifactTestsScheduled'], 1)
        self.assertEqual(sum(row['build'] == 'missing' for row in report['coverage']), 48)

    def test_completed_nine_app_ios_producer_remains_exactly_scoped(self):
        report, matrix = self.inventory(str(CURRENT_IOS))
        self.assertEqual(len(matrix), 1)
        self.assertEqual(matrix[0]['run'], CURRENT_IOS)
        self.assertEqual(matrix[0]['source'], CURRENT_IOS_SOURCE)
        self.assertEqual(matrix[0]['platform'], 'ios')
        self.assertEqual(matrix[0]['runner'], 'ubuntu-24.04')
        self.assertFalse(report['runtimeAcceptance'])
        m.validate(artifact(CURRENT_IOS), 'ios', APP, CURRENT_IOS)
        wrong = artifact(CURRENT_IOS)
        wrong['workflow_run']['head_sha'] = m.SOURCE
        with self.assertRaises(ValueError): m.validate(wrong, 'ios', APP, CURRENT_IOS)

    def test_all_nine_current_ios_artifacts_are_scheduled_once(self):
        def nine_api(path):
            if f'/{CURRENT_IOS}/artifacts?' in path:
                rows = []
                for index, app in enumerate(m.APPS):
                    row = artifact(CURRENT_IOS)
                    row.update(id=CURRENT_IOS + index, name=f'ios-build-{app}')
                    rows.append(row)
                return {'total_count': len(rows), 'artifacts': rows}
            if f'/{CURRENT_IOS}/jobs?' in path:
                return {'total_count': len(m.APPS), 'jobs': [
                    {'name': f'build_ios ({app})', 'status': 'completed', 'conclusion': 'success'}
                    for app in m.APPS]}
            return api(path)
        with tempfile.TemporaryDirectory() as temporary:
            previous = Path.cwd()
            try:
                os.chdir(temporary)
                with patch.dict(os.environ, {'BUILD_RUN_ID': str(CURRENT_IOS), 'GITHUB_OUTPUT': str(Path(temporary)/'output')}), patch.object(m, 'api', side_effect=nine_api), patch('sys.stdout', new=io.StringIO()):
                    m.discover()
                matrix = json.loads(Path('output').read_text().splitlines()[0].removeprefix('matrix='))['include']
                self.assertEqual(len(matrix), 9)
                self.assertEqual({row['app'] for row in matrix}, set(m.APPS))
                self.assertTrue(all(row['run'] == CURRENT_IOS and row['source'] == CURRENT_IOS_SOURCE for row in matrix))
            finally:
                os.chdir(previous)

    def test_all_nine_preserved_mac_artifacts_are_scheduled_once(self):
        def nine_api(path):
            if f'/{LATEST_MAC}/artifacts?' in path:
                rows = []
                for index, app in enumerate(m.APPS):
                    row = artifact(LATEST_MAC)
                    row.update(id=LATEST_MAC + index, name=f'macos-build-{app}')
                    rows.append(row)
                return {'total_count': len(rows), 'artifacts': rows}
            if f'/{LATEST_MAC}/jobs?' in path:
                return {'total_count': len(m.APPS), 'jobs': [
                    {'name': f'build_macos ({app})', 'status': 'completed', 'conclusion': 'success'}
                    for app in m.APPS]}
            return api(path)
        with tempfile.TemporaryDirectory() as temporary:
            previous = Path.cwd()
            try:
                os.chdir(temporary)
                with patch.dict(os.environ, {'BUILD_RUN_ID': str(LATEST_MAC), 'GITHUB_OUTPUT': str(Path(temporary)/'output')}), patch.object(m, 'api', side_effect=nine_api), patch('sys.stdout', new=io.StringIO()):
                    m.discover()
                matrix = json.loads(Path('output').read_text().splitlines()[0].removeprefix('matrix='))['include']
                self.assertEqual(len(matrix), 9)
                self.assertEqual({row['app'] for row in matrix}, set(m.APPS))
                self.assertTrue(all(row['run'] == LATEST_MAC and row['source'] == LATEST_MAC_SOURCE and row['archiveFormat'] == 'tar' and row['runner'] == 'macos-26-intel' for row in matrix))
            finally:
                os.chdir(previous)

    def test_unknown_producer_selection_fails_before_api(self):
        with patch.dict(os.environ, {'BUILD_RUN_ID': '123'}), patch.object(m, 'api') as request:
            with self.assertRaises(ValueError): m.discover()
            request.assert_not_called()

    def test_each_source_rejects_cross_source_and_expired_metadata(self):
        for run in (OLD, IOS, NEW, LATEST_MAC):
            platform = 'ios' if run in (IOS, BLUEPRINT, CURRENT_IOS, LATEST_IOS) else 'macos'
            m.validate(artifact(run), platform, APP, run)
            for field, value in [('head_sha', '0'*40), ('id', 123)]:
                wrong = artifact(run); wrong['workflow_run'][field] = value
                with self.assertRaises(ValueError): m.validate(wrong, platform, APP, run)
            wrong = artifact(run); wrong['expired'] = True
            with self.assertRaises(ValueError): m.validate(wrong, platform, APP, run)

    def test_matrix_format_and_scope_cannot_be_switched(self):
        item = {**m.BUILDS[NEW], 'run': NEW, 'app': APP, 'id': 100}
        m.matrix_scope(item)
        for key, value in [('archiveFormat', 'raw'), ('source', m.SOURCE), ('platform', 'ios'), ('run', OLD), ('id', True), ('app', '../escape')]:
            with self.assertRaises(ValueError): m.matrix_scope({**item, key: value})

    def test_downloaded_tar_reaches_unchanged_strict_launcher_and_propagates_failure(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            archive = root/f'macos-{APP}.tar'
            with tarfile.open(archive, 'w') as output:
                binary = tarfile.TarInfo('Fixture.app/Contents/MacOS/fixture'); binary.mode = 0o755; binary.size = 1
                output.addfile(binary, io.BytesIO(b'x'))
                alias = tarfile.TarInfo('Fixture.app/alias'); alias.type = tarfile.SYMTYPE; alias.linkname = 'Contents/MacOS/fixture'; output.addfile(alias)
            seen = []
            class Loader(importlib.abc.Loader):
                def create_module(self, spec): return None
                def exec_module(self, module):
                    def launch(restored):
                        seen.append((module.SOURCE, module.ARTIFACT))
                        self_case.assertTrue((restored/'Fixture.app/alias').is_symlink())
                        self_case.assertEqual((restored/'Fixture.app/alias').read_bytes(), b'x')
                        self_case.assertEqual((restored/'Fixture.app/Contents/MacOS/fixture').stat().st_mode & 0o777, 0o755)
                        raise ValueError('strict signature fixture rejection')
                    module.launch = launch
            self_case = self
            original = importlib.util.spec_from_file_location
            def spec_for(name, path):
                return importlib.util.spec_from_loader(name, Loader()) if name == 'clinic_smoke' else original(name, path)
            item = {**m.BUILDS[NEW], 'app': APP, 'id': 100, 'run': NEW}
            with patch.object(importlib.util, 'spec_from_file_location', side_effect=spec_for):
                with self.assertRaisesRegex(ValueError, 'strict signature fixture rejection'): m.inspect(item, root)
            self.assertEqual(seen, [(NEW_SOURCE, 100)])


    def test_built_and_downloaded_ios_bundles_share_the_same_inspector(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root/'Info.plist').write_bytes(plistlib.dumps({'CFBundlePackageType': 'APPL',
                'CFBundleSupportedPlatforms': ['iPhoneOS'], 'CFBundleExecutable': 'Runner',
                'CFBundleIdentifier': 'com.primecare.fixture'}))
            (root/'Runner').write_bytes(b'fixture-device-binary')
            with patch.object(m.subprocess, 'run', return_value=SimpleNamespace(stdout='Mach-O 64-bit executable arm64')) as file_check:
                built = m.inspect_ios_bundle(root, APP, m.SOURCE)
                item = {**m.BUILDS[IOS], 'app': APP, 'run': IOS, 'id': 123}
                output = io.StringIO()
                with patch('sys.stdout', new=output): m.inspect(item, root)
                downloaded = json.loads(output.getvalue())
                self.assertEqual({**built, 'artifact': 123}, downloaded)
                self.assertEqual(built['executableSha256'], hashlib.sha256(b'fixture-device-binary').hexdigest())
                self.assertFalse(built['runtimeLaunchTested'])
                self.assertTrue(built['deviceSigningRequired'])
                self.assertEqual(file_check.call_count, 2)

    def test_built_ios_identity_and_metadata_fail_before_binary_probe(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            valid = {'CFBundlePackageType': 'APPL', 'CFBundleSupportedPlatforms': ['iPhoneOS'],
                     'CFBundleExecutable': 'Runner', 'CFBundleIdentifier': 'com.primecare.fixture'}
            (root/'Runner').write_bytes(b'fixture')
            with patch.object(m.subprocess, 'run') as file_check:
                for app, source in [('invented', m.SOURCE), (APP, 'not-a-source')]:
                    with self.assertRaises(ValueError): m.inspect_ios_bundle(root, app, source)
                for field, value in [('CFBundlePackageType', 'FMWK'), ('CFBundleSupportedPlatforms', ['iPhoneSimulator']),
                                     ('CFBundleExecutable', '../escape'), ('CFBundleIdentifier', '')]:
                    (root/'Info.plist').write_bytes(plistlib.dumps({**valid, field: value}))
                    with self.assertRaises(ValueError): m.inspect_ios_bundle(root, APP, m.SOURCE)
                file_check.assert_not_called()

    def test_built_ios_binary_must_remain_arm64_macho(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root/'Info.plist').write_bytes(plistlib.dumps({'CFBundlePackageType': 'APPL',
                'CFBundleSupportedPlatforms': ['iPhoneOS'], 'CFBundleExecutable': 'Runner',
                'CFBundleIdentifier': 'com.primecare.fixture'}))
            (root/'Runner').write_bytes(b'fixture')
            for output in ['ELF 64-bit', 'Mach-O executable x86_64']:
                with patch.object(m.subprocess, 'run', return_value=SimpleNamespace(stdout=output)):
                    with self.assertRaises(ValueError): m.inspect_ios_bundle(root, APP, m.SOURCE)


    def test_reviewed_blueprint_schedules_only_its_single_app(self):
        report, matrix = self.inventory(str(BLUEPRINT))
        self.assertEqual(len(report['coverage']), 55)
        self.assertEqual(len(matrix), 1)
        self.assertEqual(matrix[0]['app'], BLUEPRINT_APP)
        self.assertEqual(matrix[0]['source'], BLUEPRINT_SOURCE)
        self.assertEqual(matrix[0]['id'], BLUEPRINT_ARTIFACT)
        self.assertEqual(matrix[0]['runner'], 'ubuntu-24.04')
        self.assertEqual(report['artifactTestsScheduled'], 1)

    def test_reviewed_blueprint_identity_cannot_be_retargeted(self):
        m.validate(artifact(BLUEPRINT), 'ios', BLUEPRINT_APP, BLUEPRINT)
        for key, value in [('id', 999), ('name', 'ios-build-' + BLUEPRINT_APP)]:
            wrong = artifact(BLUEPRINT); wrong[key] = value
            with self.assertRaises(ValueError): m.validate(wrong, 'ios', BLUEPRINT_APP, BLUEPRINT)
        with self.assertRaises(ValueError): m.validate(artifact(BLUEPRINT), 'ios', APP, BLUEPRINT)
        item = {**m.BUILDS[BLUEPRINT], 'run': BLUEPRINT, 'id': BLUEPRINT_ARTIFACT}
        for key, value in [('id', 999), ('app', APP), ('executableSha256', '0'*64)]:
            with self.assertRaises(ValueError): m.matrix_scope({**item, key: value})

    def test_downloaded_blueprint_binary_must_match_reviewed_builder_digest(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root/'Info.plist').write_bytes(plistlib.dumps({'CFBundlePackageType': 'APPL',
                'CFBundleSupportedPlatforms': ['iPhoneOS'], 'CFBundleExecutable': 'Runner',
                'CFBundleIdentifier': 'com.primecare.fixture'}))
            (root/'Runner').write_bytes(b'fixture-binary')
            item = {**m.BUILDS[BLUEPRINT], 'run': BLUEPRINT, 'id': BLUEPRINT_ARTIFACT}
            with patch.object(m.subprocess, 'run', return_value=SimpleNamespace(stdout='Mach-O 64-bit arm64')):
                with self.assertRaisesRegex(ValueError, 'differs from reviewed builder digest'): m.inspect(item, root)
                digest = SimpleNamespace(hexdigest=lambda: m.BUILDS[BLUEPRINT]['executableSha256'])
                output = io.StringIO()
                with patch.object(m.hashlib, 'file_digest', return_value=digest), patch('sys.stdout', new=output): m.inspect(item, root)
                result = json.loads(output.getvalue())
                self.assertEqual(result['executableSha256'], m.BUILDS[BLUEPRINT]['executableSha256'])
                self.assertFalse(result['runtimeLaunchTested'])
                self.assertTrue(result['deviceSigningRequired'])



    def test_latest_nine_ios_artifacts_use_only_the_exact_completed_producer(self):
        def latest_api(path):
            if f'/{LATEST_IOS}/artifacts?' in path:
                rows = []
                for index, app in enumerate(m.APPS):
                    row = artifact(LATEST_IOS)
                    row.update(id=LATEST_IOS + index, name=f'ios-build-{app}')
                    rows.append(row)
                return {'total_count': len(rows), 'artifacts': rows}
            if f'/{LATEST_IOS}/jobs?' in path:
                return {'total_count': len(m.APPS), 'jobs': [
                    {'name': f'build_ios ({app})', 'status': 'completed', 'conclusion': 'success'}
                    for app in m.APPS]}
            return api(path)
        with tempfile.TemporaryDirectory() as temporary:
            previous = Path.cwd()
            try:
                os.chdir(temporary)
                with patch.dict(os.environ, {'BUILD_RUN_ID': str(LATEST_IOS), 'GITHUB_OUTPUT': str(Path(temporary)/'output')}), patch.object(m, 'api', side_effect=latest_api), patch('sys.stdout', new=io.StringIO()):
                    m.discover()
                matrix = json.loads(Path('output').read_text().splitlines()[0].removeprefix('matrix='))['include']
                self.assertEqual(len(matrix), 9)
                self.assertEqual({row['app'] for row in matrix}, set(m.APPS))
                self.assertTrue(all(row['run'] == LATEST_IOS and row['source'] == LATEST_IOS_SOURCE and row['runner'] == 'ubuntu-24.04' for row in matrix))
                self.assertFalse(json.loads(Path('apple-artifact-coverage.json').read_text())['runtimeAcceptance'])
            finally:
                os.chdir(previous)
        m.validate(artifact(LATEST_IOS), 'ios', APP, LATEST_IOS)
        wrong = artifact(LATEST_IOS)
        wrong['workflow_run']['head_sha'] = CURRENT_IOS_SOURCE
        with self.assertRaises(ValueError): m.validate(wrong, 'ios', APP, LATEST_IOS)
        wrong = artifact(LATEST_IOS)
        wrong['workflow_run']['head_repository_id'] = 8
        with self.assertRaises(ValueError): m.validate(wrong, 'ios', APP, LATEST_IOS)
        with self.assertRaises(ValueError): m.matrix_scope({**matrix[0], 'source': CURRENT_IOS_SOURCE})

if __name__ == '__main__': unittest.main()

