"""Offline regression tests: no production connections or governance writes."""
import contextlib
import importlib.util
import io
import json
import subprocess
import sys
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

spec = importlib.util.spec_from_file_location('verify_screens', Path(__file__).with_name('verify_screens.py'))
verifier = importlib.util.module_from_spec(spec)
spec.loader.exec_module(verifier)


class ScreenVerificationSafetyTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)

    def row(self, path=None, expected=None):
        return {'id': 1, 'screen_name': 'Example', 'actual_file_path': path, 'expected_file_path': expected}

    def audit(self, rows):
        before = [dict(row) for row in rows]
        result = verifier.audit_sources(rows, self.root)
        self.assertEqual(rows, before)
        self.assertFalse(result['overall_passed'])
        self.assertFalse(result['runtime_verified'])
        self.assertEqual(result['verified_count'], 0)
        self.assertTrue(result['blockers'])
        return result

    def test_missing_and_undefined_paths_fail_without_simulation(self):
        for row in (self.row(), self.row('missing.dart'), self.row(expected='missing.dart')):
            with self.subTest(row=row):
                result = self.audit([row])
                self.assertEqual(len(result['failures']), 1)
                self.assertEqual(result['source_signature_count'], 0)

    def test_valid_source_is_only_a_static_observation(self):
        (self.root / 'screen.dart').write_text('class Example extends Widget { build() {} }')
        result = self.audit([self.row(expected='screen.dart')])
        self.assertEqual(result['source_signature_count'], 1)
        self.assertEqual(result['failures'], [])
        self.assertEqual(result['evidence_kind'], 'static_source_inspection_only')

    def test_simulated_widget_text_never_becomes_runtime_proof(self):
        (self.root / 'fake.dart').write_text('// simulated trace: class Fake Widget build(')
        self.audit([self.row('fake.dart')])

    def test_mixed_results_never_promote_any_row(self):
        (self.root / 'screen.dart').write_text('class Example {}')
        result = self.audit([self.row('screen.dart'), self.row('missing.dart')])
        self.assertEqual(result['source_signature_count'], 1)
        self.assertEqual(len(result['failures']), 1)

    def test_missing_actual_path_is_not_hidden_by_existing_expected_path(self):
        (self.root / 'expected.dart').write_text('class Example {}')
        self.assertEqual(len(self.audit([self.row('missing.dart', 'expected.dart')])['failures']), 1)

    def test_directory_outside_root_invalid_encoding_and_missing_signature_fail(self):
        (self.root / 'invalid.dart').write_bytes(b'\xffclass Widget')
        (self.root / 'empty.dart').write_text('')
        for path in ('.', '../outside.dart', 'invalid.dart', 'empty.dart'):
            with self.subTest(path=path):
                self.assertEqual(len(self.audit([self.row(path)])['failures']), 1)

    def test_symlink_escape_is_rejected_before_reading_source(self):
        project = self.root / 'project'
        project.mkdir()
        outside = self.root / 'outside.dart'
        outside.write_text('class Example extends Widget {}')
        (project / 'screen.dart').symlink_to(outside)
        with patch.object(Path, 'read_text') as read:
            result = verifier.audit_sources([self.row('screen.dart')], project)
            read.assert_not_called()
        self.assertFalse(result['overall_passed'])
        self.assertFalse(result['runtime_verified'])
        self.assertEqual(result['verified_count'], 0)
        self.assertEqual(result['source_signature_count'], 0)
        self.assertEqual(result['failures'][0]['reason'], 'File path is outside the project root')

    def test_cli_exits_nonzero_and_emits_only_failure_evidence(self):
        # Copy only the quarantined command into a disposable project. Never run
        # the legacy command or write its report into the actual checkout.
        scripts = self.root / 'scripts'
        scripts.mkdir()
        command = scripts / 'verify_screens.py'
        command.write_text(Path(verifier.__file__).read_text())
        report = self.root / 'screens_verification_result.json'
        report.write_text('{"overall_passed": true, "verified_count": 999}')
        result = subprocess.run(
            [sys.executable, '-I', str(command)], cwd=self.root,
            capture_output=True, text=True, timeout=10, check=False,
        )
        self.assertEqual(result.returncode, 1)
        self.assertIn('no screens were verified', result.stderr)
        evidence = json.loads(report.read_text())
        self.assertFalse(evidence['overall_passed'])
        self.assertFalse(evidence['runtime_verified'])
        self.assertEqual(evidence['verified_count'], 0)
        self.assertEqual(evidence['total_screens_scanned'], 0)
        self.assertEqual(set(self.root.rglob('*')), {scripts, command, report})

    def test_read_error_fails_closed(self):
        (self.root / 'screen.dart').write_text('class Example {}')
        with patch.object(Path, 'read_text', side_effect=PermissionError('denied')):
            self.assertEqual(len(self.audit([self.row('screen.dart')])['failures']), 1)

    def test_empty_inventory_is_not_success(self):
        self.audit([])

    def test_entrypoint_never_opens_database_and_replaces_stale_success(self):
        report = self.root / 'screens_verification_result.json'
        report.write_text('{"overall_passed": true, "verified_count": 999}')
        with patch.object(verifier, 'PROJECT_ROOT', self.root), patch('sqlite3.connect') as connect:
            with contextlib.redirect_stderr(io.StringIO()):
                self.assertEqual(verifier.main(), 1)
            connect.assert_not_called()
        result = json.loads(report.read_text())
        self.assertFalse(result['overall_passed'])
        self.assertEqual(result['verified_count'], 0)
        self.assertEqual(result['total_screens_scanned'], 0)
        self.assertEqual(list(self.root.iterdir()), [report])

    def test_report_write_failure_still_returns_nonzero(self):
        with patch.object(Path, 'write_text', side_effect=OSError('read only')):
            with contextlib.redirect_stderr(io.StringIO()):
                self.assertEqual(verifier.main(), 1)


if __name__ == '__main__':
    unittest.main()
