"""Compare bulk exporter with legacy SQL, preserving the reviewed CSS-null fix."""
import importlib.util,json,os,pathlib,subprocess,tempfile,sys
ROOT=pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'scripts'))
def load(path,name):
 spec=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);return m
with tempfile.TemporaryDirectory() as tmp:
 tmp=pathlib.Path(tmp);source=tmp/'fixture.db'
 # The fixture must be explicit; never derive it by reading a production credential.
 import gzip
 source.write_bytes(gzip.decompress((ROOT/'.agents/governance/governance-recovery-snapshot.db.gz').read_bytes()))
 original=tmp/'original.py';original.write_bytes((ROOT/'tools/governance-production/legacy-export-fixture.py').read_bytes())
 old=load(original,'old_export');new=load(ROOT/'scripts/export-typescript-websites.py','new_export')
 old.export(str(source),tmp/'old','https://fixture.invalid','/login')
 os.environ['GOVERNANCE_ALLOW_SQLITE_FIXTURES']='1'
 new.export(str(source),tmp/'new','https://fixture.invalid','/login')
 for name in new.PORTALS:
  a=json.loads((tmp/'old'/name/'portal.json').read_text());b=json.loads((tmp/'new'/name/'portal.json').read_text());a.pop('generatedAt');b.pop('generatedAt')
  # Reviewed compatibility amendment: 17a5cd8dd deliberately stopped exporting
  # non-CSS rows with NULL variable names as the JSON key "null". Preserve the
  # immutable legacy generator; allow exactly that removal, no other field drift.
  a['theme'].pop('null',None)
  assert 'null' not in b['theme'],name
  assert a==b,name
 print('All nine portal exports match legacy SQL, except timestamp and the reviewed invalid null CSS-key removal (17a5cd8dd).')
