"""Check every migrated controller against its pinned original and central parent."""
import hashlib
import json
import re
import subprocess
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]

def check():
    manifest=json.loads((ROOT/'docs/architecture/controller-migration.json').read_text())
    records=manifest['migrated']
    assert len({r['path'] for r in records})==len(records), 'Duplicate migration path'
    assert manifest['newApiCompletions']==0, 'Inheritance does not complete APIs'
    proc=subprocess.Popen(['git','cat-file','--batch'],cwd=ROOT,
        stdin=subprocess.PIPE,stdout=subprocess.PIPE)
    try:
        for record in records:
            path=record['path'];target=ROOT/path
            assert target.resolve().is_relative_to(ROOT), 'Path escapes repository'
            assert target.is_file() and not target.is_symlink(), 'Missing controller '+path
            proc.stdin.write((manifest['sourceCommit']+':'+path+'\n').encode());proc.stdin.flush()
            header=proc.stdout.readline().decode().strip().split()
            assert len(header)==3 and header[1]=='blob','Missing pinned original '+path
            before=proc.stdout.read(int(header[2]));proc.stdout.read(1)
            assert hashlib.sha256(before).hexdigest()==record['beforeSha256'], 'Original source drift '+path
            original=before.decode();current=target.read_text()
            assert re.search(r'final\s+'+re.escape(record['provider'])+r'\s*=',current), 'Provider renamed '+path
            parent='BaseDashboardController' if record['kind']=='dashboard' else 'BaseScaffoldController'
            assert re.search(r'class\s+'+re.escape(record['controller'])+r'\s+extends\s+'+parent+r'\b',current), 'Missing central parent '+path
            assert not re.search(r'\b(?:loadDashboardData|syncData|performAction|build)\s*\(',current), 'Controller bypasses inherited lifecycle '+path
            if record['kind']=='dashboard':
                assert ".get('"+record['endpoint']+"')" in original, 'Original endpoint mismatch '+path
                assert re.search(r"endpoint:\s*'"+re.escape(record['endpoint'])+r"'", current),'Endpoint changed '+path
                assert re.search(r'class\s+'+re.escape(record['state'])+r'\s+extends\s+DashboardState<',current),'State identity changed '+path
            else:
                assert 'action_completed' in original, 'Not a reviewed simulation '+path
                assert 'action_completed' not in current,'Synthetic completion retained '+path
    finally:
        proc.stdin.close();proc.wait()
    hosts=json.loads((ROOT/'docs/architecture/dart-host-migration.json').read_text())
    for record in hosts['hosts']:
        path=record['path'];current=(ROOT/path).read_text()
        original=subprocess.check_output(['git','show',hosts['sourceCommit']+':'+path],cwd=ROOT,text=True)
        assert hashlib.sha256(original.encode()).hexdigest()==record['beforeSha256'], 'Host original drift '+path
        assert re.search(r'extends Base(?:ServiceHost|HttpServiceHost|CorsServiceHost)\b', current), 'Missing host parent '+path
        assert not re.search(r'\b(?:run|serve)\s*\([^;]*\)\s*(?:async\s*)?\{',current), 'Host overrides central startup '+path
        def routes(text):
            return re.findall(r"\brouter\.(get|post|put|patch|delete|all|mount)\(\s*'([^']*)'",text)
        assert routes(original)==routes(current), 'Host route/method/order changed '+path
        def sql(text):
            return re.findall(r"'(?:SELECT|INSERT|UPDATE|DELETE) [^']*'",text)
        assert sql(original)==sql(current), 'Host SQL changed '+path
        assert 'defaultPort: '+str(record['defaultPort']) in current, 'Host port changed '+path
        service=Path(path).parts[1]
        pubspec=(ROOT/'services'/service/'pubspec.yaml').read_text()
        assert 'path: ../../packages/server_core' in pubspec, 'Missing shared host dependency '+path
        docker=(ROOT/'services'/service/'Dockerfile').read_text()
        assert 'COPY packages/server_core packages/server_core' in docker, 'Missing shared host container dependency '+path
    print(json.dumps({'dartHosts':len(hosts['hosts']),'controllers':len(records),'dashboard':sum(r['kind']=='dashboard' for r in records),
      'scaffold':sum(r['kind']=='scaffold' for r in records),'newApiCompletions':0}))
if __name__=='__main__':check()
