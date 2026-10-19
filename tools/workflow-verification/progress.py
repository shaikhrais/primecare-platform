"""Reproducible engineering ledger; scoped checks never complete a role workflow."""
from abc import ABC,abstractmethod
from collections import Counter
import argparse,hashlib,json,re,sqlite3,subprocess,shutil
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
SEED=Path(__file__).with_name('progress-seed.json')
def digest(path):return hashlib.sha256(path.read_bytes()).hexdigest()
class BaseProgressStore(ABC):
 @abstractmethod
 def register(self,tasks):raise NotImplementedError
 @abstractmethod
 def tasks(self):raise NotImplementedError
 @abstractmethod
 def snapshot(self,report):raise NotImplementedError
class SqliteProgressStore(BaseProgressStore):
 def __init__(self,db):
  self.db=db;db.execute('CREATE TABLE IF NOT EXISTS engineering_progress_tasks(task_id TEXT PRIMARY KEY,definition TEXT NOT NULL)');db.execute('CREATE TABLE IF NOT EXISTS engineering_progress_snapshots(name TEXT PRIMARY KEY,definition TEXT NOT NULL)')
 def register(self,tasks):
  for task in tasks:self.db.execute('INSERT OR REPLACE INTO engineering_progress_tasks VALUES(?,?)',(task['id'],json.dumps(task)))
 def tasks(self):return [json.loads(r[0]) for r in self.db.execute('SELECT definition FROM engineering_progress_tasks ORDER BY task_id')]
 def snapshot(self,report):self.db.execute('INSERT OR REPLACE INTO engineering_progress_snapshots VALUES(?,?)',('current-recovery',json.dumps(report)))
def current_file(root,name):
 path=(root/name).resolve()
 if not path.is_relative_to(root.resolve()) or not path.is_file():raise ValueError('Evidence file missing or outside the project: '+name)
 return path

def evaluate(task,root,prerequisites=None):
 result={**task,'whole_workflow_verified':False,'test_status':'unverified','status':'implemented_unverified' if task['implementation']=='implemented' else 'pending','reason':'No current evidence registered.'}
 unmet=[name for name in task.get('depends_on',[]) if (prerequisites or {}).get(name) not in ['scoped_tested','verified']]
 if unmet:
  result.update(status='blocked',reason='Prerequisite work required: '+', '.join(unmet));return result
 if task['kind']=='registered_workflow':return result
 if task.get('evidence'):
  try:
   report=json.loads(current_file(root,task['evidence']).read_text())
   if report.get('passed') is not True or report.get('wholeTaskVerified') is not False:raise ValueError('A passing scoped receipt is required.')
   if report.get('scope')!=task['scope']:raise ValueError('Evidence scope does not match this task.')
   count=len(report['cases']) if isinstance(report.get('cases'),list) else report.get('tests')
   if count!=task['expected_cases']:raise ValueError('Acceptance case count does not match.')
   if isinstance(report.get('cases'),list) and not all(all(c.get(flag) is True for flag in task.get('required_flags',[])) for c in report['cases']):raise ValueError('Acceptance checks are incomplete.')
   sources=report.get('sources',{})
   if not set(task['required_sources']).issubset(sources):raise ValueError('Required source bindings are missing.')
   for name,expected in sources.items():
    if digest(current_file(root,name))!=expected:raise ValueError('Source changed; rerun verification: '+name)
   result.update(status='scoped_tested',test_status='current_scoped_evidence',reason='Current source-bound evidence passes for the stated scope only.',evidence_sha256=digest(current_file(root,task['evidence'])))
  except (ValueError,TypeError,KeyError,OSError) as error:result['reason']=str(error)
 return result

def report(tasks,root):
 index={t['id']:t for t in tasks};resolved={}
 def visit(task,chain=()):
  if task['id'] in resolved:return resolved[task['id']]
  if task['id'] in chain:return {**task,'status':'blocked','reason':'Dependency cycle','whole_workflow_verified':False,'test_status':'unverified'}
  deps={name:visit(index[name],(*chain,task['id']))['status'] for name in task.get('depends_on',[]) if name in index}
  resolved[task['id']]=evaluate(task,root,deps);return resolved[task['id']]
 rows=[visit(task) for task in tasks];counts=Counter(r['status'] for r in rows)
 return dict(summary=dict(tracked_items=len(rows),status_counts=dict(counts),fully_verified_workflows=0,counts_are_engineering_items_not_platform_backlog=True,historical_workflow_counts='not_revalidated_after_workspace_recovery'),tasks=rows)

def run_small_checks(tasks,root):
 jobs=[('recovery.closed-appointments',['node','--test','scripts/test-care-closed-appointments.mjs'],r'(?:#\s*)?tests\s+(\d+)'),('verification.gate-evaluator',['python3','tools/workflow-verification/test_gates.py'],r'Ran (\d+) tests')]
 jobs.append(('next.isolated-care-fixture',['node','--test','scripts/test-care-availability-api.mjs'],r'(?:#\s*)?tests\s+(\d+)'))
 for task_id,command,pattern in jobs:
  task=next(t for t in tasks if t['id']==task_id);target=root/task['evidence'];target.parent.mkdir(parents=True,exist_ok=True);target.write_text(json.dumps({'passed':False,'wholeTaskVerified':False}))
  before={name:digest(current_file(root,name)) for name in task['required_sources']}
  run=subprocess.run(command,cwd=root,capture_output=True,text=True);output=(run.stdout+'\n'+run.stderr).rstrip()+'\n';(target.with_suffix('.log')).write_text(output)
  matches=re.findall(pattern,output)
  if run.returncode or not matches or int(matches[-1])!=task['expected_cases']:raise RuntimeError('Check failed or unexpected case count: '+task_id)
  if before!={name:digest(current_file(root,name)) for name in task['required_sources']}:raise RuntimeError('Sources changed during execution: '+task_id)
  target.write_text(json.dumps(dict(passed=True,wholeTaskVerified=False,scope=task['scope'],tests=int(matches[-1]),sources=before),indent=2)+'\n')

def capture_browser_evidence(tasks,root):
 for task in tasks:
  if not task.get('run_evidence'):continue
  candidate={**task,'evidence':task['run_evidence']};checked=evaluate(candidate,root)
  if checked['status']!='scoped_tested':raise RuntimeError('Cannot preserve invalid evidence: '+task['id']+'; '+checked['reason'])
  destination=root/task['evidence'];destination.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(current_file(root,task['run_evidence']),destination)
  if task.get('run_video'):
   shutil.copyfile(current_file(root,task['run_video']),root/task['diagnostic_video'])

def save(report,target):
 target.mkdir(parents=True,exist_ok=True);(target/'recovery-progress.json').write_text(json.dumps(report,indent=2)+'\n')
 lines=['# PrimeCare recovery progress','','Scoped engineering checks are separate from full role workflows. No historical completion totals have been carried forward.','','| Item | Implementation | Evidence status | Current scope | Commit | Evidence | Next action |','| --- | --- | --- | --- | --- | --- | --- |']
 for task in report['tasks']:lines.append('| '+task['title']+' | '+task['implementation']+' | '+task['status']+' | '+task['scope']+' | '+task.get('commit','pending')+' | '+task.get('evidence','none')+' | '+task['next']+' |')
 lines+=['','## Status rules','','- pending: work is planned.','- implemented_unverified: code exists, but current evidence is missing or stale.','- scoped_tested: current tests pass only for the stated unit/component scope.','- blocked: an exact prerequisite or external blocker remains.','- verified workflow: reserved for all registered acceptance criteria and all seven evidence gates; none is claimed by this ledger.','','Current counts: '+json.dumps(report['summary']['status_counts'],sort_keys=True)+'. Fully verified workflows: 0.','','## Next sequence','','1. Run the isolated availability API fixture and preserve current evidence.','2. Run the registered PSW availability workflow through real login, UI, API, database and reload.','3. Attach video evidence, denied-access and tenant-isolation checks; evaluate the workflow gates.','','Refresh with `python3 tools/workflow-verification/progress.py`. Use `--run-small-checks` to reproduce unit and isolated API receipts. Use `--refresh-browser-evidence` after rerunning the browser checks to preserve their validated receipts and diagnostic recordings. Missing receipts or changed source hashes remove scoped test credit automatically.','','The seed registers engineering work in governance.db; generated Markdown/JSON and a database snapshot provide the current view. Existing business roles, permissions and workflow completion flags are not changed.','Commits are local until published; the deleted historical branch and its evidence remain unavailable.','']
 (target/'RECOVERY_PROGRESS.md').write_text('\n'.join(lines))
if __name__=='__main__':
 parser=argparse.ArgumentParser();parser.add_argument('--run-small-checks',action='store_true');parser.add_argument('--refresh-browser-evidence',action='store_true');args=parser.parse_args();tasks=json.loads(SEED.read_text())['tasks']
 if len({t['id'] for t in tasks})!=len(tasks):raise ValueError('Duplicate progress task IDs')
 if args.run_small_checks:run_small_checks(tasks,ROOT)
 if args.refresh_browser_evidence:capture_browser_evidence(tasks,ROOT)
 with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
  store=SqliteProgressStore(db);store.register(tasks);result=report(store.tasks(),ROOT);store.snapshot(result);save(result,ROOT/'docs/task-progress')
 print(json.dumps(result['summary']))
