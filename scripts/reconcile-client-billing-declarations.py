"""Retire unused billing invoice declaration; preserve its identity and references."""
import json, sqlite3
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]
LEGACY = (248, '/v1/client/billing/invoices')
LEGACY_IDENTITY = {
 'app_id':1,'runtime_artifact_id':None,'controller_id':None,'service_id':None,
 'request_schema_id':None,'response_schema_id':None,
 'endpoint_code':'API__V1_CLIENT_BILLING_INVOICES','route_path':LEGACY[1],
 'http_method':'POST','controller_name':'','service_name':'PRISMA','auth_required':1,
 'gateway_url':'https://api.primecare.io/v1/client/billing/invoices','icon_key':'post',
 'api_version':'v1','is_backend_only':0,'permission_key':None,'request_schema':None,
 'response_schema':None,'rate_limit_key':None,'deprecated_at':None,'last_tested_at':None,
 'created_at':'2026-06-19 00:15:58','prisma_model_names':None,'query_pattern':None,
 'uses_pagination':0,'uses_select':0,'uses_include':0,'possible_n_plus_one':0,
 'recommended_indexes_json':None,'db_query_time_ms':0,'optimization_status':'pending',
 'avg_latency_ms':None,
}
def identifier(value):
    return '"'+value.replace('"','""')+'"'

def reject_endpoint_references(db, aid):
    # Only the closed generated coverage diagnostic is a reviewed exception.
    # No reference exception grants authority. Explicit registry-domain FKs stay untouched.
    tables = [r[0] for r in db.execute("SELECT name FROM sqlite_master WHERE type='table'")]
    for table in tables:
        fks = db.execute('PRAGMA foreign_key_list('+identifier(table)+')').fetchall()
        columns = {r[1] for r in db.execute('PRAGMA table_info('+identifier(table)+')')}
        refs = {r[3] for r in fks if r[2]=='api_endpoints'}
        registry_columns = {r[3] for r in fks if r[2]=='api_registry'}
        if 'api_id' in columns and 'api_id' not in registry_columns:
            refs.add('api_id')
        for key in ('endpoint_path','route_path'):
            if table!='api_endpoints' and key in columns and db.execute('SELECT 1 FROM '+identifier(table)+' WHERE '+identifier(key)+'=? LIMIT 1',(LEGACY[1],)).fetchone():
                raise ValueError('Legacy declaration gained route reference: '+table)
        for column in refs:
            if table=='governance_findings' and column=='related_api_id':
                rows=db.execute('SELECT finding_category,finding_code,status,related_screen_id,related_file_id,description FROM governance_findings WHERE related_api_id=?',(aid,)).fetchall()
                expected=('drift','missing_test_coverage','closed',None,None,'API Endpoint POST '+LEGACY[1]+' is missing verification test proof.')
                if any(tuple(r)!=expected for r in rows):
                    raise ValueError('Legacy declaration gained unreviewed diagnostic')
                continue
            if db.execute('SELECT 1 FROM '+identifier(table)+' WHERE '+identifier(column)+'=? LIMIT 1',(aid,)).fetchone():
                raise ValueError('Legacy declaration gained endpoint reference: '+table+'.'+column)

CANONICAL = [(16432, '/v1/client/invoices', 'client-self-batch-7.openapi.json'),
             (16440, '/v1/client/invoices/{invoiceId}', 'client-invoices-batch-12.openapi.json')]

def expected_contract(path, filename):
    operation = json.loads((ROOT / 'docs/api' / filename).read_text())['paths'][path]['get']
    request = {'type':'object','additionalProperties':False,'properties':{p['name']:p['schema'] for p in operation.get('parameters',[]) if p['in']=='query'}}
    return request, operation['responses']['200']['content']['application/json']['schema']

def reconcile(db):
    db.execute('SAVEPOINT client_billing_retirement')
    try:
        if db.execute("SELECT 1 FROM sqlite_master WHERE type='trigger' AND tbl_name='api_endpoints' LIMIT 1").fetchone():
            raise ValueError('Unreviewed endpoint trigger')
        for aid, path, filename in CANONICAL:
            rows = db.execute("SELECT id,service_name,auth_required,permission_key,request_schema,response_schema,app_id,endpoint_code,implementation_status FROM api_endpoints WHERE route_path=? AND http_method='GET'", (path,)).fetchall()
            if len(rows)!=1 or tuple(rows[0][:4])!=(aid,'client',1,'authenticated_client_profile_owner'):
                raise ValueError('Canonical identity or owner authority changed: '+path)
            code='CLIENT_SELF_INVOICES' if aid==16432 else 'CLIENT_SELF_INVOICE_DETAIL'
            if tuple(rows[0][6:])!=(6,code,'implemented'):
                raise ValueError('Canonical app/code/implementation changed: '+path)
            try:
                actual = tuple(json.loads(v) for v in rows[0][4:6])
            except (ValueError,TypeError) as error:
                raise ValueError('Canonical schema malformed: '+path) from error
            if actual != expected_contract(path,filename):
                raise ValueError('Canonical request or response contract changed: '+path)
        aid,path = LEGACY
        fields = list(LEGACY_IDENTITY)+['implementation_status','health_status']
        row = db.execute('SELECT '+','.join(fields)+' FROM api_endpoints WHERE id=?',(aid,)).fetchone()
        if row is None or tuple(row[:-2])!=tuple(LEGACY_IDENTITY.values()):
            raise ValueError('Legacy declaration source identity or contract changed')
        if tuple(row[-2:]) not in [('active','healthy'),('retired','unverified')]:
            raise ValueError('Legacy declaration implementation state changed')
        reject_endpoint_references(db,aid)
        db.execute("UPDATE api_endpoints SET implementation_status='retired',health_status='unverified' WHERE id=?",(aid,))
    except Exception:
        db.execute('ROLLBACK TO client_billing_retirement')
        db.execute('RELEASE client_billing_retirement')
        raise
    db.execute('RELEASE client_billing_retirement')

if __name__=='__main__':
    with sqlite3.connect(ROOT / '.agents/governance/governance.db') as db:
        reconcile(db)
    print('Retired one duplicate billing declaration; no new API implementation.')
