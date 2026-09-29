import sqlite3,json,hashlib,sys
c=sqlite3.connect(sys.argv[1])
r=c.execute("SELECT baseline_sql,migration_sources,schema_metadata,validation_evidence,sha256 FROM database_rebuild_baselines WHERE name='postgres-clean-rebuild-v1'").fetchone()
assert r,'Tested governed baseline missing'
assert hashlib.sha256((r[0]+r[1]).encode()).hexdigest()==r[4],'Baseline checksum mismatch'
v=json.loads(r[3]); assert all(v[k] is True for k in ['baseline','migrations','ceoCreation','duplicateCeoRejected','passwordVerified','authSchema'])
with open(sys.argv[2],'w') as f:json.dump({'sql':r[0],'migrations':json.loads(r[1]),'columns':json.loads(r[2]),'validation':v},f)
