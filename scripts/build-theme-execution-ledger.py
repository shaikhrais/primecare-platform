"""Reproducible scoped execution ledger; source inventory never implies activation."""
import argparse
import hashlib
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
ASSESSMENT = 'docs/appearance/deep-assessment-repair-plan-2026-11-01.json'
OUTPUT = 'docs/appearance/theme-execution-ledger.json'
SYMBOLS = ['PrimeWorkspaceLayout','PrimeWorkspaceNavigation','PrimeWorkModule','PrimeCommunicationModule','PrimeApplicationModule','TenantTaskModulePort','ApplicationProfilePort','ApplicationSettingsPort','CommunicationModulePort']

def build(root=ROOT):
    assessment = json.loads((root / ASSESSMENT).read_text())
    packages = assessment['repairPackages']
    plan = json.loads((root / 'docs/task-progress/primecare-theme-implementation-batches.json').read_text())
    contract = json.loads((root / 'tools/governance-production/theme-adoption-contract.json').read_text())
    developer = json.loads((root / 'packages/primecare_ui/catalogs/developer-catalogue.json').read_text())
    mapped = {b['id']: [p['id'] for p in packages if b['id'] in p['batches']] for b in plan['batches']}
    items = []
    seen = {}
    for batch in plan['batches']:
        for index, statement in enumerate(batch.get('remainingScope', []), 1):
            for part, text in enumerate(statement.split(';'), 1):
                text = text.strip()
                if not text:
                    continue
                item_id = f"{batch['id']}-S{index:02}-{part:02}"
                fingerprint = hashlib.sha256(re.sub(r'\s+', ' ', text).lower().encode()).hexdigest()
                items.append({'id': item_id, 'batch': batch['id'], 'parentScope': f"{batch['id']}-S{index:02}",
                              'requirement': text, 'repairPackages': mapped[batch['id']],
                              'executionOwner': 'Codex under user instruction to execute the plan',
                              'reviewOwner': 'unassigned where independent human review is required',
                              'state': 'open', 'duplicateTextOf': seen.get(fingerprint),
                              'closureRequires': ['current source/contract binding', 'authorized actual-host flow',
                                                 'independent persistence/reload where applicable',
                                                 'denied/cross-tenant coverage where applicable',
                                                 'deployed/device/review evidence where required']})
                seen.setdefault(fingerprint, item_id)
    compositions = []
    for base in ['apps', 'websites/typescript/src', 'packages/flutter_core/lib/registry']:
        for path in sorted((root / base).rglob('*')):
            if path.suffix not in ['.ts', '.tsx', '.dart']:
                continue
            text = path.read_text(errors='replace')
            for symbol in SYMBOLS:
                for match in re.finditer(r'\b' + symbol + r'(?:\.\w+)?\s*\(', text):
                    compositions.append({'path': str(path.relative_to(root)), 'symbol': symbol,
                                         'line': text.count('\n', 0, match.start()) + 1,
                                         'classification': 'static_constructor_candidate_not_runtime_acceptance'})
    native_apps = sorted(str(p.parent.relative_to(root)) for p in (root / 'apps').glob('primecare_*/pubspec.yaml'))
    return {'format': 1, 'assessmentSource': assessment['assessedSource'], 'currentPlan': ASSESSMENT,
            'scopeStatements': sum(len(b.get('remainingScope', [])) for b in plan['batches']),
            'decomposedItemCount': len(items), 'wholeBatchesComplete': 0,
            'runtimeActivated': False, 'newRoleGrants': 0,
            'evidenceRules': ['Pending CI is not passed', 'Source/metadata/host/deployment/device/review are separate',
                              'Duplicate text is retained as an overlap, not a new defect',
                              'Static scan does not resolve every dynamic factory or prove runtime absence'],
            'supersededClaims': [
                {'historical': 'docs/appearance/theme-batches-main-audit.md', 'claims': ['B10 native sticky pinning remains unfixed', 'B17 developer catalogue remains unpublished'],
                 'current': ['docs/appearance/theme-gap-closure.md', 'docs/appearance/developer-catalogue.md'], 'disposition': 'retain historical receipt; do not redo accepted subset'},
                {'historical': 'docs/appearance/theme-draft-preservation-evidence.json: Flutter pending',
                 'current': 'CI 41346938130: all seven combined source jobs passed', 'disposition': 'source accepted; deployed/device/human acceptance still open'}],
            'packages': [{'id': p['id'], 'title': p['title'], 'dependsOn': p['dependsOn'],
                          'acceptance': p['acceptance'], 'executionOwner': 'Codex',
                          'state': 'open'} for p in packages],
            'features': [{'id': f['id'], 'batch': f['batch'], 'sourceEvidence': f['sourceEvidence'],
                          'currentSources': [{'path': s['path'], 'exists': (root / s['path']).is_file(),
                                              'sha256': hashlib.sha256((root / s['path']).read_bytes()).hexdigest() if (root / s['path']).is_file() else None} for s in f['sourceEvidence']],
                          'state': 'source_inventory_only'} for f in contract['features']],
            'hostInventory': {'nativeApps': native_apps, 'webPortalCountFromAssessment': assessment['measurements']['webPortals'],
                              'developerNativeApps': developer['nativeApps'], 'webPortals': developer['webPortals'],
                              'staticCompositions': compositions, 'dynamicResolutionRequired': True},
            'items': items}

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    value = json.dumps(build(), indent=2, ensure_ascii=False) + '\n'
    target = ROOT / OUTPUT
    if args.check:
        if not target.exists() or target.read_text() != value:
            raise SystemExit('Execution ledger drift; rebuild and review changed scope')
    else:
        target.write_text(value)
    result = json.loads(value)
    print(json.dumps({k: result[k] for k in ['scopeStatements','decomposedItemCount','wholeBatchesComplete']}))

if __name__ == '__main__':
    main()
