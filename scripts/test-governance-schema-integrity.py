import json
import sqlite3
import unittest
from governance_schema_integrity import PLACEHOLDER, canonical_schema_rows, quarantine_generated_schemas


class SchemaIntegrityTests(unittest.TestCase):
    def fixture(self):
        db = sqlite3.connect(':memory:')
        db.executescript('''
          CREATE TABLE api_endpoints(id INTEGER PRIMARY KEY,http_method TEXT,route_path TEXT,endpoint_code TEXT,request_schema TEXT,response_schema TEXT,request_schema_id INTEGER,response_schema_id INTEGER);
          CREATE TABLE api_endpoint_registry(id INTEGER PRIMARY KEY,endpoint_code TEXT,method TEXT,endpoint_path TEXT);
          CREATE TABLE api_request_schemas(id INTEGER PRIMARY KEY,api_id INTEGER,schema_name TEXT,schema_json TEXT);
          CREATE TABLE api_response_schemas(id INTEGER PRIMARY KEY,api_id INTEGER,schema_name TEXT,schema_json TEXT);
          INSERT INTO api_endpoints VALUES(1,'POST','/v1/auth/register','AUTH_REGISTER','{"type":"object","properties":{"email":{"type":"string"}}}',NULL,1,1);
          INSERT INTO api_endpoint_registry VALUES(1,'api_v1_rmt_list_get','GET','/v1/rmt');
        ''')
        for table, prefix in [('api_request_schemas','Req_'),('api_response_schemas','Res_')]:
            db.execute(f'INSERT INTO {table} VALUES(1,1,?,?)', (prefix+'api_v1_rmt_list_get', json.dumps(PLACEHOLDER)))
        db.commit()
        return db

    def test_colliding_numeric_id_never_promotes_registry_schema(self):
        db=self.fixture()
        before=db.execute('SELECT request_schema,response_schema FROM api_endpoints').fetchone()
        self.assertEqual(quarantine_generated_schemas(db), {'api_request_schemas':1,'api_response_schemas':1})
        self.assertEqual(db.execute('SELECT request_schema,response_schema FROM api_endpoints').fetchone(), before)
        self.assertEqual(db.execute('SELECT request_schema_id,response_schema_id FROM api_endpoints').fetchone(), (None,None))
        saved=db.execute('SELECT original_row_json,linked_endpoint_json FROM governance_schema_quarantine').fetchall()
        self.assertEqual(len(saved),2)
        self.assertTrue(all(json.loads(row[0])['api_id']==1 for row in saved))
        self.assertTrue(all(json.loads(row[1])['route_path']=='/v1/auth/register' for row in saved))
        self.assertEqual(quarantine_generated_schemas(db), {'api_request_schemas':0,'api_response_schemas':0})

    def test_unproven_origin_and_real_contract_preserved(self):
        db=self.fixture()
        db.execute("UPDATE api_request_schemas SET schema_name='ManualContract'")
        db.execute("UPDATE api_response_schemas SET schema_json='{}'")
        self.assertEqual(quarantine_generated_schemas(db), {'api_request_schemas':0,'api_response_schemas':0})

    def test_atomic_rollback_on_archive_identity_collision(self):
        db=self.fixture()
        quarantine_generated_schemas(db)
        db.execute('INSERT INTO api_request_schemas VALUES(1,1,?,?)',('Req_api_v1_rmt_list_get',json.dumps(PLACEHOLDER,sort_keys=True)))
        with self.assertRaisesRegex(ValueError,'identity collision'):
            quarantine_generated_schemas(db)
        self.assertEqual(db.execute('SELECT COUNT(*) FROM api_request_schemas').fetchone()[0],1)
        self.assertEqual(db.execute('SELECT COUNT(*) FROM governance_schema_quarantine').fetchone()[0],2)

    def test_outer_transaction_can_roll_back_all_changes(self):
        db=self.fixture()
        db.execute('BEGIN')
        quarantine_generated_schemas(db)
        db.rollback()
        self.assertEqual(db.execute('SELECT COUNT(*) FROM api_request_schemas').fetchone()[0],1)
        self.assertFalse(db.execute("SELECT name FROM sqlite_master WHERE name='governance_schema_quarantine'").fetchall())

    def test_every_cleared_pointer_relationship_is_preserved(self):
        db=self.fixture()
        db.execute("INSERT INTO api_endpoints VALUES(2,'GET','/other','OTHER',NULL,NULL,1,NULL)")
        quarantine_generated_schemas(db)
        raw=db.execute("SELECT cleared_references_json FROM governance_schema_quarantine WHERE source_table='api_request_schemas'").fetchone()[0]
        self.assertEqual(json.loads(raw), [{'id':1,'request_schema_id':1,'response_schema_id':1},{'id':2,'request_schema_id':1,'response_schema_id':None}])
        self.assertEqual(db.execute('SELECT request_schema_id FROM api_endpoints ORDER BY id').fetchall(),[(None,),(None,)])

    def test_digest_and_provenance_corruption_abort_deletion(self):
        for column in ['original_sha256','registry_row_json','linked_endpoint_json','cleared_references_json']:
            with self.subTest(column=column):
                db=self.fixture()
                original=db.execute('SELECT * FROM api_request_schemas').fetchone()
                quarantine_generated_schemas(db)
                db.execute('INSERT INTO api_request_schemas VALUES(?,?,?,?)', original)
                db.execute('UPDATE governance_schema_quarantine SET '+column+"='corrupted' WHERE source_table='api_request_schemas'")
                with self.assertRaisesRegex(ValueError,'corrupted provenance/digest'):
                    quarantine_generated_schemas(db)
                self.assertEqual(db.execute('SELECT * FROM api_request_schemas').fetchone(),original)

    def test_unreviewed_triggers_and_incoming_cascade_are_rejected(self):
        for ddl in ["CREATE TRIGGER unsafe AFTER DELETE ON api_request_schemas BEGIN DELETE FROM api_endpoints; END",
                    "CREATE TABLE other(id INTEGER, schema_id INTEGER REFERENCES api_request_schemas(id) ON DELETE CASCADE)"]:
            db=self.fixture()
            db.executescript(ddl)
            with self.assertRaisesRegex(ValueError,'Unreviewed'):
                quarantine_generated_schemas(db)
            self.assertEqual(db.execute('SELECT COUNT(*) FROM api_request_schemas').fetchone()[0],1)

    def test_archive_layout_drift_is_rejected(self):
        db=self.fixture()
        db.execute('CREATE TABLE governance_schema_quarantine(source_table TEXT,source_id INTEGER)')
        with self.assertRaisesRegex(ValueError,'archive schema'):
            quarantine_generated_schemas(db)
        self.assertEqual(db.execute('SELECT COUNT(*) FROM api_request_schemas').fetchone()[0],1)

    def test_generation_uses_only_explicit_canonical_schema(self):
        db=self.fixture()
        request,response=canonical_schema_rows(db.cursor(),1,'AUTH_REGISTER')
        self.assertEqual(json.loads(request[3])['properties']['email']['type'],'string')
        self.assertIsNone(response)
        db.execute('UPDATE api_endpoints SET response_schema=?', (json.dumps(PLACEHOLDER),))
        with self.assertRaisesRegex(ValueError,'not an approved'):
            canonical_schema_rows(db.cursor(),1,'AUTH_REGISTER')
        with self.assertRaisesRegex(ValueError,'does not exist'):
            canonical_schema_rows(db.cursor(),999,'AUTH_REGISTER')


if __name__=='__main__': unittest.main()
