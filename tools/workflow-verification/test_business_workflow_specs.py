import copy
import json
import sqlite3
import unittest
from register_business_workflows import ROOT, register


class BusinessWorkflowSpecTests(unittest.TestCase):
    def setUp(self):
        self.spec = json.loads((ROOT / 'tools/workflow-verification/specs/care.psw.submit-availability.json').read_text())
        self.db = sqlite3.connect(':memory:')
        self.addCleanup(self.db.close)
        self.db.executescript('''CREATE TABLE roles(id INTEGER PRIMARY KEY,role_code TEXT);
            CREATE TABLE screens(id INTEGER PRIMARY KEY,screen_code TEXT);
            CREATE TABLE api_endpoints(id INTEGER PRIMARY KEY,endpoint_code TEXT);
            CREATE TABLE care_delivery_policy(id TEXT PRIMARY KEY);
            INSERT INTO roles VALUES(1,'psw'); INSERT INTO screens VALUES(1,'care_delivery');
            INSERT INTO care_delivery_policy VALUES('care-v1');''')
        self.db.executemany('INSERT INTO api_endpoints VALUES(?,?)', enumerate(self.spec['bindings']['api_codes'], 1))

    def test_registration_and_repeat_never_claim_execution(self):
        first = register(self.db, self.spec, ROOT)
        self.assertEqual(first, register(self.db, self.spec, ROOT))
        self.assertEqual(self.db.execute('SELECT * FROM business_workflow_verification_summary').fetchone(), (1, 0, 1, 0, 0))
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM business_workflow_specs').fetchone()[0], 1)

    def test_changed_spec_invalidates_previous_completion(self):
        register(self.db, self.spec, ROOT)
        # A synthetic prior state is used solely to exercise invalidation.
        self.db.execute("UPDATE business_workflow_specs SET verification_status='verified'")
        self.spec['end'] += ' Synthetic changed expectation.'
        register(self.db, self.spec, ROOT)
        self.assertEqual(self.db.execute('SELECT verification_status FROM business_workflow_specs').fetchone()[0], 'implemented-unverified')

    def test_incomplete_or_invented_bindings_rejected(self):
        for mutate in (lambda s: s.update(end=''),
                       lambda s: s['bindings']['api_codes'].append('not-registered'),
                       lambda s: s['steps'][0].update(order=9),
                       lambda s: s['sources'].append('../outside.ts')):
            spec = copy.deepcopy(self.spec)
            mutate(spec)
            with self.assertRaises(ValueError):
                register(self.db, spec, ROOT)


if __name__ == '__main__':
    unittest.main()
