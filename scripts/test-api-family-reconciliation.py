"""Verify classification accounting and refusal to consume a stale route audit."""
import importlib.util
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('families', Path(__file__).with_name('generate-api-family-reconciliation.py'))
families = importlib.util.module_from_spec(spec)
spec.loader.exec_module(families)


class AccountingTests(unittest.TestCase):
    def fixture(self):
        rows = []
        for api, stage, area in [('GET /v1/auth/login', 'needs_contract_and_verification', 'auth'), ('GET /v1/client/profile', 'unit_evidence_recorded', 'client'), ('POST /v1/notes', 'blocked', 'notes')]:
            method, route = api.split(' ', 1)
            rows.append({'api': api, 'method': method, 'route': route, 'stage': stage, 'area': area, 'declarationIds': [len(rows)+1], 'missingContractFields': ['permission'] if stage.startswith('needs') else []})
        return {'operations': rows, 'summary': {'uniqueOperations': 3}, 'countingRule': 'method/path'}, {'operations': [{'api': rows[0]['api'], 'classification': 'worker_route_not_found'}]}

    def test_stages_retirements_and_pending_are_distinct(self):
        checklist, audit = self.fixture()
        package = {'retirements': {'POST /v1/auth/old': {'reason': 'stale', 'evidence': ['caller migrated']}, 'POST /v1/auth/unproven': {'reason': 'stale'}, 'GET /v1/client/profile': {'reason': 'not retired', 'evidence': ['still active']}}}
        report = families.build(checklist, audit, package)
        self.assertEqual(report['summary']['pendingOperations'], 1)
        self.assertEqual(report['summary']['documentedRetiredOperations'], 1)
        self.assertEqual(report['summary']['activeStages']['blocked'], 1)
        self.assertEqual(report['summary']['activeStages']['unit_evidence_recorded'], 1)
        self.assertFalse(report['operations'][0]['businessOperationVerified'])
        self.assertEqual(sum(report['summary']['pendingFamilyCounts'].values()), 1)
        checklist['operations'].append({'api':'POST /v1/auth/old','stage':'retired_with_evidence'})
        checklist['summary']['uniqueOperations']=4
        report=families.build(checklist,audit,package)
        self.assertEqual(report['summary']['pendingOperations'],1)
        self.assertEqual(report['summary']['activeUniqueOperations'],3)
        self.assertEqual(report['summary']['baselineUniqueOperations'],4)
        self.assertEqual(report['summary']['documentedRetiredOperations'],1)

    def test_stale_or_duplicate_probes_fail_closed(self):
        checklist, audit = self.fixture()
        for probes in [[], audit['operations'] * 2, audit['operations'] + [{'api': 'POST /old', 'classification': 'worker_route_not_found'}]]:
            with self.assertRaises(ValueError):
                families.build(checklist, {'operations': probes}, {})


if __name__ == '__main__':
    unittest.main()
