"""Exact native self-enrollment API links/grants; never user data or provider writes."""
import hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError
import voice_contact_contracts_registration as contracts
FILE=Path(__file__).with_name('voice-contact-access-registration.json')
TABLES={'screen_api_links':'id','api_permissions':'id'}
PURPOSE='Native first-time own-phone enrollment; current session and API/screen grants required; no AI access'
def definition():
 d=json.loads(FILE.read_text())
 if d.get('version')!=1 or d.get('screens')!={'234':'psw_messages','331':'patient_messages','559':'communication','578':'messaging'} or d.get('apiIds')!={'contact.status':16535,'contact.start':16536,'contact.check':16537} or d.get('eligibility')!='active-role-and-existing-communication-screen-can-view' or d.get('permission')!='role_screen_permissions' or d.get('existingDenials')!='preserve' or d.get('activation') is not False:raise GovernanceReadError('Exact self-enrollment access scope required')
 return d
def expected_scope():
 d=definition();return dict(optInVariable='GOVERNANCE_VOICE_CONTACT_ACCESS',tables=sorted(TABLES),screenIds=sorted(map(int,d['screens'])),apiIds=sorted(d['apiIds'].values()),eligibility=d['eligibility'],existingDenials='preserve',definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),schemaChanges=False,businessDataWrites=False,providerWrites=False,activation=False)
def eligible(db):
 d=definition()
 roles=db.execute('SELECT id,active FROM roles').fetchall();active=set()
 for rid,enabled in roles:
  if type(rid)is not int or type(enabled)is not int or enabled not in (0,1):raise GovernanceReadError('Malformed registered role')
  if enabled==1:
   if rid in active:raise GovernanceReadError('Duplicate active role')
   active.add(rid)
 rows=db.execute('SELECT role_id,screen_id,can_view FROM role_screen_permissions').fetchall();seen=set();allowed=set()
 for rid,sid,view in rows:
  if sid not in map(int,d['screens']):continue
  if (rid,sid) in seen or type(rid)is not int or type(view)is not int or view not in (0,1):raise GovernanceReadError('Ambiguous registered screen grant')
  seen.add((rid,sid))
  if rid in active and view==1:allowed.add(rid)
 return sorted(allowed)
def validate(db):
 d=definition()
 for sid,code in d['screens'].items():
  if db.execute('SELECT screen_code,active FROM screens WHERE id=?',(int(sid),)).fetchall()!=[(code,1)]:raise GovernanceReadError('Existing active communication screen required')
 anchor=db.execute('SELECT app_id FROM api_endpoints WHERE id=710').fetchall()
 if len(anchor)!=1:raise GovernanceReadError('Existing communication application required')
 for op in contracts.definition()['operations']:
  rows=db.execute('SELECT id,'+','.join(contracts.FIELDS)+' FROM api_endpoints WHERE http_method=? AND route_path=?',(op['method'],op['path'])).fetchall()
  if len(rows)!=1 or rows[0][0]!=d['apiIds'][op['key']] or contracts.normalized(rows[0][1:])!=[contracts.values(contracts.definition(),op,anchor[0][0])[k] for k in contracts.FIELDS]:raise GovernanceReadError('Exact registered enrollment API required')
 return eligible(db)
class VoiceContactAccessStore(ProductionWorkflowStore):
 def __init__(self,**kwargs):
  super().__init__(**kwargs)
  try:
   if self.pin.get('voiceContactAccessWriter')!=expected_scope() or os.environ.get('GOVERNANCE_VOICE_CONTACT_ACCESS')!='1':raise GovernanceReadError('Exact pinned enrollment access opt-in required')
   # Freeze eligibility and targets for the transaction; no role/screen rights are written.
   self.db.execute('LOCK TABLE '+','.join(self.table(t) for t in sorted(['roles','role_screen_permissions',*TABLES]))+' IN SHARE ROW EXCLUSIVE MODE')
   for table in TABLES:
    meta=self.tables.get(table)
    if not meta or any(len(c['storage_types'])>1 for c in meta['columns']):raise GovernanceReadError('Access metadata manifest required')
    actual=dict(self.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s',(self.pin['schema'],'govt_'+table)).fetchall())
    expected={'_primecare_import_row':'bigint',**{c['name']:{'integer':'bigint','text':'text','real':'double precision','blob':'bytea'}.get(c['storage_types'][0] if c['storage_types'] else None,'jsonb') for c in meta['columns']}}
    if actual!=expected:raise GovernanceReadError('Physical access metadata differs from manifest')
  except Exception:self.db.rollback();self.db.close();raise
 def insert_exact(self,table,entry):
  d=definition()
  if table=='screen_api_links':
   if set(entry)!={'screen_id','api_id','purpose'} or entry['screen_id'] not in map(int,d['screens']) or entry['api_id'] not in d['apiIds'].values() or entry['purpose']!=PURPOSE:raise GovernanceReadError('Exact native API link required')
  elif table=='api_permissions':
   if set(entry)!={'role_id','api_id','permission_key','can_access'} or entry['role_id'] not in validate(self) or entry['api_id'] not in d['apiIds'].values() or entry['permission_key']!=d['permission'] or entry['can_access']!=1:raise GovernanceReadError('Existing screen access required for own-phone API grant')
  else:raise GovernanceReadError('Unrelated access table refused')
  entry=dict(entry);entry['id']=self.execute('SELECT COALESCE(MAX(id),0)+1 FROM '+table).fetchone()[0];entry['_primecare_import_row']=self.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+self.table(table)).fetchone()[0]
  if not set(entry)<={'_primecare_import_row',*[c['name'] for c in self.tables[table]['columns']]}:raise GovernanceReadError('Unregistered access field')
  keys=list(entry);self.db.execute('INSERT INTO '+self.table(table)+'('+','.join(map(quote,keys))+') VALUES('+','.join(['%s']*len(keys))+')',[entry[k] if k=='_primecare_import_row' else self._value(table,k,entry[k]) for k in keys])
def register(db,apply=True):
 d=definition();roles=validate(db);denied=0
 for aid in d['apiIds'].values():
  for sid in map(int,d['screens']):
   rows=db.execute('SELECT id,purpose FROM screen_api_links WHERE screen_id=? AND api_id=?',(sid,aid)).fetchall()
   if len(rows)>1 or rows and rows[0][1]!=PURPOSE:raise GovernanceReadError('Existing native API link preserved')
   if not rows:
    if not apply:raise GovernanceReadError('Native API link missing')
    db.insert_exact('screen_api_links',dict(screen_id=sid,api_id=aid,purpose=PURPOSE))
  for rid in roles:
   rows=db.execute('SELECT id,permission_key,can_access FROM api_permissions WHERE role_id=? AND api_id=?',(rid,aid)).fetchall()
   if len(rows)>1 or rows and (rows[0][1]!=d['permission'] or type(rows[0][2])is not int or rows[0][2] not in (0,1)):raise GovernanceReadError('Edited or ambiguous native API permission preserved')
   if rows and rows[0][2]==0:denied+=1
   if not rows:
    if not apply:raise GovernanceReadError('Native API permission missing')
    db.insert_exact('api_permissions',dict(role_id=rid,api_id=aid,permission_key=d['permission'],can_access=1))
 return dict(definitionSha256=expected_scope()['definitionSha256'],screenLinks=12,eligibleRoles=len(roles),explicitDenialsPreserved=denied,apiGrants=len(roles)*3-denied,businessDataWrites=False,providerWrites=False,activation=False)
def main():
 if sys.argv[1:] not in [['--dry-run'],['--apply']]:raise SystemExit('Explicit mode required')
 with VoiceContactAccessStore() as db:
  result=register(db)
  if result!=register(db):raise GovernanceReadError('Non-idempotent enrollment access')
  if sys.argv[1]=='--dry-run':db.db.rollback()
 if sys.argv[1]=='--apply':
  from production_reader import connect
  with connect() as reader:
   if register(reader,False)!=result:raise GovernanceReadError('Independent enrollment access readback differs')
  result['independentReadback']=True
 print('VOICE_CONTACT_ACCESS '+json.dumps(result))
if __name__=='__main__':main()
