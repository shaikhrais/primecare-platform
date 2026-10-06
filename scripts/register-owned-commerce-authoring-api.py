"""Batches 225–235: existing owner authority, explicit FKs, metadata only."""
import json, re, sqlite3
from pathlib import Path
from record_authority_guard import validate_record_authority
ROOT=Path(__file__).resolve().parents[1]
DEFINITIONS=[
 {'service':'auth','path':'/me/authored-post-records','table':'blog_posts','ownerField':'author_user_id','tenantThroughUser':True,'collection':'posts','item':'post','fields':['id','status','created_at','updated_at'],'listBatch':225,'summaryBatch':226,'summaryField':'status','alias':'blogpost','aliasBatch':232},
 {'service':'auth','path':'/me/ledger-event-records','table':'transaction_ledger','ownerField':'actor_user_id','collection':'events','item':'event','fields':['id','status','created_at'],'listBatch':227,'summaryBatch':228,'summaryField':'status','alias':'transactionledger','aliasBatch':233},
 {'service':'client','path':'/inventory-item-records','table':'inventory_items','ownerField':'clientProfileId','collection':'items','item':'item','fields':['id','created_at','updated_at'],'listBatch':229,'batch':229,'summaryBatch':0,'alias':'inventoryitem','aliasBatch':234},
 {'service':'client','path':'/purchase-order-records','table':'purchase_orders','ownerField':'clientProfileId','collection':'orders','item':'order','fields':['id','status','created_at'],'listBatch':230,'batch':230,'summaryBatch':231,'summaryField':'status','alias':'purchaseorder','aliasBatch':235},
]
PERMISSIONS={'auth':'authenticated_self_record_owner','client':'authenticated_client_profile_owner'}
paging={'limit':{'type':'integer','minimum':1,'maximum':100,'default':25},'offset':{'type':'integer','minimum':0,'maximum':100000,'default':0}}
pagination={'type':'object','additionalProperties':False,'required':['limit','offset','total','hasMore'],'properties':{**paging,'total':{'type':'integer','minimum':0},'hasMore':{'type':'boolean'}}}
paths={};registries={service:json.loads((ROOT/'cloudflare/workers/src'/filename).read_text()) for service,filename in [('auth','self-records-registry.json'),('client','client-records-registry.json')]}
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 # Establish the existing authority and all relationship/projection requirements
 # before writing any endpoint, registry or OpenAPI artifact.
 for service,route in [('auth','/v1/auth/me/authored-message-records'),('client','/v1/client/family-notification-records')]:
  if db.execute("SELECT service_name,auth_required,permission_key FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchall()!=[(service,1,PERMISSIONS[service])]:raise RuntimeError('Baseline owner authority drift: '+route)
 prepared=[]
 for definition in DEFINITIONS:
  record=dict(definition);service=record['service'];table=record['table']
  validate_record_authority(db,[record],service,PERMISSIONS[service])
  rows=db.execute('SELECT c.column_name,c.data_type,c.is_nullable,c.is_foreign,c.foreign_table_name,c.foreign_column_name FROM db_schema_columns c JOIN db_schema_tables t ON t.id=c.table_id WHERE t.table_name=?',(table,)).fetchall()
  columns={r[0]:r[1:] for r in rows};target='users' if service=='auth' else 'client_profiles'
  if columns.get(record['ownerField'],())[2:]!=(1,target,'id'):raise RuntimeError('Unregistered owner relation: '+table)
  if not record.get('tenantThroughUser') and columns.get('tenant_id',())[2:]!=(1,'tenants','id'):raise RuntimeError('Unregistered tenant relation: '+table)
  for field in record['fields']:
   if not re.fullmatch(r'[A-Za-z_][A-Za-z0-9_]*',field) or field not in columns:raise RuntimeError('Missing projection: '+table)
  if columns['created_at'][1] or 'timestamp' not in columns['created_at'][0]:raise RuntimeError('Stable non-null timestamp required: '+table)
  properties={f:{'type':['string','null'] if columns[f][1] else 'string',**({'format':'date-time'} if 'timestamp' in columns[f][0] else {})} for f in record['fields']}
  record.update(orderField='created_at',types={f:p['type'] for f,p in properties.items()},dateFields=[f for f,p in properties.items() if p.get('format')=='date-time'])
  alias='/v1/premium/'+record['alias'];existing=db.execute("SELECT id FROM api_endpoints WHERE route_path=? AND http_method='GET'",(alias,)).fetchall()
  if len(existing)!=1:raise RuntimeError('Unique existing compatibility declaration required: '+alias)
  prepared.append((record,properties))
 # The runtime resolves the active actor's profile; verify the registered bridge.
 for table in ['users','client_profiles']:
  cols={r[0]:r[1:] for r in db.execute('SELECT c.column_name,c.is_foreign,c.foreign_table_name,c.foreign_column_name FROM db_schema_columns c JOIN db_schema_tables t ON t.id=c.table_id WHERE t.table_name=?',(table,))}
  if cols.get('tenant_id')!=(1,'tenants','id') or table=='client_profiles' and cols.get('user_id')!=(1,'users','id'):raise RuntimeError('Unregistered actor/profile bridge: '+table)
 for record,properties in prepared:
  service=record['service'];permission=PERMISSIONS[service]
  sid,app=db.execute("SELECT id,app_id FROM screens WHERE screen_code=?",('login' if service=='auth' else 'client_profile',)).fetchone()
  projected={'type':'object','additionalProperties':False,'required':record['fields'],'properties':properties}
  root='/v1/'+service+record['path']
  description=('Only metadata owned by the active bearer actor through '+record['table']+'.'+record['ownerField']+'. '+('Every query joins the current owning User tenant. Null authors are excluded.' if record.get('tenantThroughUser') else 'Every query binds the explicit owner and matching non-null tenant. Null owners and foreign tenants are excluded.')+' Client reads require exactly one currently owned ClientProfile. Return only registered ID, stored status where available and timestamps. Exclude article contents/title/slug/SEO, ledger amounts/accounts/references/checksums/IP/metadata, inventory SKU/name/quantity/prices and order supplier/number/amount. Stored labels do not establish publication, stock availability, payment, settlement, purchase approval or accounting correctness. Strict bounded stable paging and exact owned detail, no-store read-only repeatable-read snapshot, source limits and sanitized failures. No new roles, arbitrary owner filters or writes. Summary total counts stored status groups, including nullable labels, not rows.')
  modes=['list','detail']+(['summary'] if record.get('summaryField') else [])
  for mode in modes:
   route=root+('/{recordId}' if mode=='detail' else '/summary' if mode=='summary' else '')
   paged=mode!='detail';batch=record['summaryBatch'] if mode=='summary' else record['listBatch']
   if mode=='summary':
    group={'type':'object','additionalProperties':False,'required':['status','count'],'properties':{'status':properties['status'],'count':{'type':'integer','minimum':0}}}
    response={'type':'object','additionalProperties':False,'required':['groups','pagination'],'properties':{'groups':{'type':'array','items':group},'pagination':pagination}}
   elif mode=='list':response={'type':'object','additionalProperties':False,'required':[record['collection'],'pagination'],'properties':{record['collection']:{'type':'array','items':projected},'pagination':pagination}}
   else:response={'type':'object','additionalProperties':False,'required':[record['item']],'properties':{record['item']:projected}}
   request={'type':'object','additionalProperties':False,'properties':paging if paged else {}}
   code=(service+'_OWN_'+record['table']+'_'+mode).upper()
   rows=db.execute("SELECT id FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchall()
   if not rows:
    db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination) VALUES(?,?,?,'GET',?,1,'implemented',?,?,?,'workspace.source',?)",(app,code,route,service,permission,json.dumps(request),json.dumps(response),int(paged)))
   aid=db.execute("SELECT id FROM api_endpoints WHERE route_path=? AND http_method='GET'",(route,)).fetchone()[0]
   db.execute('UPDATE api_endpoints SET request_schema=?,response_schema=? WHERE id=?',(json.dumps(request),json.dumps(response),aid))
   db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,aid,'Existing owner authority; explicit FK metadata only'))
   db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,?,?,'implemented','pending')",('GET '+route,sid,batch,permission))
   params=[{'in':'query','name':name,'schema':schema} for name,schema in (paging if paged else {}).items()]
   if mode=='detail':params=[{'in':'path','name':'recordId','required':True,'schema':{'type':'string','pattern':'^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$'}}]
   paths[route]={'get':{'operationId':code.lower(),'summary':'Read own '+record['table'].replace('_',' ')+' '+mode,'description':description,'security':[{'bearerAuth':[]}],'parameters':params,'responses':{'200':{'description':'Owned projected metadata','content':{'application/json':{'schema':response}}},**{str(n):{'description':d} for n,d in [(400,'Invalid query or ID'),(401,'No active bearer'),(403,'Tenant mismatch'),(404,'Own record/profile absent'),(405,'Read only'),(429,'Source limit'),(503,'Unavailable or invalid data')]}}}}
  # Runtime registries do not need compatibility/generation fields.
  registered={k:v for k,v in record.items() if k not in ['service','alias','aliasBatch']}
  registries[service]=[r for r in registries[service] if r['path']!=registered['path']]+[registered]
 for service,filename in [('auth','self-records-registry.json'),('client','client-records-registry.json')]:
  (ROOT/'cloudflare/workers/src'/filename).write_text(json.dumps(registries[service],indent=2)+'\n')
 (ROOT/'docs/api/owned-commerce-authoring-batches-225-231.openapi.json').write_text(json.dumps({'openapi':'3.1.0','info':{'title':'PrimeCare Owned Commerce and Authored Post Metadata','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}},indent=2)+'\n')
print('Registered batches 225–231 explicit owner metadata; existing permissions only.')
