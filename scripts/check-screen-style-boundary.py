#!/usr/bin/env python3
"""Reject new screen-local appearance and missing dashboard registrations.

This complements check-shared-ui-boundary.py. Legacy occurrences are compared per
file against a fixed commit; a later successful push does not bless them. Route
membership here is presentation metadata only, never authorization or readiness.
"""
import argparse
from collections import Counter
from importlib.machinery import SourceFileLoader
import importlib.util
import json
import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BASELINE = 'a75adabc1efdedbc5ed387584cf5b51ad9e41cbc'
WORKSPACE = 'packages/primecare_ui/lib/src/screens/workspace_screen_registrations.dart'
CATALOG = 'packages/primecare_ui/lib/src/screens/screen_manager_catalog.dart'
MODULE = 'packages/primecare_ui/lib/src/screens/module_screen_registrations.dart'
GENERATED = 'packages/primecare_ui/lib/src/features/auth/generated_managed_routes.g.dart'
WORKER = 'cloudflare/workers/src/workspace-registry.json'
WEB_DISPATCHER = 'websites/typescript/src/managed-routes.ts'
WEB_ENTRY = 'websites/typescript/src/main.ts'
SPECIALISTS = {'/care': ('psw', 'renderPSW'), '/growth': ('growth', 'renderGrowth')}
DASHBOARD_DART = ('packages/flutter_core/lib/dashboard_pages/',
                  'packages/primecare_dashboard_pages/lib/dashboard_pages/',
                  'packages/flutter_core/lib/dashboard_widgets/',
                  'packages/flutter_core/lib/registry/widgets/')
DASHBOARD_WEB = ('websites/typescript/src/', 'packages/shared/src/dashboard-pages/',
                 'packages/shared/src/dashboard-widgets/', 'packages/shared/src/tenant-dashboard/')

# Canonical role workspace destinations already enumerated in Screen Manager at
# BASELINE. These keys mirror the user-approved leadership cohort, not new grants.
CORPORATE = '/offices/corporate/roles/'
LEADERSHIP_LANDINGS = {
    'ceo': CORPORATE + 'ceo/dashboard',
    'coo': CORPORATE + 'coo/dashboard',
    'cfo': CORPORATE + 'cfo/dashboard',
    'cto': CORPORATE + 'cto/dashboard',
    'compliance_manager': CORPORATE + 'compliance_manager/dashboard',
    'governance': '/management/governance-officer-dashboard',
    'head_of_bus_dev': CORPORATE + 'head_of_bus_dev/dashboard',
    'head_of_marketing': CORPORATE + 'head_of_marketing/dashboard',
    'training_director': CORPORATE + 'training_director/dashboard',
    'finance_director': CORPORATE + 'finance_director/dashboard',
    'scrum_master': '/management/scrum-master-dashboard',
    'hr_director': CORPORATE + 'hr_director/dashboard',
    'cx_director': CORPORATE + 'cx_director/dashboard',
    'shareholder': CORPORATE + 'shareholder/dashboard',
    'legal': CORPORATE + 'legal/dashboard',
    'ciso': CORPORATE + 'ciso/dashboard',
    'it_admin': CORPORATE + 'it_admin/dashboard',
    'maintenance': '/maintenance/configuration',
}

loader = SourceFileLoader('shared_ui_boundary', str(Path(__file__).with_name('check-shared-ui-boundary.py')))
spec = importlib.util.spec_from_loader(loader.name, loader)
boundary = importlib.util.module_from_spec(spec)
loader.exec_module(boundary)

DART = [
    ('local-style-constructor', re.compile(
        r'\b(TextStyle|StrutStyle|TextTheme|DefaultTextStyle|Theme|ThemeData|ColorScheme|'
        r'ButtonStyle|InputDecorationTheme|IconThemeData|CupertinoThemeData|'
        r'BoxDecoration|ShapeDecoration|BoxShadow|LinearGradient|RadialGradient|SweepGradient|'
        r'CardTheme(?:Data)?|CheckboxThemeData|ElevatedButtonThemeData|FilledButtonThemeData|'
        r'OutlinedButtonThemeData|TextButtonThemeData|NavigationBarThemeData)'
        r'\s*(?:\.\s*(?!(?:of|maybeOf|capture|captureAll|resolve)\b)\w+\s*)?\('
        r'|\b(?:TextStyle|TextTheme|ThemeData|ColorScheme|ButtonStyle|BoxDecoration|BoxShadow)'
        r'\s*\.\s*new\b')),
    ('local-font-override', re.compile(
        r'\b(?:GoogleFonts\s*\.\s*\w+|fontFamily(?:Fallback)?|fontPackage|fontFeatures|'
        r'fontVariations|fontSize|fontWeight|fontStyle|letterSpacing|wordSpacing)\s*(?::|\(|=)')),
    ('local-style-composition', re.compile(
        r'\b(?:styleFrom|withOpacity|withAlpha|withRed|withGreen|withBlue|'
        r'Color\s*\.\s*(?:alphaBlend|lerp)|(?:HSVColor|HSLColor)\s*\.\s*from\w+)\s*\('
        r'|\bwithValues\s*\((?=\s*(?:alpha|red|green|blue)\s*:)')),
    ('local-design-dimension', re.compile(
        r'\b(?:EdgeInsets(?:Directional)?|BorderRadius(?:Directional)?|Radius)\s*\.\s*'
        r'\w+\s*\([^()]*?(?<![.\w])\d+(?:\.\d+)?(?![.\w])')),
    ('local-theme-alias', re.compile(
        r'\btypedef\s+\w+\s*(?:<[^;=]*>)?\s*=\s*(?:\w+\s*\.\s*)?'
        r'(?:TextStyle|TextTheme|ThemeData|ColorScheme|ButtonStyle|BoxDecoration|BoxShadow)\b')),
]
DART_NATIVE_WRAPPER = re.compile(
    r'\b(ColoredBox|DecoratedBox(?:Transition)?|Ink|InkWell|InkResponse|PhysicalModel|PhysicalShape)'
    r'\s*(?:\.\s*\w+\s*)?\(|'
    r'\b(?:ColoredBox|DecoratedBox(?:Transition)?|Ink|InkWell|InkResponse|PhysicalModel|PhysicalShape)'
    r'\s*\.\s*new\b')
WEB = [
    ('screen-html-style', re.compile(r'<style(?=[\s>])|\bstyle\s*=\s*["\x27`]', re.I)),
    ('screen-jsx-style', re.compile(r'<[A-Za-z][\w.:-]*[^<>;]{0,500}?\bstyle\s*=\s*\{')),
    ('screen-dom-style', re.compile(
        r'\.\s*style\s*(?:\.\s*\w+\s*(?:=|\()|\[|=)|\bsetAttribute\s*\(\s*["\x27]style["\x27]', re.I)),
    ('screen-created-style', re.compile(r'\bcreateElement\s*\(\s*["\x27]style["\x27]|\bnew\s+CSSStyleSheet\s*\(')),
    ('screen-svg-color', re.compile(
        r'\b(?:fill|stroke)\s*=\s*["\x27](?!(?:currentColor|none|inherit)\b|var\()'
        r'(?:#[0-9a-f]{3,8}\b|(?:rgba?|hsla?)\(|[a-z]+(?=["\x27]))', re.I)),
]


def kind(path):
    if path.endswith('.dart') and not path.endswith(('.g.dart', '.freezed.dart')):
        if (re.match(r'^(?:apps/[^/]+/lib/|packages/primecare_ui/lib/src/(?:screens|features)/)', path)
                or path.startswith(DASHBOARD_DART)):
            return 'dart'
    if path.startswith(DASHBOARD_WEB):
        if path == 'websites/typescript/src/styles.css':
            return None  # The central browser stylesheet.
        if path.endswith(('.css', '.scss', '.sass', '.less')):
            return 'web-css'
        if path.endswith(('.ts', '.tsx', '.html', '.mjs', '.jsx', '.js')):
            # Central managed theme token consumption, not screen-owned style.
            if path not in {'websites/typescript/src/theme-center.ts',
                            'websites/typescript/src/theme-library.ts',
                            'websites/typescript/src/theme-manager.ts',
                            'websites/typescript/src/screen-presentation.ts'}:
                return 'web'
    return None


def fingerprint(source, code, start, end, symbol, rule):
    # Capture a complete forbidden call, or a named argument's value, with
    # strings preserved. A grandfathered multiline font/style expression
    # cannot be repurposed by modifying only the value on the next line.
    first_line = source.rfind('\n', 0, start) + 1
    last_line = source.find('\n', end)
    if last_line < 0:
        last_line = len(source)
    if rule == 'screen-html-style' and re.match(r'(?i)style\s*=', symbol):
        # A minified template can be one entire dashboard function line. Match
        # the exact old declaration and its owner tag, not unrelated neighbouring
        # content. Keep the fixed baseline and per-file occurrence count below.
        quote = symbol[-1]
        tag = source.rfind('<', first_line, start)
        if tag >= 0 and re.fullmatch(r'<[A-Za-z][\w:-]*(?:\s+[^<>]*)?\s+', source[tag:start]):
            quoted = re.match(r'(?:\\.|[^\\' + re.escape(quote) + r'])*' + re.escape(quote),
                              source[end:last_line])
            if quoted:
                functions = list(re.finditer(r'\bfunction\s+([\w$]+)\s*\(', source[first_line:tag]))
                owner = functions[-1][1] if functions else ''
                return (rule, re.sub(r'\s+', ' ', symbol),
                        owner + ':' + source[tag:end + quoted.end()])
    token = symbol.rstrip()[-1:]
    if token in ('(', ':', '='):
        pending = ['('] if token == '(' else []
        pairs = {')': '(', ']': '[', '}': '{'}
        for offset in range(end, len(code)):
            ch = code[offset]
            if ch in '([{':
                pending.append(ch)
            elif ch in ')]}':
                if not pending or pending[-1] != pairs[ch]:
                    last_line = max(last_line, offset)
                    break
                pending.pop()
                if token == '(' and not pending:
                    last_line = max(last_line, offset + 1)
                    break
            elif ch in ',;' and not pending:
                last_line = max(last_line, offset)
                break
    return (rule, re.sub(r'\s+', ' ', symbol),
            re.sub(r'\s+', ' ', source[first_line:last_line].strip()))


def findings(path, source):
    k = kind(path)
    if k is None or not source:
        return []
    if k == 'web-css':
        # No noncentral stylesheet may be added or expanded. Whitespace-only
        # movement is harmless; no parser guessing about safe-looking selectors.
        return [(line, ('screen-stylesheet', 'local stylesheet', text.strip()))
                for line, text in enumerate(source.splitlines(), 1) if text.strip()]
    code = boundary.executable_code(source) if k == 'dart' else re.sub(
        r'/\*[\s\S]*?\*/|<!--[^<>]*?-->', lambda m: re.sub(r'[^\n]', ' ', m[0]), source)
    out = []
    rules = WEB
    if k == 'dart':
        rules = (DART if path.startswith('packages/primecare_ui/lib/') else
                 [*DART, ('direct-presentation-control', DART_NATIVE_WRAPPER)])
    for rule, check in rules:
        for match in check.finditer(code):
            line = code.count('\n', 0, match.start()) + 1
            out.append((line, fingerprint(source, code, match.start(), match.end(), match[0], rule)))
    return sorted(out)


def compare_findings(path, old, new):
    allowance = Counter(key for _, key in findings(path, old))
    incoming, retained = [], []
    for line, key in findings(path, new):
        if allowance[key]:
            allowance[key] -= 1
            retained.append((line, *key[:2]))
        else:
            incoming.append((line, *key[:2]))
    return incoming, retained


def regressions(path, old, new):
    return compare_findings(path, old, new)[0]


def git(root, *args):
    return subprocess.run(['git', '-C', str(root), *args], check=True, stdout=subprocess.PIPE).stdout


def file_at(root, revision, path):
    exists = git(root, 'ls-tree', '-z', revision, '--', path)
    return git(root, 'show', f'{revision}:{path}').decode('utf-8') if exists else ''


def registered_literals(workspace, catalog, module='', generated=''):
    connectors = boundary.executable_code(catalog)
    constructor = re.search(r'\bScreenManager\s*\(', connectors)
    if not constructor:
        return set()
    start = constructor.start()
    stop = connectors.find(';', start)
    stop = len(connectors) if stop < 0 else stop
    operation = connectors[start:stop]
    routes = set()
    for symbol, source in (('workspaceScreenRegistrations', workspace),
                           ('moduleScreenRegistrations', module),
                           ('generatedManagedScreenRoutes', generated)):
        if not re.search(r'\.\s*withAdditionalRoutes\s*\(\s*' + symbol + r'\s*\)', operation):
            continue
        executable = boundary.executable_code(source)
        literal_set = re.search(r'\bconst\s+' + symbol + r'\s*=\s*<\s*String\s*>\s*\{', executable)
        if not literal_set:
            continue
        offset = literal_set.end()
        close = executable.find('}', offset)
        if close < 0:
            continue
        for match in re.finditer(r"(['\"])(/[^'\"\s]+)\1\s*,", source[offset:close]):
            if executable[offset + match.start():offset + match.end()].strip() == ',':
                routes.add(match[2])
    for match in re.finditer(r"\bManagedScreenRegistration\s*\(\s*id\s*:\s*(['\"])(/[^'\"\n]+)\1",
                             catalog[start:stop]):
        if operation[match.start():].startswith('ManagedScreenRegistration'):
            routes.add(match[2])
    return routes


def dashboard_paths(registry):
    screens = json.loads(registry).get('screens')
    if not isinstance(screens, list):
        raise ValueError('Expected screens array in Worker workspace registry')
    result = set()
    for row in screens:
        if not isinstance(row, dict) or row.get('renderer') != 'dashboard':
            continue
        route = row.get('route')
        if not isinstance(route, str) or not re.fullmatch(r'/(?!/)[^?#\s]*', route):
            raise ValueError(f'Invalid Worker dashboard path for {row.get("code")!r}')
        result.add(route)
    if not result:
        raise ValueError('No dashboard renderers found in Worker workspace registry')
    return result


def managed_specialists(dispatcher, entry):
    # No arbitrary raw path string is sufficient: use exact dispatcher mappings
    # inside their actual map and require the existing Screen Manager bootstrap.
    dispatch_code = boundary.executable_code(dispatcher)
    table = re.search(r'\bconst\s+exact\s*:[^;]*?=\s*Object\.freeze\s*\(\s*\{', dispatch_code)
    boot = re.search(r'(?m)^loadManifest\(\)\.then\(', entry)
    if not table or not boot or not re.search(r'\badapter\s*=\s*exact\s*\[\s*path\s*\]', dispatch_code):
        return set()
    table_end = dispatch_code.find('}', table.end())
    if table_end < 0:
        return set()
    entry = entry[boot.start():]
    active = boundary.executable_code(entry)
    resolve = re.search(r'\bconst\s+route\s*=\s*resolveManagedRoute\s*\(\s*location\.pathname\s*,[^;]+;', active)
    mount = re.search(r"\bmanager\.registerScope\s*\(\s*['\"]entry['\"]\s*,\s*\[\s*route\s*\]\s*\)", entry)
    present = re.search(r'\bmanager\.present\s*\(\s*route\.id\s*,\s*route\.route\s*,\s*async\s*\(\s*\)\s*=>\s*\{', active)
    if not (resolve and mount and present and resolve.end() < mount.start() < mount.end() < present.start()
            and active[mount.start():].startswith('manager.registerScope')):
        return set()
    switch = re.search(r'\bswitch\s*\(\s*route\.adapter\s*\)\s*\{', active[present.end():])
    if not switch:
        return set()
    switch_start = present.end() + switch.end()
    switch_end = active.find('}', switch_start)
    if switch_end < 0:
        return set()
    result = set()
    for route, (adapter, implementation) in SPECIALISTS.items():
        row = re.search(r"(['\"])" + re.escape(route) + r"\1\s*:\s*(['\"])" + adapter + r"\2",
                        dispatcher[table.end():table_end])
        if not row or dispatch_code[table.end() + row.start():table.end() + row.end()].strip() != ':':
            continue
        arm = re.search(r"\bcase\s+(['\"])" + adapter + r"\1\s*:\s*return\s+"
                        + implementation + r'\s*\(', entry[switch_start:switch_end])
        if arm and active[switch_start + arm.start():].startswith('case'):
            result.add(route)
    return result


def run(root, baseline, head):
    changes = git(root, 'diff', '--name-only', '--no-renames', '-z', baseline, head)
    failed = retained_total = 0
    for raw_path in changes.decode('utf-8').split('\0'):
        if not kind(raw_path):
            continue
        old, new = (file_at(root, rev, raw_path) for rev in (baseline, head))
        incoming, retained = compare_findings(raw_path, old, new)
        for line, rule, symbol in incoming:
            print(f'{raw_path}:{line}: error [{rule}] {symbol}: use the shared presentation library and its design tokens')
            failed += 1
        for line, rule, symbol in retained:
            print(f'{raw_path}:{line}: warning [{rule}] {symbol}: existing style remains; migrate to shared UI')
            retained_total += 1
    old_workspace, old_catalog = (file_at(root, baseline, p) for p in (WORKSPACE, CATALOG))
    old_routes = registered_literals(old_workspace, old_catalog)
    new_routes = registered_literals(*(file_at(root, head, p) for p in (WORKSPACE, CATALOG, MODULE, GENERATED)))
    # Retain the 18 known primary entries. Deeper, generated and pattern-based
    # routes still require the existing parity and runtime tests.
    for role, route in LEADERSHIP_LANDINGS.items():
        if route not in old_routes or route not in new_routes:
            print(f'{CATALOG}: error [screen-manager] {role}: missing presentation registration {route}')
            failed += 1
    dashboards = dashboard_paths(file_at(root, head, WORKER))
    specialists = dashboards.intersection(SPECIALISTS)
    native = dashboards - specialists
    web = managed_specialists(*(file_at(root, head, p) for p in (WEB_DISPATCHER, WEB_ENTRY)))
    for path in sorted(native - new_routes):
        print(f'{CATALOG}: error [dashboard-screen-manager] missing native declaration: {path}')
        failed += 1
    for path in sorted(specialists - web):
        print(f'{WEB_ENTRY}: error [dashboard-screen-manager] missing managed specialist entry: {path}')
        failed += 1
    print(f'{failed} new screen style/registration violations; '
          f'{retained_total} legacy style findings in changed sources; baseline {baseline}; '
          f'{len(LEADERSHIP_LANDINGS)} leadership anchors, {len(native)} native dashboard declarations, '
          f'{len(specialists)} specialist web dashboards checked')
    return bool(failed)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=ROOT)
    parser.add_argument('--baseline', default=BASELINE)
    parser.add_argument('--head', default='HEAD')
    parser.add_argument('--baseline-ref', action='store_true', help='Print the fixed legacy comparison commit')
    args = parser.parse_args()
    if args.baseline_ref:
        print(BASELINE)
        return False
    return run(args.root, args.baseline, args.head)


if __name__ == '__main__':
    raise SystemExit(main())
