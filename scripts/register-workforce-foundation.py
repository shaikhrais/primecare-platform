"""Register proposed duties and safeguards, without creating real employee assignments."""
import json,sqlite3,argparse
from pathlib import Path
root=Path(__file__).resolve().parents[1];p=argparse.ArgumentParser();p.add_argument('--check',action='store_true');a=p.parse_args();source=sqlite3.connect(root/'.agents/governance/governance.db');db=sqlite3.connect(':memory:') if a.check else source
if a.check:source.backup(db)
seed=json.loads((root/'docs/workforce/foundation-seed.json').read_text());known={r[0] for r in db.execute('SELECT role_code FROM roles WHERE active=1')}
assert len({t['task_code'] for t in seed['tasks']})==len(seed['tasks'])
for task in seed['tasks']:
 assert set(task['owner_roles']+task['reviewer_roles'])<=known
 assert all(task[k] for k in ['title','deadline_rule','evidence_required','acceptance_rule'])
 assert task['auto_assignment_enabled'] is False
assert not seed['rules']['earned_pay_withheld_for_missed_task']
db.execute('CREATE TABLE IF NOT EXISTS workforce_foundation_templates(task_code TEXT PRIMARY KEY,definition TEXT NOT NULL)');db.execute('CREATE TABLE IF NOT EXISTS workforce_foundation_policy(policy_id TEXT PRIMARY KEY,definition TEXT NOT NULL)')
for t in seed['tasks']:db.execute('INSERT OR REPLACE INTO workforce_foundation_templates VALUES(?,?)',(t['task_code'],json.dumps(t)))
db.execute('INSERT OR REPLACE INTO workforce_foundation_policy VALUES(?,?)',('workforce-v1',json.dumps({k:v for k,v in seed.items() if k!='tasks'})));db.commit()
key='workforce.operations_guide'
db.execute("INSERT OR IGNORE INTO language_resources(resource_key,resource_group,description,context,active) VALUES(?,'workforce','Employee operations foundation document','workforce',1)",(key,))
rid=db.execute('SELECT resource_id FROM language_resources WHERE resource_key=?',(key,)).fetchone()[0]
for lang,value in [('en','Employee operations foundation'),('fr','Cadre des opérations des employés'),('es','Estructura de operaciones de empleados')]:
 lid=db.execute('SELECT language_id FROM languages WHERE language_code=?',(lang,)).fetchone()[0]
 db.execute('INSERT INTO language_resource_values(resource_id,language_id,translated_text,reviewed,approved,version) SELECT ?,?,?,0,0,1 WHERE NOT EXISTS(SELECT 1 FROM language_resource_values WHERE resource_id=? AND language_id=?)',(rid,lid,value,rid,lid))
db.execute('CREATE TABLE IF NOT EXISTS report_document_registry(document_id TEXT PRIMARY KEY,resource_key TEXT NOT NULL,file_path TEXT NOT NULL,download_path TEXT NOT NULL,deployment_verified INTEGER NOT NULL DEFAULT 0)')
db.execute('INSERT OR REPLACE INTO report_document_registry VALUES(?,?,?,?,?)',('employee-operations-foundation','workforce.operations_guide','websites/typescript/public/assets/reviews/PrimeCare_Employee_Operations_Foundation.pdf','/assets/reviews/PrimeCare_Employee_Operations_Foundation.pdf',0));db.commit()
out=root/'packages/shared/src/workforce/foundation.json';content=json.dumps(seed,indent=2)+'\n'
if a.check:assert out.read_text()==content
else:out.write_text(content)
print('Registered',len(seed['tasks']),'foundation templates; real assignments created: 0')
