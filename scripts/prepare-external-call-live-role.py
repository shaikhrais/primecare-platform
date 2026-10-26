"""Read current staff eligibility only. Never grant or alter production access."""
import json,sys
from pathlib import Path
sys.path.insert(0,'tools/governance-production')
import external_call_access_registration as access
from production_reader import connect,GovernanceReadError
with connect() as db:
 d=access.definition(db);codes=[]
 for rid in access.validate(db):
  rows=db.execute('SELECT role_code FROM roles WHERE id=?',(rid,)).fetchall()
  if len(rows)!=1:raise GovernanceReadError('Exact role required')
  if all(db.execute('SELECT permission_key,can_access FROM api_permissions WHERE role_id=? AND api_id=?',(rid,aid)).fetchall()==[(d['permission'],1)] for aid in d['apiIds'].values()):codes.append(rows[0][0])
 if not codes:raise GovernanceReadError('No existing permitted staff role')
 role=sorted(codes,key=lambda c:(c!='psw',c))[0]
Path('test-results/external-calls').mkdir(parents=True,exist_ok=True)
Path('test-results/external-calls/live-role.json').write_text(json.dumps({'role':role,'existingRole':True,'permissionWrites':False})+'\n')
print('External call readiness uses an existing permitted staff role; no grants changed')
