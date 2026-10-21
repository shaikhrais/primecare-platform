"""Register Flutter presentation of the existing MFA contract; no grants or account writes."""
import json,hashlib,os,sys
from pathlib import Path
from mfa_surface import Store
from production_reader import GovernanceReadError
FILE=Path(__file__).with_name('mfa-native-surface.json')
def register(db):
 d=json.loads(FILE.read_text())
 scope=dict(optInVariable='GOVERNANCE_MFA_NATIVE_WRITES',tables=['screen_components','screen_required_elements'],screenId=949,apiId=16496,definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,roleGrants=False)
 if db.pin.get('mfaNativeSurfaceWriter')!=scope or os.environ.get(scope['optInVariable'])!='1':raise GovernanceReadError('Exact native MFA presentation scope required')
 if db.execute('SELECT screen_code,active FROM screens WHERE id=949').fetchall()!=[('mfa',1)]:raise GovernanceReadError('Existing MFA screen required')
 if db.execute('SELECT route_path,http_method,permission_key FROM api_endpoints WHERE id=16496').fetchall()!=[('/v1/auth/mfa','POST','password_verified_mfa_challenge')]:raise GovernanceReadError('Existing challenge authority required')
 db.db.execute('LOCK TABLE '+','.join(db.table(t) for t in scope['tables'])+' IN SHARE ROW EXCLUSIVE MODE')
 for name,component in d['controls'].items():
  if db.execute('SELECT active FROM primecare_ui_component_registry WHERE component_code=?',(component,)).fetchall()!=[(1,)]:raise GovernanceReadError('Registered component required')
  label='authMfa.'+('title' if name in ['form','seed','status'] else name)
  if not db.execute('SELECT resource_id FROM language_resources WHERE resource_key=? AND active=1',(label,)).fetchall():raise GovernanceReadError('Existing translation required')
  db.ensure('screen_components',dict(screen_id=949,component_code='authMfa.native.'+name),dict(component_name=label,component_type=component,data_cy='mfa-'+name,file_path=d['file'],implementation_status='registered-unimplemented'))
  db.ensure('screen_required_elements',dict(screen_id=949,element_key='authMfa.native.'+name),dict(element_type=component,label=label,test_id='mfa-'+name,required=1))
 return dict(screenId=949,apiId=16496,controls=6,accountChanges=0,roleGrants=0)
def main():
 if len(sys.argv)!=2 or sys.argv[1] not in ['--dry-run','--apply']:raise SystemExit('Explicit mode required')
 with Store() as db:
  r=register(db)
  if register(db)!=r:raise GovernanceReadError('Non-idempotent native registration')
  if sys.argv[1]=='--dry-run':db.db.rollback()
 print('MFA_NATIVE_REGISTERED '+json.dumps(r))
if __name__=='__main__':main()
