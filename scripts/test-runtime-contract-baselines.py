#!/usr/bin/env python3
"""Exact migration/auth baseline checks, including rejection of arbitrary drift."""
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch
import refactor_runtime_contracts as contracts


class RuntimeContractBaselines(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.historical = contracts.render_migration()
        cls.expected = contracts.render()

    def test_all_files_remain_checked_with_only_two_auth_evolutions(self):
        self.assertEqual(len(self.expected), 29)
        self.assertEqual(self.expected.keys(), self.historical.keys())
        changed = {p for p in self.expected if self.expected[p] != self.historical[p]}
        self.assertEqual(changed, set(contracts.AUTH_FILES))
        contracts.check_files(self.expected)

    def test_baselines_are_immutable_and_manifest_records_them(self):
        for source in [contracts.SOURCE, contracts.AUTH_SOURCE]:
            self.assertRegex(source, r'^[a-f0-9]{40}$')
        manifest = json.loads(contracts.MANIFEST.read_text())
        self.assertEqual(manifest['sourceCommit'], contracts.SOURCE)
        self.assertEqual(manifest['authEvolutionSourceCommit'], contracts.AUTH_SOURCE)
        self.assertEqual(manifest['authEvolutionFiles'], list(contracts.AUTH_FILES))
        self.assertEqual(manifest['files'], list(self.expected))

    def test_mutation_of_every_checked_file_is_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            for path, content in self.expected.items():
                target = root / path
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_text(content)
            with patch.object(contracts, 'ROOT', root):
                contracts.check_files(self.expected)
                for path, content in self.expected.items():
                    with self.subTest(path=path):
                        (root / path).write_text(content + '// unreviewed drift\n')
                        with self.assertRaisesRegex(AssertionError, path):
                            contracts.check_files(self.expected)
                        (root / path).write_text(content)

    def test_historical_auth_rollback_is_rejected(self):
        for path in contracts.AUTH_FILES:
            with self.subTest(path=path), tempfile.TemporaryDirectory() as directory:
                root = Path(directory)
                target = root / path
                target.parent.mkdir(parents=True)
                target.write_text(self.historical[path])
                with patch.object(contracts, 'ROOT', root):
                    with self.assertRaisesRegex(AssertionError, path):
                        contracts.check_files({path: self.expected[path]})

    def test_missing_pinned_git_content_fails_closed(self):
        with patch.object(contracts, 'render_migration', return_value=dict(self.historical)):
            with patch.object(contracts.subprocess, 'check_output', side_effect=RuntimeError('missing pinned object')):
                with self.assertRaisesRegex(RuntimeError, 'missing pinned object'):
                    contracts.render()


if __name__ == '__main__':
    unittest.main()
