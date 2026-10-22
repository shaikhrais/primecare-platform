"""Pinned native contract registration. No role grants, business writes or activation."""
import hashlib
import json
import os
import sys
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore, quote
from production_reader import GovernanceReadError
PURPOSE = 'Shared communication contract only; role grants, handler activation and acceptance pending'
DEFINITION = Path(__file__).with_name('communications-registration.json')
TABLES = {'api_endpoints':'id', 'screen_api_links':'id'}

def definition():
    return json.loads(DEFINITION.read_text())

def expected_scope():
    return dict(optInVariable='GOVERNANCE_COMMUNICATION_REGISTRATION_WRITES',
        tables=sorted(TABLES), existingApiIds=[710,857], screenIds=[234,331,559,578],
        definitionSha256=hashlib.sha256(DEFINITION.read_bytes()).hexdigest(),
        schemaChanges=False, businessDataWrites=False, roleGrants=False, activation=False)

class CommunicationRegistrationStore(ProductionWorkflowStore):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        try:
            if (self.pin.get('communicationRegistrationWriter') != expected_scope() or
                    os.environ.get('GOVERNANCE_COMMUNICATION_REGISTRATION_WRITES') != '1'):
                raise GovernanceReadError('Exact pinned communication registration and opt-in required')
            self.db.execute('LOCK TABLE '+','.join(self.table(t) for t in sorted(TABLES))+' IN SHARE ROW EXCLUSIVE MODE')
            for table in TABLES:
                meta=self.tables.get(table)
                if not meta or any(len(c['storage_types'])>1 for c in meta['columns']):
                    raise GovernanceReadError('Missing or mixed communication metadata schema')
                actual=dict(self.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s',(self.pin['schema'],'govt_'+table)).fetchall())
                expected={'_primecare_import_row':'bigint',**{c['name']:{'integer':'bigint','text':'text','real':'double precision','blob':'bytea'}.get(c['storage_types'][0] if c['storage_types'] else None,'jsonb') for c in meta['columns']}}
                if actual != expected:raise GovernanceReadError('Physical communication metadata differs from manifest')
        except Exception:
            self.db.rollback();self.db.close();raise

    def insert_exact(self, table, values):
        # Internal helper: register() creates the entire allowlisted value map.
        if table not in TABLES:raise GovernanceReadError('Unrelated table refused')
        d=definition()
        if table=='api_endpoints':
            op=next((op for op in d['operations'] if op['path']==values.get('route_path') and op['method']==values.get('http_method') and 'existingId' not in op),None)
            app=self.execute('SELECT app_id FROM api_endpoints WHERE id=710').fetchall()
            if not op or len(app)!=1 or values!=new_api_values(d,op,app[0][0]):
                raise GovernanceReadError('Only exact new communication contracts may be inserted')
        else:
            if (set(values)!={'screen_id','api_id','purpose'} or values.get('screen_id') not in map(int,d['screens']) or values.get('purpose')!=PURPOSE):
                raise GovernanceReadError('Exact communication screen link required')
            row=self.execute('SELECT http_method,route_path,service_name,permission_key FROM api_endpoints WHERE id=?',(values.get('api_id'),)).fetchall()
            if len(row)!=1 or row[0][2:]!=(d['service'],d['permission']) or not any(row[0][:2]==(op['method'],op['path']) for op in d['operations']):
                raise GovernanceReadError('Exact registered communication API required')
        fields={c['name'] for c in self.tables[table]['columns']}
        if not set(values)<=fields:raise GovernanceReadError('Unregistered communication metadata column')
        values=dict(values)
        values[TABLES[table]]=self.execute('SELECT COALESCE(MAX('+TABLES[table]+'),0)+1 FROM '+table).fetchone()[0]
        values['_primecare_import_row']=self.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+self.table(table)).fetchone()[0]
        keys=list(values)
        self.db.execute('INSERT INTO '+self.table(table)+'('+','.join(map(quote,keys))+') VALUES('+','.join(['%s']*len(keys))+')',
            [values[k] if k=='_primecare_import_row' else self._value(table,k,values[k]) for k in keys])
        return values[TABLES[table]]

def new_api_values(d,op,app):
    return dict(app_id=app,http_method=op['method'],route_path=op['path'],
        endpoint_code='COMMUNICATION_'+op['key'].replace('.','_').upper(),api_version='v1',
        health_status='unknown',uses_pagination=0,service_name=d['service'],auth_required=1,
        permission_key=d['permission'],implementation_status=d['implementationStatus'],
        request_schema=json.dumps(op['request'],sort_keys=True),response_schema=json.dumps(op['response'],sort_keys=True))

def register(db):
    d=definition()
    for sid,code in d['screens'].items():
        if db.execute('SELECT screen_code,active FROM screens WHERE id=?',(int(sid),)).fetchall()!=[(code,1)]:
            raise GovernanceReadError('Existing communication screen changed')
    # Use the existing common-message application identity, never invent an app.
    app=db.execute('SELECT app_id FROM api_endpoints WHERE id=710').fetchall()
    if len(app)!=1 or app[0][0] is None:raise GovernanceReadError('Existing message application required')
    receipt={}
    fields=['service_name','auth_required','permission_key','implementation_status','request_schema','response_schema']
    for op in d['operations']:
        values=[d['service'],1,d['permission'],d['implementationStatus'],json.dumps(op['request'],sort_keys=True),json.dumps(op['response'],sort_keys=True)]
        rows=db.execute('SELECT id,'+','.join(fields)+' FROM api_endpoints WHERE http_method=? AND route_path=?',(op['method'],op['path'])).fetchall()
        if len(rows)>1:raise GovernanceReadError('Duplicate communication API identity')
        if rows:
            aid=rows[0][0]
            if op.get('existingId') not in (None,aid):raise GovernanceReadError('Existing API identity changed')
            actual=list(rows[0][1:])
            for i in [4,5]:
                if isinstance(actual[i],dict):actual[i]=json.dumps(actual[i],sort_keys=True)
                elif actual[i] is not None:
                    try:actual[i]=json.dumps(json.loads(actual[i]),sort_keys=True)
                    except (ValueError,TypeError):raise GovernanceReadError('Edited schema preserved')
            if actual != values:
                if (op.get('existingId')!=aid or actual!=['PRISMA',1,None,'active',None,None]):
                    raise GovernanceReadError('Edited communication contract preserved; reconciliation required')
                keys=fields
                cur=db.db.execute('UPDATE '+db.table('api_endpoints')+' SET '+','.join(quote(k)+'=%s' for k in keys)+' WHERE id=%s',
                    [db._value('api_endpoints',k,v) for k,v in zip(keys,values)]+[aid])
                if cur.rowcount!=1:raise GovernanceReadError('Unexpected communication update count')
        else:
            if 'existingId' in op:raise GovernanceReadError('Existing message API missing')
            aid=db.insert_exact('api_endpoints',new_api_values(d,op,app[0][0]))
        receipt[op['key']]=aid
        for sid in map(int,d['screens']):
            links=db.execute('SELECT id,purpose FROM screen_api_links WHERE screen_id=? AND api_id=?',(sid,aid)).fetchall()
            purpose=PURPOSE
            if len(links)>1 or links and links[0][1]!=purpose:raise GovernanceReadError('Edited communication screen link preserved')
            if not links:db.insert_exact('screen_api_links',dict(screen_id=sid,api_id=aid,purpose=purpose))
    return dict(apiIds=receipt,screenLinks=len(receipt)*len(d['screens']),roleGrants=0,businessDataWrites=False,
        activation=False,implementationStatus=d['implementationStatus'],definitionSha256=expected_scope()['definitionSha256'])

if __name__ == '__main__':
    if sys.argv[1:] not in [['--dry-run'],['--apply']]:raise SystemExit('Explicit --dry-run or --apply required')
    with CommunicationRegistrationStore() as db:
        result=register(db)
        if result!=register(db):raise GovernanceReadError('Non-idempotent communication registration')
        if sys.argv[1]=='--dry-run':db.db.rollback()
    print('COMMUNICATION_CONTRACT_REGISTRATION '+json.dumps(result))
