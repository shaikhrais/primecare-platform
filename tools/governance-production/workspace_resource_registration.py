"""Register existing workspace copy as unreviewed metadata, without grants or DDL."""
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
from workspace_resource_catalog import verify

CATALOG='packages/primecare_ui/lib/src/localization/screens/workspace.json'
TABLES={'language_resources':'resource_id','language_resource_values':'translation_id'}

class WorkspaceResourceStore(ProductionWorkflowStore):
    def __init__(self,**kwargs):
        super().__init__(**kwargs)
        try:
            scope=self.pin.get('workspaceResourceWriter',{})
            if (scope.get('optInVariable')!='GOVERNANCE_WORKSPACE_RESOURCE_WRITES'
                    or os.environ.get('GOVERNANCE_WORKSPACE_RESOURCE_WRITES')!='1'
                    or set(scope.get('tables',[]))!=set(TABLES)
                    or scope.get('namespace')!='screenText.workspace.'
                    or scope.get('catalogPath')!=CATALOG
                    or scope.get('schemaChanges') is not False
                    or scope.get('businessDataWrites') is not False
                    or scope.get('permissionChanges') is not False):
                raise GovernanceReadError('Exact pinned workspace resource scope and explicit opt-in required')
            raw=(ROOT/CATALOG).read_bytes()
            if hashlib.sha256(raw).hexdigest()!=scope.get('catalogSha256'):
                raise GovernanceReadError('Workspace source catalog differs from the explicitly pinned registration input')
            document=json.loads(raw)
            if document.get('screen')!='workspace' or document.get('version')!=1:
                raise GovernanceReadError('Existing workspace catalog required')
            self.locales=document['locales']
            if set(self.locales)!={'en','fr','es'} or not self.locales['en']:
                raise GovernanceReadError('Exact EN/FR/ES workspace labels required')
            keys=set(self.locales['en'])
            if any(set(values)!=keys or any(not isinstance(v,str) or not v.strip() or len(v)>2000 for v in values.values()) for values in self.locales.values()):
                raise GovernanceReadError('Invalid existing workspace label parity')
            self.resources={'screenText.workspace.'+key:key for key in keys}
            language_rows=list(self.execute("SELECT language_code,language_id FROM languages WHERE language_code IN ('en','fr','es') AND enabled=1"))
            self.languages=dict(language_rows)
            if len(language_rows)!=3 or set(self.languages)!={'en','fr','es'}:raise GovernanceReadError('Existing enabled EN/FR/ES language identities required')
            self.db.execute('LOCK TABLE '+','.join(self.table(t) for t in sorted(TABLES))+' IN SHARE ROW EXCLUSIVE MODE')
            for table in TABLES:
                meta=self.tables.get(table)
                if not meta or any(len(c['storage_types'])>1 for c in meta['columns']):raise GovernanceReadError('Unregistered or mixed workspace metadata schema')
                actual=dict(self.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s',(self.pin['schema'],'govt_'+table)).fetchall())
                expected={'_primecare_import_row':'bigint',**{c['name']:{'integer':'bigint','real':'double precision','text':'text','blob':'bytea'}.get(c['storage_types'][0] if c['storage_types'] else None,'jsonb') for c in meta['columns']}}
                if actual!=expected:raise GovernanceReadError('Physical workspace metadata differs from production manifest')
        except Exception:
            self.db.rollback();self.db.close();raise

    def insert_metadata(self,table,values):
        values=dict(values)
        if table not in TABLES:raise GovernanceReadError('Workspace writer cannot mutate this relation')
        if table=='language_resources':
            if (values.get('resource_key') not in self.resources or values.get('resource_group')!='liveScreenText'
                    or values.get('context')!='workspace' or values.get('active')!=1):
                raise GovernanceReadError('Only the exact existing workspace text namespace may be registered')
        else:
            rows=self.execute('SELECT resource_key FROM language_resources WHERE resource_id=?',(values.get('resource_id'),)).fetchall()
            language=next((key for key,value in self.languages.items() if value==values.get('language_id')),None)
            if len(rows)!=1 or rows[0][0] not in self.resources or not language:
                raise GovernanceReadError('Existing workspace resource and language binding required')
            if (values.get('translated_text')!=self.locales[language][self.resources[rows[0][0]]]
                    or values.get('reviewed')!=0 or values.get('approved')!=0):
                raise GovernanceReadError('Existing source labels only; review or approval must never be fabricated')
        identity=TABLES[table]
        columns={c['name'] for c in self.tables[table]['columns']}
        if not set(values)<=columns:raise GovernanceReadError('Unregistered workspace resource field')
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
        if len(rows)>1:raise GovernanceReadError('Duplicate workspace resource identity')
        if rows:
            rid,group,context,active=rows[0]
            if (group,context,active)!=('liveScreenText','workspace',1):raise GovernanceReadError('Existing workspace resource differs; explicit migration/review required')
        else:
            rid=db.insert_metadata('language_resources',{'resource_key':resource,'resource_group':'liveScreenText','description':'Existing shared workspace text; independent review pending','context':'workspace','active':1});created_resources+=1
        for language,lid in sorted(db.languages.items()):
            existing=db.execute('SELECT translation_id,translated_text FROM language_resource_values WHERE resource_id=? AND language_id=?',(rid,lid)).fetchall()
            if len(existing)>1:raise GovernanceReadError('Duplicate workspace translation identity')
            if existing:
                if existing[0][1]!=db.locales[language][key]:raise GovernanceReadError('Preserve edited workspace translation; explicit reconciliation required')
            else:
                db.insert_metadata('language_resource_values',{'resource_id':rid,'language_id':lid,'translated_text':db.locales[language][key],'reviewed':0,'approved':0,'version':'workspace-registration-v1'});created_values+=1
    rows=db.execute("SELECT r.resource_key,l.language_code,v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.resource_key LIKE ?",('screenText.workspace.%',)).fetchall()
    actual={language:{} for language in db.languages}
    for resource,language,value in rows:
        if resource not in db.resources or language not in actual:raise GovernanceReadError('Unexpected workspace resource binding; refuse broad namespace changes')
        actual[language][db.resources[resource]]=value
    if actual!=db.locales:raise GovernanceReadError('Workspace production resource parity failed')
    verify(db)
    return {'resources':len(db.resources),'values':len(rows),'created_resources':created_resources,'created_values':created_values,'catalog_sha256':db.pin['workspaceResourceWriter']['catalogSha256'],'source_parity':True,'new_values_reviewed':False,'new_values_approved':False,'schema_changes':False,'business_data_changes':False,'permission_changes':False}

if __name__=='__main__':
    if '--apply' not in sys.argv:raise SystemExit('Explicit --apply required')
    with WorkspaceResourceStore() as db:
        result=register(db)
        db.execute('INSERT INTO virtual_flow_catalog_snapshots VALUES(?,?,CURRENT_TIMESTAMP) ON CONFLICT(name) DO UPDATE SET summary_json=excluded.summary_json,updated_at=CURRENT_TIMESTAMP',('workspace-resource-registration-current',json.dumps(result)))
    out=ROOT/'test-results/workspace-resource-registration';out.mkdir(parents=True,exist_ok=True)
    (out/'receipt.json').write_text(json.dumps(result,indent=2))
    print('WORKSPACE_RESOURCE_REGISTRATION_COMMITTED '+json.dumps(result))
