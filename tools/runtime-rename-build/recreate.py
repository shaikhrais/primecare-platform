from pathlib import Path
import json,re,sys,subprocess
BASE='a3052ff0350f6ef75a6b338dc66e320e34fc83c9'
EXPECTED='cb9ad8d901c58b289b64d1eaddf929f6053eec5d'
assert subprocess.check_output(['git','rev-parse','HEAD'],text=True).strip()==BASE
for root in ('apps','packages','tools/screenshots'):
 for p in Path(root).rglob('*'):
  if not p.is_file() or p.name=='test_credentials_registry.dart' or not (p.suffix=='.dart' or p.name in ('pubspec.yaml','pubspec.lock')):continue
  s=p.read_text(encoding='utf-8')
  t=s.replace('package:flutter_core/flutter_core.dart','package:primecare_runtime/primecare_runtime.dart').replace('package:flutter_core/','package:primecare_runtime/')
  if p.name in ('pubspec.yaml','pubspec.lock'):t=re.sub(r'\bflutter_core\b','primecare_runtime',t)
  if t!=s:p.write_text(t,encoding='utf-8')
old=Path('packages/flutter_core');new=Path('packages/primecare_runtime')
old.rename(new);(new/'lib/flutter_core.dart').rename(new/'lib/primecare_runtime.dart')
p=new/'lib/primecare_core.dart';p.write_text(p.read_text().replace("'flutter_core.dart'","'primecare_runtime.dart'"))
p=Path('tools/package_master/catalog.py');p.write_text(p.read_text().replace("identity == 'flutter_core'", "identity == 'primecare_runtime'"))
sys.path.insert(0,'tools/package_master')
import catalog
p=Path('packages/primecare_package_base/catalog.json')
data=json.loads(p.read_text().replace('flutter_core','primecare_runtime'))
for entry in data['packages']:
 for field in ('dependencies','developmentDependencies','sourceDependencies'):
  if field in entry:entry[field].sort()
data['packages'].sort(key=lambda e:e['path'])
for path,content in catalog.outputs(data).items():path.write_text(content)
p=Path('scripts/test_registry.dart');s=p.read_text()
t=re.sub(r"(?m)^(\s*(?:import|export|part)\s+['\"])package:flutter_core/flutter_core\.dart",r"\g<1>package:primecare_runtime/primecare_runtime.dart",s)
t=re.sub(r"(?m)^(\s*(?:import|export|part)\s+['\"])package:flutter_core/",r"\g<1>package:primecare_runtime/",t)
if t!=s:p.write_text(t)
for p in Path('.github/workflows').glob('*.yml'):
 s=p.read_text()
 if 'flutter_core' not in s or re.search(r'PC_SHA:|PC_TREE:|PC_PARENT:|ref:.*[0-9a-f]{40}',s) or p.name.startswith(('deploy','release','record')) or p.name=='build_macos.yml':continue
 t=s.replace('packages/flutter_core/lib/flutter_core.dart','packages/primecare_runtime/lib/primecare_runtime.dart').replace('packages/flutter_core/','packages/primecare_runtime/').replace('packages/flutter_core\n','packages/primecare_runtime\n').replace('package:flutter_core/flutter_core.dart','package:primecare_runtime/primecare_runtime.dart').replace('package:flutter_core/','package:primecare_runtime/')
 if t!=s:p.write_text(t)
paths=['scripts/check_route_sites.py','scripts/check_screen_inheritance.py','scripts/check-screen-style-boundary.py','scripts/check-shared-ui-boundary.py','scripts/audit-ui-localization.py','scripts/generate-controller-compile-test.py','tools/build-communication-stack.py','tools/fuse-reference-cloud/prepare_layout_capture.py']
for x in paths:
 p=Path(x);s=p.read_text();t=s.replace('packages/flutter_core','packages/primecare_runtime')
 if x=='tools/build-communication-stack.py':t=t.replace('flutter_core:', 'primecare_runtime:')
 p.write_text(t)
subprocess.run(['git','add','-A','--','apps','packages','tools/package_master','tools/screenshots','scripts','.github/workflows','tools/build-communication-stack.py','tools/fuse-reference-cloud/prepare_layout_capture.py'],check=True)
actual=subprocess.check_output(['git','write-tree'],text=True).strip()
assert actual==EXPECTED, f'Candidate source tree differs: {actual}, expected {EXPECTED}'
print('Exact source tree confirmed:',actual)
