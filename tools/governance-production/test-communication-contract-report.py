"""No database access, credentials, grants or business records in these fixtures."""
import unittest
from communication_contract_report import assess_contracts, object_schema, response_schema

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
    def test_registered_command_variants_and_private_binary_response_are_recognized(self):
        self.assertTrue(object_schema({'type':'object','oneOf':[self.api['requestSchema'],self.api['requestSchema']]}))
        self.assertFalse(object_schema({'type':'object','oneOf':[{}]}))
        self.assertFalse(object_schema({'type':'object','oneOf':[]}))
        self.assertTrue(response_schema({'type':'string','format':'binary','contentMediaType':'image/png'}))
        self.assertFalse(response_schema({'type':'string','format':'binary','contentMediaType':'image/svg+xml'}))
    def test_report_does_not_mutate_registration_inputs(self):
        import copy
        before=copy.deepcopy([self.api,self.links,self.permissions,self.grants])
        self.report()
        self.assertEqual(before,[self.api,self.links,self.permissions,self.grants])

    def test_closed_empty_command_is_not_an_unconstrained_object(self):
        schema = dict(type='object', properties={}, additionalProperties=False, required=[])
        self.assertTrue(object_schema(schema))
        self.assertTrue(object_schema(__import__('json').dumps(schema)))
        for change in [dict(additionalProperties=True), dict(required=['missing']),
                       dict(minProperties=1), dict(patternProperties={'.*': {}})]:
            self.assertFalse(object_schema(dict(schema, **change)))

    def test_registered_voice_shapes_without_promoting_access(self):
        import json
        from pathlib import Path
        definition = json.loads(Path(__file__).with_name('twilio-contracts-registration.json').read_text())
        self.assertEqual(len(definition['operations']), 21)
        for operation in definition['operations']:
            with self.subTest(operation=operation['key']):
                self.assertTrue(object_schema(operation['request']))
                self.assertTrue(response_schema(operation['response']))
                self.api.update(requestSchema=operation['request'], responseSchema=operation['response'])
                report = assess_contracts([self.api], [], [], [], [1])[0]
                self.assertEqual(report['metadataGaps'], ['screen_link_missing',
                    'matching_active_role_api_and_screen_grants_missing'])
                self.assertFalse(report['metadataComplete'])
                self.assertFalse(report['runtimePolicyVerified'])
                self.assertFalse(report['liveAcceptanceVerified'])

    def test_unbounded_xml_and_unknown_response_types_remain_gaps(self):
        for value in [dict(type='string'), dict(type='string', contentMediaType='text/html'),
                      dict(type='string', contentMediaType='application/xml'),
                      dict(type='null', properties={'x': {}})]:
            self.assertFalse(response_schema(value))
        for minimum, maximum in [(0, 100), (1, 32769), (10, 2), (True, 100), (1, '100')]:
            self.assertFalse(response_schema(dict(type='string', contentMediaType='application/xml',
                minLength=minimum, maxLength=maximum)))

if __name__ == '__main__': unittest.main()
