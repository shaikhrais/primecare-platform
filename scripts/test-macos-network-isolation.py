"""Rollback and scope guards; actual filtering/startup requires the Mac control job."""
import importlib.util
import unittest
from pathlib import Path
from unittest.mock import patch
from types import SimpleNamespace

spec = importlib.util.spec_from_file_location('network', Path(__file__).with_name('macos-network-isolation.py'))
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)


class Isolation(unittest.TestCase):
    def test_platform_guard_precedes_mutation(self):
        with patch.object(m.sys, 'platform', 'linux'), patch.object(m.NetworkIsolation, 'privileged') as command:
            with self.assertRaises(RuntimeError):
                with m.NetworkIsolation(): pass
            command.assert_not_called()

    def test_cleanup_only_flushes_owned_anchor_and_releases_owned_token(self):
        guard = m.NetworkIsolation()
        guard.created = guard.loaded = True
        guard.token = '12345'
        with patch.object(guard, 'privileged') as command:
            guard.close()
            self.assertEqual([call.args for call in command.call_args_list], [
                ('/sbin/pfctl', '-a', guard.anchor, '-F', 'rules'),
                ('/sbin/pfctl', '-X', '12345'),
                ('/usr/sbin/dseditgroup', '-o', 'delete', guard.group)])
        self.assertFalse(guard.created or guard.loaded or guard.verified)

    def test_cleanup_attempts_every_resource_and_cannot_report_success_on_failure(self):
        guard = m.NetworkIsolation()
        guard.created = guard.loaded = True
        guard.token = '12345'
        with patch.object(guard, 'privileged', side_effect=RuntimeError('fixture cleanup failure')) as command:
            with self.assertRaisesRegex(RuntimeError, 'cleanup failed'):
                guard.close()
            self.assertEqual(command.call_count, 3)

    def test_setup_probe_failure_rolls_back_before_any_app_launch(self):
        guard = m.NetworkIsolation()
        def privileged(*args, **kwargs):
            return SimpleNamespace(stdout='anchor "com.apple/*" all', stderr='')
        with patch.object(m.sys, 'platform', 'darwin'), patch.object(m.os, 'getuid', return_value=501), patch.object(m.grp, 'getgrgid', side_effect=KeyError), patch.object(guard, 'privileged', side_effect=privileged) as command, patch.object(guard, 'verify_probes', side_effect=RuntimeError('fixture probe failure')):
            with self.assertRaisesRegex(RuntimeError, 'probe failure'):
                guard.__enter__()
            self.assertEqual(command.call_args_list[-1].args, ('/usr/sbin/dseditgroup', '-o', 'delete', guard.group))
            self.assertFalse(guard.created)

    def test_remaining_children_prevent_filter_removal(self):
        guard = m.NetworkIsolation()
        guard.created = guard.loaded = True
        guard.gid = 50001
        with patch.object(guard, 'stop_children', side_effect=RuntimeError('fixture child remains')), patch.object(guard, 'privileged') as command:
            with self.assertRaisesRegex(RuntimeError, 'child remains'):
                guard.close()
            command.assert_not_called()
            self.assertTrue(guard.loaded)

    def test_child_enumeration_is_limited_to_its_unique_effective_group(self):
        guard = m.NetworkIsolation()
        guard.created = True
        guard.gid = 50001
        reads = [SimpleNamespace(stdout='101 50001\n202 20\n'), SimpleNamespace(stdout='202 20\n'), SimpleNamespace(stdout='202 20\n'), SimpleNamespace(stdout='202 20\n'), SimpleNamespace(stdout='202 20\n')]
        with patch.object(m.subprocess, 'run', side_effect=reads), patch.object(m.os, 'kill') as kill:
            guard.stop_children()
            kill.assert_called_once_with(101, m.signal.SIGTERM)

    def test_no_group_no_child_command(self):
        with self.assertRaises(RuntimeError):
            m.NetworkIsolation().command(['/fixture/app'], {})


if __name__ == '__main__': unittest.main()
