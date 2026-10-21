"""Repair only the fingerprinted legacy grants attached to public login API 2."""
import hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore
from production_reader import GovernanceReadError
OLD='api_permission_api_v1_rmt_create_post'
NEW='public_password_exchange'
FINGERPRINT='c2b0688d492d8bfd9c11383e95509dc886e8763234f3ca99bb96e182c456f0e0'
def repair(db):
 scope=dict(optInVariable='GOVERNANCE_PUBLIC_LOGIN_GRANTS',tables=['api_permissions'],apiIds=[2],reviewedFingerprint=FINGERPRINT,rowCount=64,schemaChanges=False,businessDataWrites=False,roleGrants=False)
 if db.pin.get('publicLoginGrantRepairWriter')!=scope or os.environ.get(scope['optInVariable'])!='1':raise GovernanceReadError('Exact public login repair scope required')
 db.db.execute('LOCK TABLE '+','.join(db.table(t) for t in ['api_permissions','api_endpoints','api_endpoint_registry'])+' IN SHARE ROW EXCLUSIVE MODE')
 def rows(table,fields,where):
  return [dict(zip(fields,r)) for r in db.execute('SELECT '+','.join(fields)+' FROM '+table+' '+where)]
 endpoint=rows('api_endpoints',['id','http_method','route_path','permission_key'],'WHERE id=2')
 if len(endpoint)!=1 or endpoint[0]!=dict(id=2,http_method='POST',route_path='/v1/auth/login',permission_key=NEW):raise GovernanceReadError('Public login endpoint identity changed')
 fields=['id','api_id','role_id','runtime_artifact_id','permission_key','can_access']
 members=rows('api_permissions',fields,'WHERE api_id=2 ORDER BY id')
 if len(members)!=64:raise GovernanceReadError('Public login grant count changed')
 if all(r['permission_key']==NEW and r['can_access']==0 and r['runtime_artifact_id'] is None for r in members):return dict(apiId=2,repairedRows=64,enabledRoleGrants=0,accountChanges=0)
 origins=rows('api_endpoint_registry',['id','api_id','endpoint_code','method','endpoint_path'],"WHERE endpoint_code='api_v1_rmt_create_post'")
 fingerprint=hashlib.sha256(json.dumps(dict(members=members,endpoint=endpoint[0],origins=origins),sort_keys=True,separators=(',',':')).encode()).hexdigest()
 if fingerprint!=FINGERPRINT or any(r['permission_key']!=OLD for r in members):raise GovernanceReadError('Legacy grant fingerprint changed; refusing repair')
 valid_roles={r[0] for r in db.execute('SELECT id FROM roles')}
 if any(r['role_id'] not in valid_roles for r in members):raise GovernanceReadError('Role identities changed')
 result=db.db.execute('UPDATE '+db.table('api_permissions')+' SET permission_key=%s,can_access=%s,runtime_artifact_id=%s WHERE api_id=%s AND permission_key=%s',[db._value('api_permissions','permission_key',NEW),db._value('api_permissions','can_access',0),None,2,db._value('api_permissions','permission_key',OLD)])
 if result.rowcount!=64:raise GovernanceReadError('Unexpected repair count')
 expected=[dict(r,permission_key=NEW,can_access=0,runtime_artifact_id=None) for r in members]
 if rows('api_permissions',fields,'WHERE api_id=2 ORDER BY id')!=expected:raise GovernanceReadError('Repair readback mismatch')
 return dict(apiId=2,repairedRows=64,enabledRoleGrants=0,accountChanges=0)
def main():
 if len(sys.argv)!=2 or sys.argv[1] not in ['--dry-run','--apply']:raise SystemExit('Explicit mode required')
 with ProductionWorkflowStore() as db:
  result=repair(db)
  if repair(db)!=result:raise GovernanceReadError('Non-idempotent repair')
  if sys.argv[1]=='--dry-run':db.db.rollback()
 print('PUBLIC_LOGIN_GRANTS_REPAIRED '+json.dumps(result))
if __name__=='__main__':main()
