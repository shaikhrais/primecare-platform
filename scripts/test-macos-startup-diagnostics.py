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


if __name__ == '__main__': unittest.main()
