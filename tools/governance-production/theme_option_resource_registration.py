"""Register existing Theme Center option copy as unreviewed metadata, without grants or DDL."""
import datetime
import hashlib
import json
import os
import sys
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore,quote
from production_reader import GovernanceReadError
from theme_option_catalog import verify

CATALOG='tools/governance-production/theme-option-resources.json'
TABLES={'language_resources':'resource_id','language_resource_values':'translation_id'}

class ThemeOptionResourceStore(ProductionWorkflowStore):
    def __init__(self,**kwargs):
        super().__init__(**kwargs)
        try:
            scope=self.pin.get('themeOptionResourceWriter',{})
            if (scope.get('optInVariable')!='GOVERNANCE_THEME_OPTION_RESOURCE_WRITES'
                    or os.environ.get('GOVERNANCE_THEME_OPTION_RESOURCE_WRITES')!='1'
                    or set(scope.get('tables',[]))!=set(TABLES)
                    or scope.get('namespace')!='themeCenter.options.'
                    or scope.get('catalogPath')!=CATALOG
                    or scope.get('schemaChanges') is not False
                    or scope.get('businessDataWrites') is not False
                    or scope.get('permissionChanges') is not False):
                raise GovernanceReadError('Exact pinned Theme Center option resource scope and explicit opt-in required')
            raw=(ROOT/CATALOG).read_bytes()
            if hashlib.sha256(raw).hexdigest()!=scope.get('catalogSha256'):
                raise GovernanceReadError('Workspace source catalog differs from the explicitly pinned registration input')
            document=json.loads(raw)
            if document.get('screen')!='theme_center_options' or document.get('version')!=1:
                raise GovernanceReadError('Existing Theme Center option catalog required')
            self.locales=document['locales']
            if set(self.locales)!={'en','fr','es'} or not self.locales['en']:
                raise GovernanceReadError('Exact EN/FR/ES Theme Center option labels required')
            keys=set(self.locales['en'])
            if any(set(values)!=keys or any(not isinstance(v,str) or not v.strip() or len(v)>2000 for v in values.values()) for values in self.locales.values()):
                raise GovernanceReadError('Invalid existing Theme Center option label parity')
            self.resources={'themeCenter.options.'+key:key for key in keys}
            language_rows=list(self.execute("SELECT language_code,language_id FROM languages WHERE language_code IN ('en','fr','es') AND enabled=1"))
            self.languages=dict(language_rows)
            if len(language_rows)!=3 or set(self.languages)!={'en','fr','es'}:raise GovernanceReadError('Existing enabled EN/FR/ES language identities required')
            self.db.execute('LOCK TABLE '+','.join(self.table(t) for t in sorted(TABLES))+' IN SHARE ROW EXCLUSIVE MODE')
            for table in TABLES:
                meta=self.tables.get(table)
                if not meta or any(len(c['storage_types'])>1 for c in meta['columns']):raise GovernanceReadError('Unregistered or mixed Theme Center option metadata schema')
                actual=dict(self.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s',(self.pin['schema'],'govt_'+table)).fetchall())
                expected={'_primecare_import_row':'bigint',**{c['name']:{'integer':'bigint','real':'double precision','text':'text','blob':'bytea'}.get(c['storage_types'][0] if c['storage_types'] else None,'jsonb') for c in meta['columns']}}
                if actual!=expected:raise GovernanceReadError('Physical Theme Center option metadata differs from production manifest')
        except Exception:
            self.db.rollback();self.db.close();raise

    def insert_metadata(self,table,values):
        values=dict(values)
        if table not in TABLES:raise GovernanceReadError('Workspace writer cannot mutate this relation')
        if table=='language_resources':
            if set(values)!={'resource_key','resource_group','description','context','active'}:
                raise GovernanceReadError('Exact resource insertion fields required')
            if (values.get('resource_key') not in self.resources or values.get('resource_group')!='themeCenterOptions'
                    or values.get('context')!='theme_center' or values.get('active')!=1):
                raise GovernanceReadError('Only the exact existing Theme Center option text namespace may be registered')
        else:
            if set(values)!={'resource_id','language_id','translated_text','reviewed','approved','version'} or values['version']!='theme-options-v1':
                raise GovernanceReadError('Exact unreviewed translation insertion fields required')
            rows=self.execute('SELECT resource_key FROM language_resources WHERE resource_id=?',(values.get('resource_id'),)).fetchall()
            language=next((key for key,value in self.languages.items() if value==values.get('language_id')),None)
            if len(rows)!=1 or rows[0][0] not in self.resources or not language:
                raise GovernanceReadError('Existing Theme Center option resource and language binding required')
            if (values.get('translated_text')!=self.locales[language][self.resources[rows[0][0]]]
                    or values.get('reviewed')!=0 or values.get('approved')!=0):
                raise GovernanceReadError('Existing source labels only; review or approval must never be fabricated')
        identity=TABLES[table]
        columns={c['name'] for c in self.tables[table]['columns']}
        if not set(values)<=columns:raise GovernanceReadError('Unregistered Theme Center option resource field')
        values[identity]=self.execute('SELECT COALESCE(MAX('+identity+'),0)+1 FROM '+table).fetchone()[0]
        for key in ['created_at','updated_at']:
            if key in columns:values.setdefault(key,datetime.datetime.now(datetime.timezone.utc).isoformat())
        ordinal=self.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+self.table(table)).fetchone()[0]
        fields=list(values)
        self.db.execute('INSERT INTO '+self.table(table)+' (_primecare_import_row,'+','.join(map(quote,fields))+') VALUES('+','.join(['%s']*(len(fields)+1))+')',[ordinal,*[self._value(table,key,values[key]) for key in fields]])
        return values[identity]

def register(db):
    created_resources=created_values=0
    for resource,key in sorted(db.resources.items()):
        rows=db.execute('SELECT resource_id,resource_group,context,active FROM language_resources WHERE resource_key=?',(resource,)).fetchall()
        if len(rows)>1:raise GovernanceReadError('Duplicate Theme Center option resource identity')
        if rows:
            rid,group,context,active=rows[0]
            if (group,context,active)!=('themeCenterOptions','theme_center',1):raise GovernanceReadError('Existing Theme Center option resource differs; explicit migration/review required')
        else:
            rid=db.insert_metadata('language_resources',{'resource_key':resource,'resource_group':'themeCenterOptions','description':'Existing shared Theme Center option text; independent review pending','context':'theme_center','active':1});created_resources+=1
        for language,lid in sorted(db.languages.items()):
            existing=db.execute('SELECT translation_id,translated_text FROM language_resource_values WHERE resource_id=? AND language_id=?',(rid,lid)).fetchall()
            if len(existing)>1:raise GovernanceReadError('Duplicate Theme Center option translation identity')
            if existing:
                if existing[0][1]!=db.locales[language][key]:raise GovernanceReadError('Preserve edited Theme Center option translation; explicit reconciliation required')
            else:
                db.insert_metadata('language_resource_values',{'resource_id':rid,'language_id':lid,'translated_text':db.locales[language][key],'reviewed':0,'approved':0,'version':'theme-options-v1'});created_values+=1
    rows=db.execute("SELECT r.resource_key,l.language_code,v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.resource_key LIKE ?",('themeCenter.options.%',)).fetchall()
    actual={language:{} for language in db.languages}
    for resource,language,value in rows:
        if resource not in db.resources or language not in actual:raise GovernanceReadError('Unexpected Theme Center option resource binding; refuse broad namespace changes')
        actual[language][db.resources[resource]]=value
    if actual!=db.locales:raise GovernanceReadError('Workspace production resource parity failed')
    verify(db)
    return {'resources':len(db.resources),'values':len(rows),'created_resources':created_resources,'created_values':created_values,'catalog_sha256':db.pin['themeOptionResourceWriter']['catalogSha256'],'source_parity':True,'new_values_reviewed':False,'new_values_approved':False,'schema_changes':False,'business_data_changes':False,'permission_changes':False}

if __name__=='__main__':
    import argparse
    from production_reader import connect
    from theme_option_catalog import export_dart
    parser=argparse.ArgumentParser()
    parser.add_argument('--apply',action='store_true')
    parser.add_argument('--readback',action='store_true')
    parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args()
    result={'status':'not_started','schema_changes':False,'business_data_changes':False,'permission_changes':False,'runtime_activated':False}
    try:
        if args.apply==args.readback:raise GovernanceReadError('Exactly one explicit operation required')
        if args.apply:
            with ThemeOptionResourceStore() as db:result.update(register(db))
            result['status']='registration_committed'
        else:
            with connect() as db:
                result.update(verify(db))
                dart=export_dart(db)
            args.output.parent.mkdir(parents=True,exist_ok=True)
            args.output.with_name('theme_center_options_generated.dart').write_text(dart)
            result['status']='independent_readback_complete'
    except Exception as error:
        result.update(status='operation_failed',errorType=type(error).__name__)
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result))
    raise SystemExit(0 if result['status'] in ['registration_committed','independent_readback_complete'] else 1)
