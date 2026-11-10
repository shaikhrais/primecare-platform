import json
import sqlite3
import unittest
from audit_development_state import audit


class AuditTests(unittest.TestCase):
    def setUp(self):
        self.db=sqlite3.connect(':memory:')
        self.addCleanup(self.db.close)
        self.db.executescript('''CREATE TABLE screens(id INTEGER,active INTEGER,route_path TEXT,screen_code TEXT);
        INSERT INTO screens VALUES(1,1,'/one','PLATFORM_ADMINISTRATION'),(2,0,'/one','other'),(3,1,'/two','third');
        CREATE TABLE roles(id INTEGER,role_code TEXT,active INTEGER);
        INSERT INTO roles VALUES(1,'sensitive-role-name',1),(2,'inactive',0);
        CREATE TABLE runtime_catalog_permissions(role_id INTEGER,can_view_organization INTEGER);
        INSERT INTO runtime_catalog_permissions VALUES(1,1);
        CREATE TABLE role_screen_permissions(role_id INTEGER,can_view INTEGER,screen_id INTEGER);
        INSERT INTO role_screen_permissions VALUES(1,1,1),(2,1,2);
        CREATE TABLE virtual_workflow_definitions(flow_id TEXT,flow_kind TEXT,verification_status TEXT);
        INSERT INTO virtual_workflow_definitions VALUES('a','business_process','implemented-unverified'),('b','business_process','blocked'),('support','action','verified');
        CREATE TABLE virtual_workflow_attempts(flow_id TEXT);
        INSERT INTO virtual_workflow_attempts VALUES('a'),('a'),('support');
        CREATE TABLE virtual_workflow_checkpoints(flow_id TEXT);
        INSERT INTO virtual_workflow_checkpoints VALUES('a'),('support');''')
        self.registry={'definitions':[{'report_id':'page_readiness','grants':[{'role':'sensitive-role-name'}]}]}

    def test_counts_distinguish_saved_attempts_and_supporting_flows(self):
        report=audit(self.db,self.registry)
        self.assertEqual(report['registeredScreens'],3)
        self.assertEqual(report['activeRegisteredScreens'],2)
        self.assertEqual(report['distinctRegisteredRoutes'],2)
        self.assertEqual(report['businessProcesses'],2)
        self.assertEqual(report['savedBusinessProcessAttempts'],2)
        self.assertEqual(report['businessProcessesWithoutSavedAttempt'],1)
        self.assertEqual(report['savedBusinessProcessCheckpoints'],1)
        self.assertTrue(report['reportAuthorityComparison'][0]['matchesReconciler'])
        self.assertNotIn('sensitive-role-name',json.dumps(report))

    def test_unknown_and_duplicate_source_grants_are_not_accepted(self):
        self.registry['definitions'][0]['grants']=[{'role':'other'},{'role':'other'}]
        row=audit(self.db,self.registry)['reportAuthorityComparison'][0]
        self.assertFalse(row['matchesReconciler'])
        self.assertEqual((row['sourceOnlyRoleCount'],row['expectedOnlyRoleCount'],row['duplicateSourceRoles']),(1,1,1))
        self.registry['definitions'][0]['report_id']='unregistered'
        with self.assertRaises(ValueError):audit(self.db,self.registry)

    def test_registered_code_admin_is_expected_only_with_parent_view(self):
        self.db.execute("INSERT INTO roles VALUES(3,'code_admin',1)")
        self.db.execute('INSERT INTO role_screen_permissions VALUES(3,1,1)')
        self.registry={'definitions':[{'report_id':'platform_administration','grants':[{'role':'platform_admin'},{'role':'code_admin'}]}]}
        self.assertTrue(audit(self.db,self.registry)['reportAuthorityComparison'][0]['matchesReconciler'])
        self.db.execute('UPDATE role_screen_permissions SET can_view=0 WHERE role_id=3')
        self.assertFalse(audit(self.db,self.registry)['reportAuthorityComparison'][0]['matchesReconciler'])

    def test_audit_executes_no_mutations(self):
        before=self.db.serialize()
        self.db.execute('PRAGMA query_only=ON')
        audit(self.db,self.registry)
        self.assertEqual(self.db.serialize(),before)


if __name__ == '__main__':unittest.main()
