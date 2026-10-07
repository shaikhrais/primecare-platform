import importlib.util, unittest
from pathlib import Path
spec=importlib.util.spec_from_file_location('checklist',Path(__file__).with_name('generate-api-delivery-checklist.py'))
module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)

def row(id,state='unit_fixtures_recorded',missing=None,method='GET'):
    return {'id':id,'method':method,'route':'/v1/auth/example','service':'auth',
            'verificationState':state,'missingContractFields':missing or []}

class ChecklistTests(unittest.TestCase):
    def test_duplicates_do_not_inflate_progress(self):
        data=module.build([row(1),row(2),row(3,method='POST')])
        self.assertEqual(data['summary']['uniqueOperations'],2)
        self.assertEqual(data['summary']['duplicateDeclarationRows'],1)
        self.assertEqual(data['operations'][0]['declarationIds'],[1,2])
    def test_conflicting_evidence_cannot_promote_operation(self):
        data=module.build([row(1),row(2,'verification_pending',['permission'])])
        self.assertEqual(data['operations'][0]['stage'],'needs_reconciliation')
        self.assertFalse(data['operations'][0]['unitEvidenceRecorded'])
    def test_contract_gaps_and_global_ci_are_not_completion(self):
        data=module.build([row(1,missing=['responseSchema']),row(2,'blocked',method='POST')])
        self.assertEqual(data['summary']['stages'],{'blocked':1,'needs_contract_and_verification':1})
        self.assertEqual(data['summary']['postgresEvidenceMapped'],0)
        self.assertEqual(data['firstWorkPackage']['total'],1)
        self.assertEqual(data['firstWorkPackage']['resolved'],0)

if __name__=='__main__': unittest.main()
