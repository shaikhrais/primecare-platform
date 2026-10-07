"""Isolated regression tests for cross-catalog ID collisions; no real DB writes."""
import importlib.util,sqlite3,unittest
from pathlib import Path
spec=importlib.util.spec_from_file_location('migration',Path(__file__).with_name('migrate_architecture_tables.py'))
migration=importlib.util.module_from_spec(spec);spec.loader.exec_module(migration)

class GrantMappingTest(unittest.TestCase):
    def setUp(self):
        self.db=sqlite3.connect(':memory:');self.db.row_factory=sqlite3.Row
        self.db.execute('create table api_endpoints(id integer primary key,http_method text,route_path text)')
        self.db.executemany('insert into api_endpoints values (?,?,?)',[(1,'GET','/v1/wrong'),(50,'GET','/v1/correct')])
        self.registry={'id':1,'api_id':50,'method':'GET','endpoint_path':'/v1/correct'}
    def tearDown(self):self.db.close()
    def check(self):return migration.validated_api_endpoint_id(self.db.cursor(),self.registry)
    def test_registry_id_collision_uses_validated_api_id(self):self.assertEqual(self.check(),50)
    def test_missing_target_denied(self):
        self.registry['endpoint_path']='/v1/missing'
        with self.assertRaisesRegex(ValueError,'0 exact'):self.check()
    def test_unrelated_numeric_ids_not_used(self):
        self.registry['api_id']=1;self.assertEqual(self.check(),50)
    def test_null_numeric_mapping_still_resolves_identity(self):
        self.registry['api_id']=None;self.assertEqual(self.check(),50)
    def test_method_drift_denied(self):
        self.registry['method']='POST'
        with self.assertRaisesRegex(ValueError,'0 exact'):self.check()
    def test_ambiguous_exact_targets_denied(self):
        self.db.execute('insert into api_endpoints values (51,?,?)',('GET','/v1/correct'))
        with self.assertRaisesRegex(ValueError,'2 exact'):self.check()

if __name__=='__main__':unittest.main()
