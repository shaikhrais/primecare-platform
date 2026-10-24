"""Reusable read-only governance inventory. Never reads applicant or staff records."""
import hashlib
import json
from communication_contract_report import assess_contracts


class GovernedMetadataInventory:
    """Subclasses select candidate metadata; selection never authorizes a feature."""
    domain = None

    def matches(self, value):
        raise NotImplementedError

    def collect(self, db, source):
        if not self.domain:
            raise ValueError('Inventory domain required')
        screens = [dict(zip(('id', 'code', 'route'), row)) for row in db.execute(
            'SELECT id,screen_code,route_path FROM screens WHERE active=1 ORDER BY id').fetchall()]
        screens = [row for row in screens if self.matches(row['code']) or self.matches(row['route'])]
        screen_ids = {row['id'] for row in screens}
        all_links = [dict(zip(('apiId', 'screenId'), row)) for row in db.execute(
            'SELECT api_id,screen_id FROM screen_api_links').fetchall()]
        linked_api_ids = {row['apiId'] for row in all_links if row['screenId'] in screen_ids}
        apis = [dict(zip(('id', 'method', 'path', 'status', 'permission', 'service',
                         'authRequired', 'requestSchema', 'responseSchema'), row)) for row in db.execute(
            'SELECT id,http_method,route_path,implementation_status,permission_key,service_name,auth_required,request_schema,response_schema FROM api_endpoints ORDER BY id').fetchall()]
        apis = [row for row in apis if self.matches(row['path']) or row['id'] in linked_api_ids]
        api_ids = {row['id'] for row in apis}
        links = [row for row in all_links if row['apiId'] in api_ids]
        linked_screens = {row['screenId'] for row in links}
        permissions = [dict(zip(('apiId', 'roleId', 'permission', 'canAccess'), row)) for row in db.execute(
            'SELECT api_id,role_id,permission_key,can_access FROM api_permissions').fetchall() if row[0] in api_ids]
        grants = [dict(zip(('screenId', 'roleId', 'canView'), row)) for row in db.execute(
            'SELECT screen_id,role_id,can_view FROM role_screen_permissions').fetchall() if row[0] in linked_screens]
        roles = [dict(zip(('id', 'code'), row)) for row in db.execute(
            'SELECT id,role_code FROM roles WHERE active=1 ORDER BY id').fetchall()]
        contracts = assess_contracts(apis, links, permissions, grants, [row['id'] for row in roles])
        flows = []
        for flow_id, text, digest, status in db.execute(
                'SELECT flow_id,definition_json,definition_sha256,test_status FROM virtual_workflow_definitions WHERE flow_kind=?',
                ('business_process',)).fetchall():
            if hashlib.sha256(text.encode()).hexdigest() != digest:
                raise ValueError('Definition digest mismatch')
            definition = json.loads(text)
            if self.matches(flow_id) or self.matches(definition.get('title', '')):
                flows.append({'id': flow_id, 'testStatus': status, 'definition': definition})
        relevant_roles = {row['roleId'] for row in permissions}
        return {'source': source, 'domain': self.domain, 'authority': 'pinned-production-postgresql',
                'writesAttempted': False, 'readsBusinessRecords': False,
                'registrationIsNotVerification': True, 'candidateMatchesRequireReview': True,
                'screens': screens, 'apis': apis, 'flows': flows,
                'roles': [row for row in roles if row['id'] in relevant_roles or self.matches(row['code'])],
                'contractBindings': contracts,
                'summary': {'screens': len(screens), 'apis': len(apis), 'flows': len(flows),
                            'metadataComplete': sum(row['metadataComplete'] for row in contracts),
                            'liveAcceptanceVerified': 0, 'grantsChanged': False}}
