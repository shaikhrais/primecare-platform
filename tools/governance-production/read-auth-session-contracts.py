"""Read current auth identity contracts only; no accounts, secrets or writes."""
import json,os
from pathlib import Path
from production_reader import connect
ROUTES=['/v1/auth/login','/v1/auth/me','/v1/auth/mfa','/v1/auth/mfa/replacement/confirm']
with connect() as db:
 names,values=db.query('SELECT id,http_method,route_path,service_name,auth_required,permission_key,response_schema FROM api_endpoints WHERE route_path IN ('+','.join('?' for _ in ROUTES)+') ORDER BY id',ROUTES)
 rows=[dict(zip(names,row)) for row in values]
packet={'sourceCommit':os.environ.get('GITHUB_SHA'),'authority':'pinned-production-postgresql','writesAttempted':False,'contracts':rows}
out=Path('test-results/communication-stack');out.mkdir(parents=True,exist_ok=True)
(out/'auth-session-contracts.json').write_text(json.dumps(packet,indent=2)+'\n')
print('AUTH_SESSION_CONTRACTS '+json.dumps(packet))
