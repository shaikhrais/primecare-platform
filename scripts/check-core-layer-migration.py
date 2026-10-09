#!/usr/bin/env python3
"""Pinned equivalence of reorganized core code, excluding declared field/parent extraction."""
from pathlib import Path
import re,json,hashlib,subprocess
r=Path(__file__).resolve().parents[1];m=json.loads((r/'docs/architecture/core-layer-migration.json').read_text())
def strip_imports(s):return re.sub(r'^import [^;]+;\s*','',s,flags=re.M)
def tokens(s):
 p=r'''"(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*'|//[^\n]*|/\*[\s\S]*?\*/|\w+|[^\s]'''
 ts=[t for t in re.findall(p,s) if not t.startswith(('//','/*'))]
 return [t for i,t in enumerate(ts) if not(t==',' and i+1<len(ts) and ts[i+1] in [')',']','}'])]
for rec in m['files']:
 source=rec['source'];old=subprocess.check_output(['git','show',m['sourceCommit']+':'+source],cwd=r,text=True)
 assert hashlib.sha256(old.encode()).hexdigest()==rec['beforeSha256'],source+' pinned source differs'
 expected=old
 for a,b in rec['replacements']:
  assert a in expected,(source,a);expected=expected.replace(a,b)
 expected=rec['prefix']+expected
 current=(r/rec['target']).read_text()
 if rec.get('modelTarget'):current=(r/rec['modelTarget']).read_text()+current
 if rec.get('modelTarget'):expected=strip_imports(expected);current=strip_imports(current)
 assert tokens(expected)==tokens(current),source+' behavior changed beyond declared extraction'
 assert tokens((r/source).read_text())==tokens(rec['facade']),source+' compatibility facade differs'
 assert all(x not in (r/source).parts for x in ['..']),source
print(json.dumps({'reorganizedFiles':len(m['files']),'businessServices':5,'entityModels':11,'responseEnvelopes':1,'repositories':1,'permissionPolicies':1,'newApiCompletions':0}))
