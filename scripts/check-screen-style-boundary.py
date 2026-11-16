#!/usr/bin/env python3
"""Reject new screen-local appearance and lost Leadership presentation routes.

This complements check-shared-ui-boundary.py. Legacy occurrences are compared per
file against a fixed commit; a later successful push does not bless them. Route
membership here is presentation metadata only, never authorization or readiness.
"""
import argparse
from collections import Counter
from importlib.machinery import SourceFileLoader
import importlib.util
import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BASELINE = 'a75adabc1efdedbc5ed387584cf5b51ad9e41cbc'
WORKSPACE = 'packages/primecare_ui/lib/src/screens/workspace_screen_registrations.dart'
CATALOG = 'packages/primecare_ui/lib/src/screens/screen_manager_catalog.dart'

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
        r'BoxDecoration|ShapeDecoration|BoxShadow|LinearGradient|RadialGradient|SweepGradient)'
        r'\s*(?:\.\s*(?!(?:of|maybeOf|capture|captureAll|resolve)\b)\w+\s*)?\('
        r'|\b(?:TextStyle|TextTheme|ThemeData|ColorScheme|ButtonStyle|BoxDecoration|BoxShadow)'
        r'\s*\.\s*new\b')),
    ('local-font-override', re.compile(
        r'\b(?:GoogleFonts\s*\.\s*\w+|fontFamily(?:Fallback)?|fontPackage|fontFeatures|'
        r'fontVariations|fontSize|fontWeight|fontStyle|letterSpacing|wordSpacing)\s*(?::|\(|=)')),
    ('local-style-composition', re.compile(
        r'\b(?:styleFrom|withOpacity|withAlpha|withRed|withGreen|withBlue|'
        r'Color\s*\.\s*(?:alphaBlend|lerp)|(?:HSVColor|HSLColor)\s*\.\s*from\w+)\s*\(')),
    ('local-design-dimension', re.compile(
        r'\b(?:EdgeInsets(?:Directional)?|BorderRadius(?:Directional)?|Radius)\s*\.\s*'
        r'\w+\s*\([^()]*?(?<![.\w])\d+(?:\.\d+)?(?![.\w])')),
    ('local-theme-alias', re.compile(
        r'\btypedef\s+\w+\s*(?:<[^;=]*>)?\s*=\s*(?:\w+\s*\.\s*)?'
        r'(?:TextStyle|TextTheme|ThemeData|ColorScheme|ButtonStyle|BoxDecoration|BoxShadow)\b')),
]
WEB = [
    ('screen-html-style', re.compile(r'<style(?=[\s>])|\bstyle\s*=\s*["\x27`]', re.I)),
    ('screen-dom-style', re.compile(
        r'\.\s*style\s*(?:\.\s*\w+\s*(?:=|\()|\[|=)|\bsetAttribute\s*\(\s*["\x27]style["\x27]', re.I)),
    ('screen-created-style', re.compile(r'\bcreateElement\s*\(\s*["\x27]style["\x27]|\bnew\s+CSSStyleSheet\s*\(')),
    ('screen-svg-color', re.compile(
        r'\b(?:fill|stroke)\s*=\s*["\x27](?!currentColor\b|none\b|var\()'
        r'(?:#[0-9a-f]{3,8}\b|(?:rgba?|hsla?)\()', re.I)),
]


def kind(path):
    if path.endswith('.dart') and not path.endswith(('.g.dart', '.freezed.dart')):
        if re.match(r'^(?:apps/[^/]+/lib/|packages/primecare_ui/lib/src/(?:screens|features)/)', path):
            return 'dart'
    if path.startswith('websites/typescript/src/'):
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
    for rule, check in DART if k == 'dart' else WEB:
        for match in check.finditer(code):
            line = code.count('\n', 0, match.start()) + 1
            out.append((line, fingerprint(source, code, match.start(), match.end(), match[0], rule)))
    return sorted(out)


def regressions(path, old, new):
    allowance = Counter(key for _, key in findings(path, old))
    incoming = []
    for line, key in findings(path, new):
        if allowance[key]:
            allowance[key] -= 1
        else:
            incoming.append((line, *key[:2]))
    return incoming


def git(root, *args):
    return subprocess.run(['git', '-C', str(root), *args], check=True, stdout=subprocess.PIPE).stdout


def file_at(root, revision, path):
    exists = git(root, 'ls-tree', '-z', revision, '--', path)
    return git(root, 'show', f'{revision}:{path}').decode('utf-8') if exists else ''


def registered_literals(workspace, catalog):
    # Workspace has the central Dart Set of exact paths. Confirm the catalog
    # consumes it so an orphan file can't satisfy the check.
    connectors = boundary.executable_code(catalog)
    routes = set()
    if re.search(r'\.\s*withAdditionalRoutes\s*\(\s*workspaceScreenRegistrations\s*\)', connectors):
        for match in re.finditer(r"(?m)^\s*(['\"])(/[^'\"\n]+)\1\s*,", workspace):
            if boundary.executable_code(workspace[match.start():match.end()]).strip() == ',':
                routes.add(match[2])
    for match in re.finditer(r"\bManagedScreenRegistration\s*\(\s*id\s*:\s*(['\"])(/[^'\"\n]+)\1", catalog):
        if connectors[match.start():].startswith('ManagedScreenRegistration'):
            routes.add(match[2])
    return routes


def run(root, baseline, head):
    changes = git(root, 'diff', '--name-only', '--no-renames', '-z', baseline, head)
    failed = 0
    for raw_path in changes.decode('utf-8').split('\0'):
        if not kind(raw_path):
            continue
        old, new = (file_at(root, rev, raw_path) for rev in (baseline, head))
        for line, rule, symbol in regressions(raw_path, old, new):
            print(f'{raw_path}:{line}: error [{rule}] {symbol}: use the shared presentation library and its design tokens')
            failed += 1
    old_workspace, old_catalog = (file_at(root, baseline, p) for p in (WORKSPACE, CATALOG))
    new_workspace, new_catalog = (file_at(root, head, p) for p in (WORKSPACE, CATALOG))
    old_routes = registered_literals(old_workspace, old_catalog)
    new_routes = registered_literals(new_workspace, new_catalog)
    # Retain the 18 known primary entries. Deeper, generated and pattern-based
    # routes still require the existing parity and runtime tests.
    for role, route in LEADERSHIP_LANDINGS.items():
        if route not in old_routes or route not in new_routes:
            print(f'{CATALOG}: error [screen-manager] {role}: missing presentation registration {route}')
            failed += 1
    print(f'{failed} new screen style/registration violations; baseline {baseline}; {len(LEADERSHIP_LANDINGS)} leadership routes checked')
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
