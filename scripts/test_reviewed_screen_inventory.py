#!/usr/bin/env python3
"""Isolated negative cases for the static-review gate; no application execution."""
import copy
import hashlib
import tempfile
import unittest
from pathlib import Path

from check_reviewed_screen_inventory import safe_path, summary, validate


class ReviewedInventoryTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)
        self.file = 'apps/example/lib/example_screen.dart'
        path = self.root / self.file
        path.parent.mkdir(parents=True)
        path.write_text('class ExampleScreen extends StatelessWidget {}\n')
        self.candidates = [dict(file=self.file, **{'class': 'ExampleScreen'}, base='StatelessWidget')]
        self.rows = [dict(file=self.file, class_name='ExampleScreen', base='StatelessWidget',
                          batch='initial', category='unresolved_scaffold_screen', reason='No binding established.',
                          next_action='Resolve exact owner.', evidence=self.file + ':1', declaration='',
                          owner_module='', selected_module_files='')]
        self.manifest = dict(schema_version=1, reviewed_commit='a' * 40, runtime_verified=0,
                             reviewed_candidates=1, total_candidates=1,
                             categories={'unresolved_scaffold_screen': 1}, batches=[dict(batch='initial', entries=1)],
                             source_sha256={self.file: hashlib.sha256(path.read_bytes()).hexdigest()})

    def check(self):
        return validate(self.root, self.rows, self.manifest, self.candidates)

    def test_valid(self):
        self.assertEqual(self.check(), [])

    def test_source_drift(self):
        (self.root / self.file).write_text('// changed\n')
        self.assertTrue(any('Changed reviewed source' in e for e in self.check()))

    def test_missing_source(self):
        (self.root / self.file).unlink()
        self.assertTrue(any('Missing reviewed source' in e for e in self.check()))

    def test_unhashed_evidence(self):
        self.manifest['source_sha256'] = {}
        self.assertTrue(any('Unhashed evidence' in e for e in self.check()))

    def test_duplicate(self):
        self.rows.append(copy.deepcopy(self.rows[0]))
        self.assertTrue(any('Duplicate identity' in e for e in self.check()))

    def test_same_name_wrong_path(self):
        self.candidates[0]['file'] = 'apps/example/lib/other/example_screen.dart'
        self.assertTrue(any('Stale or noncandidate' in e for e in self.check()))

    def test_base_change(self):
        self.candidates[0]['base'] = 'GovernedConsumerWidget'
        self.assertTrue(any('Stale or noncandidate' in e for e in self.check()))

    def test_new_candidate(self):
        self.candidates.append(dict(file='other.dart', **{'class': 'OtherScreen'}, base='StatelessWidget'))
        self.assertTrue(any('Candidate total changed' in e for e in self.check()))

    def test_invalid_line(self):
        self.rows[0]['evidence'] = self.file + ':99'
        self.assertTrue(any('Invalid evidence line' in e for e in self.check()))

    def test_empty_action(self):
        self.rows[0]['next_action'] = ''
        self.assertTrue(any('Missing next_action' in e for e in self.check()))

    def test_category_and_batch_drift(self):
        self.rows[0]['category'] = 'invented'
        self.rows[0]['batch'] = 'invented'
        self.assertIn('Category counts mismatch', self.check())
        self.assertIn('Batch counts mismatch', self.check())

    def test_no_runtime_claim(self):
        self.manifest['runtime_verified'] = 1
        self.assertTrue(any('runtime verification claim' in e for e in self.check()))

    def test_unsafe_path(self):
        for path in ('../secret', '/tmp/secret'):
            with self.assertRaises(ValueError):
                safe_path(self.root, path)

    def test_summary_counts_come_from_rows(self):
        rows = [dict(self.rows[0], category='module_declared_placeholder',
                     content='false_completion_placeholder') for _ in range(3)]
        rows += [dict(self.rows[0], category='owner_module_selects_other_file',
                      content='section_scaffold_with_todo_placeholders')]
        rendered = summary(rows, dict(self.manifest, total_candidates=10))
        self.assertIn('4 / 10 candidate identities', rendered)
        self.assertIn('6 remain unclassified', rendered)
        self.assertIn('3 exact owner-module placeholders', rendered)
        self.assertIn('1 same-name alternatives', rendered)
        self.assertIn('3 unsupported completion-text', rendered)
        self.assertIn('1 scaffolds importing TODO sections', rendered)

    def test_demo_is_separate_from_module_placeholder(self):
        self.rows[0]['category'] = 'demo_scaffold'
        self.rows[0]['binding'] = 'material_app_home_declared_exact'
        self.rows[0]['content'] = 'flutter_counter_demo'
        self.manifest['categories'] = {'demo_scaffold': 1}
        self.assertEqual(self.check(), [])
        rendered = summary(self.rows, self.manifest)
        self.assertIn('| demo_scaffold | 1 |', rendered)
        self.assertIn('0 exact owner-module placeholders', rendered)
        self.assertIn('not a production route', rendered)

    def test_summary_deterministic(self):
        self.assertEqual(summary(self.rows, self.manifest), summary(self.rows, self.manifest))
        self.assertIn('not production dispatch evidence', summary(self.rows, self.manifest))


if __name__ == '__main__':
    unittest.main()
