"""Generate review-only Flutter MVC scaffolds from source-bound contract metadata.

No database access, route registration, authentication policy or deployment.
Hashes establish input integrity, NOT governance approval or production parity.
"""
import argparse
import hashlib
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[2]
SLOTS = ('businessRequirement', 'role', 'screen', 'sections', 'elements', 'apis',
         'permission', 'theme', 'localization', 'tests', 'documentation')
MARKER = '// Generated review scaffold. NOT IMPLEMENTED; NOT PRODUCTION READY.\n'


def canonical(value):
    return json.dumps(value, sort_keys=True, ensure_ascii=True, allow_nan=False)


def parse_json(raw):
    def unique(pairs):
        result = {}
        for key, value in pairs:
            if key in result:
                raise ValueError('Duplicate JSON key')
            result[key] = value
        return result
    return json.loads(raw, object_pairs_hook=unique,
                      parse_constant=lambda _: (_ for _ in ()).throw(ValueError('Nonfinite JSON')))


def read_json(path):
    return parse_json(path.read_text(encoding='utf-8'))


def safe_path(root, relative):
    if not isinstance(relative, str) or not relative or '\\' in relative:
        raise ValueError('Expected repository-relative path')
    path = Path(relative)
    if path.is_absolute() or any(part in ('.', '..') for part in relative.split('/')):
        raise ValueError('Unsafe repository-relative path')
    result = root / path
    for candidate in (result, *result.parents):
        if candidate == root:
            break
        if candidate.is_symlink():
            raise ValueError('Symlink paths are not supported')
    if not result.resolve().is_relative_to(root.resolve()):
        raise ValueError('Path escapes repository')
    return result


def pointer(document, value):
    if not isinstance(value, str) or not value.startswith('/'):
        raise ValueError('Exact JSON pointer required')
    for part in value[1:].split('/'):
        if re.search(r'~(?![01])', part):
            raise ValueError('Invalid JSON pointer escape')
        part = part.replace('~1', '/').replace('~0', '~')
        if isinstance(document, list):
            if not re.fullmatch(r'0|[1-9][0-9]*', part):
                raise ValueError('Invalid JSON array index')
            document = document[int(part)]
        elif isinstance(document, dict):
            document = document[part]
        else:
            raise ValueError('Unresolved JSON pointer')
    return document


def nonempty(value):
    if isinstance(value, str):
        return bool(value.strip())
    if isinstance(value, list):
        return bool(value) and all(nonempty(x) for x in value)
    if isinstance(value, dict):
        return bool(value) and all(nonempty(x) for x in value.values())
    return value is not None


def validate(root, request):
    if not isinstance(request, dict) or set(request) != {'version', 'source', 'contract'} or type(request['version']) is not int or request['version'] != 1:
        raise ValueError('Expected version 1 source-bound request')
    source = request['source']
    if not isinstance(source, dict) or set(source) != {'path', 'sha256', 'pointer'}:
        raise ValueError('Source needs path, sha256 and pointer')
    path = safe_path(root, source['path'])
    if not path.is_file():
        raise ValueError('Source missing')
    raw = path.read_bytes()
    if hashlib.sha256(raw).hexdigest() != source['sha256']:
        raise ValueError('Source missing or hash mismatch')
    contract = request['contract']
    if canonical(pointer(parse_json(raw.decode('utf-8')), source['pointer'])) != canonical(contract):
        raise ValueError('Contract does not exactly match source metadata')
    if not isinstance(contract, dict) or set(contract) != {'app', 'className', 'route', 'screenCode', 'titleKey', 'semanticsLabel', 'slots'}:
        raise ValueError('Incomplete screen contract identity')
    patterns = {'app': r'primecare_[a-z][a-z0-9_]*', 'className': r'[A-Z][A-Za-z0-9]*',
                'screenCode': r'[a-z][a-z0-9_]*', 'titleKey': r'[A-Za-z][A-Za-z0-9_.]*',
                'semanticsLabel': r'[a-z][a-z0-9]*(?:-[a-z0-9]+)*',
                'route': r'/(?:[A-Za-z0-9_-]+|:[A-Za-z_][A-Za-z0-9_]*)(?:/(?:[A-Za-z0-9_-]+|:[A-Za-z_][A-Za-z0-9_]*))*'}
    for key, pattern in patterns.items():
        if not isinstance(contract[key], str) or not re.fullmatch(pattern, contract[key]):
            raise ValueError('Invalid contract identity: ' + key)
    slots = contract['slots']
    if not isinstance(slots, dict) or set(slots) != set(SLOTS) or not all(isinstance(slots[key], dict) and nonempty(slots[key]) for key in SLOTS):
        raise ValueError('Every required contract metadata slot must be explicit and nonempty')
    # Metadata completeness is a review prerequisite, never an access grant.
    return contract


def render(contract, source):
    name = contract['className']
    snake = re.sub(r'(?<!^)(?=[A-Z])', '_', name).lower()
    base = f'lib/features/{snake}'
    state = MARKER + '''import 'package:primecare_models/primecare_models.dart';

class NAMEState extends BaseScreenState<NAMEState> {
  const NAMEState({super.isLoading, super.errorMessage, super.data});

  @override
  NAMEState rebuild({required bool isLoading, required String? errorMessage,
      required Map<String, dynamic> data}) => NAMEState(
        isLoading: isLoading, errorMessage: errorMessage,
        data: Map<String, dynamic>.unmodifiable(data));
}
'''
    controller = MARKER + '''import 'package:flutter_riverpod/legacy.dart';
import 'SNAKE_state.dart';

// Implement only from the reviewed API contract. No fake asynchronous success.
// The owning application injects a concrete controller through its provider.
abstract class NAMEController extends StateNotifier<NAMEState> {
  NAMEController() : super(const NAMEState());

  Future<void> load();
}
'''
    view = MARKER + '''import 'package:primecare_ui/primecare_ui.dart';
import 'SNAKE_state.dart';

// Abstract until the reviewed components, localization and API mapping exist.
// Existing GovernedConsumerWidget shell, theme and locale behavior is retained.
// This class adds NO authentication or authorization grants.
abstract class NAMEView extends GovernedConsumerWidget {
  const NAMEView({super.key});

  NAMEState watchState(WidgetRef ref);
  Widget buildContent(BuildContext context, WidgetRef ref, NAMEState state);

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) =>
      buildContent(context, ref, watchState(ref));
}
'''
    unit = MARKER + '''import 'package:flutter_test/flutter_test.dart';
import '../lib/features/SNAKE/SNAKE_state.dart';

void main() {
  test('initial state does not claim loaded business data', () {
    const state = NAMEState();
    expect(state.isLoading, isFalse);
    expect(state.errorMessage, isNull);
    expect(state.data, isEmpty);
  });
  test('rebuild explicitly clears errors and snapshots data', () {
    const failed = NAMEState(errorMessage: 'isolated test failure');
    final input = <String, dynamic>{'fixture': true};
    final next = failed.rebuild(isLoading: true, errorMessage: null, data: input);
    input.clear();
    expect(next.errorMessage, isNull);
    expect(next.isLoading, isTrue);
    expect(next.data, {'fixture': true});
    expect(() => next.data.clear(), throwsUnsupportedError);
    expect(failed.errorMessage, 'isolated test failure');
  });
  test('inherited copyWith preserves fields not supplied', () {
    const state = NAMEState(errorMessage: 'isolated test failure');
    expect(state.copyWith(isLoading: true).errorMessage, state.errorMessage);
  });
}
'''
    e2e = MARKER + '''import 'package:flutter_test/flutter_test.dart';

// STARTERS ONLY. Replace each fail with real application navigation and
// assertions, then remove skip. Never use production accounts or databases.
// Route: ROUTE?enable-semantics=true
// Stable Flutter semantics label: LABEL
// Run in the owning app's integration_test harness after route/policy review.
void main() {
  const blocked = 'Requires reviewed route, isolated backend and test identities';
  for (final scenario in <String>[
    'authorized actor sees contracted content',
    'unauthenticated actor cannot open deep link',
    'wrong role cannot access screen or API',
    'other tenant and other owner data stay inaccessible',
    'loading, empty and API error states are truthful',
    'logout, Back and stale requests do not restore protected data',
    'locale and theme changes preserve accessible controls',
  ]) {
    testWidgets('$scenario (starter: $blocked)', (tester) async {
      fail('Implement this scenario against the isolated application harness');
    }, skip: true);
  }
}
'''
    def substitute(text):
        values = {'NAME': name, 'SNAKE': snake, 'ROUTE': contract['route'], 'LABEL': contract['semanticsLabel']}
        return re.sub(r'NAME|SNAKE|ROUTE|LABEL', lambda match: values[match.group()], text)
    artifacts = {f'{base}/{snake}_state.dart': substitute(state),
                 f'{base}/{snake}_controller.dart': substitute(controller),
                 f'{base}/{snake}_view.dart': substitute(view),
                 f'test/{snake}_state_test.dart': substitute(unit),
                 f'integration_test/{snake}_starter_test.dart': substitute(e2e)}
    artifacts['review.json'] = json.dumps({'version': 1, 'source': source, 'contract': contract,
        'status': 'abstract_scaffold_only', 'productionParityVerified': False,
        'routeRegistered': False, 'apiConnected': False, 'authorizationVerified': False,
        'unitTests': 'not_run', 'e2eTests': 'skipped_starters', 'productionReady': False}, indent=2) + '\n'
    return artifacts


def generate(root, request, *, write=False):
    root = root.resolve()
    contract = validate(root, request)
    artifacts = render(contract, request['source'])
    output = safe_path(root, f"scratch/screen-scaffolds/{contract['app']}/{contract['screenCode']}")
    # Never overwrite, including unknown files or an interrupted prior attempt.
    if output.exists():
        raise ValueError('Output already exists; review it instead of overwriting')
    for parent in output.parents:
        if parent == root:
            break
        if parent.exists() and not parent.is_dir():
            raise ValueError('Output parent is not a directory')
    if write:
        output.mkdir(parents=True, exist_ok=False)
        for relative, content in artifacts.items():
            target = output / relative
            target.parent.mkdir(parents=True, exist_ok=True)
            with target.open('x', encoding='utf-8') as stream:
                stream.write(content)
    return output, artifacts


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--request', required=True, help='Repository-relative source-bound JSON request')
    parser.add_argument('--write', action='store_true', help='Write review directory; default only previews paths')
    args = parser.parse_args()
    request = read_json(safe_path(ROOT, args.request))
    output, artifacts = generate(ROOT, request, write=args.write)
    print(json.dumps({'mode': 'written' if args.write else 'preview',
                      'output': str(output.relative_to(ROOT)), 'files': sorted(artifacts),
                      'status': 'abstract_scaffold_only', 'e2e': 'skipped_starters'}))


if __name__ == '__main__':
    main()
