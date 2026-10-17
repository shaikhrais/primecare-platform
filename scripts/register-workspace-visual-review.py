"""Bind existing workspace screens to shared visual presentation; no readiness grants."""
import sqlite3,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1];db=sqlite3.connect(ROOT/'.agents/governance/governance.db');catalog=json.loads((ROOT/'cloudflare/workers/src/workspace-registry.json').read_text())
db.execute('CREATE TABLE IF NOT EXISTS workspace_visual_bindings(screen_id INTEGER PRIMARY KEY,renderer TEXT NOT NULL,component_codes TEXT NOT NULL,review_scope TEXT NOT NULL)')
db.execute('DELETE FROM workspace_visual_bindings')
for screen in catalog['screens']:
 if not any(g['view']==1 for g in screen['grants']) or screen['renderer']=='account' or screen['route'] in ['/growth','/appearance-review','/platform/administration','/maintenance/configuration','/forgot-password','/reset-password']:continue
 db.execute('INSERT OR REPLACE INTO workspace_visual_bindings VALUES(?,?,?,?)',(screen['id'],screen['renderer'],json.dumps(['prime_card','prime_icon_web']),'Inherited headings, role labels, navigation icons, task-first content; no domain-workflow completion claim'))
db.commit();print('Registered existing workspace visual bindings:',db.execute('SELECT COUNT(*) FROM workspace_visual_bindings').fetchone()[0])
