"""Pure producer/consumer fixtures; no native application is executed here."""
import importlib.util
import importlib.abc
import io
import json
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
APP = 'primecare_clinic'
NEW_SOURCE = '89273fca8fd30463a8b4c80f66106b8693601fa2'


def artifact(run):
    platform = 'ios' if run == IOS else 'macos'
    return {'id': run + 100, 'name': f'{platform}-build-{APP}', 'expired': False,
            'size_in_bytes': 1, 'workflow_run': {'id': run,
            'head_sha': NEW_SOURCE if run == NEW else m.SOURCE,
            'head_branch': 'main', 'repository_id': 7, 'head_repository_id': 7}}


def api(path):
    run = int(path.split('/')[2])
    platform = 'ios' if run == IOS else 'macos'
    if '/artifacts?' in path:
        return {'total_count': 1, 'artifacts': [artifact(run)]}
    if '/jobs?' in path:
        return {'total_count': 1, 'jobs': [{'name': f'build_{platform} ({APP})',
                                         'status': 'completed', 'conclusion': 'success'}]}
    return {'head_sha': NEW_SOURCE if run == NEW else m.SOURCE, 'head_branch': 'main',
            'path': f'.github/workflows/build_{platform}.yml',
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
        self.assertEqual(len(report['coverage']), 27)
        self.assertEqual(len(matrix), 3)
        self.assertEqual({item['run'] for item in matrix}, {OLD, IOS, NEW})
        self.assertEqual(next(item for item in matrix if item['run'] == NEW)['source'], NEW_SOURCE)
        self.assertEqual(next(item for item in matrix if item['run'] == OLD)['source'], m.SOURCE)
        self.assertFalse(report['runtimeAcceptance'])

    def test_completed_producer_selection_does_not_schedule_old_artifacts(self):
        report, matrix = self.inventory(str(NEW))
        self.assertEqual(len(report['coverage']), 27)
        self.assertEqual([item['run'] for item in matrix], [NEW])
        self.assertEqual(report['artifactTestsScheduled'], 1)
        self.assertEqual(sum(row['build'] == 'missing' for row in report['coverage']), 24)

    def test_unknown_producer_selection_fails_before_api(self):
        with patch.dict(os.environ, {'BUILD_RUN_ID': '123'}), patch.object(m, 'api') as request:
            with self.assertRaises(ValueError): m.discover()
            request.assert_not_called()

    def test_each_source_rejects_cross_source_and_expired_metadata(self):
        for run in (OLD, IOS, NEW):
            platform = 'ios' if run == IOS else 'macos'
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


if __name__ == '__main__': unittest.main()
