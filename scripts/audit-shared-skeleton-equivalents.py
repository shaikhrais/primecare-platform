"""Reconcile reviewed shared implementations with historical skeleton proposals.

Source mappings are evidence of available APIs, never runtime acceptance.
"""
import argparse
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
WEB = 'packages/primecare_ui/web/component-catalogue.ts'
NATIVE = 'packages/flutter_core/lib/component_catalogue/prime_component_catalogue.dart'
MAPPINGS = [
 ('core.FuseCountdown', 'countdown(', 'class PrimeCountdown ', 'Absolute deadline; expiry once; disposal'),
 ('core.FuseDialog', 'modal(', 'class PrimeCatalogueModal ', 'Owned modal; confirmation; focus return'),
 ('core.FuseExample', 'preview(', 'Widget preview(', 'Caller-created preview; no dynamic source execution'),
 ('core.FuseHighlight', 'code(', 'class PrimeCodePreview ', 'Literal code tokens and copy; no HTML execution'),
 ('core.FuseLoading', 'state(', 'Widget state(', 'Loading state using active shared theme'),
 ('core.FuseSplashScreen', 'state(', 'Widget state(', 'Splash variant of scoped loading state'),
 ('core.FuseSuspense', 'asyncRegion<', 'class PrimeAsyncBoundary<', 'Scoped asynchronous loading/error/empty/content states'),
]

def render(root=ROOT):
    catalogue = json.loads((root/'packages/primecare_ui/catalogs/developer-catalogue.json').read_text())
    features = {row['id']: row for row in catalogue['features']}
    web, native = (root/WEB).read_text(), (root/NATIVE).read_text()
    assert len({row[0] for row in MAPPINGS}) == len(MAPPINGS), 'Duplicate feature mapping'
    rows = []
    for identity, web_api, native_api, scope in MAPPINGS:
        if identity not in features or web_api not in web or native_api not in native:
            raise ValueError('Shared source mapping drift: '+identity)
        rows.append(f"| `{identity}` | `{web_api}` | `{native_api}` | {scope} |")
    return '\n'.join([
        '# Shared skeleton equivalents: source reconciliation', '',
        'Seven reviewed proposal mappings resolve to existing original PrimeCare web and Flutter APIs. '
        'The historical developer catalogue marks six of these missing because their proposal source lists are empty; '
        'that does not mean these shared implementations are absent. This report adds current API mappings without changing historical proposal hashes or granting acceptance.', '',
        '| Reference capability | Shared web API | Shared Flutter API | Supported subset |',
        '|---|---|---|---|', *rows, '',
        f'Web owner: `{WEB}`. Flutter owner: `{NATIVE}`. Public Flutter entry: `package:primecare_ui/component_catalogue.dart`.', '',
        'Use the existing scoped factory/kit and governed labels. Reuse the existing implementation rather than creating a per-app copy. '
        'Source availability is unverified for current runtime adoption. Each feature still requires its host binding, role/API decisions where applicable, localization/accessibility review and current native/browser acceptance. '
        'Vendor variants and whole-feature parity are not implied. No new registration, grant, route, production activation or ready-screen credit is created.', '',
        'Reproduce: `python3 scripts/audit-shared-skeleton-equivalents.py --check`. '
        'Behavior tests remain in the existing component-catalogue web/native suites.', ''
    ])

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    output = ROOT/'docs/appearance/shared-skeleton-equivalents.md'
    text = render()
    if args.check:
        if not output.exists() or output.read_text() != text:
            raise SystemExit('Shared skeleton equivalent report drift')
    else:
        output.write_text(text)
    print('7 shared source mappings verified; 0 runtime acceptance credits')
