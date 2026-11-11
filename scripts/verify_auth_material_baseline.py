"""Fail-closed oracle for the stable Flutter auth Material baseline only."""
import json
import re
import sys
from pathlib import Path

LIMIT = 2 * 1024 * 1024
NAME = 'login help ink surface en 360.0'
SOURCE = '/packages/primecare_ui/test/auth_material_surface_test.dart'
WRAPPER = 'Test failed. See exception logs above.\nThe test description was: ' + NAME
# Captured from GitHub run42519681178, testID4. Only checkout root varies.
EXPECTED_DIAGNOSTIC = '══╡ EXCEPTION CAUGHT BY FLUTTER TEST FRAMEWORK ╞════════════════════════════════════════════════════\nThe following TestFailure was thrown running a test:\nExpected: true\n  Actual: <false>\nAUTH_INK_SURFACE: help ink must paint above the opaque auth card\n\nWhen the exception was thrown, this was the stack:\n#4      expectLocalInkSurface (file:///fixture/checkout/packages/primecare_ui/test/auth_material_surface_test.dart:33:3)\n#5      main.<anonymous closure> (file:///fixture/checkout/packages/primecare_ui/test/auth_material_surface_test.dart:71:9)\n<asynchronous suspension>\n#6      testWidgets.<anonymous closure>.<anonymous closure> (package:flutter_test/src/widget_tester.dart:192:15)\n<asynchronous suspension>\n#7      TestWidgetsFlutterBinding._runTestBody (package:flutter_test/src/binding.dart:1682:5)\n<asynchronous suspension>\n<asynchronous suspension>\n(elided one frame from package:stack_trace)\n\nThis was caught by the test expectation on the following line:\n  file:///fixture/checkout/packages/primecare_ui/test/auth_material_surface_test.dart line 33\nThe test description was:\n  login help ink surface en 360.0\n════════════════════════════════════════════════════════════════════════════════════════════════════'


def require(condition, message):
    if not condition:
        raise ValueError(message)


def normalize(message):
    return re.sub(r'file:///[^\s()]+/packages/primecare_ui/test/auth_material_surface_test\.dart',
                  'file://<checkout>' + SOURCE, message)


def unique_object(pairs):
    result = {}
    for key, value in pairs:
        require(key not in result, 'Duplicate JSON key')
        result[key] = value
    return result


def verify(payload):
    require(isinstance(payload, bytes) and len(payload) <= LIMIT, 'Report exceeds byte limit')
    try:
        events = [json.loads(line, object_pairs_hook=unique_object)
                  for line in payload.decode('utf-8').splitlines() if line.strip()]
    except (UnicodeError, json.JSONDecodeError, RecursionError) as error:
        raise ValueError('Malformed report') from error
    require(events, 'Empty report')
    states = {}
    active = None
    phase = 0
    diagnostic = False
    error_seen = False
    completed = False
    last_time = -1
    allowed = {'start', 'suite', 'group', 'allSuites', 'debug', 'testStart',
               'print', 'error', 'testDone', 'done'}
    for event in events:
        require(type(event) is dict and type(event.get('type')) is str and
                event['type'] in allowed, 'Malformed event/type')
        require(not completed, 'Events after completion')
        timestamp = event.get('time')
        require(type(timestamp) is int and timestamp >= last_time, 'Invalid event time')
        last_time = timestamp
        kind = event['type']
        if kind == 'testStart':
            require(active is None and phase < 4, 'Overlapping/additional test')
            test = event.get('test')
            require(type(test) is dict, 'Missing test')
            identifier = test.get('id')
            require(type(identifier) is int and identifier >= 0 and identifier not in states,
                    'Invalid/duplicate test ID')
            metadata = test.get('metadata')
            require(type(metadata) is dict and metadata.get('skip') is False and
                    metadata.get('skipReason') is None, 'Skipped test')
            name = test.get('name')
            if phase == 0:
                require(isinstance(name, str) and name.startswith('loading /') and
                        name.endswith(SOURCE), 'Wrong loading test')
            else:
                require(name == ('(setUpAll)', NAME, '(tearDownAll)')[phase - 1],
                        'Wrong selected test/lifecycle order')
            states[identifier] = phase
            active = identifier
        elif kind in ('print', 'error', 'testDone'):
            identifier = event.get('testID')
            require(type(identifier) is int and identifier == active and identifier in states,
                    'Foreign/stale test ID')
            if kind == 'print':
                require(event.get('messageType') == 'print' and
                        isinstance(event.get('message'), str), 'Malformed print')
                message = event['message']
                suspicious = any(token in message.lower() for token in
                                 ('exception', 'testfailure', 'auth_ink_surface', 'expected:', 'actual:'))
                if suspicious:
                    require(phase == 2 and not diagnostic and not error_seen and
                            normalize(message) == normalize(EXPECTED_DIAGNOSTIC),
                            'Wrong assertion context/stack or extra diagnostic')
                    diagnostic = True
            elif kind == 'error':
                require(phase == 2 and diagnostic and not error_seen and
                        event.get('error') == WRAPPER and event.get('stackTrace') == '' and
                        event.get('isFailure') is False, 'Unexpected/additional error')
                error_seen = True
            else:
                require(event.get('skipped') is False and
                        event.get('hidden') is (phase != 2), 'Skipped/hidden result')
                if phase == 2:
                    require(diagnostic and error_seen and event.get('result') == 'error',
                            'Missing exact baseline failure')
                else:
                    require(event.get('result') == 'success', 'Lifecycle failure')
                active = None
                phase += 1
        elif kind == 'done':
            require(phase == 4 and active is None and diagnostic and error_seen and
                    event.get('success') is False, 'Incomplete/wrong completion')
            completed = True
        else:
            require('testID' not in event, 'Unrecognized test-scoped event')
    require(completed and phase == 4, 'Missing complete baseline result')


def read_bounded(path):
    path = Path(path)
    require(path.stat().st_size <= LIMIT, 'Report exceeds byte limit')
    with path.open('rb') as stream:
        payload = stream.read(LIMIT + 1)
    require(len(payload) <= LIMIT, 'Report exceeds byte limit')
    return payload


def verify_files(stdout_path, stderr_path):
    require(read_bounded(stderr_path) == b'', 'Unexpected baseline stderr')
    verify(read_bounded(stdout_path))


def main():
    require(len(sys.argv) == 3, 'Expected stdout and stderr paths')
    verify_files(sys.argv[1], sys.argv[2])
    print('Baseline failed only the actual help-tile ink-surface assertion.')


if __name__ == '__main__':
    main()
