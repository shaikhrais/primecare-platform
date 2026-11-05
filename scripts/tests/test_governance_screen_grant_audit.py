import sqlite3
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from audit_governance_screen_grants import collect


class GovernanceScreenGrantAuditTest(unittest.TestCase):
    def test_reads_only_matching_screen_and_role_metadata(self):
        db = sqlite3.connect(':memory:')
        self.addCleanup(db.close)
        db.executescript('''
          CREATE TABLE screens(id INTEGER, screen_code TEXT, route_path TEXT);
          CREATE TABLE roles(id INTEGER, role_code TEXT);
          CREATE TABLE role_screen_permissions(screen_id INTEGER, role_id INTEGER, can_view INTEGER);
          INSERT INTO screens VALUES(1, 'ceo_growth_pipeline', '/offices/corporate/roles/ceo/growth-pipeline');
          INSERT INTO screens VALUES(2, 'unrelated', '/unrelated');
          INSERT INTO roles VALUES(1, 'ceo');
          INSERT INTO role_screen_permissions VALUES(1, 1, 1);
        ''')
        before = db.total_changes
        rows = collect(db)
        self.assertEqual(db.total_changes, before)
        self.assertEqual(rows, [{'screen_code': 'ceo_growth_pipeline',
          'route_path': '/offices/corporate/roles/ceo/growth-pipeline', 'role_code': 'ceo', 'can_view': 1}])


if __name__ == '__main__':
    unittest.main()
