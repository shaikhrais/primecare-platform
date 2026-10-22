"""Register shared account session controls from existing route7/APIs; no actor grants change."""
import datetime,hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError
TABLES={'screens':'id','screen_components':'id','screen_required_elements':'id','screen_api_links':'id','language_resources':'resource_id','language_resource_values':'translation_id'}
BINDING_TABLES=['virtual_workflow_definitions','virtual_workflow_steps','virtual_workflow_source_links']
def definition():return json.loads(Path(__file__).with_name('account-sessions-registration.json').read_text())
class AccountRegistrationStore(ProductionWorkflowStore):
    def __init__(self,**kwargs):
        super().__init__(**kwargs)
        try:
            expected={'optInVariable':'GOVERNANCE_ACCOUNT_REGISTRATION_WRITES','screenCode':'AUTHENTICATED_ACCOUNT','routeRegistryId':7,'appId':1,'apiIds':[16425,16426],'tables':[*TABLES,*BINDING_TABLES],'definitionSha256':hashlib.sha256(Path(__file__).with_name('account-sessions-registration.json').read_bytes()).hexdigest(),'schemaChanges':False,'permissionChanges':False,'businessDataWrites':False}
            if self.pin.get('accountSessionsRegistrationWriter')!=expected or os.environ.get('GOVERNANCE_ACCOUNT_REGISTRATION_WRITES')!='1':raise GovernanceReadError('Exact pinned shared-account cutover scope required')
            self.db.execute('LOCK TABLE '+','.join(self.table(t) for t in sorted(set([*TABLES,*BINDING_TABLES])))+' IN SHARE ROW EXCLUSIVE MODE')
            for table in [*TABLES,*BINDING_TABLES]:
                meta=self.tables.get(table)
                if not meta or any(len(c['storage_types'])>1 for c in meta['columns']):raise GovernanceReadError('Missing/mixed account metadata schema')
                actual=dict(self.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s',(self.pin['schema'],'govt_'+table)).fetchall())
                expected={'_primecare_import_row':'bigint',**{c['name']:{'integer':'bigint','text':'text','real':'double precision','blob':'bytea'}.get(c['storage_types'][0] if c['storage_types'] else None,'jsonb') for c in meta['columns']}}
                if actual!=expected:raise GovernanceReadError('Account metadata physical schema differs from manifest')
            self.screen_id=None
        except Exception:self.db.rollback();self.db.close();raise
    def insert_metadata(self,table,values):
        values=dict(values);d=definition()
        if table not in TABLES:raise GovernanceReadError('Unrelated account metadata insertion refused')
        if table=='screens':
            expected={k:d[k2] for k,k2 in [('app_id','appId'),('screen_code','screenCode'),('screen_name','screenName'),('route_path','route'),('actual_file_path','file')]}
            if any(values.get(k)!=v for k,v in expected.items()) or values.get('role_id') is not None:raise GovernanceReadError('Only the existing shared authenticated account surface may be registered')
        if table in ['screen_components','screen_required_elements','screen_api_links'] and (self.screen_id is None or values.get('screen_id')!=self.screen_id):raise GovernanceReadError('Shared-account screen binding required')
        if table=='screen_components' and (values.get('file_path')!=d['panelFile'] or not values.get('component_code','').startswith('accountSessions.')):raise GovernanceReadError('Own-session component namespace required')
        if table=='screen_required_elements' and not values.get('element_key','').startswith('accountSessions.'):raise GovernanceReadError('Own-session element namespace required')
        if table=='screen_api_links' and values.get('api_id') not in d['apiIds'].values():raise GovernanceReadError('Only existing own-session APIs may be linked')
        if table=='language_resources' and not values.get('resource_key','').startswith('accountSessions.'):raise GovernanceReadError('Own-session resource namespace required')
        if table=='language_resource_values' and not self.execute("SELECT resource_id FROM language_resources WHERE resource_id=? AND context='accountSessions'",(values.get('resource_id'),)).fetchone():raise GovernanceReadError('Own-session translation namespace required')
        columns={c['name'] for c in self.tables[table]['columns']}
        if not set(values).issubset(columns):raise GovernanceReadError('Unregistered account metadata field')
        values[TABLES[table]]=self.execute('SELECT COALESCE(MAX('+TABLES[table]+'),0)+1 FROM '+table).fetchone()[0]
        values['_primecare_import_row']=self.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+self.table(table)).fetchone()[0]
        fields=list(values)
        self.db.execute('INSERT INTO '+self.table(table)+'('+','.join(map(quote,fields))+') VALUES('+','.join(['%s']*len(fields))+')',[values[k] if k=='_primecare_import_row' else self._value(table,k,values[k]) for k in fields])
        return values[TABLES[table]]
    def ensure(self,table,key,values,initial=None):
        fields=list(values)
        rows=self.execute('SELECT '+TABLES[table]+','+','.join(fields)+' FROM '+table+' WHERE '+' AND '.join(k+'=?' for k in key),tuple(key.values())).fetchall()
        if len(rows)>1:raise GovernanceReadError('Duplicate shared-account metadata key')
        if rows:
            if tuple(rows[0][1:])!=tuple(values.values()):raise GovernanceReadError('Edited account metadata preserved; reconciliation required')
            return rows[0][0]
        return self.insert_metadata(table,{**key,**values,**(initial or {})})
def validate_bindings(db,d):
    if d!=definition():raise GovernanceReadError('Exact pinned own-session definition required')
    if db.execute("SELECT app_code FROM apps WHERE id=1").fetchall()!=[('ui',)]:raise GovernanceReadError('Registered shared UI application required')
    if db.execute('SELECT route_code,route_path,flow_type FROM auth_route_registry WHERE id=7').fetchall()!=[('success','/success','authenticated_session_summary')]:raise GovernanceReadError('Existing authenticated account entry changed')
    if db.execute("SELECT route_path FROM auth_route_registry WHERE id=1 AND route_code='login'").fetchall()!=[('/login',)]:raise GovernanceReadError('Existing login destination changed')
    for op,method in [('list','GET'),('revoke','DELETE')]:
        if db.execute('SELECT http_method,route_path,service_name,auth_required,permission_key FROM api_endpoints WHERE id=?',(d['apiIds'][op],)).fetchall()!=[(method,d['endpoints'][op],'auth',1,'authenticated_self_session')]:raise GovernanceReadError('Existing own-session API authority changed')
    for c in d['controls'].values():
        if db.execute('SELECT component_code,active FROM primecare_ui_component_registry WHERE id=?',(c['componentId'],)).fetchall()!=[(c['component'],1)]:raise GovernanceReadError('Registered account component changed')
def read_catalog(db,d):
    validate_bindings(db,d)
    rows=db.execute('SELECT id,app_id,role_id,route_path,actual_file_path,active FROM screens WHERE screen_code=?',(d['screenCode'],)).fetchall()
    if len(rows)!=1 or rows[0][1:]!=(1,None,'/success',d['file'],1):raise GovernanceReadError('Registered shared-account screen missing or changed')
    sid=rows[0][0]
    actual=db.execute("SELECT component_code,component_type,data_cy,file_path FROM screen_components WHERE screen_id=? AND component_code LIKE 'accountSessions.%' ORDER BY component_code",(sid,)).fetchall()
    expected=sorted(('accountSessions.'+key,c['component'],c['testId'],d['panelFile']) for key,c in d['controls'].items())
    if actual!=expected:raise GovernanceReadError('Own-session controls differ from registration')
    if sorted(r[0] for r in db.execute('SELECT api_id FROM screen_api_links WHERE screen_id=?',(sid,)))!=sorted(d['apiIds'].values()):raise GovernanceReadError('Own-session API links differ from registration')
    locales={l:{} for l in ['en','fr','es']}
    for key,locale,text in db.execute("SELECT r.resource_key,l.language_code,v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.context='accountSessions' AND r.active=1"):
        if locale in locales:
            key=key.removeprefix('accountSessions.')
            if key in locales[locale]:raise GovernanceReadError('Duplicate account translation')
            locales[locale][key]=text
    if locales!=d['locales']:raise GovernanceReadError('Account resources differ from production registration')
    return {**d,'screenId':sid,'authority':{'source':'pinned-production-postgresql','schema':db.pin['schema'],'manifestSha256':db.pin['manifestSha256'],'authorization':'existing authenticated_self_session APIs; existing route7; no role grant changes','reviewStatus':'pending'},'implementationStatus':'registered-unimplemented'}
def register(db,d):
    validate_bindings(db,d)
    conflicts=db.execute('SELECT screen_code FROM screens WHERE route_path=?',(d['route'],)).fetchall()
    if conflicts and conflicts!=[(d['screenCode'],)]:raise GovernanceReadError('Another screen already owns account route; preserve it')
    sid=db.ensure('screens',{'screen_code':d['screenCode']},{'app_id':1,'role_id':None,'screen_name':d['screenName'],'route_path':d['route'],'actual_file_path':d['file'],'active':1},initial={'stage':'created','runtime_verified':0,'cypress_verified':0,'production_ready':0,'completeness_score':0,'implementation_tag':'placeholder','content_tag':'governed_content','api_tag':'api_missing','test_tag':'test_pending','review_tag':'not_reviewed','component_summary':'Own-session controls registered; implementation pending.','section_summary':'Shared authenticated account; route registry7.'})
    db.screen_id=sid
    languages=dict(db.execute("SELECT language_code,language_id FROM languages WHERE language_code IN ('en','fr','es') AND enabled=1"))
    if set(languages)!=set(d['locales']):raise GovernanceReadError('Existing account languages required')
    for locale,values in d['locales'].items():
        for key,text in values.items():
            rid=db.ensure('language_resources',{'resource_key':'accountSessions.'+key},{'resource_group':'accountSessions','description':'Shared authenticated account sessions','context':'accountSessions','active':1})
            db.ensure('language_resource_values',{'resource_id':rid,'language_id':languages[locale]},{'translated_text':text,'reviewed':0,'approved':0,'version':'account-sessions-v1'})
    for key,c in d['controls'].items():
        label=d['locales']['en'][c['label']]
        db.ensure('screen_components',{'screen_id':sid,'component_code':'accountSessions.'+key},{'component_name':label,'component_type':c['component'],'data_cy':c['testId'],'file_path':d['panelFile'],'implementation_status':'registered-unimplemented'})
        db.ensure('screen_required_elements',{'screen_id':sid,'element_key':'accountSessions.'+key},{'element_type':'button' if c['component']=='prime_button' else 'table' if c['component']=='prime_table_web' else 'layout','label':label,'test_id':c['testId'],'required':1})
    for op,aid in d['apiIds'].items():db.ensure('screen_api_links',{'screen_id':sid,'api_id':aid},{'purpose':'Existing authenticated self-session '+op+'; no role grant'})
    for flow,op,method in zip(d['flows'],['list','revoke'],['GET','DELETE']):
        row=db.execute('SELECT definition_json,definition_sha256,actor_roles_json FROM virtual_workflow_definitions WHERE flow_id=? AND flow_kind=?',(flow,'business_process')).fetchone()
        if not row or hashlib.sha256(row[0].encode()).hexdigest()!=row[1]:raise GovernanceReadError('Existing account process missing or changed')
        plan=json.loads(row[0]);actors=json.loads(row[2])
        if plan['id']!=flow or plan['actor_roles']!=actors or not actors:raise GovernanceReadError('Existing own-session actors changed')
        selected=[s for s in plan['steps'] if s.get('api_method')==method]
        if len(selected)!=1 or selected[0].get('api_path') not in ['/v1/auth/user/sessions',d['endpoints'][op]]:raise GovernanceReadError('Existing own-session step changed')
        normalized=db.execute('SELECT step_order,api_path FROM virtual_workflow_steps WHERE flow_id=? AND api_method=?',(flow,method)).fetchall()
        if len(normalized)!=1 or normalized[0][1] not in ['/v1/auth/user/sessions',d['endpoints'][op]]:raise GovernanceReadError('Normalized own-session step changed')
        if plan.get('own_sessions_implementation_binding') is True:
            if selected[0]['api_path']!=d['endpoints'][op]:raise GovernanceReadError('Mapped own-session operation changed')
            continue
        selected[0]['api_path']=d['endpoints'][op]
        refs=[{'table':t,'key':key,'key_columns':['id'],'reference_status':'row'} for t,key in [('auth_route_registry',7),('screens',sid),('api_endpoints',d['apiIds'][op])]]
        plan.update(governance_refs=refs,declared_governance_refs=refs,registered_source={'screen_id':sid,'route_registry_id':7,'api_id':d['apiIds'][op],'controls':d['controls'],'presentation':'shared current-account surface; authenticated_self_session'},gaps=['Controls and canonical APIs registered; own-session panel implementation and current execution/review evidence remain pending.'])
        encoded=json.dumps(plan,ensure_ascii=False,sort_keys=True);fingerprint=hashlib.sha256(encoded.encode()).hexdigest()
        if fingerprint!=row[1]:
            db._update('virtual_workflow_definitions',{'definition_json':encoded,'definition_sha256':fingerprint,'definition_status':'draft','test_status':'blocked','blocker_json':json.dumps(plan['gaps']),'updated_at':datetime.datetime.now(datetime.timezone.utc).isoformat()},flow)
            cur=db.db.execute('UPDATE '+db.table('virtual_workflow_steps')+' SET api_path=%s WHERE flow_id=%s AND step_order=%s',(d['endpoints'][op],flow,normalized[0][0]))
            if cur.rowcount!=1:raise GovernanceReadError('Unexpected account step update count')
            db.db.execute('DELETE FROM '+db.table('virtual_workflow_source_links')+' WHERE flow_id=%s',(flow,))
            for ref in refs:
                values={'flow_id':flow,'source_table':ref['table'],'source_key':str(ref['key']),'source_key_columns':json.dumps(ref['key_columns']),'reference_status':'row'}
                ordinal=db.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+db.table('virtual_workflow_source_links')).fetchone()[0]
                fields=list(values)
                db.db.execute('INSERT INTO '+db.table('virtual_workflow_source_links')+' (_primecare_import_row,'+','.join(map(quote,fields))+') VALUES('+','.join(['%s']*(len(fields)+1))+')',[ordinal,*[db._value('virtual_workflow_source_links',k,values[k]) for k in fields]])
    return read_catalog(db,d)

def committed_catalog():
    return json.loads((ROOT/'packages/shared/src/account-sessions.json').read_text())
def bind_implementation(db,catalog):
    d=definition()
    if catalog!=read_catalog(db,d) or catalog!=committed_catalog():
        raise GovernanceReadError('Current production account catalog required')
    paths=[d['file'],d['panelFile'],'websites/typescript/src/sessions-client.ts','websites/typescript/src/sessions-controller.ts','websites/typescript/src/infrastructure/http/base-session-client.ts','cloudflare/workers/src/self-sessions.ts','cloudflare/workers/src/auth.ts','cloudflare/workers/src/gateway.ts','packages/shared/src/account-sessions.json','tools/governance-production/account_sessions_registration.py']
    hashes={p:hashlib.sha256((ROOT/p).read_bytes()).hexdigest() for p in paths}
    results=[]
    for flow,op,method in zip(d['flows'],['list','revoke'],['GET','DELETE']):
        rows=db.execute('SELECT definition_json,definition_sha256,flow_kind,actor_roles_json FROM virtual_workflow_definitions WHERE flow_id=?',(flow,)).fetchall()
        if len(rows)!=1 or rows[0][2]!='business_process' or hashlib.sha256(rows[0][0].encode()).hexdigest()!=rows[0][1]:
            raise GovernanceReadError('Exact own-session process required')
        plan=json.loads(rows[0][0]);actors=json.loads(rows[0][3])
        if not actors or plan['id']!=flow or plan['actor_roles']!=actors or not any(s.get('api_method')==method and s.get('api_path')==d['endpoints'][op] for s in plan['steps']):
            raise GovernanceReadError('Registered own-session actors or operation changed')
        refs=[dict(table=t,key=k,key_columns=['id'],reference_status='row') for t,k in [('auth_route_registry',7),('screens',catalog['screenId']),('api_endpoints',d['apiIds'][op])]]
        for key, in db.execute('SELECT id FROM screen_components WHERE screen_id=? AND file_path=? ORDER BY id',(catalog['screenId'],d['panelFile'])):
            refs.append(dict(table='screen_components',key=key,key_columns=['id'],reference_status='row'))
        for key, in db.execute("SELECT resource_id FROM language_resources WHERE context='accountSessions' AND active=1 ORDER BY resource_id"):
            refs.append(dict(table='language_resources',key=key,key_columns=['resource_id'],reference_status='row'))
        plan.update(own_sessions_implementation_binding=True,governance_refs=refs,declared_governance_refs=refs,definition_quality='source_mapped',source_paths=paths,source_sha256=hashes,gaps=['Own-session source implemented. Current deployed browser/API/database evidence, complete failure alternatives, required reviews and independent acceptance remain separate gates.'])
        encoded=json.dumps(plan,ensure_ascii=False,sort_keys=True);fingerprint=hashlib.sha256(encoded.encode()).hexdigest()
        if fingerprint==rows[0][1]:
            results.append({'flow_id':flow,'changed':False});continue
        db._update('virtual_workflow_definitions',{'definition_json':encoded,'definition_sha256':fingerprint,'definition_status':'source_mapped','verification_status':'implemented-unverified','test_status':'stale','blocker_json':json.dumps(plan['gaps']),'updated_at':datetime.datetime.now(datetime.timezone.utc).isoformat()},flow)
        db.db.execute('DELETE FROM '+db.table('virtual_workflow_source_links')+' WHERE flow_id=%s',(flow,))
        for ref in refs:
            values={'flow_id':flow,'source_table':ref['table'],'source_key':str(ref['key']),'source_key_columns':json.dumps(ref['key_columns']),'reference_status':'row'}
            ordinal=db.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+db.table('virtual_workflow_source_links')).fetchone()[0]
            fields=list(values)
            db.db.execute('INSERT INTO '+db.table('virtual_workflow_source_links')+' (_primecare_import_row,'+','.join(map(quote,fields))+') VALUES('+','.join(['%s']*(len(fields)+1))+')',[ordinal,*[db._value('virtual_workflow_source_links',k,values[k]) for k in fields]])
        results.append({'flow_id':flow,'changed':True,'definition_sha256':fingerprint,'source_links':len(refs),'verification_status':'implemented-unverified','test_status':'stale'})
    return results

def open_production_store():
    import psycopg,time
    for attempt in range(3):
        try:return AccountRegistrationStore()
        except psycopg.errors.LockNotAvailable:
            if attempt==2:raise
            time.sleep(2)
def main():
    if '--apply' not in sys.argv:raise SystemExit('Explicit --apply required')
    with open_production_store() as db:
        catalog=register(db,definition())
        bindings=bind_implementation(db,catalog)
        state={'flows':bindings,'screenId':catalog['screenId'],'apiIds':catalog['apiIds'],'controls':len(catalog['controls']),'nativeScreensChanged':False,'roleGrantsChanged':False,'schemaChanged':False,'implementation':'pending','reviewApprovals':'pending'}
        db.execute('INSERT INTO virtual_flow_catalog_snapshots VALUES(?,?,CURRENT_TIMESTAMP) ON CONFLICT(name) DO UPDATE SET summary_json=excluded.summary_json,updated_at=CURRENT_TIMESTAMP',('account-sessions-registration-current',json.dumps(state)))
    out=ROOT/'test-results/account-sessions-registration';out.mkdir(parents=True,exist_ok=True)
    (out/'catalog.json').write_text(json.dumps(catalog,ensure_ascii=False,indent=2)+'\n');(out/'receipt.json').write_text(json.dumps(state,indent=2))
    print('ACCOUNT_SESSIONS_REGISTERED '+json.dumps(state))
if __name__=='__main__':main()
