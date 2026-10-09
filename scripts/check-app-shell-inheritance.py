#!/usr/bin/env python3
import hashlib,json,re,subprocess
from pathlib import Path
root=Path(__file__).resolve().parents[1]
m=json.loads((root/'docs/architecture/app-shell-migration.json').read_text())
def tokens(s):
 p=r'''"(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*'|//[^\n]*|/\*[\s\S]*?\*/|\w+|[^\s]'''
 ts = [t for t in re.findall(p,s) if not t.startswith(('//','/*'))]
 return [t for i,t in enumerate(ts) if not (t == ',' and i+1 < len(ts) and ts[i+1] in [')',']','}'])]
for app in m['apps']:
 path=app['path'];old=subprocess.check_output(['git','show',m['sourceCommit']+':'+path],cwd=root,text=True);new=(root/path).read_text()
 assert hashlib.sha256(old.encode()).hexdigest()==app['beforeSha256'],path
 assert 'class '+app['class']+' extends '+app['parent'] in new,path
 assert "applicationTitle => '"+app['title']+"'" in new,path
 assert 'ref.watch(appRouterProvider)' in new,path
 assert "import 'package:go_router/go_router.dart';" in new,path+' missing router type import'
 assert 'Widget build(' not in new and 'MaterialApp.router(' not in new,path
 # Preserve application identity overrides and bootstrap call exactly, ignoring formatting.
 body=lambda s:s[s.index('void main()'):s.index('class '+app['class'])]
 assert tokens(body(old))==tokens(body(new)),path+' bootstrap changed'
 if 'clinic/' in path:assert 'ClinicTenant().primeThemeData' in new and 'useShellBoundary => false' in new,path
 if 'corporate/' in path:assert 'corporate.PrimeCareTenant().branding' in new,path
 if 'governance/' in path:assert 'applicationThemeMode => ThemeMode.light' in new,path
print(json.dumps({'applicationRoots':len(m['apps']),'bootstrapPreserved':True,'newApiCompletions':0}))
