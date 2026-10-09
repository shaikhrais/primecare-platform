"""Read-only authority triage; never infer grants or mark operations complete."""
import json, sqlite3, subprocess
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]

def build():
    checklist=json.loads((ROOT/'docs/api/api-delivery-checklist.json').read_text())
    db=sqlite3.connect(f"file:{ROOT/'.agents/governance/governance.db'}?mode=ro",uri=True)
    db.row_factory=sqlite3.Row
    selected=[o for o in checklist['operations'] if o['area'] in ('admin','governance') and o['method']=='GET' and not o['unitEvidenceRecorded']]
    files=subprocess.check_output(['git','ls-files','apps/**/*.dart','packages/**/*.dart'],cwd=ROOT,text=True).splitlines()
    sources={p:(ROOT/p).read_text(errors='replace').splitlines() for p in files}
    audit=json.loads((ROOT/'docs/api/api-reachability-audit.json').read_text())
    probes={p['api']:p for p in audit['operations']}
    operations=[]
    for o in selected:
        endpoints=[]
        for e in db.execute('select id,endpoint_code,permission_key,request_schema,response_schema from api_endpoints where route_path=? and http_method=?',(o['route'],o['method'])):
            grants=[dict(g) for g in db.execute('select permission_key,count(*) grantRows,sum(can_access) allowedRows from api_permissions where api_id=? group by permission_key',(e['id'],))]
            endpoints.append({**dict(e),'registeredGrantKeys':grants})
        callers=[{'file':p,'line':i+1,'source':line.strip()} for p,lines in sources.items() for i,line in enumerate(lines) if o['route'] in line]
        probe=probes.get(o['api'])
        operations.append({'api':o['api'],'declarationIds':o['declarationIds'],'disposition':'needs_business_and_authority_contract','completedCredit':False,'endpointEvidence':endpoints,'callers':callers,'routingEvidence':{k:probe[k] for k in ('classification','status','forwarded')} if probe else None,'reason':'Endpoint permission key is missing. Existing api_permissions rows cannot substitute for a defined endpoint permission or establish a scoped workflow. Register operation-specific authority and response contract before implementing or aliasing.'})
    assert len({o['api'] for o in operations})==len(operations)
    assert all(o['endpointEvidence'] and all(e['permission_key'] is None for e in o['endpointEvidence']) for o in operations), 'Authority changed: manual review required'
    return {'scope':'Pending GET admin and governance operations only','summary':{'reviewedUniqueOperations':len(operations),'resolved':0,'needsBusinessAndAuthorityContract':len(operations)},'authorityWarning':'api_permissions rows are retained as evidence, not treated as grants: sampled keys refer to unrelated workflows. Screen visibility alone is not endpoint authority.','canonicalAlternatives':[{'operation':'GET /v1/governance/overview','authority':'workspace-registry.permissions.organization','limitation':'Tenant account/session/domain counts; not legacy dashboard metrics/insights/timeline contract.'},{'operation':'GET /v1/auth/me/audit-event-records','authority':'Actor ownership via self-records registry','limitation':'Personal records; not system transaction ledger.'}],'operations':operations}

if __name__=='__main__':
    report=build()
    (ROOT/'docs/api/admin-read-authority-audit.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps(report['summary']))
