"""Register implementation settings for auth throttling and generate its configuration."""
import json
import sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
    with db:
        db.execute('''CREATE TABLE IF NOT EXISTS auth_security_policy (
          operation TEXT PRIMARY KEY, max_attempts INTEGER NOT NULL CHECK(max_attempts>0),
          window_seconds INTEGER NOT NULL CHECK(window_seconds>0), subject TEXT NOT NULL)''')
        db.execute('INSERT OR IGNORE INTO auth_security_policy VALUES(?,?,?,?)',
                   ('login',10,60,'sha256 of normalized login email; all attempts'))
        db.execute("UPDATE api_endpoints SET rate_limit_key='auth.login' WHERE route_path='/v1/auth/login' AND http_method='POST'")
        # Existing authenticated operations: count attempts by backend user ID,
        # independently of the session token and mutation transaction outcome.
        for operation, attempts, route in [
            ('changePassword', 5, '/v1/user/change-password'),
            ('createAccount', 10, '/v1/auth/register'),
            ('manageAccount', 10, '/v1/admin/users'),
        ]:
            if db.execute('SELECT COUNT(*) FROM api_endpoints WHERE route_path=? AND UPPER(http_method)=?',
                          (route, 'POST')).fetchone()[0] != 1:
                raise ValueError(f'Expected one governed operation: {route}')
            db.execute('INSERT OR IGNORE INTO auth_security_policy VALUES(?,?,?,?)',
                       (operation, attempts, 60, 'sha256 of operation and authenticated user ID; valid-input attempts including denied and failed mutations'))
            db.execute('UPDATE api_endpoints SET rate_limit_key=? WHERE route_path=? AND UPPER(http_method)=?',
                       ('auth.' + operation, route, 'POST'))
    policy={row[0]:{'maxAttempts':row[1],'windowSeconds':row[2]} for row in db.execute('SELECT operation,max_attempts,window_seconds FROM auth_security_policy ORDER BY operation')}
(ROOT/'cloudflare/workers/src/auth-security-policy.json').write_text(json.dumps(policy,indent=2)+'\n')
print('Generated governance-backed authentication security configuration.')
