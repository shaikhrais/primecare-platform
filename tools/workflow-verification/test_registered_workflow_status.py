import sqlite3
import unittest
from register_workflow_status import register, snapshot


class RegisteredWorkflowStatusTests(unittest.TestCase):
    def setUp(self):
        self.db = sqlite3.connect(':memory:')
        self.addCleanup(self.db.close)
        self.db.executescript('''
            CREATE TABLE workflow_definitions(id INTEGER PRIMARY KEY,app_id INTEGER,
              role_id INTEGER,workflow_code TEXT,workflow_name TEXT,status TEXT);
            CREATE TABLE workflow_steps(workflow_id INTEGER,api_id INTEGER,expected_result TEXT);
            INSERT INTO workflow_definitions VALUES(1,1,1,'test','Synthetic','active');
            INSERT INTO workflow_steps VALUES(1,NULL,'Success');
        ''')

    def test_exclusive_counts_and_lifecycle_preserved(self):
        register(self.db)
        self.assertEqual(snapshot(self.db)['summary'], dict(total=1,missing=0,
            implemented_unverified=0,verified=0,blocked=1))
        self.assertEqual(self.db.execute('SELECT status FROM workflow_definitions').fetchone()[0], 'active')
        with self.assertRaises(sqlite3.IntegrityError):
            self.db.execute("UPDATE workflow_definitions SET verification_status='completed'")

    def test_rerun_preserves_reviewed_classification(self):
        register(self.db)
        self.db.execute("UPDATE workflow_definitions SET verification_status='implemented-unverified',verification_reason='Synthetic reviewed mapping'")
        register(self.db)
        self.assertEqual(snapshot(self.db)['summary']['implemented_unverified'], 1)
        self.assertEqual(snapshot(self.db)['workflows'][0]['verification_reason'], 'Synthetic reviewed mapping')

    def test_changed_inventory_requires_review(self):
        self.db.execute("UPDATE workflow_steps SET api_id=1,expected_result='Measurable synthetic expectation'")
        with self.assertRaises(ValueError):
            register(self.db)


if __name__ == '__main__':
    unittest.main()
