import json,re,sqlite3,sys,pathlib,hashlib
root=pathlib.Path(sys.argv[1]); evidence=pathlib.Path(sys.argv[2])
rows=json.loads((evidence/'schema.json').read_text())
result=json.loads((evidence/'result.json').read_text())
assert all(result[k] is True for k in ['baseline','migrations','ceoCreation','duplicateCeoRejected','passwordVerified','authSchema'])
sql=(evidence/'baseline.sql').read_text()
fks={}
for table,col,target,target_col in re.findall(r'ALTER TABLE "([^"]+)" ADD CONSTRAINT "[^"]+" FOREIGN KEY \("([^"]+)"\) REFERENCES "([^"]+)"\("([^"]+)"\)',sql):
 fks[(table,col)]=(target,target_col)
# These references come from the compatibility migration, which creates the
# auth tables before the legacy UUID migrations are applied.
for table,columns in {'auth_sessions':['user_id'],'auth_account_audit':['actor_user_id','target_user_id'],'auth_bootstrap_audit':['user_id'],'auth_management_audit':['actor_user_id','target_user_id'],'auth_password_audit':['user_id']}.items():
 for col in columns:fks[(table,col)]=('users','id')
c=sqlite3.connect(root/'.agents/governance/governance.db')
c.execute('PRAGMA foreign_keys=ON')
with c:
 c.execute('CREATE TABLE IF NOT EXISTS database_rebuild_baselines (name TEXT PRIMARY KEY, app_id INTEGER NOT NULL REFERENCES apps(id), baseline_sql TEXT NOT NULL, migration_sources TEXT NOT NULL, schema_metadata TEXT NOT NULL, validation_evidence TEXT NOT NULL, sha256 TEXT NOT NULL)')
 migrations={p.name:p.read_text() for p in sorted((root/'packages/database/migrations').glob('*.sql'))}
 digest=hashlib.sha256((sql+json.dumps(migrations,sort_keys=True)).encode()).hexdigest()
 c.execute('INSERT OR REPLACE INTO database_rebuild_baselines VALUES (?,?,?,?,?,?,?)',('postgres-clean-rebuild-v1',15,sql,json.dumps(migrations,sort_keys=True),json.dumps(rows),json.dumps(result),digest))
 for table in sorted({r['table_name'] for r in rows}):
  existing=c.execute('SELECT id FROM db_schema_tables WHERE app_id=15 AND table_name=?',(table,)).fetchall()
  assert len(existing)<=1
  if existing:tid=existing[0][0]
  else:tid=c.execute("INSERT INTO db_schema_tables(app_id,table_name,table_type,status) VALUES (15,?,'table','active')",(table,)).lastrowid
  for r in [r for r in rows if r['table_name']==table]:
   target=fks.get((table,r['column_name']))
   vals=(r['udt_name'],int(r['is_nullable']=='YES'),int(r['is_primary']),int(target is not None),r['column_default'],target[0] if target else None,target[1] if target else None)
   existing_col=c.execute('SELECT id FROM db_schema_columns WHERE table_id=? AND column_name=?',(tid,r['column_name'])).fetchall()
   assert len(existing_col)<=1
   if existing_col:c.execute('UPDATE db_schema_columns SET data_type=?,is_nullable=?,is_primary=?,is_foreign=?,default_value=?,foreign_table_name=?,foreign_column_name=? WHERE id=?',(*vals,existing_col[0][0]))
   else:c.execute('INSERT INTO db_schema_columns(table_id,column_name,data_type,is_nullable,is_primary,is_foreign,default_value,foreign_table_name,foreign_column_name) VALUES (?,?,?,?,?,?,?,?,?)',(tid,r['column_name'],*vals))
 assert c.execute('PRAGMA integrity_check').fetchone()[0]=='ok'
print(json.dumps({'registered_tables':len({r['table_name'] for r in rows}),'registered_columns':len(rows),'baseline_sha256':digest}))
