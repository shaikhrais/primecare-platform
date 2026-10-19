"""Record scoped native evidence; never bootstrap production accounts."""
import hashlib,json,os,pathlib,subprocess
from production_store import ProductionWorkflowStore
from execution import record_attempt,export_progress
ROOT=pathlib.Path(__file__).resolve().parents[2]
FLOW='auth.bootstrap-first-central-admin'
DEFINITION='37ba0a56137ce040952225ca11eddcc785c0f60333cfededa1e63bb403748358'
def main():
    if os.environ.get('GITHUB_REF')!='refs/heads/main':
        raise ValueError('Only merged main may record production bootstrap tracking')
    commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()
    url=os.environ.get('BOOTSTRAP_EVIDENCE_URL','')
    if not url.startswith('https://github.com/shaikhrais/primecare-platform/actions/runs/') or '/artifacts/' not in url:
        raise ValueError('Current repository artifact URL required')
    path='test-results/central-bootstrap/postgres.json'
    receipt=json.loads((ROOT/path).read_text())
    if receipt.get('workflow_id')!=FLOW or receipt.get('wholeTaskVerified') is not False:
        raise ValueError('Wrong or overclaimed receipt')
    cases=receipt.get('results',[])
    if len(cases)!=6 or len({r['name'] for r in cases})!=6 or any(r['status']!='passed' for r in cases):
        raise ValueError('Six successful native cases required')
    sources=receipt['source_bindings']
    for name,sha in sources.items():
        source=(ROOT/name).resolve()
        if not source.is_relative_to(ROOT) or hashlib.sha256(source.read_bytes()).hexdigest()!=sha:
            raise ValueError('Stale source binding')
    blockers=['The pinned definition leaves approved deployment operator identity and approved execution environment unbound; no registered operator application role or bootstrap API may be invented.']
    handoff={'workflow_id':FLOW,'main_sha':commit,'work_branch':'work/central-bootstrap-verification','pr':211,'merge_state':'merged; remote cleanup still required','verification_status':'blocked','test_status':'scoped_pass','blockers':blockers,'evidence_url':url,'synthetic_data_cleanup':receipt['cleanup'],'next_action':'Bind the approved operator identity/environment in governed requirements before protected acceptance. Then test real credential login, permitted console/API/database/reload, denied roles/tenants/session/offline cases, video and required reviews. While blocked, inspect the next unblocked business process from live production on the existing branch; finish branch cleanup before opening another.'}
    result={'status':'blocked','test_status':'scoped_pass','scope':'scoped','source_bindings':sources,'evidence':[{'path':path,'sha256':hashlib.sha256((ROOT/path).read_bytes()).hexdigest(),'kind':'database','url':url}],'blockers':blockers,'next_action':json.dumps(handoff,sort_keys=True)}
    with ProductionWorkflowStore() as db:
        row=db.execute('SELECT definition_sha256 FROM virtual_workflow_definitions WHERE flow_id=?',(FLOW,)).fetchone()
        if not row or row[0]!=DEFINITION:
            raise ValueError('Production specification changed; re-review before recording')
        output=record_attempt(db,FLOW,result,ROOT)
        export_progress(db,ROOT)
    print('CENTRAL_BOOTSTRAP_ATTEMPT_COMMITTED '+json.dumps(output,sort_keys=True))
if __name__=='__main__':main()
