"""Pinned additive registration of three existing owner-only client reads."""
import hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError,connect
from twilio_voice_registration import retry_transaction
from twilio_contracts_registration import FIELDS as BASE_FIELDS,normalized
FIELDS=[*BASE_FIELDS,'rate_limit_key']
FILE=Path(__file__).with_name('vapi-client-read-contracts.json')
PURPOSE='Existing native client-owner reads; client_profiles.user_id and tenant_id remain authoritative; no new grants'
PATHS=['/v1/client/visits','/v1/client/consents','/v1/client/service-authorizations']
def definition():
 d=json.loads(FILE.read_text())
 if d.get('version')!=1 or d.get('anchorApiId')!=16431 or d.get('screenCode')!='client_profile' or d.get('service')!='client' or d.get('permission')!='authenticated_client_profile_owner' or [o['path'] for o in d['operations']]!=PATHS or any(o['method']!='GET' or o['request'].get('additionalProperties')is not False for o in d['operations']):raise GovernanceReadError('Exact existing client reads required')
 return d
def expected_scope():
 return dict(optInVariable='GOVERNANCE_VAPI_CLIENT_READS',tables=['api_endpoints','screen_api_links'],paths=PATHS,anchorApiId=16431,screenCode='client_profile',definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),sourceSha256={p:hashlib.sha256((ROOT/p).read_bytes()).hexdigest() for p in ['cloudflare/workers/src/client-self.ts','cloudflare/workers/src/client-records-registry.json']},schemaChanges=False,roleGrants=False,authenticationChanges=False,businessDataWrites=False,providerWrites=False,activation=False)
def anchor(db):
 d=definition();a=db.execute('SELECT app_id,service_name,auth_required,permission_key,http_method,route_path FROM api_endpoints WHERE id=?',(d['anchorApiId'],)).fetchall();s=db.execute('SELECT id,app_id,active FROM screens WHERE screen_code=?',(d['screenCode'],)).fetchall()
 if len(a)!=1 or a[0][1:]!=('client',1,d['permission'],'GET','/v1/client/home/profile') or len(s)!=1 or s[0][1]!=a[0][0] or s[0][2]!=1:raise GovernanceReadError('Existing client application/screen required')
 return a[0][0],s[0][0]
def values(op,app):
 d=definition();return dict(app_id=app,http_method='GET',route_path=op['path'],endpoint_code=op['key'],api_version='v1',health_status='unknown',uses_pagination=1,service_name='client',auth_required=1,permission_key=d['permission'],implementation_status='implemented',request_schema=json.dumps(op['request'],sort_keys=True),response_schema=json.dumps(op['response'],sort_keys=True),rate_limit_key='workspace.source')
class ClientAgentReadStore(ProductionWorkflowStore):
 def __init__(self,**kwargs):
  super().__init__(**kwargs)
  try:
   if self.pin.get('vapiClientReadContractWriter')!=expected_scope() or os.environ.get('GOVERNANCE_VAPI_CLIENT_READS')!='1':raise GovernanceReadError('Exact client-read opt-in required')
   self.db.execute('LOCK TABLE '+','.join(self.table(t) for t in ['api_endpoints','screens','screen_api_links'])+' IN SHARE ROW EXCLUSIVE MODE')
   for table in ['api_endpoints','screen_api_links']:
    meta=self.tables.get(table)
    if not meta or any(len(c['storage_types'])>1 for c in meta['columns']):raise GovernanceReadError('Exact metadata schema required')
    actual=dict(self.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s',(self.pin['schema'],'govt_'+table)).fetchall())
    expected={'_primecare_import_row':'bigint',**{c['name']:{'integer':'bigint','text':'text','real':'double precision','blob':'bytea'}.get(c['storage_types'][0] if c['storage_types'] else None,'jsonb') for c in meta['columns']}}
    if actual!=expected:raise GovernanceReadError('Metadata physical shape differs')
   anchor(self)
  except Exception:self.db.rollback();self.db.close();raise
 def insert_exact(self,table,entry):
  app,screen=anchor(self)
  if table=='api_endpoints':
   op=next((o for o in definition()['operations'] if o['path']==entry.get('route_path')),None)
   if not op or entry!=values(op,app):raise GovernanceReadError('Unrelated API refused')
  elif table=='screen_api_links':
   ids=[self.execute('SELECT id FROM api_endpoints WHERE route_path=? AND http_method=?',(p,'GET')).fetchall() for p in PATHS]
   if any(len(r)!=1 for r in ids) or entry not in [dict(screen_id=screen,api_id=r[0][0],purpose=PURPOSE) for r in ids]:raise GovernanceReadError('Unrelated screen link refused')
  else:raise GovernanceReadError('Unrelated metadata table refused')
  entry=dict(entry);entry['id']=self.execute('SELECT COALESCE(MAX(id),0)+1 FROM '+table).fetchone()[0];entry['_primecare_import_row']=self.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+self.table(table)).fetchone()[0]
  if not set(entry)<={'_primecare_import_row',*[c['name'] for c in self.tables[table]['columns']]}:raise GovernanceReadError('Unknown metadata column')
  keys=list(entry);self.db.execute('INSERT INTO '+self.table(table)+'('+','.join(map(quote,keys))+') VALUES('+','.join(['%s']*len(keys))+')',[entry[k] if k=='_primecare_import_row' else self._value(table,k,entry[k]) for k in keys]);return entry['id']
def register(db,apply=True):
 app,screen=anchor(db);ids={}
 # All three contracts are established before any screen link is inserted.
 for op in definition()['operations']:
  expected=values(op,app);rows=db.execute('SELECT id,'+','.join(FIELDS)+' FROM api_endpoints WHERE http_method=? AND route_path=?',('GET',op['path'])).fetchall()
  if len(rows)>1:raise GovernanceReadError('Duplicate client read identity')
  if rows:
   if normalized(rows[0][1:])!=[expected[k] for k in FIELDS]:raise GovernanceReadError('Edited client read preserved')
   aid=rows[0][0]
  else:
   if not apply:raise GovernanceReadError('Client read contract missing')
   aid=db.insert_exact('api_endpoints',expected)
  if type(aid)is not int or aid<1 or aid in ids.values() or db.execute('SELECT COUNT(*) FROM api_endpoints WHERE id=?',(aid,)).fetchall()!=[(1,)]:raise GovernanceReadError('Client API identity collision')
  ids[op['key']]=aid
 for aid in ids.values():
  rows=db.execute('SELECT id,purpose FROM screen_api_links WHERE screen_id=? AND api_id=?',(screen,aid)).fetchall()
  if len(rows)>1 or rows and rows[0][1]!=PURPOSE:raise GovernanceReadError('Edited client read link preserved')
  if not rows:
   if not apply:raise GovernanceReadError('Client read link missing')
   db.insert_exact('screen_api_links',dict(screen_id=screen,api_id=aid,purpose=PURPOSE))
 return dict(apiIds=ids,registered=3,screenLinks=3,roleGrants=0,authenticationChanges=False,schemaChanges=False,businessDataWrites=False,providerWrites=False,definitionSha256=expected_scope()['definitionSha256'])
def verify():
 with connect() as reader:return dict(**register(reader,False),independentReadback=True,writesAttempted=False)
def main():
 if sys.argv[1:]not in [['--dry-run'],['--apply'],['--verify']]:raise SystemExit('Explicit mode required')
 if sys.argv[1]=='--verify':result=verify()
 else:
  def work():
   with ClientAgentReadStore() as db:
    result=register(db)
    if result!=register(db):raise GovernanceReadError('Non-idempotent client reads')
    if sys.argv[1]=='--dry-run':db.db.rollback()
   return result
  result=retry_transaction(work)
  if sys.argv[1]=='--apply':
   checked=verify()
   if any(checked[k]!=v for k,v in result.items()):raise GovernanceReadError('Independent client read differs')
   result['independentReadback']=True
 print('CLIENT_AGENT_READ_CONTRACTS '+json.dumps(result))
if __name__=='__main__':main()
