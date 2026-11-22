import json
import tempfile
import unittest
from pathlib import Path

from tools.package_master.catalog import build, validate


class CatalogTests(unittest.TestCase):
    def fixture(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        root = Path(temporary.name)
        (root / 'packages').mkdir()
        (root / 'services').mkdir()
        return root

    def manifest(self, root, group, identity, data):
        directory = root / group / identity
        directory.mkdir()
        (directory / 'package.json').write_text(json.dumps(data))

    def test_future_package_is_discovered_and_dependency_resolved(self):
        root = self.fixture()
        self.manifest(root, 'packages', 'new_core', {'name': '@primecare/new-core'})
        self.manifest(root, 'services', 'new_service', {
            'name': '@primecare/new-service', 'dependencies': {'@primecare/new-core': '1.0.0'}})
        source = build(root)
        self.assertEqual(len(source['packages']), 2)
        self.assertEqual(source['packages'][1]['dependencies'], ['new_core'])
        self.assertEqual(source['packages'][1]['kind'], 'service')

    def test_missing_workspace_dependency_fails(self):
        root = self.fixture()
        self.manifest(root, 'packages', 'core', {
            'name': '@primecare/core', 'dependencies': {'@primecare/missing': '1.0.0'}})
        with self.assertRaisesRegex(ValueError, 'Unresolved workspace'):
            build(root)

    def test_duplicate_name_fails(self):
        root = self.fixture()
        for identity in ('first', 'second'):
            self.manifest(root, 'packages', identity, {'name': '@primecare/core'})
        with self.assertRaisesRegex(ValueError, 'Duplicate declared name'):
            build(root)

    def test_wrong_dart_path_fails_even_with_matching_name(self):
        root = self.fixture()
        for identity in ('models', 'host'):
            (root / 'packages' / identity).mkdir()
        (root / 'packages/models/pubspec.yaml').write_text('name: models\n')
        (root / 'packages/host/pubspec.yaml').write_text(
            'name: host\ndependencies:\n  models:\n    path: ../missing\n')
        with self.assertRaisesRegex(ValueError, 'Unresolved local'):
            build(root)

    def test_disconnected_cycle_fails(self):
        with self.assertRaisesRegex(ValueError, 'cycle'):
            validate([{'id': 'ok', 'dependencies': []},
                      {'id': 'a', 'dependencies': ['b']},
                      {'id': 'b', 'dependencies': ['a']}])


if __name__ == '__main__':
    unittest.main()
