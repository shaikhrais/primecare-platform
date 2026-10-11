"""Verify retirement never removes changed or untracked source."""
import csv
import gzip
import importlib.util
import io
import json
import subprocess
import sys
import tempfile
import unittest
from contextlib import redirect_stdout
from pathlib import Path
from unittest.mock import patch

spec = importlib.util.spec_from_file_location('retirement', Path(__file__).with_name('retire-obsolete-screen-backup.py'))
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


class RetirementTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.root = Path(self.temp.name)
        self.output = self.root / 'docs/inventory'
        self.source = self.root / module.BACKUP / 'screens/example_screen.dart'
        self.source.parent.mkdir(parents=True)
        self.source.write_text("class ExampleScreen {} // /v1/visits\n")
        (self.root / 'live.dart').write_text('class Live {}\n')
        self.run_git('init', '-q')
        self.run_git('add', '.')
        self.run_git('-c', 'user.name=Fixture', '-c', 'user.email=fixture@example.test', 'commit', '-qm', 'fixture')
        self.tree = self.run_git('rev-parse', 'HEAD:' + module.BACKUP)
        self.head = self.run_git('rev-parse', 'HEAD')

    def tearDown(self):
        self.temp.cleanup()

    def run_git(self, *args):
        return subprocess.check_output(['git', *args], cwd=self.root, text=True).strip()

    def retire(self, apply=False, tree=None):
        arguments = ['retire', '--recovery-commit', self.head, '--expected-backup-tree', tree or self.tree]
        if apply:
            arguments.append('--apply')
        with patch.object(module, 'ROOT', self.root), patch.object(module, 'OUTPUT', self.output), patch.object(sys, 'argv', arguments), redirect_stdout(io.StringIO()):
            module.main()

    def test_dry_run_records_source_and_does_not_delete(self):
        self.retire()
        rows = list(csv.DictReader(io.StringIO(gzip.decompress((self.output / 'file-inventory.csv.gz').read_bytes()).decode())))
        record = next(row for row in rows if row['path'].endswith('example_screen.dart'))
        self.assertEqual(record['declarations'], 'ExampleScreen')
        self.assertEqual(record['endpoint_references'], '/v1/visits')
        self.assertEqual(record['recovery_commit'], self.head)
        self.assertTrue(self.source.exists())

    def test_apply_preserves_untracked_backup_and_live_source(self):
        untracked = self.source.with_name('manual.dart')
        untracked.write_text('manual work')
        self.retire(apply=True)
        self.assertFalse(self.source.exists())
        self.assertEqual(untracked.read_text(), 'manual work')
        self.assertTrue((self.root / 'live.dart').exists())
        self.assertTrue(json.loads((self.output / 'summary.json').read_text())['applied'])

    def test_modified_source_refuses_before_deletion(self):
        self.source.write_text('new work')
        with self.assertRaises(ValueError):
            self.retire(apply=True)
        self.assertEqual(self.source.read_text(), 'new work')
        self.assertFalse(self.output.exists())

    def test_wrong_recovery_tree_refuses_before_deletion(self):
        with self.assertRaises(ValueError):
            self.retire(apply=True, tree='0' * 40)
        self.assertTrue(self.source.exists())
        self.assertFalse(self.output.exists())


if __name__ == '__main__':
    unittest.main()
