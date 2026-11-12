"""Reconcile existing shared public APIs without changing proposal/runtime evidence."""
import argparse
import importlib.util
import json
from pathlib import Path
import re
import posixpath

ROOT = Path(__file__).resolve().parents[1]
MAPPINGS = json.loads(Path(__file__).with_name('shared-skeleton-equivalents.json').read_text())
spec=importlib.util.spec_from_file_location('boundary',Path(__file__).with_name('check-shared-ui-boundary.py'))
boundary=importlib.util.module_from_spec(spec);spec.loader.exec_module(boundary)


def source(root, filename):
    if not isinstance(filename,str) or not filename:
        raise ValueError('Invalid shared mapping source path')
    path=Path(filename)
    if path.is_absolute() or '..' in path.parts or path.as_posix()!=filename:
        raise ValueError('Invalid shared mapping source path')
    file=root/path
    if file.is_symlink() or not file.resolve().is_relative_to(root.resolve()) or not file.is_file():
        raise ValueError('Shared mapping source missing or escapes repository: '+filename)
    return file.read_text()


def public_api(root, evidence, platform='native'):
    if not isinstance(evidence,dict) or set(evidence)!={'path','api','entry','exports'}:
        raise ValueError('Invalid shared API evidence')
    if not isinstance(evidence['api'],str) or not evidence['api'].strip():
        raise ValueError('Missing shared API declaration')
    prefix='packages/primecare_ui/web/' if platform=='web' else 'packages/primecare_ui/lib/'
    if not isinstance(evidence['entry'],str) or not evidence['entry'].startswith(prefix):
        raise ValueError('Shared public library entry required')
    code=boundary.executable_code(source(root,evidence['path']))
    if evidence['api'] not in code:
        raise ValueError('Shared API declaration drift: '+evidence['path'])
    source(root,evidence['entry'])
    exports=evidence['exports']
    if not isinstance(exports,list) or (evidence['entry']!=evidence['path'] and not exports):
        raise ValueError('Public shared export chain missing')
    if exports and (not isinstance(exports[0],dict) or exports[0].get('path')!=evidence['entry']):
        raise ValueError('Public shared export entry mismatch')
    expected=evidence['entry']
    for export in exports:
        if not isinstance(export,dict) or set(export)!={'path','target'} or not isinstance(export['target'],str):
            raise ValueError('Invalid public shared export')
        if export['path']!=expected:
            raise ValueError('Disconnected public shared export chain')
        target=export['target']
        if target.startswith('package:'):
            match=re.fullmatch(r'package:([a-z_]+)/(.+)',target)
            if not match:raise ValueError('Invalid package export target')
            expected=f'packages/{match[1]}/lib/{match[2]}'
        else:
            expected=posixpath.normpath(posixpath.join(posixpath.dirname(export['path']),target))
        if platform=='web' and not Path(expected).suffix:
            expected+='.ts'
        source(root,expected)
        raw=source(root,export['path']);code=boundary.executable_code(raw)
        pattern=r"(?m)^\s*export\s+(?:\*\s+from\s+)?(['\"])"+re.escape(export['target'])+r'\1\s*;'
        if not any(code[m.start():].lstrip().startswith('export') for m in re.finditer(pattern,raw)):
            raise ValueError('Public shared export drift: '+export['path'])
    if expected!=evidence['path']:
        raise ValueError('Public shared export chain does not reach declaration')
    return f"`{evidence['api'].strip()}` via `{evidence['entry']}`"


def render(root=ROOT):
    root=Path(root).resolve()
    catalogue=json.loads(source(root,'packages/primecare_ui/catalogs/developer-catalogue.json'))
    features={row['id']:row for row in catalogue['features']}
    historical={identity for identity,row in features.items() if row['sources']}
    seen=set();rows=[]
    for row in MAPPINGS:
        if (not isinstance(row,dict) or set(row)!={'id','web','native','scope'} or not isinstance(row['id'],str) or row['id'] not in features
                or row['id'] in seen or not isinstance(row['scope'],str) or not row['scope'].strip()):
            raise ValueError('Unknown, duplicate or invalid shared mapping')
        seen.add(row['id'])
        web=public_api(root,row['web'],'web');native=public_api(root,row['native'],'native')
        rows.append(f"| `{row['id']}` | {web} | {native} | {row['scope']} |")
    reconciled=len(historical|seen);additional=len(seen-historical);unreconciled=len(features)-reconciled
    return '\n'.join([
        '# Shared skeleton equivalents: source reconciliation','',
        f'{len(MAPPINGS)} reviewed mappings identify existing original PrimeCare shared APIs. '
        f'{additional} repair empty historical proposal mappings; one mapping also documents an existing historical source. '
        f'Together with {len(historical)} historical mapped features, {reconciled}/{len(features)} features now have source mappings; '
        f'{unreconciled} still need reconciliation. This is lexical source/export availability, not resolved semantic analysis or feature parity.', '',
        '| Reference capability | Shared web API / public entry | Shared Flutter API / public entry | Supported subset and open boundary |',
        '|---|---|---|---|',*rows,'',
        'Historical developer-catalogue proposal hashes, registrations, dispositions and runtimeVerified fields are unchanged. '
        'A factory or protocol mapping does not imply approved business adapters, authenticated host activation, full vendor variants, '
        'device, accessibility or human localization/release acceptance. All 72 tracked features remain pending full acceptance; '
        'implementation, retirement, registration and ready-screen credits from this audit are zero.', '',
        'Reuse these public entry points and existing governed labels rather than copying implementations into apps. '
        'Unbound or denied adapters remain unavailable. Source reconciliation identifies shared factories and explicit unavailable slots; '
        'it does not close business, host or runtime gaps. Reconciled work templates remain limited to task-backed subsets, not standalone business applications.', '',
        'Reproduce: `python3 scripts/audit-shared-skeleton-equivalents.py --check`. '
        'The audit checks executable declaration anchors and public export statements, rejects unsafe paths, and does not run or activate a feature. '
        'Runtime behavior remains covered by each existing component, page, workspace, navigation, theme, preference, utility, data-control and dashboard suite.', ''
    ])


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--check',action='store_true');args=parser.parse_args()
    output=ROOT/'docs/appearance/shared-skeleton-equivalents.md';text=render()
    if args.check:
        if not output.exists() or output.read_text()!=text:raise SystemExit('Shared skeleton equivalent report drift')
    else:output.write_text(text)
    print(f'{len(MAPPINGS)} shared source mappings verified; 0 runtime acceptance credits')
