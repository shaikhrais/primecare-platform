"""Reproduce the B01-B18 evidence audit from a pinned main commit and captured GitHub reads.

This checks source/evidence presence and historical receipts; it never promotes those
facts to production functionality or release approval. No network or database writes.
"""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser()
parser.add_argument('--snapshot', default='docs/appearance/theme-batches-main-audit-snapshot.json')
parser.add_argument('--check', action='store_true')
args = parser.parse_args()
snapshot = json.loads((ROOT / args.snapshot).read_text())
source = snapshot['sourceCommit']
if len(source) != 40 or any(c not in '0123456789abcdef' for c in source):
    raise SystemExit('A pinned source commit is required')
cache = {}
def content(path):
    if path not in cache:
        result = subprocess.run(['git', 'show', f'{source}:{path}'], cwd=ROOT, capture_output=True)
        cache[path] = result.stdout if result.returncode == 0 else None
    return cache[path]
def document(path):
    raw = content(path)
    return json.loads(raw) if raw is not None else {}

plan = document('docs/task-progress/primecare-theme-implementation-batches.json')
contract = document('tools/governance-production/theme-adoption-contract.json')
assert [b['id'] for b in plan['batches']] == [f'B{n:02}' for n in range(1, 19)]
remote = {row['id']: row for row in snapshot['historicalRuns']}
features = Counter(row['batch'] for row in contract['features'])
rows = []
for batch in plan['batches']:
    bid = batch['id']
    evidence_path = f"docs/appearance/theme-adoption-batch-{bid[1:]}-evidence.json"
    evidence = document(evidence_path)
    paths = list(dict.fromkeys(batch.get('evidence', [])))
    missing = [p for p in paths if content(p) is None]
    hashes = evidence.get('sourceSha256') or evidence.get('sourceArtifactsSha256') or {}
    changed = [p for p, digest in hashes.items() if content(p) is None or hashlib.sha256(content(p)).hexdigest() != digest]
    remaining = batch.get('remainingScope') or evidence.get('remainingScope') or evidence.get('remaining') or []
    if not remaining:
        remaining = [x['detail'] for x in batch.get('blockers', [])]
    if bid == 'B16':
        remaining = ['Verify latest native fixes; obtain independent registration readback and production slot activation',
                     'Native authenticated read/session adapter', 'Real finance/crypto workflow bindings',
                     'Android/iOS, human localization/accessibility and release acceptance']
    if bid in ['B17', 'B18']:
        remaining = batch['scope']
    rows.append({'id': bid, 'title': batch['title'], 'recordedStatus': batch['status'],
                 'fullFunctionalityConfirmed': False,
                 'sourceState': 'plan_only' if bid in ['B17', 'B18'] else 'implemented_subset_or_foundation',
                 'evidenceReferences': len(paths), 'missingEvidenceReferences': missing,
                 'historicalHashCount': len(hashes), 'changedSinceHistoricalHashes': changed,
                 'proposalFeatureCount': features[bid], 'historicalRun': remote.get(bid),
                 'remaining': remaining})
branches = snapshot['branches']
result = {'format': 1, 'sourceCommit': source, 'capturedAt': snapshot['capturedAt'],
          'remoteBranches': branches, 'mainOnlyConfirmed': [x['name'] for x in branches] == ['main'],
          'all18FullyFunctional': False, 'fullyConfirmedBatches': 0,
          'historicalEvidenceIsNotCurrentProductionAcceptance': True,
          'latestB16': snapshot['latestB16'], 'localRegressions': snapshot['localRegressions'],
          'proposalFeatures': len(contract['features']), 'batches': rows}
passed = sum(row['exitCode'] == 0 for row in snapshot['localRegressions'])
lines = ['# B01-B18 main-branch functionality audit', '',
         f"Captured: {snapshot['capturedAt']}. Audited source: `{source}`.", '',
         '**All 18 batches are not fully functional or production verified.** B01-B15 have historical passing checks for registered subsets/factories; B16 has recent native failures and corrections; B17/B18 were planned at the audited source. No batch is promoted to full functionality from a green build, metadata registration or file presence.', '',
         f"GitHub branch read: {', '.join(x['name'] for x in branches)}. Main-only confirmed: {result['mainOnlyConfirmed']}. No branch was created or deleted by this audit.", '',
         f"Current local checks: {passed}/{len(snapshot['localRegressions'])} scripts passed. The workspace browser script could not launch because local Chromium is unavailable; this is an environment limitation, not a passing browser result. Historical and new CI results are listed separately. Local PostgreSQL tests here use PGlite; native PostgreSQL/browser acceptance comes from CI.", '',
         '| Batch | Source saved on main | Historical verification | Full functionality | Main remaining work |',
         '|---|---|---|---|---|']
for row in rows:
    run = row['historicalRun']
    status = f"[{run.get('conclusion', 'pending')}]({run['url']})" if run and run.get('url') else 'Not established'
    source_text = 'Plan only' if row['sourceState'] == 'plan_only' else ('Missing evidence links' if row['missingEvidenceReferences'] else 'Subset/foundation and evidence')
    remain = '; '.join(str(x) for x in row['remaining'][:2]).replace('|', '/')
    lines.append(f"| {row['id']} | {source_text} | {status} | Not confirmed | {remain} |")
latest = snapshot['latestB16']
job_summary = '; '.join(f"{job['name']}: {job.get('conclusion') or job['status']}" for job in latest.get('jobs', []))
lines += ['', f"Latest B16 repairs: [run {latest['runId']}](https://github.com/shaikhrais/primecare-platform/actions/runs/{latest['runId']}) at `{latest['sourceCommit']}`. {job_summary}. Pending jobs are not counted as accepted.", '', '## Exact limits and next actions', '',
          'The 72 proposal-feature records are a bounded catalogue, not an authoritative claim of complete reference parity. B09 and B10 historical source digests differ for later-edited native renderer files; their older receipts remain historical. Full details, missing references, digests and remaining work are in the JSON audit.', '',
          'Keep all remaining work on main. Verify the B16 native test repairs first. Then close registered host/access/preference bindings and real workflows in earlier batches before claiming app-wide adoption. B17 must finish catalogue and app migration; B18 must verify deployed UI/API/database/reload and denied/cross-tenant/device/review paths.', '',
          'Reproduce: `python scripts/audit-theme-batches.py --check`. The snapshot records GitHub reads and local test summaries; it does not fetch new evidence or change production state.', '']
outputs = {'docs/appearance/theme-batches-main-audit.json': json.dumps(result, indent=2)+'\n',
           'docs/appearance/theme-batches-main-audit.md': '\n'.join(lines)}
for path, value in outputs.items():
    target = ROOT / path
    if args.check:
        if not target.exists() or target.read_text() != value:
            raise SystemExit(f'Audit drift: {path}')
    else:
        target.write_text(value)
print(f'AUDIT: 18 batches, main-only={result["mainOnlyConfirmed"]}, full functionality not confirmed, {passed}/{len(snapshot["localRegressions"])} local scripts passed')
