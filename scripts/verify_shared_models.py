"""Compile every migrated state and verify inherited copy behavior with Dart."""
import json
import re
import subprocess
import tempfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
manifest=json.loads((ROOT/'docs/refactoring/shared-model-migration.json').read_text())
with tempfile.TemporaryDirectory() as tmp:
    work=Path(tmp)
    (work/'packages.json').write_text(json.dumps({'configVersion':2,'packages':[{
        'name':'primecare_models',
        'rootUri':(ROOT/'packages/primecare_models').as_uri()+'/',
        'packageUri':'lib/','languageVersion':'3.11'}]}))
    imports=[];checks=[];count=0
    for i,record in enumerate(manifest['files']):
        if record['kind']!='inherited_screen_state':continue
        p=ROOT/record['path'];name=re.search(r'class (\w+) extends',p.read_text())[1]
        imports.append(f"import '{p.as_uri()}' as m{i};")
        checks.append(f"""  const s{i}=m{i}.{name}(errorMessage:'existing',data:{{'id':'1'}});
  final m{i}.{name} n{i}=s{i}.copyWith(isLoading:true);
  if(!n{i}.isLoading || n{i}.errorMessage!='existing' || !identical(n{i}.data,s{i}.data)) {{
    throw StateError('Regression: {record['path']}');
  }}""")
        count+=1
    program='\n'.join(imports)+'\nvoid main() {\n'+'\n'.join(checks)+f"\n  print('{count} inherited models compiled and copy behavior verified');\n}}\n"
    (work/'all_models.dart').write_text(program)
    subprocess.run(['dart','--packages='+str(work/'packages.json'),str(work/'all_models.dart')],check=True)
