"""Original source/API catalogue and app adoption inventory. No runtime activation or parity claim."""
import argparse
import hashlib
import json
from pathlib import Path
import re
ROOT = Path(__file__).resolve().parents[1]
p = argparse.ArgumentParser(); p.add_argument('--check', action='store_true'); args = p.parse_args()
plan = json.loads((ROOT/'docs/task-progress/primecare-theme-implementation-batches.json').read_text())
contract = json.loads((ROOT/'tools/governance-production/theme-adoption-contract.json').read_text())
batches = {b['id']: b for b in plan['batches']}
usage = {'B02':'native-workspace-usage.md','B03':'native-workspace-usage.md','B04':'workspace-navigation-usage.md','B05':'page-template-usage.md','B06':'advanced-theme-usage.md','B07':'preference-sync-usage.md','B08':'shell-utilities-usage.md','B09':'component-catalogue-usage.md','B10':'data-controls-usage.md','B11':'dashboard-widgets-usage.md','B12':'original-assets-usage.md','B13':'work-modules-usage.md','B14':'communication-modules-usage.md','B15':'application-modules-usage.md','B16':'dashboard-pages-usage.md'}
rows = []
for feature in contract['features']:
    batch = batches[feature['batch']]
    sources = []
    for evidence in feature['sourceEvidence']:
        path = ROOT/evidence['path']
        exists = path.is_file()
        text = path.read_text() if exists else ''
        symbols = sorted(set(re.findall(r'\bexport\s+(?:abstract\s+)?(?:class|function|const|type|interface|enum)\s+(\w+)', text))) if path.suffix != '.dart' else sorted(set(re.findall(r'\b(?:class|enum|mixin)\s+([A-Z]\w*)', text)))
        digest = hashlib.sha256(path.read_bytes()).hexdigest() if exists else None
        sources.append({'path': evidence['path'], 'present': exists, 'sha256': digest,
                        'matchesOriginalProposalHash': digest == evidence.get('sha256'), 'declaredSymbols': symbols})
    missing = not sources or any(not row['present'] for row in sources)
    remaining = batch.get('remainingScope') or [b['detail'] for b in batch.get('blockers', [])] or [batch.get('nextAction') or 'Batch acceptance remains open']
    rows.append({'id':feature['id'],'title':feature['title'],'batch':feature['batch'],
                 'ownerPackage':feature['ownerPackage'],'disposition':'missing' if missing else 'blocked',
                 'reviewedDisposition':False,'reason':'Source presence is not full business/runtime/review acceptance',
                 'sources':sources,'usage':usage.get(feature['batch']), 'remaining':remaining,
                 'sourceProposalStatus':feature['sourceStatus'],'runtimeVerified':False})
apps = []
for path in sorted((ROOT/'apps').glob('*/pubspec.yaml')):
    name = path.parent.name
    consumers = []
    for dart in sorted(path.parent.rglob('*.dart')):
        if any(x in dart.parts for x in ['build','.dart_tool','ephemeral']): continue
        if re.search(r"(?:import|export)\s+['\"]package:(?:primecare_ui|flutter_core)/", dart.read_text(errors='replace')):
            consumers.append(str(dart.relative_to(ROOT)))
    apps.append({'app':name,'dependencyDeclared':bool(re.search(r'^\s+(?:primecare_ui|flutter_core):',path.read_text(),re.M)),
                 'sharedImportFiles':consumers,'runtimeAdoptionVerified':False})
web = json.loads((ROOT/'websites/typescript/projects.json').read_text())
reference_rows=[]
skeleton=json.loads((ROOT/'packages/primecare_ui/catalogs/fuse-skeleton.inventory.json').read_text())
for item in skeleton['files']:
    reference_rows.append({'scope':'skeleton','reference':item['source'],'sourceSha256':item['sha256'],'disposition':'blocked','reviewed':False,'ownerPackage':'packages/primecare_ui','reason':'Inventory-only reference; feature/runtime equivalence requires reviewed mapping'})
charts=json.loads((ROOT/'docs/appearance/dashboard-widgets-reference-audit.json').read_text())
for item in charts['files']:
    reference_rows.append({'scope':item['bundle'],'reference':item['path'],'sourceSha256':item['sha256'],'disposition':'blocked','reviewed':False,'ownerPackage':'packages/primecare_ui','reason':item['disposition']})
components=json.loads((ROOT/'docs/appearance/component-catalogue-reference-audit.json').read_text())
for family in components['families']:
    for path in family['files']:
        reference_rows.append({'scope':'component-family:'+family['family'],'reference':path,'disposition':'blocked','reviewed':False,'ownerPackage':'packages/primecare_ui','reason':family['classification'],'familyMetadataSha256':family['sourceMetadataSha256']})
result = {'format':1,'referenceScope':'72 proposal feature records only; not every vendor example or variant',
          'vendorSourceCopied':False,'runtimeActivated':False,'fullReferenceParity':False,
          'features':rows,'referenceDispositions':reference_rows,'nativeApps':apps,'webPortals':sorted(web),
          'webHost':'websites/typescript/src/main.ts','appWideAdoptionVerified':False}
lines = ['# PrimeCare developer catalogue and adoption inventory','',
         'This is a reproducible source catalogue, not a claim of production activation or complete reference parity. Each of the 72 proposal features has an owner package, source paths and declared symbols, a usage recipe where available, and an explicit missing/blocked disposition. Human disposition review and app migration remain open.','',
         '| Feature | Batch | Owner | Disposition | Usage |','|---|---|---|---|---|']
for row in rows:
    recipe = f"[Recipe]({row['usage']})" if row['usage'] else 'Batch contract/evidence'
    lines.append(f"| {row['title'].replace('|','/')} (`{row['id']}`) | {row['batch']} | `{row['ownerPackage']}` | {row['disposition']} | {recipe} |")
lines += ['', '## Shared API entry points', '',
          f'Known reference inventory: {len(reference_rows)} records across skeleton, chart/demo and component-family audits. All receive explicit blocked dispositions until reviewed; these audits have different logical/physical scopes and their counts must not be added as a unique vendor-feature total.', '',
          'The JSON catalogue records source-level public symbols and content digests. Examples and adapter contracts are linked from the usage column. An unchanged proposal digest is not proof that a source was tested or approved.','',
          f"Native app inventory: {len(apps)} apps with pubspecs; {sum(bool(x['sharedImportFiles']) for x in apps)} have direct shared-package imports. Web portals: {len(web)} using the central TypeScript host. Import presence does not establish a working authenticated screen or absence of duplicate old implementations.",'',
          'For app-by-app importer paths and feature source APIs, read [developer-catalogue.json](../../packages/primecare_ui/catalogs/developer-catalogue.json). Preserve old paths until live compatibility and migration acceptance pass.','',
          'Reproduce with `python scripts/build-theme-developer-catalogue.py --check`. No registrations, permissions, provider calls, dependency removals or production changes are performed.','']
outputs = {'packages/primecare_ui/catalogs/developer-catalogue.json':json.dumps(result,indent=2)+'\n',
           'docs/appearance/developer-catalogue.md':'\n'.join(lines)}
for path, text in outputs.items():
    target = ROOT/path
    if args.check:
        if not target.exists() or target.read_text()!=text: raise SystemExit(f'Catalogue drift: {path}')
    else: target.write_text(text)
print(f'CATALOGUE: {len(rows)} features, {len(apps)} native apps, {len(web)} web portals; activation/adoption not inferred')
