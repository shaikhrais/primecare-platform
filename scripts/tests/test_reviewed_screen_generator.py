"""Isolated generator tests. Flutter checks run only in GitHub Actions."""
import copy
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[2]
SPEC = importlib.util.spec_from_file_location('reviewed_screen_generator', ROOT / 'tools/mvc_generator/generate_reviewed_screen.py')
GEN = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(GEN)


def fixture(root):
    # Synthetic metadata is permitted ONLY in this temporary test fixture.
    contract = {'app': 'primecare_fixture', 'className': 'FixtureScreen',
                'route': '/fixture/screen', 'screenCode': 'fixture_screen',
                'titleKey': 'fixture.screen.title', 'semanticsLabel': 'fixture-screen',
                'slots': {key: {'fixtureOnly': 'isolated test metadata'} for key in GEN.SLOTS}}
    source = root / 'fixture.json'
    source.write_text(json.dumps({'screens': [contract]}), encoding='utf-8')
    return {'version': 1, 'source': {'path': 'fixture.json',
            'sha256': hashlib.sha256(source.read_bytes()).hexdigest(), 'pointer': '/screens/0'},
            'contract': contract}


class ReviewedScreenGeneratorTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.request = fixture(self.root)

    def sync_source(self):
        path = self.root / 'fixture.json'
        path.write_text(json.dumps({'screens': [self.request['contract']]}))
        self.request['source']['sha256'] = hashlib.sha256(path.read_bytes()).hexdigest()

    def test_preview_is_deterministic_and_writes_nothing(self):
        first = GEN.generate(self.root, self.request)
        self.assertEqual(first, GEN.generate(self.root, self.request))
        self.assertFalse((self.root / 'scratch').exists())
        self.assertEqual(len(first[1]), 6)

    def test_writes_only_review_scaffold_and_refuses_overwrite(self):
        output, artifacts = GEN.generate(self.root, self.request, write=True)
        self.assertEqual({p.relative_to(output).as_posix(): p.read_text() for p in output.rglob('*') if p.is_file()}, artifacts)
        self.assertFalse((self.root / 'apps').exists())
        self.assertFalse((self.root / 'packages').exists())
        with self.assertRaises(ValueError):
            GEN.generate(self.root, self.request, write=True)
        self.assertIn('extends BaseScreenState<FixtureScreenState>', artifacts['lib/features/fixture_screen/fixture_screen_state.dart'])
        self.assertIn('extends GovernedConsumerWidget', artifacts['lib/features/fixture_screen/fixture_screen_view.dart'])
        self.assertIn('abstract class FixtureScreenController', artifacts['lib/features/fixture_screen/fixture_screen_controller.dart'])
        self.assertIn('skip: true', artifacts['integration_test/fixture_screen_starter_test.dart'])
        self.assertIn('starter: $blocked', artifacts['integration_test/fixture_screen_starter_test.dart'])
        self.assertIn('fail(', artifacts['integration_test/fixture_screen_starter_test.dart'])
        self.assertNotIn('Future.delayed', ''.join(artifacts.values()))

    def test_source_hash_and_exact_metadata_required(self):
        for change in ('hash', 'value', 'pointer'):
            with self.subTest(change=change):
                request = copy.deepcopy(self.request)
                if change == 'hash': request['source']['sha256'] = '0' * 64
                if change == 'value': request['contract']['route'] = '/unregistered'
                if change == 'pointer': request['source']['pointer'] = '/screens/01'
                with self.assertRaises((ValueError, KeyError, IndexError)):
                    GEN.generate(self.root, request, write=True)
                self.assertFalse((self.root / 'scratch').exists())

    def test_every_slot_required(self):
        for key in GEN.SLOTS:
            with self.subTest(slot=key):
                self.request = fixture(self.root)
                self.request['contract']['slots'][key] = ''
                self.sync_source()
                with self.assertRaises(ValueError): GEN.generate(self.root, self.request)

    def test_rejects_unsafe_or_incomplete_identity(self):
        for key, value in [('app', '../outside'), ('className', 'X\nclass Evil'),
                           ('route', "/bad'quote"), ('titleKey', '${injected}'),
                           ('semanticsLabel', 'bad label'), ('screenCode', '../bad')]:
            with self.subTest(key=key):
                self.request = fixture(self.root)
                self.request['contract'][key] = value
                self.sync_source()
                with self.assertRaises(ValueError): GEN.generate(self.root, self.request)
        self.request = fixture(self.root)
        self.request['version'] = True
        with self.assertRaises(ValueError): GEN.generate(self.root, self.request)

    def test_rejects_source_escape_and_output_symlink(self):
        for path in ('../fixture.json', '/fixture.json', 'a/../fixture.json'):
            request = copy.deepcopy(self.request)
            request['source']['path'] = path
            with self.assertRaises(ValueError): GEN.generate(self.root, request)
        (self.root / 'scratch').symlink_to(self.root, target_is_directory=True)
        with self.assertRaises(ValueError): GEN.generate(self.root, self.request, write=True)

    def test_duplicate_json_keys_rejected(self):
        path = self.root / 'duplicate.json'
        path.write_text('{"version": 1, "version": 2}')
        with self.assertRaises(ValueError): GEN.read_json(path)

    def test_inserted_values_are_not_reinterpreted_as_template_tokens(self):
        for name in ('ROUTE', 'LABEL', 'SNAKE', 'NAME', 'MyROUTEView'):
            with self.subTest(name=name):
                self.request = fixture(self.root)
                self.request['contract']['className'] = name
                self.request['contract']['route'] = '/fixture/LABEL'
                self.sync_source()
                _, artifacts = GEN.generate(self.root, self.request)
                states = [v for k, v in artifacts.items() if k.endswith('_state.dart')]
                self.assertIn(f'class {name}State extends BaseScreenState<{name}State>', states[0])
                e2e = next(v for k, v in artifacts.items() if k.startswith('integration_test/'))
                self.assertIn('/fixture/LABEL?enable-semantics=true', e2e)

    @unittest.skipUnless(os.environ.get('GITHUB_ACTIONS') == 'true',
                         'Generated Dart compilation and tests run in GitHub Actions only')
    def test_generated_dart_analyzes_and_unit_tests_execute(self):
        self.assertTrue(shutil.which('flutter'), 'Flutter SDK is required in GitHub Actions')
        output, _ = GEN.generate(self.root, self.request, write=True)
        (output / 'pubspec.yaml').write_text(
            'name: generated_screen_fixture\npublish_to: none\n'
            'environment:\n  sdk: ^3.11.3\n'
            'dependencies:\n  flutter:\n    sdk: flutter\n'
            f'  primecare_ui:\n    path: {ROOT / "packages/primecare_ui"}\n'
            f'  primecare_models:\n    path: {ROOT / "packages/primecare_models"}\n'
            '  flutter_riverpod: ^3.3.1\n'
            'dev_dependencies:\n  flutter_test:\n    sdk: flutter\n')
        for command in (['flutter', 'pub', 'get'],
                        ['dart', 'format', 'lib', 'test', 'integration_test'],
                        ['flutter', 'analyze', '--no-fatal-infos', 'lib', 'test', 'integration_test'],
                        ['flutter', 'test', 'test']):
            result = subprocess.run(command, cwd=output, text=True, capture_output=True, timeout=600)
            print('Generated fixture command:', ' '.join(command), flush=True)
            print(result.stdout, flush=True)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        # E2E starters are analyzed, not counted as executed integration tests.


if __name__ == '__main__':
    unittest.main()
