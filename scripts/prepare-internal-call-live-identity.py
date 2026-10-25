"""Select an existing role with all current call grants; never create or grant roles."""
import json,sys
from pathlib import Path
sys.path.insert(0,'tools/governance-production')
import internal_call_access_registration as access
from production_reader import connect,GovernanceReadError
with connect() as db:
 d=access.definition(db);eligible=access.validate(db);candidates=[]
 for rid in eligible:
  rows=db.execute('SELECT role_code FROM roles WHERE id=?',(rid,)).fetchall()
  if len(rows)!=1 or not isinstance(rows[0][0],str):raise GovernanceReadError('Exact registered role required')
  code=rows[0][0]
  if code in ('platform_admin','code_admin'):continue
  if all(db.execute('SELECT permission_key,can_access FROM api_permissions WHERE role_id=? AND api_id=?',(rid,aid)).fetchall()==[(d['permission'],1)] for aid in d['apiIds'].values()):candidates.append(code)
 if not candidates:raise GovernanceReadError('No existing communication role eligible for live proof')
 role=sorted(candidates,key=lambda c:(c not in ('psw','patient','client'),c))[0]
Path('test-results/internal-calls').mkdir(parents=True,exist_ok=True)
Path('test-results/internal-calls/live-role.json').write_text(json.dumps({'role':role,'existingRole':True,'permissionWrites':False})+'\n')
print('Live acceptance uses an existing eligible role; no role or permission changes')
