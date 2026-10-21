"""Reconcile public login metadata with its deployed password/MFA behavior."""
import json,hashlib,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError
FILE=Path(__file__).with_name('mfa-login-contract.json')
def register(db):
 expected=dict(optInVariable='GOVERNANCE_MFA_LOGIN_CONTRACT',tables=['api_endpoints'],apiIds=[2],definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,roleGrants=False)
 if db.pin.get('mfaLoginContractWriter')!=expected or os.environ.get('GOVERNANCE_MFA_LOGIN_CONTRACT')!='1':raise GovernanceReadError('Exact login contract scope required')
 d=json.loads(FILE.read_text())
 if db.execute('SELECT route_code,route_path FROM auth_route_registry WHERE id=1').fetchall()!=[('login','/login')]:raise GovernanceReadError('Existing public login authority changed')
 table=db.table('api_endpoints');db.db.execute('LOCK TABLE '+table+' IN SHARE ROW EXCLUSIVE MODE')
 fields=['service_name','auth_required','request_schema','response_schema','permission_key','rate_limit_key']
 row=db.execute('SELECT route_path,http_method,'+','.join(fields)+' FROM api_endpoints WHERE id=2').fetchall()
 if len(row)!=1 or row[0][:2]!=(d['route'],d['method']):raise GovernanceReadError('Existing login API changed')
 target=('auth',0,json.dumps(d['request'],sort_keys=True),json.dumps(d['response'],sort_keys=True),'public_password_exchange','login')
 current=tuple(row[0][2:])
 if current!=target:
  if current!=tuple(d['reviewed'][k] for k in fields):raise GovernanceReadError('Login metadata drift; preserve existing contract')
  r=db.db.execute('UPDATE '+table+' SET '+','.join(quote(k)+'=%s' for k in fields)+' WHERE id=2',[db._value('api_endpoints',k,v) for k,v in zip(fields,target)])
  if r.rowcount!=1:raise GovernanceReadError('Unexpected login update count')
 if db.execute('SELECT '+','.join(fields)+' FROM api_endpoints WHERE id=2').fetchall()!=[target]:raise GovernanceReadError('Login contract readback mismatch')
 return dict(apiId=2,publicPasswordExchange=True,mfaChallengeDocumented=True,roleGrants=0,accountChanges=0)
def main():
 if len(sys.argv)!=2 or sys.argv[1] not in ['--apply','--dry-run']:raise SystemExit('Explicit mode required')
 with ProductionWorkflowStore() as db:
  result=register(db)
  if result!=register(db):raise GovernanceReadError('Non-idempotent login contract')
  if sys.argv[1]=='--dry-run':db.db.rollback()
 print('MFA_LOGIN_CONTRACT_REGISTERED '+json.dumps(result))
if __name__=='__main__':main()
