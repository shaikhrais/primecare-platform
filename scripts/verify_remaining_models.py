"""Compile all inherited placeholder DTOs and verify their existing empty contract."""
from pathlib import Path
import json,re,subprocess,tempfile
from urllib.parse import urljoin
ROOT=Path(__file__).resolve().parents[1]
manifest=json.loads((ROOT/'docs/refactoring/remaining-model-migration.json').read_text())
with tempfile.TemporaryDirectory() as tmp:
    work=Path(tmp);source=ROOT/'packages/primecare_models/.dart_tool/package_config.json';config=json.loads(source.read_text())
    for package in config['packages']:package['rootUri']=urljoin(source.as_uri(),package['rootUri'])
    (work/'packages.json').write_text(json.dumps(config))
    imports=[];checks=[];count=0
    for i,record in enumerate(manifest['files']):
        if record['kind']!='inherited_empty_placeholder':continue
        p=ROOT/record['path'];name=re.search(r'class (\w+) extends',p.read_text())[1]
        imports.append(f"import '{p.as_uri()}' as m{i};")
        checks.append(f"  const s{i}=m{i}.{name}();\n  if(s{i}.toJson().isNotEmpty || m{i}.{name}.fromJson({{'ignored':'unchanged'}}).toJson().isNotEmpty) throw StateError('Placeholder contract changed: {record['path']}');")
        count+=1
    (work/'all_models.dart').write_text('\n'.join(imports)+'\nvoid main() {\n'+'\n'.join(checks)+f"\n  print('{count} placeholder models compiled; empty behavior preserved');\n}}\n")
    subprocess.run(['dart','--packages='+str(work/'packages.json'),str(work/'all_models.dart')],check=True)
