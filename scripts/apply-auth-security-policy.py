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
    policy={row[0]:{'maxAttempts':row[1],'windowSeconds':row[2]} for row in db.execute('SELECT operation,max_attempts,window_seconds FROM auth_security_policy ORDER BY operation')}
(ROOT/'cloudflare/workers/src/auth-security-policy.json').write_text(json.dumps(policy,indent=2)+'\n')
print('Generated governance-backed authentication security configuration.')
