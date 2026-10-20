"""Narrow production cutover for the already implemented maintenance surface.

No DDL, business data writes, new actor authority, or arbitrary SQL write API.
Existing screen grants and source routes are checked before metadata is written.
"""
import datetime
import hashlib
import json
import os
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools/workflow-verification'))
from production_store import ProductionWorkflowStore, quote
from production_reader import GovernanceReadError

TABLES = {'api_endpoints': 'id', 'api_permissions': 'id',
          'screen_api_links': 'id', 'screen_components': 'id',
          'screen_required_elements': 'id', 'language_resources': 'resource_id',
          'language_resource_values': 'translation_id'}


class MaintenanceRegistrationStore(ProductionWorkflowStore):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        try:
            scope = self.pin.get('maintenanceRegistrationWriter', {})
            if (scope.get('optInVariable') != 'GOVERNANCE_MAINTENANCE_REGISTRATION_WRITES'
                    or set(scope.get('tables', [])) != set(TABLES)
                    or scope.get('screenId') != 1264 or scope.get('schemaChanges') is not False
                    or scope.get('businessDataWrites') is not False
                    or os.environ.get('GOVERNANCE_MAINTENANCE_REGISTRATION_WRITES') != '1'):
                raise GovernanceReadError('Explicit pinned maintenance metadata write scope required')
            self.db.execute('LOCK TABLE '+','.join(self.table(t) for t in sorted(TABLES))+' IN SHARE ROW EXCLUSIVE MODE')
            for table in TABLES:
                meta = self.tables.get(table)
                if not meta or any(len(c['storage_types']) > 1 for c in meta['columns']):
                    raise GovernanceReadError('Missing or mixed registered metadata schema: '+table)
                actual = dict(self.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s', (self.pin['schema'], 'govt_'+table)).fetchall())
                expected = {'_primecare_import_row':'bigint'}
                expected.update({c['name']:{'integer':'bigint','real':'double precision','text':'text','blob':'bytea'}.get(c['storage_types'][0] if c['storage_types'] else None,'jsonb') for c in meta['columns']})
                if actual != expected:
                    raise GovernanceReadError('Physical metadata differs from pin: '+table)
        except Exception:
            self.db.rollback(); self.db.close()
            raise

    def insert_metadata(self, table, values):
        if table not in TABLES:
            raise GovernanceReadError('Maintenance metadata table not allowed')
        values = dict(values)
        if table=='language_resources' and not values.get('resource_key','').startswith('maintenance.'):
            raise GovernanceReadError('Maintenance resource namespace required')
        if table=='language_resource_values' and not self.execute("SELECT resource_id FROM language_resources WHERE resource_id=? AND context='maintenance'",(values.get('resource_id'),)).fetchone():
            raise GovernanceReadError('Maintenance resource translation required')
        if table in ['screen_components','screen_required_elements','screen_api_links'] and values.get('screen_id')!=1264:
            raise GovernanceReadError('Only existing maintenance screen1264 may be registered')
        if table=='api_endpoints' and values.get('route_path') not in ['/v1/auth/maintenance/configuration','/v1/auth/maintenance/configuration/test-email']:
            raise GovernanceReadError('Existing maintenance route required')
        if table in ['api_permissions','screen_api_links'] and not self.execute("SELECT id FROM api_endpoints WHERE id=? AND route_path IN ('/v1/auth/maintenance/configuration','/v1/auth/maintenance/configuration/test-email') AND service_name='auth'",(values.get('api_id'),)).fetchone():
            raise GovernanceReadError('Maintenance API binding required')
        if table=='api_permissions' and not self.execute('SELECT role_id FROM role_screen_permissions WHERE role_id=? AND screen_id=1264 AND can_view=1',(values.get('role_id'),)).fetchone():
            raise GovernanceReadError('No new maintenance actor grant may be introduced')
        columns = {c['name'] for c in self.tables[table]['columns']}
        if not set(values).issubset(columns):
            raise GovernanceReadError('Unregistered maintenance metadata field')
        identity = TABLES[table]
        values[identity] = self.execute('SELECT COALESCE(MAX('+identity+'),0)+1 FROM '+table).fetchone()[0]
        now = datetime.datetime.now(datetime.timezone.utc).isoformat()
        for key in ('created_at','updated_at'):
            if key in columns:values.setdefault(key,now)
        values['_primecare_import_row'] = self.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+self.table(table)).fetchone()[0]
        fields = list(values)
        self.db.execute('INSERT INTO '+self.table(table)+'('+','.join(map(quote,fields))+') VALUES('+','.join(['%s']*len(fields))+')', [values[c] if c=='_primecare_import_row' else self._value(table,c,values[c]) for c in fields])
        return values[identity]

    def ensure(self, table, key, values):
        fields = list(values)
        rows = self.execute('SELECT '+TABLES[table]+','+','.join(fields)+' FROM '+table+' WHERE '+' AND '.join(k+'=?' for k in key), tuple(key.values())).fetchall()
        if len(rows)>1:raise GovernanceReadError('Duplicate maintenance natural key: '+table)
        if rows:
            if tuple(rows[0][1:]) != tuple(values.values()):
                raise GovernanceReadError('Existing maintenance metadata differs; explicit reviewed migration required: '+table)
            return rows[0][0]
        return self.insert_metadata(table,{**key,**values})


def register(db, definition):
    if definition['screenId']!=1264 or definition['route']!='/maintenance/configuration':
        raise GovernanceReadError('Unexpected maintenance surface')
    screen = db.execute('SELECT screen_code,route_path FROM screens WHERE id=1264 AND active=1').fetchall()
    if screen != [('MAINTENANCE_CONFIGURATION','/maintenance/configuration')]:
        raise GovernanceReadError('Live maintenance screen binding changed')
    grants = db.execute("SELECT r.role_code,p.can_view,p.can_create,p.can_edit FROM role_screen_permissions p JOIN roles r ON r.id=p.role_id WHERE p.screen_id=1264 AND (p.can_view=1 OR p.can_create=1 OR p.can_edit=1)").fetchall()
    if sorted(grants)!=[('ceo',1,1,1),('maintenance',1,1,1)]:
        raise GovernanceReadError('Existing maintenance authority changed; grants are never added by this writer')
    actor_ids = dict(db.execute("SELECT role_code,id FROM roles WHERE role_code IN ('ceo','maintenance') AND active=1"))
    apps = db.execute("SELECT id FROM apps WHERE app_code='at'").fetchall()
    if len(apps)!=1:raise GovernanceReadError('Exact existing auth API app required')
    language_ids = dict(db.execute("SELECT language_code,language_id FROM languages WHERE language_code IN ('en','fr','es') AND enabled=1"))
    if set(language_ids)!=set(['en','fr','es']):raise GovernanceReadError('Existing EN/FR/ES languages required')
    for key,values in definition['resources'].items():
        if len(values)!=3 or any(not isinstance(v,str) or not v.strip() for v in values):raise GovernanceReadError('Complete EN/FR/ES resource required')
        rid = db.ensure('language_resources',{'resource_key':'maintenance.'+key},{'resource_group':'maintenance','description':'Existing maintenance configuration presentation','context':'maintenance','active':1})
        for locale,text in zip(['en','fr','es'],values):
            db.ensure('language_resource_values',{'resource_id':rid,'language_id':language_ids[locale]},{'translated_text':text,'reviewed':0,'approved':1,'version':'maintenance-v1'})
    for code,test_id in definition['controls'].items():
        if not test_id.startswith(('maintenance-','screen-maintenance-')):raise GovernanceReadError('Maintenance control namespace required')
        label_key = {'screen':'title','status':'pendingTitle','pending':'pendingTitle','settings':'delivery','testEmail':'testEmail','createAccount':'createTitle','createSubmit':'createSubmit','signout':'signout'}.get(code,code)
        if code.startswith('template_'):label_key=code.rsplit('_',1)[1];label_key='templateTitle' if label_key=='title' else label_key
        label = definition['resources'].get(label_key,[code])[0]
        kind = 'input' if code in ['sender','accountEmail','accountPassword'] or code.startswith('template_') else 'button' if code in ['save','testEmail','createSubmit','refresh','signout'] else 'layout'
        db.ensure('screen_required_elements',{'screen_id':1264,'element_key':code},{'element_type':kind,'label':label,'test_id':test_id,'required':1})
        db.ensure('screen_components',{'screen_id':1264,'component_code':code},{'component_name':label,'component_type':kind,'data_cy':test_id,'file_path':'websites/typescript/src/maintenance.ts','implementation_status':'registered-unverified'})
    string={'type':'string'};template={'type':'object','required':['subject','title','body','required'],'additionalProperties':False,'properties':{'subject':string,'title':string,'body':string,'required':{'type':'array','items':string}}}
    fields={'sender':{'type':'string','format':'email'},'provider':{'const':'cloudflare'},'keyConfigured':{'const':False},'bindingConfigured':{'type':'boolean'},'settingsReady':{'const':True},'encryptionReady':{'type':'boolean'},'revision':{'type':'integer','minimum':0},'updatedAt':{'type':['string','null'],'format':'date-time'},'templates':{'type':'object','additionalProperties':template},'emailReady':{'type':'boolean'},'deliveryVerified':{'const':False},'pending':{'type':'array','items':string},'externalConfiguration':{'type':'array','items':{'type':'object','required':['name','value','instructions'],'additionalProperties':False,'properties':{'name':string,'value':string,'instructions':string}}},'audit':{'type':'array','maxItems':20,'items':{'type':'object','required':['action','created_at'],'additionalProperties':False,'properties':{'action':{'enum':['email_configuration_changed','test_email_accepted']},'created_at':{'type':'string','format':'date-time'}}}}}
    canonical=json.loads((ROOT/'cloudflare/workers/src/email-templates.json').read_text())
    fields['templates']={'type':'object','required':list(canonical),'additionalProperties':False,'properties':{key:template for key in canonical}}
    read_schema={'type':'object','required':list(fields),'additionalProperties':False,'properties':fields}
    write_template={'type':'object','required':['subject','title','body'],'additionalProperties':False,'properties':{'subject':{'type':'string','minLength':1,'maxLength':200},'title':{'type':'string','minLength':1,'maxLength':200},'body':{'type':'string','minLength':1,'maxLength':4000}}}
    write_schema={'type':'object','required':['sender','templates','revision'],'additionalProperties':False,'properties':{'sender':{'type':'string','format':'email','maxLength':254},'revision':{'type':'integer','minimum':0,'maximum':2147483646},'templates':{'type':'object','additionalProperties':write_template}}}
    write_schema['properties']['templates']={'type':'object','additionalProperties':False,'properties':{key:{**write_template,'description':'Retain each canonical required placeholder across subject/title/body; reject unknown placeholders: '+', '.join(value['required'])} for key,value in canonical.items()}}
    message={'type':'object','required':['message'],'additionalProperties':False,'properties':{'message':string}}
    routes=[('GET',definition['endpoints']['configuration'],'MAINTENANCE_CONFIGURATION_READ',{'type':'object','additionalProperties':True},read_schema,'view'),('POST',definition['endpoints']['configuration'],'MAINTENANCE_CONFIGURATION_SAVE',write_schema,message,'edit'),('POST',definition['endpoints']['testEmail'],'MAINTENANCE_CONFIGURATION_TEST_EMAIL',{'type':'object','additionalProperties':False},message,'edit')]
    api_ids=[]
    for method,route,code,request,response,operation in routes:
        if route not in ['/v1/auth/maintenance/configuration','/v1/auth/maintenance/configuration/test-email']:raise GovernanceReadError('Existing maintenance route required')
        aid=db.ensure('api_endpoints',{'app_id':apps[0][0],'route_path':route,'http_method':method},{'endpoint_code':code,'service_name':'auth','auth_required':1,'implementation_status':'implemented','permission_key':'role_screen_permissions','request_schema':json.dumps(request,sort_keys=True),'response_schema':json.dumps(response,sort_keys=True),'rate_limit_key':'none' if method=='GET' else 'maintenance','api_version':'v1','uses_pagination':0,'health_status':'unknown'})
        existing_roles={r[0] for r in db.execute('SELECT role_id FROM api_permissions WHERE api_id=? AND can_access=1',(aid,))}
        if existing_roles-set(actor_ids.values()):raise GovernanceReadError('Unexpected existing API grant; refuse authority change')
        for role_id in actor_ids.values():db.ensure('api_permissions',{'api_id':aid,'role_id':role_id},{'permission_key':'role_screen_permissions','can_access':1})
        db.ensure('screen_api_links',{'screen_id':1264,'api_id':aid},{'purpose':'Existing maintenance '+operation+'; authority from role_screen_permissions screen1264'})
        api_ids.append(aid)
    # Read back through the same pinned adapter; generated resources are never a second live authority.
    rows=db.execute("SELECT r.resource_key,l.language_code,v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.context='maintenance' AND r.active=1 AND v.approved=1").fetchall()
    locales={locale:{} for locale in ['en','fr','es']}
    for key,locale,value in rows:
        if locale in locales and key.startswith('maintenance.'):locales[locale][key.removeprefix('maintenance.')]=value
    expected={locale:{key:values[i] for key,values in definition['resources'].items()} for i,locale in enumerate(['en','fr','es'])}
    if locales!=expected:raise GovernanceReadError('Live maintenance resources differ from declared cutover')
    controls=dict(db.execute('SELECT component_code,data_cy FROM screen_components WHERE screen_id=1264'))
    if controls!=definition['controls']:raise GovernanceReadError('Unexpected maintenance control binding')
    catalog={k:definition[k] for k in ['screenId','screenCode','route','routes','endpoints','serverMessages']}
    creation_actors=[r[0] for r in db.execute("SELECT a.role_code FROM auth_account_creation_policy p JOIN roles a ON a.id=p.actor_role_id JOIN roles t ON t.id=p.target_role_id WHERE t.role_code='maintenance' AND p.scope='same_tenant'") if r[0] in actor_ids]
    catalog.update(controls=controls,locales=locales,actorRoles=sorted(actor_ids),creationActorRoles=sorted(creation_actors),creationRole='maintenance',apiIds=api_ids,authority={'schema':db.pin['schema'],'manifestSha256':db.pin['manifestSha256'],'source':'pinned-production-postgresql'})
    return catalog


def main():
    if '--apply' not in sys.argv:raise SystemExit('Explicit --apply required for the scoped transactional cutover')
    definition=json.loads((Path(__file__).with_name('maintenance-registration.json')).read_text())
    with MaintenanceRegistrationStore() as db:
        catalog=register(db,definition)
        summary={'screen_id':1264,'api_ids':catalog['apiIds'],'resources':len(definition['resources']),'languages':['en','fr','es'],'controls':len(catalog['controls']),'grants_changed':False,'schema_changed':False,'business_data_changed':False,'independent_localization_review':'pending','catalog_sha256':hashlib.sha256(json.dumps(catalog,sort_keys=True).encode()).hexdigest()}
        db.execute('INSERT INTO virtual_flow_catalog_snapshots VALUES(?,?,CURRENT_TIMESTAMP) ON CONFLICT(name) DO UPDATE SET summary_json=excluded.summary_json,updated_at=CURRENT_TIMESTAMP',('maintenance-registration-current',json.dumps(summary,sort_keys=True)))
    output=ROOT/'test-results/maintenance-registration';output.mkdir(parents=True,exist_ok=True)
    (output/'catalog.json').write_text(json.dumps(catalog,ensure_ascii=False,indent=2)+'\n')
    (output/'receipt.json').write_text(json.dumps(summary,sort_keys=True,indent=2))
    print('MAINTENANCE_REGISTRATION_COMMITTED '+json.dumps(summary))
    print('MAINTENANCE_PRODUCTION_CATALOG '+json.dumps(catalog,ensure_ascii=False))


if __name__=='__main__':main()
