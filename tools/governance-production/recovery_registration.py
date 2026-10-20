"""Transactional registration of existing public recovery views; no native routes or grants change."""
import hashlib,json,os,sys,datetime
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError

TABLES={'screen_components':'id','screen_api_links':'id','language_resources':'resource_id','language_resource_values':'translation_id','api_endpoints':'id'}
SCREENS={'forgot':(947,'forgot_password',395,3),'reset':(950,'reset_password',396,4)}
SOURCE='websites/typescript/src/auth-recovery.ts'
FLOWS=['auth.forgot-password','auth.reset-password']

def load_definition():
    return json.loads((Path(__file__).with_name('recovery-registration.json')).read_text())

class RecoveryRegistrationStore(ProductionWorkflowStore):
    def __init__(self,**kwargs):
        super().__init__(**kwargs)
        try:
            scope=self.pin.get('recoveryRegistrationWriter',{})
            expected={'optInVariable':'GOVERNANCE_RECOVERY_REGISTRATION_WRITES','screenIds':[947,950],'apiIds':[395,396],'tables':list(TABLES),'definitionSha256':hashlib.sha256((Path(__file__).with_name('recovery-registration.json')).read_bytes()).hexdigest(),'schemaChanges':False,'businessDataWrites':False,'permissionChanges':False}
            if scope!=expected or os.environ.get('GOVERNANCE_RECOVERY_REGISTRATION_WRITES')!='1':
                raise GovernanceReadError('Exact pinned recovery cutover scope required')
            self.db.execute('LOCK TABLE '+','.join(self.table(t) for t in sorted([*TABLES,'virtual_workflow_source_links']))+' IN SHARE ROW EXCLUSIVE MODE')
            for table in [*TABLES,'virtual_workflow_source_links']:
                meta=self.tables.get(table)
                if not meta or any(len(c['storage_types'])>1 for c in meta['columns']):raise GovernanceReadError('Missing/mixed recovery metadata schema')
                actual=dict(self.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s',(self.pin['schema'],'govt_'+table)).fetchall())
                expected={'_primecare_import_row':'bigint',**{c['name']:{'integer':'bigint','text':'text','real':'double precision','blob':'bytea'}.get(c['storage_types'][0] if c['storage_types'] else None,'jsonb') for c in meta['columns']}}
                if actual!=expected:raise GovernanceReadError('Recovery metadata physical schema differs from manifest')
        except Exception:
            self.db.rollback();self.db.close();raise

    def insert_metadata(self,table,values):
        values=dict(values)
        if table not in TABLES or table=='api_endpoints':raise GovernanceReadError('Recovery insert outside registered presentation scope')
        if table in ['screen_components','screen_api_links'] and values.get('screen_id') not in [947,950]:raise GovernanceReadError('Recovery screen scope mismatch')
        if table=='screen_components' and (values.get('file_path')!=SOURCE or not values.get('component_code','').startswith('web.recovery-')):raise GovernanceReadError('Exact recovery component namespace required')
        if table=='screen_api_links' and (values.get('screen_id'),values.get('api_id')) not in [(947,395),(950,396)]:raise GovernanceReadError('Exact existing recovery API binding required')
        if table=='language_resources' and not values.get('resource_key','').startswith('authRecovery.'):raise GovernanceReadError('Recovery resource namespace required')
        if table=='language_resource_values' and not self.execute("SELECT resource_id FROM language_resources WHERE resource_id=? AND context='authRecovery'",(values.get('resource_id'),)).fetchone():raise GovernanceReadError('Recovery translation namespace required')
        columns={c['name'] for c in self.tables[table]['columns']}
        if not set(values).issubset(columns):raise GovernanceReadError('Unregistered recovery field')
        identity=TABLES[table];values[identity]=self.execute('SELECT COALESCE(MAX('+identity+'),0)+1 FROM '+table).fetchone()[0]
        for field in ['created_at','updated_at']:
            if field in columns:values.setdefault(field,datetime.datetime.now(datetime.timezone.utc).isoformat())
        values['_primecare_import_row']=self.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+self.table(table)).fetchone()[0]
        fields=list(values)
        self.db.execute('INSERT INTO '+self.table(table)+'('+','.join(map(quote,fields))+') VALUES('+','.join(['%s']*len(fields))+')',[values[k] if k=='_primecare_import_row' else self._value(table,k,values[k]) for k in fields])
        return values[identity]

    def ensure(self,table,key,values):
        fields=list(values)
        rows=self.execute('SELECT '+TABLES[table]+','+','.join(fields)+' FROM '+table+' WHERE '+' AND '.join(k+'=?' for k in key),tuple(key.values())).fetchall()
        if len(rows)>1:raise GovernanceReadError('Duplicate recovery metadata identity')
        if rows:
            if tuple(rows[0][1:])!=tuple(values.values()):raise GovernanceReadError('Existing recovery metadata differs; preserve reviewed data')
            return rows[0][0]
        return self.insert_metadata(table,{**key,**values})

    def reconcile_api(self,aid,mode,definition):
        if mode not in SCREENS or SCREENS[mode][2]!=aid or definition!=load_definition():raise GovernanceReadError('Exact existing recovery API scope required')
        route=definition['endpoints'][mode]
        rows=self.execute('SELECT route_path,http_method,service_name,auth_required,request_schema,response_schema,rate_limit_key FROM api_endpoints WHERE id=?',(aid,)).fetchall()
        if len(rows)!=1 or rows[0][:2]!=(route,'POST'):raise GovernanceReadError('Canonical recovery API changed')
        string={'type':'string'}
        properties={'email':{'type':'string','format':'email','maxLength':254}}
        if mode=='reset':properties.update(code={'type':'string','pattern':'^[A-Fa-f0-9]{12}$'},newPassword={'type':'string','minLength':12,'description':'Maximum 72 UTF-8 bytes; validated by the existing password validator.'})
        request={'type':'object','required':list(properties),'additionalProperties':False,'properties':properties}
        response=({'type':'object','required':['message'],'additionalProperties':False,'properties':{'message':{'const':'If an active account matches, recovery instructions will be emailed. Check your inbox and spam folder.'}}} if mode=='forgot' else {'type':'object','required':['status','reauthenticationRequired'],'additionalProperties':False,'properties':{'status':{'const':'password_reset'},'reauthenticationRequired':{'const':True}}})
        expected=('auth',0,json.dumps(request,sort_keys=True),json.dumps(response,sort_keys=True),'forgotPassword' if mode=='forgot' else 'resetPassword')
        current=tuple(rows[0][2:])
        if current==expected:return False
        if current!=('PRISMA',1,None,None,None):raise GovernanceReadError('Unreviewed recovery API metadata change; no overwrite')
        fields=['service_name','auth_required','request_schema','response_schema','rate_limit_key']
        cur=self.db.execute('UPDATE '+self.table('api_endpoints')+' SET '+','.join(quote(k)+'=%s' for k in fields)+' WHERE id=%s',[self._value('api_endpoints',k,v) for k,v in zip(fields,expected)]+[aid])
        if cur.rowcount!=1:raise GovernanceReadError('Recovery API reconciliation affected unexpected rows')
        return True

def read_catalog(db,definition):
    baseline=json.loads((ROOT/'docs/auth-recovery/native-presentation-baseline.json').read_text())['screens']
    native={r['screen_code']:r for r in baseline}
    catalog=json.loads(json.dumps(definition))
    language_ids=dict(db.execute("SELECT language_code,language_id FROM languages WHERE language_code IN ('en','fr','es') AND enabled=1"))
    if set(language_ids)!=set(['en','fr','es']):raise GovernanceReadError('Registered EN/FR/ES languages required')
    locales={k:{} for k in language_ids}
    for key,locale,text in db.execute("SELECT r.resource_key,l.language_code,v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.context='authRecovery' AND r.active=1"):
        if locale in locales:
            short=key.removeprefix('authRecovery.')
            if short in locales[locale]:raise GovernanceReadError('Duplicate recovery translation')
            locales[locale][short]=text
    if locales!=definition['locales']:raise GovernanceReadError('Recovery resources differ from production registration')
    catalog['locales']=locales
    for mode,(sid,code,aid,rid) in SCREENS.items():
        route=db.execute('SELECT route_code,route_path FROM auth_route_registry WHERE id=?',(rid,)).fetchall()
        if route!=[(code,definition['routes'][mode])]:raise GovernanceReadError('Existing public recovery route changed')
        screen=db.execute('SELECT screen_code,route_path,actual_file_path,active FROM screens WHERE id=?',(sid,)).fetchall()
        original=native[code]
        if screen!=[(code,original['route_path'],original['actual_file_path'],1)]:raise GovernanceReadError('Native recovery metadata changed; preserve it')
        if db.execute('SELECT id FROM api_endpoints WHERE id=? AND route_path=? AND http_method=? AND service_name=? AND auth_required=0',(aid,definition['endpoints'][mode],'POST','auth')).fetchall()!=[(aid,)]:raise GovernanceReadError('Recovery API contract not reconciled')
        links=db.execute('SELECT api_id FROM screen_api_links WHERE screen_id=? AND api_id=?',(sid,aid)).fetchall()
        if links!=[(aid,)]:raise GovernanceReadError('Recovery screen/API registration missing or duplicated')
        controls=db.execute('SELECT component_code,component_type,data_cy,file_path FROM screen_components WHERE screen_id=? AND file_path=? ORDER BY component_code',(sid,SOURCE)).fetchall()
        expected=sorted(('web.'+c['key'],c['component'],c['testId'],SOURCE) for c in definition['views'][mode]['controls'])
        if controls!=expected:raise GovernanceReadError('Recovery control registration missing or changed')
        for c in definition['views'][mode]['controls']:
            if db.execute('SELECT component_code FROM primecare_ui_component_registry WHERE id=?',(c['componentId'],)).fetchall()!=[(c['component'],)]:raise GovernanceReadError('Recovery PrimeCare component binding changed')
    catalog['authority']={'source':'pinned-production-postgresql','schema':db.pin['schema'],'manifestSha256':db.pin['manifestSha256'],'relations':['auth_route_registry','screen_components','screen_api_links','api_endpoints','language_resources','language_resource_values'],'reviewStatus':'pending'}
    return catalog

def register(db,definition):
    if definition!=load_definition():raise GovernanceReadError('Recovery definition differs from the exact pinned cutover')
    # Validate source identities before any metadata writes.
    native={r['screen_code']:r for r in json.loads((ROOT/'docs/auth-recovery/native-presentation-baseline.json').read_text())['screens']}
    languages=dict(db.execute("SELECT language_code,language_id FROM languages WHERE language_code IN ('en','fr','es') AND enabled=1"))
    if set(languages)!=set(['en','fr','es']):raise GovernanceReadError('Registered recovery languages missing')
    for mode,(sid,code,aid,rid) in SCREENS.items():
        row=native[code]
        if db.execute('SELECT screen_code,route_path,actual_file_path,active FROM screens WHERE id=?',(sid,)).fetchall()!=[(code,row['route_path'],row['actual_file_path'],1)]:raise GovernanceReadError('Native recovery binding changed')
        if db.execute('SELECT route_code,route_path FROM auth_route_registry WHERE id=?',(rid,)).fetchall()!=[(code,definition['routes'][mode])]:raise GovernanceReadError('Public recovery route changed')
        db.reconcile_api(aid,mode,definition)
    for locale,values in definition['locales'].items():
        for key,text in values.items():
            rid=db.ensure('language_resources',{'resource_key':'authRecovery.'+key},{'resource_group':'authRecovery','description':'Public recovery presentation','context':'authRecovery','active':1})
            db.ensure('language_resource_values',{'resource_id':rid,'language_id':languages[locale]},{'translated_text':text,'reviewed':0,'approved':0,'version':'recovery-web-v1'})
    for mode,(sid,code,aid,rid) in SCREENS.items():
        for control in definition['views'][mode]['controls']:
            db.ensure('screen_components',{'screen_id':sid,'component_code':'web.'+control['key']},{'component_name':control['key'],'component_type':control['component'],'data_cy':control['testId'],'file_path':SOURCE,'implementation_status':'registered-unverified'})
        db.ensure('screen_api_links',{'screen_id':sid,'api_id':aid},{'purpose':'Public web recovery; separate native presentation; no role grant'})
    return read_catalog(db,definition)

def main():
    if '--check' in sys.argv:
        from production_reader import connect
        with connect() as db:catalog=read_catalog(db,load_definition())
        if catalog!=json.loads((ROOT/'packages/shared/src/auth-recovery.json').read_text()):raise GovernanceReadError('Generated recovery catalog differs from pinned production')
        print('Recovery registration parity passed; review approvals remain separate')
        return
    if '--apply' not in sys.argv:raise SystemExit('Explicit --apply required')
    with RecoveryRegistrationStore() as db:
        catalog=register(db,load_definition())
        receipt={'screens':[947,950],'apis':[395,396],'controls':18,'schemaChanged':False,'permissionGrantsChanged':False,'nativeMetadataChanged':False,'reviews':'pending','catalogSha256':hashlib.sha256(json.dumps(catalog,sort_keys=True).encode()).hexdigest()}
        db.execute('INSERT INTO virtual_flow_catalog_snapshots VALUES(?,?,CURRENT_TIMESTAMP) ON CONFLICT(name) DO UPDATE SET summary_json=excluded.summary_json,updated_at=CURRENT_TIMESTAMP',('recovery-registration-current',json.dumps(receipt)))
    out=ROOT/'test-results/recovery-registration';out.mkdir(parents=True,exist_ok=True)
    (out/'catalog.json').write_text(json.dumps(catalog,ensure_ascii=False,indent=2)+'\n')
    (out/'receipt.json').write_text(json.dumps(receipt,indent=2))
    print('RECOVERY_REGISTRATION_COMMITTED '+json.dumps(receipt))
    print('RECOVERY_PRODUCTION_CATALOG '+json.dumps(catalog,ensure_ascii=False))
if __name__=='__main__':main()
