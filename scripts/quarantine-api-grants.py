"""Offline, fail-closed quarantine for proven API catalog ID-domain collisions.

Default is read-only. Apply requires the exact preflight digest and an explicit
local SQLite path. No remapping or replacement business grants are generated.
"""
import argparse,hashlib,json,sqlite3
from collections import Counter
from pathlib import Path

COLUMNS=['id','api_id','role_id','runtime_artifact_id','permission_key','can_access','created_at']
INVALID={'registry_endpoint_identity_mismatch','missing_endpoint'}

def encoded(value):return json.dumps(value,sort_keys=True,separators=(',',':'),ensure_ascii=False)
def digest(value):return hashlib.sha256(encoded(value).encode()).hexdigest()

def validate_schema(db):
    cols=[r['name'] for r in db.execute('pragma table_info(api_permissions)')]
    if cols!=COLUMNS:raise ValueError('Unsupported api_permissions schema; no mutation')
    primary=[r['name'] for r in db.execute('pragma table_info(api_permissions)') if r['pk']]
    unique=[]
    for index in db.execute('pragma index_list(api_permissions)').fetchall():
        if index['unique']:unique.append([r['name'] for r in db.execute('pragma index_info("'+index['name'].replace('"','""')+'")')])
    if primary!=['id'] or ['api_id','role_id'] not in unique:raise ValueError('Unsupported grant identity constraints')
    fks=[dict(r) for r in db.execute('pragma foreign_key_list(api_permissions)')]
    expected={('api_id','api_endpoints','id','CASCADE'),('role_id','roles','id','CASCADE'),('runtime_artifact_id','runtime_artifacts','id','SET NULL')}
    if {(r['from'],r['table'],r['to'],r['on_delete']) for r in fks}!=expected:raise ValueError('Unexpected foreign-key contract')
    if list(db.execute("select name from sqlite_master where type='trigger' and tbl_name='api_permissions'")):raise ValueError('Unreviewed grant triggers')
    incoming=[]
    for t in db.execute("select name from sqlite_master where type='table'").fetchall():
        for fk in db.execute('pragma foreign_key_list("'+t['name'].replace('"','""')+'")'):
            if fk['table']=='api_permissions':incoming.append(t['name'])
    if incoming:raise ValueError('Incoming grant foreign keys require review: '+str(incoming))
    return digest({'columns':[dict(r) for r in db.execute('pragma table_info(api_permissions)')],'foreignKeys':fks,'sql':db.execute("select sql from sqlite_master where name='api_permissions'").fetchone()[0]})

def preflight(db):
    schema=validate_schema(db)
    endpoints={r['id']:dict(r) for r in db.execute('select id,endpoint_code,http_method,route_path,permission_key from api_endpoints')}
    registry={r['id']:dict(r) for r in db.execute('select id,api_id,endpoint_code,method,endpoint_path from api_endpoint_registry')}
    candidates=[];counts=Counter();source=[]
    for row in db.execute('select * from api_permissions order by id'):
        r=dict(row);e=endpoints.get(r['api_id']);reg=registry.get(r['api_id'])
        # Require exact generator provenance before declaring any row corrupt.
        if not reg or r['permission_key']!='api_permission_'+reg['endpoint_code']:state='unknown_key_origin'
        elif not e:state='missing_endpoint'
        elif (e['http_method'],e['route_path'])!=(reg['method'],reg['endpoint_path']):state='registry_endpoint_identity_mismatch'
        else:state='identity_matches_requires_authority_review'
        counts[state]+=1
        entry={'row':r,'classification':state,'referencedEndpoint':e,'keyOriginRegistry':reg}
        source.append(entry)
        if state in INVALID:candidates.append(entry)
    plan={'version':1,'schemaDigest':schema,'sourceDigest':digest(source),'classifications':dict(counts),'candidateRows':len(candidates),'candidateDigest':digest(candidates),'authorityPolicy':'No grants inferred, reassigned, or recreated. Unknown or identity-matching rows remain for explicit authority review.'}
    plan['planDigest']=digest(plan)
    return plan,candidates

def violations(db):
    # Incoming FKs are rejected by validate_schema. Only grant rows are deleted;
    # unrelated legacy tables can contain invalid FK definitions of their own.
    return Counter(tuple(r) for r in db.execute('pragma foreign_key_check(api_permissions)'))

def validate_quarantine_tables(db):
    expected={
        'api_permission_quarantine':['source_id','source_json','source_digest','classification','provenance_json','plan_digest','quarantined_at'],
        'api_permission_quarantine_runs':['plan_digest','schema_digest','after_source_digest','quarantined_rows','applied_at'],
    }
    for table,columns in expected.items():
        actual=[r['name'] for r in db.execute('pragma table_info('+table+')')]
        if actual and actual!=columns:raise ValueError('Unsupported quarantine schema: '+table)
        if list(db.execute("select name from sqlite_master where type='trigger' and tbl_name=?",(table,))):raise ValueError('Unreviewed quarantine trigger')

def apply(db,expected_digest,fail_after=None):
    if db.in_transaction:raise ValueError('Caller transaction is unsupported')
    db.execute('pragma foreign_keys=ON')
    if db.execute('pragma foreign_keys').fetchone()[0]!=1:raise ValueError('Foreign keys unavailable')
    db.execute('BEGIN IMMEDIATE')
    try:
        validate_quarantine_tables(db)
        plan,rows=preflight(db)
        if db.execute("select 1 from sqlite_master where type='table' and name='api_permission_quarantine_runs'").fetchone():
            prior=db.execute('select after_source_digest,schema_digest from api_permission_quarantine_runs where plan_digest=?',(expected_digest,)).fetchone()
            if prior:
                if (prior['after_source_digest'],prior['schema_digest'])!=(plan['sourceDigest'],plan['schemaDigest']):raise ValueError('Previously applied quarantine state changed')
                db.commit()
                return {'quarantinedRows':0,'remainingGrantRows':sum(plan['classifications'].values()),'planDigest':expected_digest,'newForeignKeyViolations':0,'alreadyApplied':True}
        if plan['planDigest']!=expected_digest:raise ValueError('Preflight changed; no mutation')
        before=violations(db)
        if rows:
            db.execute('''CREATE TABLE IF NOT EXISTS api_permission_quarantine (
                source_id INTEGER PRIMARY KEY,source_json TEXT NOT NULL,source_digest TEXT NOT NULL,
                classification TEXT NOT NULL,provenance_json TEXT NOT NULL,plan_digest TEXT NOT NULL,
                quarantined_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP)''')
            for index,entry in enumerate(rows):
                raw=encoded(entry['row']);provenance=encoded({k:v for k,v in entry.items() if k!='row'})
                existing=db.execute('select source_digest,provenance_json from api_permission_quarantine where source_id=?',(entry['row']['id'],)).fetchone()
                if existing and (existing['source_digest']!=digest(entry['row']) or existing['provenance_json']!=provenance):raise ValueError('Quarantine source ID conflict')
                db.execute('insert or ignore into api_permission_quarantine(source_id,source_json,source_digest,classification,provenance_json,plan_digest) values (?,?,?,?,?,?)',(entry['row']['id'],raw,digest(entry['row']),entry['classification'],provenance,plan['planDigest']))
                stored=db.execute('select source_json,source_digest,classification,provenance_json from api_permission_quarantine where source_id=?',(entry['row']['id'],)).fetchone()
                if tuple(stored)!=(raw,digest(entry['row']),entry['classification'],provenance):raise ValueError('Source preservation check failed')
                db.execute('delete from api_permissions where id=?',(entry['row']['id'],))
                if fail_after is not None and index+1==fail_after:raise RuntimeError('Injected rollback test')
        after=violations(db)
        if after-before:raise ValueError('New foreign-key violation; rolling back')
        if validate_schema(db)!=plan['schemaDigest']:raise ValueError('Grant schema changed')
        db.execute('''CREATE TABLE IF NOT EXISTS api_permission_quarantine_runs (
            plan_digest TEXT PRIMARY KEY,schema_digest TEXT NOT NULL,
            after_source_digest TEXT NOT NULL,quarantined_rows INTEGER NOT NULL,
            applied_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP)''')
        after_plan,_=preflight(db)
        db.execute('insert into api_permission_quarantine_runs(plan_digest,schema_digest,after_source_digest,quarantined_rows) values (?,?,?,?)',(expected_digest,plan['schemaDigest'],after_plan['sourceDigest'],len(rows)))
        db.commit()
        return {'quarantinedRows':len(rows),'remainingGrantRows':db.execute('select count(*) from api_permissions').fetchone()[0],'planDigest':plan['planDigest'],'newForeignKeyViolations':0,'foreignKeyCheckScope':'api_permissions; no incoming FK references permitted'}
    except BaseException:
        db.rollback();raise

def consumer_preflight(root):
    # Worker/Dart runtime paths must not consume this corrupt catalog table.
    found=[]
    for area in ('cloudflare','services','packages','apps'):
        for p in (root/area).rglob('*'):
            if p.is_file() and p.suffix in ('.py','.ts','.dart','.js','.mjs','.sql') and 'api_permissions' in p.read_text(errors='replace'):found.append(str(p.relative_to(root)))
    if found:raise ValueError('Runtime consumers require fail-closed review: '+str(found))
    return {'runtimeReferences':[],'scope':['cloudflare','services','packages','apps'],'policy':'No runtime table consumer found; generated permission contracts remain independently enforced.'}

def main():
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--db',type=Path,required=True);parser.add_argument('--apply-digest');args=parser.parse_args()
    path=args.db.resolve()
    if not path.is_file():raise ValueError('Explicit existing offline SQLite file required')
    consumers=consumer_preflight(Path(__file__).resolve().parents[1])
    with sqlite3.connect('file:'+str(path)+'?mode=ro',uri=True) as db:
        db.row_factory=sqlite3.Row;plan,_=preflight(db)
    if not args.apply_digest:print(json.dumps({'preflight':plan,'consumerReview':consumers},indent=2));return
    with sqlite3.connect(path) as db:
        db.row_factory=sqlite3.Row;result=apply(db,args.apply_digest)
    print(json.dumps(result,indent=2))

if __name__=='__main__':main()
