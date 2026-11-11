"""Synthetic mutations of the observed lifecycle, not a raw reporter replay.

Source: run42519681178 / job128850217482; receipt SHA256
1965ab2707bd37cb6954442ce67defbe505ce61d4ce04287bfb2468d5c360deb.
The receipt retained testStart/testDone/error/done and the exception print.
Other reporter metadata and ordinary prints are absent. Runner checkout paths
are sanitized. Diagnostic wording, stack coordinates and event fields remain.
"""
import copy
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest

spec = importlib.util.spec_from_file_location('oracle', Path(__file__).parents[1] / 'verify_auth_material_baseline.py')
oracle = importlib.util.module_from_spec(spec)
spec.loader.exec_module(oracle)
OBSERVED = [{'test': {'id': 1,
           'name': 'loading '
                   '/fixture/checkout/packages/primecare_ui/test/auth_material_surface_test.dart',
           'suiteID': 0,
           'groupIDs': [],
           'metadata': {'skip': False, 'skipReason': None},
           'line': None,
           'column': None,
           'url': None},
  'type': 'testStart',
  'time': 1},
 {'testID': 1,
  'result': 'success',
  'skipped': False,
  'hidden': True,
  'type': 'testDone',
  'time': 30465},
 {'test': {'id': 3,
           'name': '(setUpAll)',
           'suiteID': 0,
           'groupIDs': [2],
           'metadata': {'skip': False, 'skipReason': None},
           'line': 49,
           'column': 3,
           'url': 'file:///fixture/checkout/packages/primecare_ui/test/auth_material_surface_test.dart'},
  'type': 'testStart',
  'time': 30470},
 {'testID': 3,
  'result': 'success',
  'skipped': False,
  'hidden': True,
  'type': 'testDone',
  'time': 30503},
 {'test': {'id': 4,
           'name': 'login help ink surface en 360.0',
           'suiteID': 0,
           'groupIDs': [2],
           'metadata': {'skip': False, 'skipReason': None},
           'line': 174,
           'column': 5,
           'url': 'package:flutter_test/src/widget_tester.dart',
           'root_line': 56,
           'root_column': 7,
           'root_url': 'file:///fixture/checkout/packages/primecare_ui/test/auth_material_surface_test.dart'},
  'type': 'testStart',
  'time': 30504},
 {'testID': 4,
  'messageType': 'print',
  'message': '══╡ EXCEPTION CAUGHT BY FLUTTER TEST FRAMEWORK '
             '╞════════════════════════════════════════════════════\n'
             'The following TestFailure was thrown running a test:\n'
             'Expected: true\n'
             '  Actual: <false>\n'
             'AUTH_INK_SURFACE: help ink must paint above the opaque auth card\n'
             '\n'
             'When the exception was thrown, this was the stack:\n'
             '#4      expectLocalInkSurface '
             '(file:///fixture/checkout/packages/primecare_ui/test/auth_material_surface_test.dart:33:3)\n'
             '#5      main.<anonymous closure> '
             '(file:///fixture/checkout/packages/primecare_ui/test/auth_material_surface_test.dart:71:9)\n'
             '<asynchronous suspension>\n'
             '#6      testWidgets.<anonymous closure>.<anonymous closure> '
             '(package:flutter_test/src/widget_tester.dart:192:15)\n'
             '<asynchronous suspension>\n'
             '#7      TestWidgetsFlutterBinding._runTestBody '
             '(package:flutter_test/src/binding.dart:1682:5)\n'
             '<asynchronous suspension>\n'
             '<asynchronous suspension>\n'
             '(elided one frame from package:stack_trace)\n'
             '\n'
             'This was caught by the test expectation on the following line:\n'
             '  '
             'file:///fixture/checkout/packages/primecare_ui/test/auth_material_surface_test.dart '
             'line 33\n'
             'The test description was:\n'
             '  login help ink surface en 360.0\n'
             '════════════════════════════════════════════════════════════════════════════════════════════════════',
  'type': 'print',
  'time': 32006},
 {'testID': 4,
  'error': 'Test failed. See exception logs above.\n'
           'The test description was: login help ink surface en 360.0',
  'stackTrace': '',
  'isFailure': False,
  'type': 'error',
  'time': 32010},
 {'testID': 4,
  'result': 'error',
  'skipped': False,
  'hidden': False,
  'type': 'testDone',
  'time': 32014},
 {'test': {'id': 5,
           'name': '(tearDownAll)',
           'suiteID': 0,
           'groupIDs': [2],
           'metadata': {'skip': False, 'skipReason': None},
           'line': None,
           'column': None,
           'url': None},
  'type': 'testStart',
  'time': 32015},
 {'testID': 5,
  'result': 'success',
  'skipped': False,
  'hidden': True,
  'type': 'testDone',
  'time': 32025},
 {'success': False, 'type': 'done', 'time': 32072}]


def encode(events):
    return ('\n'.join(json.dumps(event) for event in events) + '\n').encode()


def item(events, kind, selected=False):
    return next(event for event in events if event['type'] == kind and
                (not selected or event.get('testID', event.get('test', {}).get('id')) == 4))


class OracleTests(unittest.TestCase):
    def reject(self, mutate):
        events = copy.deepcopy(OBSERVED)
        mutate(events)
        with self.assertRaises(ValueError):
            oracle.verify(encode(events))

    def test_observed_reduced_lifecycle_is_accepted(self):
        oracle.verify(encode(OBSERVED))

    def test_test_ids_and_checkout_roots_are_not_hardcoded(self):
        events = copy.deepcopy(OBSERVED)
        for event in events:
            if 'test' in event:
                event['test']['id'] += 20
            if 'testID' in event:
                event['testID'] += 20
        payload = encode(events).replace(b'/fixture/checkout/', b'/another/checkout/')
        oracle.verify(payload)

    def test_additional_ordinary_same_test_print_is_accepted(self):
        events = copy.deepcopy(OBSERVED)
        index = next(i for i, e in enumerate(events) if e['type'] == 'print')
        events.insert(index, {'type': 'print', 'testID': 4, 'messageType': 'print',
                              'message': 'localization initialized', 'time': events[index]['time']})
        oracle.verify(encode(events))

    def test_missing_required_events_are_rejected(self):
        for kind in ('print', 'error', 'done'):
            with self.subTest(kind=kind):
                self.reject(lambda e: e.remove(item(e, kind)))
        self.reject(lambda e: e.remove(item(e, 'testDone', True)))
        with self.assertRaises(ValueError):
            oracle.verify(b'')

    def test_marker_only_wrong_context_stack_and_description_are_rejected(self):
        replacements = [
            ('Expected: true', 'Expected: false'),
            ('Actual: <false>', 'Actual: <true>'),
            ('AUTH_INK_SURFACE:', 'OTHER_ASSERTION:'),
            ('expectLocalInkSurface', 'unrelatedFunction'),
            ('.dart:33:3', '.dart:34:3'),
            ('.dart:71:9', '.dart:72:9'),
            ('dart line 33', 'dart line 34'),
            ('login help ink surface en 360.0', 'different test'),
        ]
        for old, new in replacements:
            with self.subTest(old=old):
                self.reject(lambda e: item(e, 'print').update(message=item(e, 'print')['message'].replace(old, new)))
        self.reject(lambda e: item(e, 'print').update(message='AUTH_INK_SURFACE: help ink must paint above the opaque auth card'))

    def test_foreign_stale_and_malformed_ids_are_rejected(self):
        for kind in ('print', 'error', 'testDone'):
            for identifier in (3, 99, True, '4', None):
                with self.subTest(kind=kind, identifier=identifier):
                    self.reject(lambda e: item(e, kind, kind != 'print').update(testID=identifier))
        self.reject(lambda e: item(e, 'testStart', True)['test'].update(id=3))
        self.reject(lambda e: e.append(copy.deepcopy(item(e, 'print'))))

    def test_extra_errors_prints_failures_and_summaries_are_rejected(self):
        for kind in ('print', 'error', 'done'):
            def duplicate(events):
                original = item(events, kind)
                events.insert(events.index(original) + 1, copy.deepcopy(original))
            with self.subTest(kind=kind):
                self.reject(duplicate)
        self.reject(lambda e: item(e, 'testDone').update(result='error'))
        self.reject(lambda e: item(e, 'error').update(error='Unrelated exception'))
        self.reject(lambda e: item(e, 'error').update(stackTrace='unexpected stack'))
        self.reject(lambda e: item(e, 'error').update(isFailure=True))
        self.reject(lambda e: item(e, 'print').update(messageType='warning'))
        self.reject(lambda e: item(e, 'done').update(success=True))

    def test_skips_wrong_name_and_incomplete_order_are_rejected(self):
        self.reject(lambda e: item(e, 'testStart', True)['test'].update(name='wrong test'))
        self.reject(lambda e: item(e, 'testStart', True)['test']['metadata'].update(skip=True))
        self.reject(lambda e: item(e, 'testDone', True).update(skipped=True))
        self.reject(lambda e: item(e, 'testDone', True).update(hidden=True))
        self.reject(lambda e: item(e, 'testDone', True).update(result='success'))
        self.reject(lambda e: item(e, 'print').update(time=0))
        self.reject(lambda e: e.reverse())

    def test_malformed_json_event_types_and_duplicate_keys_are_rejected(self):
        for payload in (b'{', b'\xff', b'[]\n', b'null\n',
                        b'{"type":"done","type":"done"}\n',
                        b'{"type":[],"time":0}\n'):
            with self.subTest(payload=payload), self.assertRaises(ValueError):
                oracle.verify(payload)
        self.reject(lambda e: item(e, 'print').update(message=[]))
        self.reject(lambda e: item(e, 'print').update(type='unsupported'))
        self.reject(lambda e: item(e, 'done').update(time='later'))

    def test_wrong_error_print_order_is_rejected(self):
        def mutate(events):
            diagnostic = item(events, 'print')
            error = item(events, 'error')
            a, b = events.index(diagnostic), events.index(error)
            diagnostic['time'], error['time'] = error['time'], diagnostic['time']
            events[a], events[b] = error, diagnostic
        self.reject(mutate)

    def test_stderr_is_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            stdout = Path(directory) / 'stdout'
            stderr = Path(directory) / 'stderr'
            stdout.write_bytes(encode(OBSERVED))
            stderr.write_bytes(b'')
            oracle.verify_files(stdout, stderr)
            stderr.write_bytes(b'unrelated runtime warning')
            with self.assertRaises(ValueError):
                oracle.verify_files(stdout, stderr)

    def test_byte_limit_and_bounded_file_reads(self):
        with self.assertRaises(ValueError):
            oracle.verify(b' ' * (oracle.LIMIT + 1))
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'report'
            path.write_bytes(b' ' * (oracle.LIMIT + 1))
            with self.assertRaises(ValueError):
                oracle.read_bounded(path)
            payload = encode(OBSERVED)
            path.write_bytes(payload)
            self.assertEqual(oracle.read_bounded(path), payload)


if __name__ == '__main__':
    unittest.main()
