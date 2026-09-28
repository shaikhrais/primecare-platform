"""Document implemented auth behavior, binding every operation to governance."""
import json
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def obj(properties, required=None, closed=True):
    schema = {'type': 'object', 'properties': properties, 'required': required or list(properties)}
    if closed:
        schema['additionalProperties'] = False
    return schema


def build():
    text = {'type': 'string'}
    password = {'type': 'string', 'minLength': 12, 'maxLength': 72,
                'writeOnly': True, 'description': 'Maximum 72 UTF-8 bytes; minimum 12 JavaScript string code units.'}
    policy = json.loads((ROOT / 'cloudflare/workers/src/account-policy.json').read_text())
    user = obj({'id': text, 'email': text, 'tenant_id': text, 'roles': text, 'status': text})
    token = {'type': 'string', 'pattern': '^[A-Za-z0-9_-]{43}$'}
    operations = [
        ('/v1/auth/login', 'post', 'login', 'Authenticate an active account',
         obj({'email': {'type': 'string', 'maxLength': 254}, 'password': {'type': 'string', 'minLength': 1, 'writeOnly': True}}, closed=False),
         obj({'userId': text, 'role': text, 'token': token, 'status': {'const': 'authenticated'}}), 200, [], [400, 401, 429, 503],
         'Normalizes email. Rejects ambiguous duplicate accounts. Ten attempts per normalized email per 60 seconds, including successful attempts. Stores only a token hash; session expires after 12 hours. Sets Secure HttpOnly SameSite=Lax session cookie.'),
        ('/v1/auth/me', 'get', 'currentSession', 'Resolve the active session', None,
         obj({'userId': text, 'roles': text, 'status': {'const': 'authenticated'}}), 200,
         [{'bearerSession': []}, {'cookieSession': []}], [401, 503],
         'Reads the current active user and unexpired session from PostgreSQL. Explicit invalid Authorization never falls back to a cookie. Returns roles as the existing string field.'),
        ('/v1/auth/logout', 'post', 'logout', 'Revoke the presented session', None,
         obj({'status': {'const': 'signed_out'}}), 200,
         [{}, {'bearerSession': []}, {'cookieSession': []}], [503],
         'Idempotent without credentials. Deletes the presented token hash and clears the cookie. Does not revoke other sessions.'),
        ('/v1/auth/register', 'post', 'createAccount', 'Create an authorized same-tenant account',
         obj({'email': {'type': 'string', 'format': 'email', 'maxLength': 254}, 'password': password,
              'role': {'type': 'string', 'enum': policy['ceo']}}), obj({'user': user}), 201,
         [{'bearerSession': []}], [400, 401, 403, 409, 503],
         'No public registration. CEO and HR allowlists come from account-policy.json generated from governance. Tenant is resolved from the actor, never accepted from the body. Creates bcrypt hash and account audit in one transaction. Duplicate email returns 409. Cookie-only requests are rejected.'),
        ('/v1/admin/users', 'post', 'manageAccount', 'Update account role and status',
         obj({'id': {'type': 'string', 'format': 'uuid'}, 'role': {'type': 'string', 'enum': policy['ceo']},
              'status': {'enum': ['active', 'inactive']}}), obj({'user': user}), 200,
         [{'bearerSession': []}], [400, 401, 403, 404, 503],
         'CEO only, same tenant, no self-modification. Both role and status are required. Revokes every target session and writes previous/new state to audit in the same transaction. Missing and cross-tenant targets both return 404. Cookie-only requests are rejected.'),
        ('/v1/user/change-password', 'post', 'changePassword', 'Change your password',
         obj({'currentPassword': {'type': 'string', 'minLength': 1, 'writeOnly': True}, 'newPassword': password}),
         obj({'status': {'const': 'password_changed'}, 'reauthenticationRequired': {'const': True}}), 200,
         [{'bearerSession': []}], [400, 401, 503],
         'Requires current password and active bearer session. New password must differ. Writes bcrypt hash, revokes all sessions and appends audit atomically, then clears cookie. Login again after success. This is not password recovery.'),
    ]
    spec = {'openapi': '3.1.0', 'info': {'title': 'PrimeCare implemented authentication API', 'version': '1.0.0',
            'description': 'Implementation contract, not production certification. Relative URLs refer to the API gateway. Recovery is not implemented. No automatic retries for mutations.'},
            'x-production-verified': False, 'paths': {}, 'components': {'securitySchemes': {
                'bearerSession': {'type': 'http', 'scheme': 'bearer', 'description': 'Opaque session token, not JWT.'},
                'cookieSession': {'type': 'apiKey', 'in': 'cookie', 'name': 'session_token'}}}}
    with sqlite3.connect(f'file:{ROOT / ".agents/governance/governance.db"}?mode=ro', uri=True) as db:
        for path, method, name, summary, request, response, success, security, errors, description in operations:
            rows = db.execute('SELECT id FROM api_endpoints WHERE route_path=? AND UPPER(http_method)=?', (path, method.upper())).fetchall()
            if len(rows) != 1:
                raise ValueError(f'Expected one governed operation: {method} {path}; found {len(rows)}')
            def reply(schema, detail):
                return {'description': detail, 'headers': {'Cache-Control': {'schema': {'const': 'no-store'}}},
                        'content': {'application/json': {'schema': schema}}}
            responses = {str(success): reply(response, 'Successful operation')}
            for code in errors:
                responses[str(code)] = reply(obj({'error': text}), {
                    400: 'Malformed or invalid input', 401: 'Missing/invalid session or credentials',
                    403: 'Role or tenant denied', 404: 'Account unavailable in actor tenant',
                    409: 'Account cannot be created', 429: 'Login attempts exhausted',
                    503: 'Service unavailable; details withheld'}[code])
            if 429 in errors:
                responses['429']['headers']['Retry-After'] = {'schema': {'type': 'string'}, 'description': 'Seconds until next attempt'}
            operation = {'operationId': name, 'summary': summary, 'description': description,
                         'x-governance-id': rows[0][0], 'security': security, 'responses': responses}
            if request:
                operation['requestBody'] = {'required': True, 'content': {'application/json': {'schema': request}}}
            spec['paths'][path] = {method: operation}
    return spec


if __name__ == '__main__':
    target = ROOT / 'docs/auth-openapi.json'
    target.write_text(json.dumps(build(), indent=2) + '\n')
    print(f'Exported six governed auth operations to {target.relative_to(ROOT)}')
