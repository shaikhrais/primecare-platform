"""Reconcile existing handlers without adding routes or changing role grants."""
import json
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
policy = json.loads((ROOT / 'cloudflare/workers/src/account-policy.json').read_text())
string = {'type': 'string'}
password = {'type': 'string', 'description': 'At least 12 JavaScript UTF-16 code units and at most 72 UTF-8 bytes; validated by the handler.'}
def obj(properties, required=None):
    return {'type': 'object', 'additionalProperties': False, 'required': required or list(properties), 'properties': properties}
identity = obj({'userId': string, 'roles': string, 'status': {'const': 'authenticated'}})
user = obj({k: string for k in ['id', 'email', 'tenant_id', 'roles', 'status']})
ignored = {'description': 'Body and query are ignored. Identity is determined solely from valid session credentials.'}
register = obj({'email': {'type': 'string', 'description': 'Trimmed and lowercased before email validation; normalized value is at most 254 UTF-16 code units.'}, 'password': password, 'role': {'type': 'string', 'enum': sorted(set(sum(policy.values(), [])))}})
manage = obj({'id': {'type': 'string', 'pattern': '^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$'}, 'role': {'type': 'string', 'enum': policy['ceo']}, 'status': {'enum': ['active', 'inactive']}})
change = obj({'currentPassword': {'type': 'string', 'minLength': 1, 'description': 'At most 72 UTF-8 bytes; must match the current password.'}, 'newPassword': password})
changed = obj({'status': {'const': 'password_changed'}, 'reauthenticationRequired': {'const': True}})
list_operation = json.loads((ROOT / 'docs/api/account-batch-2.openapi.json').read_text())['paths']['/v1/admin/users']['get']
list_query = obj({p['name']: p['schema'] for p in list_operation['parameters']}, [])
# obj defaults required to all fields: list query is optional.
list_query['required'] = []
list_response = list_operation['responses']['200']['content']['application/json']['schema']
definitions = [
    (242, 'POST', '/v1/admin/users', 'auth_account_management_policy', 'ceo_dashboard', manage, obj({'user': user}), 'Manage another account in the active CEO tenant; revoke target sessions and audit the change.', 200),
    (243, 'GET', '/v1/auth/me', 'authenticated_self_session', 'login', ignored, identity, 'Read current session identity using bearer or session cookie.', 200),
    (244, 'POST', '/v1/auth/me', 'authenticated_self_session', 'login', ignored, identity, 'Read current session identity; this compatibility POST performs no mutation.', 200),
    (245, 'POST', '/v1/auth/register', 'auth_account_creation_policy', 'ceo_dashboard', register, obj({'user': user}), 'Create a tenant account under the existing CEO or HR role assignment policy. Explicit bearer required.', 201),
    (246, 'POST', '/v1/user/change-password', 'authenticated_self_with_current_password', 'login', change, changed, 'Change own password after current-password verification; revoke all sessions and password resets.', 200),
    (247, 'GET', '/v1/admin/users', 'auth_account_management_policy', 'ceo_dashboard', list_query, list_response, 'Reconcile the legacy declaration with the existing CEO tenant account-list handler.', 200),
]
paths = {}
with sqlite3.connect(ROOT / '.agents/governance/governance.db') as db:
    selected = []
    # Validate the entire set before the first write. Preserve declaration IDs.
    for batch, method, route, permission, screen, request, response, description, status in definitions:
        rows = db.execute('SELECT id,service_name,auth_required,permission_key FROM api_endpoints WHERE http_method=? AND route_path=?', (method, route)).fetchall()
        if len(rows) != (2 if batch == 247 else 1):
            raise RuntimeError('Unexpected declaration count: ' + method + ' ' + route)
        for aid, service, authenticated, existing in rows:
            legacy_list = batch == 247 and service == 'PRISMA' and existing is None
            if service not in ('PRISMA', 'auth', None) or authenticated != 1 or (existing != permission and not legacy_list):
                raise RuntimeError('Existing authority drift: ' + method + ' ' + route)
        if batch == 247 and not any(r[1:] == ('auth', 1, permission) for r in rows):
            raise RuntimeError('Missing canonical account-list authority')
        # Preserve the existing self-session screen binding, including its
        # inactive lifecycle. A contract link does not activate a page.
        screen_rows = db.execute('SELECT id FROM screens WHERE screen_code=? AND (?=\'login\' OR active=1)', (screen, screen)).fetchall()
        if len(screen_rows) != 1:
            raise RuntimeError('Missing or ambiguous existing screen: ' + screen)
        selected.append((rows, screen_rows[0][0]))
    for definition, (rows, sid) in zip(definitions, selected):
        batch, method, route, permission, screen, request, response, description, status = definition
        for aid, *_ in rows:
            db.execute("UPDATE api_endpoints SET service_name='auth',implementation_status='implemented',permission_key=?,request_schema=?,response_schema=? WHERE id=?", (permission, json.dumps(request), json.dumps(response), aid))
            db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)', (sid, aid, description))
        # Inventory keys preserve the method; GET remains compatible with prior keys.
        key = route if method == 'GET' else method + ' ' + route
        db.execute("INSERT OR REPLACE INTO governance_api_batches VALUES(?,?,?,?, 'implemented','pending')", (key, sid, batch, permission))
        if batch == 247:
            operation = list_operation
        else:
            operation = {'operationId': 'existingAuthBatch' + str(batch), 'description': description, 'security': [{'bearerAuth': []}] + ([{'sessionCookie': []}] if batch in (243, 244) else []), 'responses': {str(status): {'description': 'Successful existing handler response', 'content': {'application/json': {'schema': response}}}, **{str(code): {'description': label} for code, label in [(400, 'Invalid input'), (401, 'Invalid session or current credentials'), (403, 'Existing authority or tenant policy rejects request'), (429, 'Rate limit'), (503, 'Source unavailable')]}}}
            if method == 'POST':
                operation['requestBody'] = {'required': batch != 244, 'content': {'application/json': {'schema': request}}}
            if batch == 242:
                operation['responses']['404'] = {'description': 'Target absent in the actor tenant'}
            if batch == 245:
                operation['responses']['409'] = {'description': 'Account cannot be created'}
        paths.setdefault(route, {})[method.lower()] = operation
document = {'openapi': '3.1.0', 'info': {'title': 'Existing authentication contracts, batches 242–247', 'version': '1.0.0'}, 'paths': paths, 'components': {'securitySchemes': {'bearerAuth': {'type': 'http', 'scheme': 'bearer'}, 'sessionCookie': {'type': 'apiKey', 'in': 'cookie', 'name': 'session_token'}}}}
(ROOT / 'docs/api/existing-auth-batches-242-247.openapi.json').write_text(json.dumps(document, indent=2) + '\n')
print('Reconciled six existing authentication declarations; no new routes or grants.')
