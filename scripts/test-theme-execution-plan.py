"""Execution inventory must preserve scope and cannot manufacture authority or completion."""
import importlib.util
from pathlib import Path
import unittest

def load(name):
    spec = importlib.util.spec_from_file_location(name, Path(__file__).with_name(name + '.py'))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module

class ExecutionPlanTests(unittest.TestCase):
    def test_ledger_preserves_every_batch_scope_and_dependency_without_acceptance_inflation(self):
        ledger = load('build-theme-execution-ledger').build()
        self.assertEqual(ledger['scopeStatements'], 86)
        self.assertEqual({i['batch'] for i in ledger['items']}, {f'B{n:02}' for n in range(1,19)})
        self.assertEqual(len({i['id'] for i in ledger['items']}), ledger['decomposedItemCount'])
        self.assertTrue(all(i['state'] == 'open' and i['executionOwner'] and i['closureRequires'] for i in ledger['items']))
        seen = set()
        for package in ledger['packages']:
            self.assertTrue(set(package['dependsOn']) <= seen)
            self.assertTrue(package['acceptance'])
            seen.add(package['id'])
        self.assertEqual(ledger['wholeBatchesComplete'], 0)
        self.assertFalse(ledger['runtimeActivated'])
        self.assertEqual(len(ledger['hostInventory']['nativeApps']), 9)
    def test_all_candidates_retained_dynamic_contracts_not_mistaken_for_absent_handlers(self):
        triage = load('build-theme-service-contract-triage').build()
        self.assertEqual(triage['candidateCount'], 187)
        self.assertTrue(all(not r['bindingApproved'] and not r['runtimeActivated'] for r in triage['candidates']))
        message = next(r for r in triage['candidates'] if r['id'] == 710)
        self.assertTrue(message['registeredContractMatches'])
        self.assertEqual(message['registeredContractMatches'][0]['operation'], 'message.command')
        self.assertEqual(message['classification'], 'registered_dynamic_router_requires_authority_and_host_acceptance')
        for candidate in triage['candidates']:
            for match in candidate['registeredContractMatches']:
                self.assertTrue(all(match['currentMetadataParity'].values()))
        self.assertEqual(triage['approvedBindings'], 0)
        self.assertTrue(all(r['historicalWorkflowReview']['freshProductionProof'] is False for r in triage['candidates'] if r['historicalWorkflowReview'] is not None))

if __name__ == '__main__':
    unittest.main()
