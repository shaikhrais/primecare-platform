"""Pure startup-log fixtures: no platform guard is changed and no app is executed."""
import importlib.util
import json
import tempfile
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('smoke', Path(__file__).with_name('test-macos-clinic-artifact.py'))
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)


class Diagnostics(unittest.TestCase):
    def diagnostic(self, payload):
        with tempfile.TemporaryDirectory() as temporary:
            path = Path(temporary)/'startup.log'
            path.write_bytes(payload)
            message = m.startup_failure(-4, path)
        self.assertFalse(path.exists())
        self.assertTrue(message.startswith('Application exited during startup: -4\n'))
        return message.split('\n', 1)[1]

    def test_reason_survives_temporary_home_cleanup(self):
        value = json.loads(self.diagnostic(b'runner startup diagnostic\n'))
        self.assertEqual(value['startupLogTail'], 'runner startup diagnostic\n')
        self.assertFalse(value['truncated'])

    def test_large_log_keeps_only_bounded_latest_bytes(self):
        value = json.loads(self.diagnostic(b'x'*20000 + b'end-of-log'))
        self.assertTrue(value['truncated'])
        self.assertEqual(len(value['startupLogTail'].encode()), 8192)
        self.assertTrue(value['startupLogTail'].endswith('end-of-log'))

    def test_invalid_utf8_does_not_mask_process_exit(self):
        self.assertEqual(json.loads(self.diagnostic(b'bad\xffdata'))['startupLogTail'], 'bad\ufffddata')

    def test_child_workflow_command_is_escaped_data(self):
        serialized = self.diagnostic(b'\n::error::child text\n\x00')
        self.assertNotIn('\n', serialized)
        self.assertNotIn('\x00', serialized)
        self.assertEqual(json.loads(serialized)['startupLogTail'], '\n::error::child text\n\x00')

    def test_missing_log_preserves_original_exit(self):
        with tempfile.TemporaryDirectory() as temporary:
            message = m.startup_failure(-4, Path(temporary)/'absent')
        self.assertTrue(message.startswith('Application exited during startup: -4\n'))
        self.assertEqual(json.loads(message.split('\n', 1)[1]), {'startupLogUnavailable': 'FileNotFoundError'})

    def test_empty_log_is_not_invented_crash_evidence(self):
        self.assertEqual(json.loads(self.diagnostic(b'')), {'startupLogTail': '', 'truncated': False})

    def report(self, directory, name='Fixture', pid=42, **extra):
        path = directory / (name + '-2026-11-13.ips')
        report = {'pid': pid, 'procName': name,
                  'exception': {'type': 'EXC_BAD_INSTRUCTION', 'signal': 'SIGILL'},
                  'faultingThread': 0, 'threads': [{'frames': [{'symbol': 'startup_frame'}]}],
                  'environment': {'PRIVATE': 'must-not-appear'}, 'procPath': '/private/fixture'}
        report.update(extra)
        path.write_text(json.dumps({'app_name': name}) + '\n' + json.dumps(report))
        return path

    def test_exact_child_crash_summary_omits_unrelated_fields(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            self.report(root)
            value = m.crash_summary(root, 42, 'Fixture', set())
            self.assertEqual(value, {'type': 'EXC_BAD_INSTRUCTION', 'signal': 'SIGILL',
                                     'symbols': ['startup_frame']})
            self.assertNotIn('must-not-appear', json.dumps(value))

    def test_old_reports_and_other_processes_are_ignored(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            path = self.report(root)
            self.assertIsNone(m.crash_summary(root, 42, 'Fixture', {path.name}))
            self.assertIsNone(m.crash_summary(root, 43, 'Fixture', set()))
            self.assertIsNone(m.crash_summary(root, 42, 'Other', set()))
            self.report(root, procName='Other')
            self.assertIsNone(m.crash_summary(root, 42, 'Fixture', set()))

    def test_malformed_and_oversized_reports_do_not_mask_original_failure(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            path = root / 'Fixture-bad.ips'
            for content in [b'{bad', b'x' * (2 * 1024 * 1024 + 1), b'\xff']:
                path.write_bytes(content)
                self.assertIsNone(m.crash_summary(root, 42, 'Fixture', set()))

    def test_summary_bounds_symbols_and_ignores_malformed_thread_metadata(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            self.report(root, threads=[{'frames': [{'symbol': 'x' * 1000}] * 100}])
            value = m.crash_summary(root, 42, 'Fixture', set())
            self.assertEqual(len(value['symbols']), 12)
            self.assertTrue(all(len(s) == 200 for s in value['symbols']))
            for index in [None, True, -1, 100, '0']:
                self.report(root, faultingThread=index)
                self.assertNotIn('symbols', m.crash_summary(root, 42, 'Fixture', set()))

    def test_symlink_reports_are_not_read(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            path = self.report(root)
            target = root / 'source.txt'
            path.rename(target)
            path.symlink_to(target)
            self.assertIsNone(m.crash_summary(root, 42, 'Fixture', set()))

    def test_crash_summary_preserves_exit_code_and_json_escaping(self):
        with tempfile.TemporaryDirectory() as temporary:
            value = m.startup_failure(-4, Path(temporary) / 'absent', {'symbols': ['\n::error::data']})
            self.assertTrue(value.startswith('Application exited during startup: -4\n'))
            self.assertEqual(len(value.splitlines()), 2)
            self.assertEqual(json.loads(value.split('\n', 1)[1])['crashSummary']['symbols'], ['\n::error::data'])


if __name__ == '__main__': unittest.main()
