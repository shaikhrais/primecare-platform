"""Register the private provider contract without changing the public API completion count."""
import argparse,json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'cloudflare/workers/src/look/provider-policy.json'
p=argparse.ArgumentParser();p.add_argument('--check',action='store_true');a=p.parse_args()
source=sqlite3.connect(ROOT/'.agents/governance/governance.db');db=sqlite3.connect(':memory:') if a.check else source
if a.check:source.backup(db)
seed=json.loads((ROOT/'docs/appearance/look-provider-policy.json').read_text())
db.execute('CREATE TABLE IF NOT EXISTS look_ai_provider_policy(id TEXT PRIMARY KEY,definition TEXT NOT NULL,requirement TEXT NOT NULL)')
db.execute('INSERT OR REPLACE INTO look_ai_provider_policy VALUES(?,?,?)',(seed['version'],json.dumps(seed),seed['requirement']))
db.commit()
policy=json.loads(db.execute('SELECT definition FROM look_ai_provider_policy WHERE id=?',(seed['version'],)).fetchone()[0])
output=json.dumps(policy,indent=2)+'\n'
if a.check:assert OUT.read_text()==output,'Provider policy differs from governance'
else:OUT.write_text(output)
print('Registered private vision service, durable replay and fail-closed policy; no public API count change')
