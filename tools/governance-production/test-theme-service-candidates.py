import importlib.util
from pathlib import Path
import sqlite3
import unittest
spec=importlib.util.spec_from_file_location('candidate_audit',Path(__file__).with_name('audit_theme_service_candidates.py'))
module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)

class CandidateTests(unittest.TestCase):
    def test_schema_presence_cannot_become_contract_or_authority(self):
        self.assertEqual(module.schema_evidence(None)['state'],'missing')
        self.assertEqual(module.schema_evidence('invalid')['state'],'invalid_json')
        self.assertEqual(module.schema_evidence('[]')['state'],'not_schema_object')
        self.assertEqual(module.schema_evidence('{}')['state'],'json_object_requires_semantic_review')
        self.assertEqual(module.schema_evidence('{"a":1,"b":2}')['sha256'],module.schema_evidence('{"b":2,"a":1}')['sha256'])
    def test_only_metadata_read_and_unapproved_candidates_preserve_malformed_evidence(self):
        db=sqlite3.connect(':memory:');self.addCleanup(db.close)
        db.executescript('''CREATE TABLE api_endpoints(id,http_method,route_path,service_name,auth_required,permission_key,endpoint_code,implementation_status,request_schema,response_schema);CREATE TABLE screen_api_links(api_id);CREATE TABLE api_permissions(api_id,can_access);
        INSERT INTO api_endpoints VALUES(1,'POST','/v1/messages','governance',1,'role_screen_permissions','MESSAGE','registered-unimplemented','{}','invalid'),(2,'GET','/unrelated','other',1,NULL,NULL,NULL,NULL,NULL);
        INSERT INTO screen_api_links VALUES(1);INSERT INTO api_permissions VALUES(1,1),(1,0);''')
        class Reader:
            pin={'manifestSha256':'fixture'}
            def execute(self,sql):
                if not sql.startswith('SELECT '):raise AssertionError('Write prohibited')
                return db.execute(sql)
        before=db.total_changes;result=module.capture(Reader());self.assertEqual(before,db.total_changes)
        self.assertEqual(result['candidateCount'],1);row=result['candidates'][0]
        self.assertEqual(row['grantInventory'],{'rows':2,'enabledRows':1,'authorityEstablished':False})
        self.assertEqual(row['responseSchema']['state'],'invalid_json');self.assertFalse(row['bindingApproved'])
        self.assertEqual(row['screenLinkCount'],1);self.assertFalse(result['runtimeActivated'])

if __name__=='__main__':unittest.main()
