"""Record current scoped care execution; never claim full workflow acceptance."""
import hashlib
import json
import os
import subprocess
from pathlib import Path
from execution import record_attempt, export_progress
from production_store import ProductionWorkflowStore

ROOT = Path(__file__).resolve().parents[2]

def sha(path):
    return hashlib.sha256((ROOT/path).read_bytes()).hexdigest()


def main():
    workflow = 'care.psw.submit-availability'
    receipt_path = 'test-results/care/availability-workflow/results.json'
    video_path = 'test-results/care/availability-workflow/availability-login-save-reload.webm'
    receipt = json.loads((ROOT/receipt_path).read_text())
    passed = receipt.get('passed') is True
    if passed and (receipt.get('wholeTaskVerified') is not False
            or len(receipt.get('cases', [])) != 6
            or not all(all(row.get(k) is True for k in ('credentialLogin','persistedWindow','reload','offlineRecovery')) for row in receipt['cases'])
            or len(receipt.get('apiChecks', [])) < 8):
        raise ValueError('Current six-case browser and security receipt required')
    for name, expected in receipt['sources'].items():
        if sha(name) != expected:
            raise ValueError('Scoped receipt source binding is stale: '+name)
    url = os.environ.get('WORKFLOW_EVIDENCE_URL')
    if not url or not url.startswith('https://github.com/shaikhrais/primecare-platform/actions/runs/'):
        raise ValueError('Uploaded durable GitHub evidence URL required')
    commit = subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()
    branch = os.environ.get('GITHUB_REF_NAME')
    if branch != 'main':
        raise ValueError('Only merged main evidence may update production recovery checkpoint')
    evidence=[{'kind':'browser','path':receipt_path,'sha256':sha(receipt_path),'url':url}]
    if (ROOT/video_path).is_file():
        evidence.append({'kind':'video','path':video_path,'sha256':sha(video_path),'url':url})
    issues=[] if passed else [{'criterion_id':'step:1','reproduction':'Run node scripts/test-care-availability-workflow.mjs with the pinned production theme reader and isolated synthetic business database.','expected':'Real credential login, availability save and browser reload agree with the isolated database.','actual':receipt.get('error','Browser acceptance did not complete.'),'affected_sources':['scripts/test-care-availability-workflow.mjs']}]
    result = {
        'status':'implemented-unverified','test_status':'scoped_pass' if passed else 'failed','scope':'scoped',
        'source_bindings':receipt['sources'],
        'evidence':evidence,
        'issues':issues,
        'blockers':receipt.get('limitations', ['Browser execution failed: '+receipt.get('error','inspect uploaded receipt')]),
        'next_action': 'Main '+commit+'; scoped browser/API/embedded database evidence uploaded at '+url+'. Work branch work/workflow-production-recorder is merged; cleanup must be confirmed after this run. Synthetic business database closed; no production synthetic accounts. Next: inspect registered deployed-route, native business concurrency, accessibility/PWA and independent review dependencies, then execute the next unblocked workflow. Recording-store native concurrency is separate from business-workflow concurrency.',
        'repository_checkpoint':{'main_sha':commit,'active_branch':branch,'work_branch':'work/workflow-production-recorder','pr_state':'merged; verify branch cleanup','ci_run':os.environ.get('GITHUB_RUN_ID'),'evidence_url':url,'synthetic_data_cleanup':'disposable embedded database closed; production business data untouched'},
    }
    with ProductionWorkflowStore() as db:
        output=record_attempt(db,workflow,result,ROOT)
        export_progress(db,ROOT)
    # Emit success only AFTER commit, never from an uncommitted transaction.
    print(json.dumps(output))

if __name__=='__main__':
    main()
