"""Generate all declared API gaps, without claiming missing code from labels."""
import json,sqlite3
from collections import Counter
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
def schema_present(value):
 try:return isinstance(json.loads(value),dict)
 except (TypeError,ValueError):return False
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 db.row_factory=sqlite3.Row
 batches={(r['route'] if r['route'].split(' ',1)[0] in ['GET','POST','PUT','PATCH','DELETE'] else 'GET '+r['route']):dict(r) for r in db.execute('SELECT * FROM governance_api_batches')}
 rows=[]
 for a in db.execute("SELECT id,http_method,route_path,service_name,implementation_status,permission_key,request_schema,response_schema FROM api_endpoints WHERE implementation_status IS NULL OR implementation_status!='retired' ORDER BY route_path,http_method,id").fetchall():
  key=a['http_method']+' '+a['route_path'];b=batches.get(key)
  if b and b['permission']!=a['permission_key']:b=None
  links=db.execute('''SELECT DISTINCT s.screen_code,a.app_code,r.role_code FROM screens s JOIN apps a ON a.id=s.app_id LEFT JOIN roles r ON r.id=s.role_id WHERE s.id IN (SELECT screen_id FROM screen_api_links WHERE api_id=? UNION SELECT screen_id FROM screen_api_map WHERE api_id=?)''',(a['id'],a['id'])).fetchall()
  missing=[name for name,ok in [('permission',bool(a['permission_key'])),('requestSchema',schema_present(a['request_schema'])),('responseSchema',schema_present(a['response_schema'])),('screenLink',bool(links))] if not ok]
  state='blocked' if a['implementation_status']=='blocked' else 'unit_fixtures_recorded' if b and b['test_status']=='unit_tested' else 'verification_pending'
  rows.append({'id':a['id'],'api':key,'method':a['http_method'],'route':a['route_path'],'service':a['service_name'],'declaredImplementation':a['implementation_status'],'verificationState':state,'batch':b['batch'] if b else None,'recordedUnitStatus':b['test_status'] if b else 'unrecorded','missingContractFields':missing,'screens':sorted({r['screen_code'] for r in links}),'apps':sorted({r['app_code'] for r in links}),'roles':sorted({r['role_code'] for r in links if r['role_code']}),'postgresVerified':False,'productionVerified':False})
 summary={'totalDeclared':len(rows),'verificationStates':dict(sorted(Counter(r['verificationState'] for r in rows).items())),'contractGaps':dict(sorted(Counter(f for r in rows for f in r['missingContractFields']).items())),'note':'Recorded declarations and local unit-fixture status only. Unrecorded means inspect implementation, not proof of absent code. PostgreSQL/production evidence is not inferred from CI or registry labels.'}
 inventory={'source':'governance.db','summary':summary,'data':rows}
 (ROOT/'cloudflare/workers/src/api-execution-inventory.json').write_text(json.dumps(inventory,separators=(',',':'))+'\n')
 (ROOT/'docs/api/api-execution-inventory.json').write_text(json.dumps(inventory,indent=2)+'\n')
 report=['# API execution inventory','',summary['note'],'',f"Declared operations: {len(rows)}",'', '| Recorded verification state | Operations |','| --- | --- |']+[f'| {k} | {v} |' for k,v in summary['verificationStates'].items()]+['','| Missing contract field | Operations |','| --- | --- |']+[f'| {k} | {v} |' for k,v in summary['contractGaps'].items()]+['','The JSON inventory includes every registered API, linked screens, apps, roles and missing fields. Use `/v1/governance/api-execution-status` with existing inventory authority to query this snapshot. `search`, `app`, `role` and `screen` filters plus bounded paging are supported.','', 'Remaining priority workflows: governed tenant-wide administration; booking approval/rejection and visit assignment; invoice/payment writes; provider document upload/verification; availability writes; compliance findings; clinical notes, consent and medication workflows. These require explicit registered business and authorization contracts; do not synthesize broad access or claim completed workflows from placeholder bindings.','', 'Release gates: apply additive migrations in the normal deployment workflow, verify PostgreSQL CI, deploy APIs separately, and run authenticated production checks. UI readiness is outside this API-only work.']
 (ROOT/'docs/api/API_EXECUTION_INVENTORY.md').write_text('\n'.join(report)+'\n')
print(json.dumps(summary))

# Maintain the finite, deduplicated operation checklist alongside this snapshot.
import runpy
runpy.run_path(str(ROOT/'scripts/generate-api-delivery-checklist.py'),run_name='__main__')
