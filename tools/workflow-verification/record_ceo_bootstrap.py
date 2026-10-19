"""Resolve recorded first-CEO defects from native evidence; never provision production users."""
import hashlib,json,os,pathlib,subprocess
from production_store import ProductionWorkflowStore
from execution import record_attempt,export_progress
ROOT=pathlib.Path(__file__).resolve().parents[2]
FLOW='auth.bootstrap-first-ceo'
DEFINITION='b7ef9afc1a5599f2887e4d42fc2cdf2727b461e9e091e872aafc972dab4e2c90'
def main():
    if os.environ.get('GITHUB_REF')!='refs/heads/main':raise ValueError('Merged main required')
    commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()
    url=os.environ.get('CEO_EVIDENCE_URL','')
    if not url.startswith('https://github.com/shaikhrais/primecare-platform/actions/runs/') or '/artifacts/' not in url:raise ValueError('Uploaded repository artifact required')
    path='test-results/ceo-bootstrap/postgres.json';receipt=json.loads((ROOT/path).read_text())
    cases=receipt.get('results',[])
    if receipt.get('workflow_id')!=FLOW or receipt.get('wholeTaskVerified') is not False or len(cases)!=9 or len({r['name'] for r in cases})!=9 or any(r['status']!='passed' for r in cases):raise ValueError('Nine successful scoped native cases required')
    sources=receipt['source_bindings']
    for name,sha in sources.items():
        source=(ROOT/name).resolve()
        if not source.is_relative_to(ROOT) or hashlib.sha256(source.read_bytes()).hexdigest()!=sha:raise ValueError('Source is stale')
    blockers=['Pinned draft leaves deployment operator identity and approved protected workflow inputs/review unresolved. Its generic authenticated-session and foreign-tenant alternatives are not reconciled with the protected operator CLI entry point.']
    handoff=dict(workflow_id=FLOW,main_sha=commit,work_branch='work/ceo-bootstrap-repair',pr=212,merge_state='merged; exact branch cleanup required',verification_status='blocked',test_status='scoped_pass',blockers=blockers,evidence_url=url,synthetic_data_cleanup=receipt['cleanup'],next_action='Resolve governed deployment operator identity, protected inputs/review and CLI versus application-session acceptance requirements. Then execute credential login, tenant-scoped console/API/database/reload, denied roles, session/offline recovery, video and required reviews. While blocked, select the next unblocked business workflow from live production; finish this branch lifecycle before opening another.')
    issues=[14,15]
    result=dict(status='blocked',test_status='scoped_pass',scope='scoped',source_bindings=sources,evidence=[dict(path=path,sha256=hashlib.sha256((ROOT/path).read_bytes()).hexdigest(),kind='database',url=url)],blockers=blockers,next_action=json.dumps(handoff,sort_keys=True),resolves_issue_ids=issues,resolution_note='Original Node import and audit-suppression criteria replayed successfully in PostgreSQL 16; audit suppression now rejects and rolls back the account. Native test module directly imports the fixed provisioning source.',issue_resolution_results={str(i):dict(criterion_id='step:1',result='passed',reproduction_verified=True,evidence_path=path) for i in issues})
    with ProductionWorkflowStore() as db:
        if db.execute('SELECT definition_sha256 FROM virtual_workflow_definitions WHERE flow_id=?',(FLOW,)).fetchone()[0]!=DEFINITION:raise ValueError('Specification changed')
        output=record_attempt(db,FLOW,result,ROOT);export_progress(db,ROOT)
    print('CEO_REPAIR_COMMITTED '+json.dumps(output,sort_keys=True))
if __name__=='__main__':main()
