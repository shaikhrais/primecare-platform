#!/usr/bin/env python3
"""Move existing application classes out of executables, preserving public exports."""
import argparse
import hashlib
import json
import os
import re
import subprocess
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
SOURCE='b41d21be2ac6de9ae8b32e4adadf24c66081c440'
MANIFEST=ROOT/'docs/refactoring/service-entrypoint-migration.json'


def render(path,source):
    service=Path(path).parts[1]
    main=re.search(r'Future<void> main\([^)]*\) async \{\n.*?\n\}',source,re.S)
    assert main is not None,path
    name=re.search(r'class (\w+) extends Base(?:Http|Cors)ServiceHost',source)[1]
    target=f'services/{service}/lib/src/application/{service}_host.dart'
    library=source[:main.start()]+source[main.end():]
    def relocate(match):
        uri=match[2]
        if ':' in uri:
            return match[0]
        resolved=(ROOT/Path(path).parent/uri).resolve()
        assert resolved.is_relative_to(ROOT) and resolved.is_file(),uri
        relocated=os.path.relpath(resolved,ROOT/Path(target).parent)
        return match[1]+relocated+match[3]
    library=re.sub(r"((?:import|export)\s+')([^']+)(';)",relocate,library)
    uri=f'package:{service}/src/application/{service}_host.dart'
    executable=f"import '{uri}';\nexport '{uri}';\n\n"+main[0]+'\n'
    return {path:executable,target:library},name,target


def current_host_source(path):
    if MANIFEST.exists():
        manifest=json.loads(MANIFEST.read_text())
        for entry in manifest['services']:
            if entry['entrypoint']==path:
                if entry['application'] == 'services/api_gateway/lib/src/application/api_gateway_host.dart' and (ROOT/'docs/refactoring/gateway-layer-migration.json').exists():
                    from refactor_gateway_layers import verify_gateway, original, HOST
                    verify_gateway()
                    return original(HOST)
                if entry['application'] == 'services/auth_api/lib/src/application/auth_api_host.dart' and (ROOT/'docs/refactoring/auth-layer-migration.json').exists():
                    from refactor_auth_layers import verify_auth, original
                    verify_auth()
                    return original()
                if (ROOT/'docs/refactoring/domain-host-migration.json').exists():
                    from refactor_domain_hosts import SERVICES, host_path, verify_domain, original
                    for service in SERVICES:
                        if entry['application'] == host_path(service):
                            verify_domain(service)
                            return original(service)
                return (ROOT/entry['application']).read_text()
    return (ROOT/path).read_text()


def main():
    parser=argparse.ArgumentParser();parser.add_argument('--check',action='store_true');args=parser.parse_args()
    paths=sorted(str(p.relative_to(ROOT)) for p in ROOT.glob('services/*/bin/server.dart'))
    outputs={};entries=[]
    for path in paths:
        source=subprocess.check_output(['git','show',SOURCE+':'+path],cwd=ROOT,text=True)
        files,name,target=render(path,source)
        outputs.update(files)
        entries.append({'entrypoint':path,'application':target,'class':name,'beforeSha256':hashlib.sha256(source.encode()).hexdigest()})
    expected={'sourceCommit':SOURCE,'services':entries,'completedWorkflows':0}
    if args.check:
        assert json.loads(MANIFEST.read_text())==expected,'Service inventory changed'
        for path,content in outputs.items():
            if path == 'services/api_gateway/lib/src/application/api_gateway_host.dart' and (ROOT/'docs/refactoring/gateway-layer-migration.json').exists():
                from refactor_gateway_layers import verify_gateway, original, HOST
                verify_gateway()
                assert original(HOST) == content, 'Gateway host baseline changed'
            elif path == 'services/auth_api/lib/src/application/auth_api_host.dart' and (ROOT/'docs/refactoring/auth-layer-migration.json').exists():
                from refactor_auth_layers import verify_auth, original
                verify_auth()
                assert original() == content, 'Auth host baseline changed'
            elif (ROOT/'docs/refactoring/domain-host-migration.json').exists() and path in [f'services/{service}/lib/src/application/{service}_host.dart' for service in __import__('refactor_domain_hosts').SERVICES]:
                from refactor_domain_hosts import verify_domain, original
                service = Path(path).parts[1]
                verify_domain(service)
                assert original(service) == content, 'Domain host baseline changed'
            else:
                assert (ROOT/path).read_text()==content,'Application/entrypoint changed: '+path
        print(json.dumps({'services':len(entries),'separateApplicationClasses':len(entries),'publicEntrypointsPreserved':True,'completedWorkflows':0}))
        return
    assert not MANIFEST.exists(),'Already migrated; use --check'
    for entry in entries:
        path=entry['entrypoint']
        source=subprocess.check_output(['git','show',SOURCE+':'+path],cwd=ROOT,text=True)
        assert (ROOT/path).read_text()==source,'Refusing changed source: '+path
        assert not (ROOT/entry['application']).exists(),'Refusing overwrite'
    for path,content in outputs.items():
        (ROOT/path).parent.mkdir(parents=True,exist_ok=True);(ROOT/path).write_text(content)
    MANIFEST.write_text(json.dumps(expected,indent=2)+'\n')


if __name__=='__main__':
    main()
