"""Strict B01-B18 release-gap report. --require-complete exits nonzero while any gate is open."""
import argparse
import json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
p=argparse.ArgumentParser();p.add_argument('--require-complete',action='store_true');p.add_argument('--output');args=p.parse_args()
plan=json.loads((ROOT/'docs/task-progress/primecare-theme-implementation-batches.json').read_text())
expected=[f'B{i:02}' for i in range(1,19)]
if [b['id'] for b in plan['batches']]!=expected:raise SystemExit('Exact ordered B01-B18 plan required')
if plan['execution_policy'].get('branch')!='main' or plan['execution_policy'].get('new_work_branches') is not False:raise SystemExit('Main-only execution policy required')
rows=[]
for b in plan['batches']:
    gates=[]
    for key in ['fullFunctionalityVerified','productionRuntimeVerified','humanReviewApproved']:
        if b.get(key) is not True:gates.append(key)
    if b.get('remainingScope'):gates.append('remainingScope')
    if b.get('blockers'):gates.append('blockers')
    evidence=b.get('releaseEvidence',{})
    for key in ['sourceCommit','ciRun','deployedUiApiDatabaseReload','deniedAndCrossTenant','supportedDevices','localizationAndAccessibilityReview']:
        if not evidence.get(key):gates.append('releaseEvidence.'+key)
    rows.append({'batch':b['id'],'ready':not gates,'openGates':gates,'recordedStatus':b['status']})
report={'format':1,'releaseReady':all(r['ready'] for r in rows),'batchCount':18,
        'mainOnlyPolicy':True,'liveBranchInventoryNotRecheckedByThisScript':True,
        'evidencePolicy':'Declared plan/evidence gates only; CI/deployment/review receipts require independent validation before final signoff',
        'batches':rows}
text=json.dumps(report,indent=2)+'\n'
if args.output:(ROOT/args.output).write_text(text)
else:print(text,end='')
if args.require_complete and not report['releaseReady']:raise SystemExit(1)
