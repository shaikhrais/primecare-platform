"""Repair stale role landing metadata only when an exact governed screen exists."""
import json,sqlite3
from pathlib import Path
root=Path(__file__).resolve().parents[1]
db=sqlite3.connect(root/'.agents/governance/governance.db')
changes=[];unresolved=[]
with db:
 for rid,code,path in db.execute('SELECT id,role_code,post_login_route FROM roles WHERE active=1').fetchall():
  if code=='ceo':
   candidates=db.execute("SELECT route_path FROM screens WHERE screen_code='ceo_dashboard' AND role_id=? AND active=1",(rid,)).fetchall()
  elif db.execute('SELECT 1 FROM screens WHERE active=1 AND route_path=? AND role_id=?',(path,rid)).fetchone():
   continue
  else:
   key=(path or '').rsplit('/',1)[-1].replace('-','_')
   candidates=db.execute('SELECT route_path FROM screens WHERE screen_code=? AND role_id=? AND active=1',(key,rid)).fetchall()
  if len(candidates)!=1:
   unresolved.append(code);continue
  target=candidates[0][0]
  db.execute('UPDATE roles SET post_login_route=? WHERE id=?',(target,rid))
  changes.append({'role':code,'before':path,'after':target})
print(json.dumps({'changes':changes,'unresolved':unresolved},indent=2))
