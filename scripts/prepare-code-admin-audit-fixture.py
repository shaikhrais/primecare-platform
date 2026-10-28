"""Complete the explicit historical CI fixture; never touches production authority."""
import os,sqlite3
from pathlib import Path
if os.environ.get('GOVERNANCE_ALLOW_SQLITE_FIXTURES')!='1' or any(os.environ.get(k) for k in ['PRODUCTION_DATABASE_URL','GOVERNANCE_DATABASE_URL']):
 raise RuntimeError('Explicit isolated CI fixture required')
p=Path(__file__).resolve().parents[1]/'.agents/governance/governance.db'
with sqlite3.connect(p) as db:
 db.execute("INSERT OR IGNORE INTO roles(role_code,role_name,role_type,active,primary_app_code,post_login_route) VALUES('code_admin','Code Administrator','Infrastructure',1,'go','/platform/administration')")
print('Code Admin role added to isolated metadata fixture; no production connection or account changes')
