"""Compare bulk exporter against the unchanged SQL exporter using isolated source data."""
import importlib.util,json,os,pathlib,subprocess,tempfile
ROOT=pathlib.Path(__file__).resolve().parents[2]
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
  a=json.loads((tmp/'old'/name/'portal.json').read_text());b=json.loads((tmp/'new'/name/'portal.json').read_text());a.pop('generatedAt');b.pop('generatedAt');assert a==b,name
 print('All nine portal exports match the previous SQL implementation exactly (excluding generation timestamp).')
