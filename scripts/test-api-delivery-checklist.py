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

    def test_retirements_preserve_baseline_without_earning_unit_api_credit(self):
        api='POST /v1/auth/retired'
        ledger={api:{'reason':'No matching workflow','evidence':['review.json'],'declarationIds':[9]}}
        data=module.build([row(1)],retirement_ledger=ledger)
        self.assertEqual(data['summary']['uniqueOperations'],2)
        self.assertEqual(data['summary']['activeUniqueOperations'],1)
        self.assertEqual(data['summary']['retiredOperations'],1)
        self.assertEqual(data['summary']['stages']['retired_with_evidence'],1)
        retired=next(o for o in data['operations'] if o['api']==api)
        self.assertFalse(retired['unitEvidenceRecorded'])
        self.assertEqual(data['summary']['pendingByDeclaredMethod'],{})
        with self.assertRaises(ValueError):module.build([row(1)],retirement_ledger={'GET /v1/auth/example':ledger[api]})
        with self.assertRaises(ValueError):module.build([row(1)],retirement_ledger={api:{'reason':'Insufficient evidence'}})

    def test_fixed_package_denominator_and_retirement_evidence(self):
        package={'name':'fixed','operations':['GET /v1/auth/example','POST /v1/auth/example'],'retirements':{}}
        data=module.build([row(1)],package)
        self.assertEqual(data['firstWorkPackage']['total'],2)
        self.assertEqual(data['firstWorkPackage']['resolved'],1)
        package['retirements']={'POST /v1/auth/example':{'reason':'obsolete'}}
        self.assertEqual(module.build([row(1)],package)['firstWorkPackage']['resolved'],1)
        package['retirements']['POST /v1/auth/example']['evidence']='reviewed removal commit'
        self.assertEqual(module.build([row(1)],package)['firstWorkPackage']['resolved'],2)

if __name__=='__main__': unittest.main()
