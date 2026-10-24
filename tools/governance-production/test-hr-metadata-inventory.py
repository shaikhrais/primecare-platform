import hashlib
import json
import unittest
from hr_metadata_inventory import HrMetadataInventory
from domain_metadata_inventory import GovernedMetadataInventory


class Fixture:
    def __init__(self):
        text = json.dumps({'title': 'Recruitment interview'})
        schema = {'type': 'object', 'properties': {}, 'additionalProperties': False}
        self.tables = {
            'screens': [(1, 'hr_dashboard', '/hr'), (2, 'thread', '/thread')],
            'screen_api_links': [(10, 1), (11, 2)],
            'api_endpoints': [(10, 'GET', '/v1/admin/processes', 'registered', 'fixture.hr', 'fixture', 1, schema, schema),
                              (11, 'GET', '/v1/thread', 'registered', 'fixture.other', 'fixture', 1, schema, schema)],
            'api_permissions': [(10, 3, 'fixture.hr', 1)],
            'role_screen_permissions': [(1, 3, 1)],
            'roles': [(3, 'hr_director')],
            'virtual_workflow_definitions': [('hr.interview', text, hashlib.sha256(text.encode()).hexdigest(), 'not_run')],
        }
        self.reads = []

    def execute(self, sql, args=()):
        self.assert_read(sql)
        table = sql.split(' FROM ')[1].split()[0]
        self.reads.append(table)
        rows = self.tables[table]
        return type('Rows', (), {'fetchall': lambda _: rows})()

    def assert_read(self, sql):
        if not sql.startswith('SELECT ') or ';' in sql:
            raise AssertionError('Only metadata SELECT allowed')


class Inventory(unittest.TestCase):
    def test_inherits_metadata_boundary_and_includes_linked_generic_api(self):
        inventory = HrMetadataInventory()
        self.assertIsInstance(inventory, GovernedMetadataInventory)
        db = Fixture()
        report = inventory.collect(db, 'fixture-source')
        self.assertEqual([row['id'] for row in report['apis']], [10])
        self.assertEqual([row['id'] for row in report['screens']], [1])
        self.assertEqual(report['summary']['metadataComplete'], 1)
        self.assertEqual(report['summary']['liveAcceptanceVerified'], 0)
        self.assertFalse(report['writesAttempted'])
        self.assertFalse(report['readsBusinessRecords'])
        self.assertTrue(report['candidateMatchesRequireReview'])
        self.assertFalse(report['contractBindings'][0]['runtimePolicyVerified'])
        self.assertEqual(set(db.reads), set(db.tables))

    def test_missing_grants_are_not_inferred_from_hr_role(self):
        db = Fixture()
        db.tables['api_permissions'] = []
        report = HrMetadataInventory().collect(db, 'fixture')
        self.assertEqual(report['summary']['metadataComplete'], 0)
        self.assertIn('matching_active_role_api_and_screen_grants_missing', report['contractBindings'][0]['metadataGaps'])

    def test_flow_digest_drift_aborts(self):
        db = Fixture()
        row = db.tables['virtual_workflow_definitions'][0]
        db.tables['virtual_workflow_definitions'] = [(row[0], row[1], 'invalid', row[3])]
        with self.assertRaisesRegex(ValueError, 'digest'):
            HrMetadataInventory().collect(db, 'fixture')

    def test_hr_is_a_token_not_a_thread_substring(self):
        inventory = HrMetadataInventory()
        for value in ['hr_director', '/v1/hr/recruitment', 'human-resources', 'risk_dashboard', 'knowledge_base']:
            self.assertTrue(inventory.matches(value))
        for value in ['thread', 'throughput', '/v1/messages']:
            self.assertFalse(inventory.matches(value))


if __name__ == '__main__':
    unittest.main()
