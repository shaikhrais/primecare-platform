"""Offline wrapper regression tests, invoked only by the isolated GitHub lane."""
import contextlib
import builtins
import json
import io
import importlib.util
import os
from pathlib import Path
import sys
import types
import unittest
from unittest.mock import patch

if len(sys.argv) != 1 or os.environ.get('NARROW_READER_ISOLATED_CI') != '1':
    raise SystemExit('Use the isolated GitHub fixture lane')
if any(k.startswith('PG') or k in ('PRODUCTION_DATABASE_URL', 'GOVERNANCE_DATABASE_URL') for k in os.environ):
    raise SystemExit('Refuse database credential environment')
import login_read_once as wrapper

SECRET = 'SYNTHETIC_NEVER_PRINT'
ENV = {'HOME': '/tmp/narrow-reader-home',
       'PRODUCTION_DATABASE_URL': 'postgresql://fixture:' + SECRET + '@pooled.db.prisma.io/postgres'}


class WrapperTests(unittest.TestCase):
    def test_fixed_connection_options_and_no_receipt_data(self):
        db = types.SimpleNamespace(close=lambda: None)
        calls = []
        def connect(**config):
            calls.append(config)
            return db
        with patch.object(wrapper.connection_policy, 'validate_local_configuration'), \
             patch.object(wrapper.candidate, 'read_candidate', return_value={'raw': SECRET}) as read:
            out = wrapper._once(ENV, connect)
        read.assert_called_once_with(db)
        self.assertEqual(out, wrapper.receipt('READ_COMPLETED'))
        self.assertNotIn(SECRET, str(out))
        self.assertEqual(calls[0]['sslmode'], 'verify-full')
        self.assertEqual(calls[0]['passfile'], '/dev/null')
        self.assertEqual(calls[0]['host'], 'pooled.db.prisma.io')
        self.assertEqual(calls[0]['application_name'], 'primecare-login-read-once')
        self.assertNotIn('conninfo', calls[0])

    def test_invalid_config_never_connects(self):
        for env in ({}, dict(ENV, PGHOST='other'), dict(ENV, PRODUCTION_DATABASE_URL=ENV['PRODUCTION_DATABASE_URL']+'?sslmode=disable'),
                    dict(ENV, GOVERNANCE_DATABASE_URL='different')):
            with patch.object(wrapper.connection_policy, 'validate_local_configuration'), \
                 patch.object(wrapper.candidate, 'read_candidate') as read:
                connector = unittest.mock.Mock()
                out = wrapper._once(env, connector)
            self.assertNotEqual(out['status'], 'READ_COMPLETED')
            connector.assert_not_called()
            read.assert_not_called()

    def test_read_failure_closes_and_suppresses_messages(self):
        for error in (RuntimeError(SECRET), wrapper.candidate.Fault('MANIFEST_UNVERIFIED')):
            closed = []
            db = types.SimpleNamespace(close=lambda: closed.append(True))
            stdout, stderr = io.StringIO(), io.StringIO()
            with patch.object(wrapper.connection_policy, 'validate_local_configuration'), \
                 patch.object(wrapper.candidate, 'read_candidate', side_effect=error), \
                 contextlib.redirect_stdout(stdout), contextlib.redirect_stderr(stderr):
                out = wrapper._once(ENV, lambda **_: db)
            self.assertEqual(closed, [True])
            self.assertNotIn(SECRET, str(out)+stdout.getvalue()+stderr.getvalue())
            self.assertNotEqual(out['status'], 'READ_COMPLETED')

    def test_close_failure_does_not_claim_success(self):
        def close(): raise RuntimeError(SECRET)
        db = types.SimpleNamespace(close=close)
        with patch.object(wrapper.connection_policy, 'validate_local_configuration'), \
             patch.object(wrapper.candidate, 'read_candidate', return_value={}):
            self.assertEqual(wrapper._once(ENV, lambda **_: db)['status'], 'CLOSE_UNVERIFIED')

    def test_connector_errors_never_leak(self):
        def connect(**_): raise RuntimeError(SECRET)
        with patch.object(wrapper.connection_policy, 'validate_local_configuration'):
            out = wrapper._once(ENV, connect)
        self.assertEqual(out, wrapper.receipt('CONNECTION_UNVERIFIED'))

    def test_main_serialization_exit_and_alarm_cleanup(self):
        for code, expected in [('READ_COMPLETED', 0), ('READ_DENIED', 1)]:
            stdout = io.StringIO()
            with patch.object(wrapper.sys, 'argv', ['login_read_once.py']), \
                 patch.object(wrapper.signal, 'signal'), patch.object(wrapper.signal, 'alarm') as alarm, \
                 patch.dict(sys.modules, {'psycopg': types.SimpleNamespace(connect=lambda: None)}), \
                 patch.object(wrapper, '_once', return_value=wrapper.receipt(code)), \
                 contextlib.redirect_stdout(stdout):
                self.assertEqual(wrapper.main(), expected)
            self.assertEqual(json.loads(stdout.getvalue()), wrapper.receipt(code))
            self.assertEqual(alarm.call_args_list, [unittest.mock.call(55), unittest.mock.call(0)])

    def test_main_arguments_and_missing_dependency(self):
        stdout = io.StringIO()
        with patch.object(wrapper.sys, 'argv', ['login_read_once.py', 'refused']), \
             contextlib.redirect_stdout(stdout):
            self.assertEqual(wrapper.main(), 1)
        self.assertEqual(json.loads(stdout.getvalue())['status'], 'ARGUMENTS_REFUSED')
        original = builtins.__import__
        def importing(name, *args, **kwargs):
            if name == 'psycopg': raise ImportError(SECRET)
            return original(name, *args, **kwargs)
        stdout = io.StringIO()
        with patch.object(wrapper.sys, 'argv', ['login_read_once.py']), \
             patch.object(wrapper.signal, 'signal'), patch.object(wrapper.signal, 'alarm'), \
             patch('builtins.__import__', side_effect=importing), contextlib.redirect_stdout(stdout):
            self.assertEqual(wrapper.main(), 1)
        self.assertEqual(json.loads(stdout.getvalue()), wrapper.receipt('DEPENDENCY_UNAVAILABLE'))

    def test_main_timeout_receipt_and_grace_handler(self):
        handlers = []
        def register(_, handler): handlers.append(handler)
        def once(*_):
            with self.assertRaises(wrapper.candidate.Fault): handlers[0](None, None)
            return wrapper.receipt('READ_COMPLETED')
        stdout = io.StringIO()
        with patch.object(wrapper.sys, 'argv', ['login_read_once.py']), \
             patch.object(wrapper.signal, 'signal', side_effect=register), \
             patch.object(wrapper.signal, 'alarm') as alarm, \
             patch.dict(sys.modules, {'psycopg': types.SimpleNamespace(connect=lambda: None)}), \
             patch.object(wrapper, '_once', side_effect=once), contextlib.redirect_stdout(stdout):
            self.assertEqual(wrapper.main(), 1)
        self.assertEqual(json.loads(stdout.getvalue()), wrapper.receipt('TOTAL_TIMEOUT'))
        self.assertEqual(alarm.call_args_list, [unittest.mock.call(55), unittest.mock.call(5), unittest.mock.call(0)])
        with patch.object(wrapper.os, 'write') as write, \
             patch.object(wrapper.os, '_exit', side_effect=SystemExit(1)):
            with self.assertRaises(SystemExit): handlers[0](None, None)
        self.assertEqual(json.loads(write.call_args.args[1]), wrapper.receipt('TOTAL_TIMEOUT'))

    def test_real_synthetic_postgres_read_and_close(self):
        spec = importlib.util.spec_from_file_location('candidate_harness',
            Path(__file__).with_name('test-login-production-candidate.py'))
        harness = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(harness)
        setup = harness.CandidateTests()
        setup.setUp()
        try:
            setup.install('mixed')
            opened = []
            def connect(**config):
                # Explicit test seam: no supplied production host/credential used.
                db = harness.harness.connection()
                opened.append(db)
                return db
            def synthetic_read(db):
                return wrapper.candidate._read_snapshot(db, setup.digest)
            with patch.object(wrapper.connection_policy, 'validate_local_configuration'), \
                 patch.object(wrapper.candidate, 'read_candidate', side_effect=synthetic_read):
                out = wrapper._once(ENV, connect)
            self.assertEqual(out, wrapper.receipt('READ_COMPLETED'))
            self.assertEqual(len(opened), 1)
            self.assertTrue(opened[0].closed)
        finally:
            setup.doCleanups()

    def test_local_policy_pin_and_home_checks_are_not_skipped(self):
        connector = unittest.mock.Mock()
        with patch.object(wrapper.connection_policy, 'validate_local_configuration',
                          side_effect=wrapper.connection_policy.Fault('PIN_MISMATCH')) as validate:
            out = wrapper._once(ENV, connector)
        validate.assert_called_once_with(ENV)
        connector.assert_not_called()
        self.assertEqual(out['status'], 'PIN_MISMATCH')


if __name__ == '__main__':
    unittest.main(verbosity=2)
