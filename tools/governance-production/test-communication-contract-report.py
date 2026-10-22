"""No database access, credentials, grants or business records in these fixtures."""
import unittest
from communication_contract_report import assess_contracts, object_schema

class Contracts(unittest.TestCase):
    def setUp(self):
        self.api = dict(id=710, method='POST', path='/v1/messages', permission='fixture_policy',
            authRequired=1, requestSchema={'type':'object','properties':{'text':{'type':'string'}}},
            responseSchema='{"type":"object","properties":{"id":{"type":"string"}}}')
        self.links = [dict(apiId=710, screenId=234)]
        self.permissions = [dict(apiId=710, roleId=1, permission='fixture_policy', canAccess=1)]
        self.grants = [dict(screenId=234, roleId=1, canView=1)]
    def report(self):
        return assess_contracts([self.api], self.links, self.permissions, self.grants, [1])[0]
    def test_complete_metadata_never_claims_live_acceptance(self):
        report=self.report()
        self.assertTrue(report['metadataComplete'])
        self.assertFalse(report['runtimePolicyVerified'])
        self.assertFalse(report['liveAcceptanceVerified'])
    def test_each_required_binding_is_reported(self):
        self.api.update(authRequired=0, permission=None, requestSchema=None, responseSchema='invalid')
        self.links=[]
        self.assertEqual(len(self.report()['metadataGaps']), 6)
    def test_grant_must_belong_to_same_api_role_screen_and_policy(self):
        for field,value in [('apiId',711),('roleId',2),('permission','different'),('canAccess',0)]:
            with self.subTest(field=field):
                old=self.permissions[0][field];self.permissions[0][field]=value
                self.assertIn('matching_active_role_api_and_screen_grants_missing',self.report()['metadataGaps'])
                self.permissions[0][field]=old
        self.grants[0]['screenId']=331
        self.assertFalse(self.report()['metadataComplete'])
    def test_inactive_roles_are_not_matching_grants(self):
        self.assertFalse(assess_contracts([self.api], self.links, self.permissions,self.grants,[])[0]['metadataComplete'])
    def test_empty_malformed_and_nonobject_schemas_do_not_pass(self):
        for value in [None, '', '{}', '{', [], True, {'type':'object'}, {'type':'array','properties':{'x':{}}}]:
            self.assertFalse(object_schema(value))
        self.assertTrue(object_schema(self.api['requestSchema']))
    def test_report_does_not_mutate_registration_inputs(self):
        import copy
        before=copy.deepcopy([self.api,self.links,self.permissions,self.grants])
        self.report()
        self.assertEqual(before,[self.api,self.links,self.permissions,self.grants])

if __name__ == '__main__': unittest.main()
