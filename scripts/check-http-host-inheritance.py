#!/usr/bin/env python3
"""Verify the middleware extraction against pinned source and route bodies."""
import hashlib,json,re,subprocess
from pathlib import Path
root=Path(__file__).resolve().parents[1]
man=json.loads((root/'docs/architecture/http-host-migration.json').read_text())
def tokens(s):
    pattern = r'''"(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*'|//[^\n]*|/\*[\s\S]*?\*/|[A-Za-z_][\w]*|[^\s]'''
    return [t for t in re.findall(pattern, s) if not t.startswith(('//', '/*'))]

def route_body(s,method):
    start=s.index('Future<Handler> '+method+'() async {')
    start=s.index('{',start)
    # Preserve every route token before the old pipeline or the new router return.
    end=s.index('    final handler =',start) if method=='createHandler' else s.index('    return router.call;',start)
    return tokens(s[start:end])
for host in man['hosts']:
    path=host['path'];original=subprocess.check_output(['git','show',man['sourceCommit']+':'+path],cwd=root,text=True)
    assert hashlib.sha256(original.encode()).hexdigest()==host['beforeSha256'],path
    current=(root/path).read_text()
    assert 'extends '+host['parent'] in current,path
    assert 'createHandler(' not in current and '.addMiddleware(' not in current,path
    assert route_body(original,'createHandler')==route_body(current,'createRoutes'),path+' route body changed'
    # All gateway CORS header values remain exact; governance custom middleware order remains exact.
    if 'api_gateway/' in path:
        old=host['originalPipeline']; current_policy=current.split('List<Middleware> get middleware =>',1)[1].split('void onStarted',1)[0]
        literals=lambda s:re.findall(r"'(?:\\.|[^'\\])*'",s)
        assert literals(old)==literals(current_policy),path+' CORS settings changed'
        assert current_policy.index('logRequests()')<current_policy.index('corsHeaders('),path
    if 'governance_api/' in path:
        assert 'get middleware => [corsMiddleware(), logRequests()]' in current,path
    if 'auth_api/' in path:
        assert 'get middleware' not in current and 'corsHeaders' not in current,path
print(json.dumps({'httpHosts':len(man['hosts']),'routeBodiesPreserved':True,'newApiCompletions':0}))
