"""Compile all inline states and compare inherited behavior to pinned originals."""
import ast,hashlib,json,re,subprocess,tempfile
from pathlib import Path
from urllib.parse import urljoin
from refactor_workspace_states import convert,states
ROOT=Path(__file__).resolve().parents[1]
manifest=json.loads((ROOT/'docs/refactoring/workspace-state-migration.json').read_text())
with tempfile.TemporaryDirectory() as tmp:
    work=Path(tmp)
    cp=ROOT/'packages/primecare_models/.dart_tool/package_config.json'
    config=json.loads(cp.read_text())
    for p in config['packages']:p['rootUri']=urljoin(cp.as_uri(),p['rootUri'])
    (work/'packages.json').write_text(json.dumps(config))
    imports=[];calls=[];count=0
    for i,r in enumerate(manifest['files']):
        original=subprocess.check_output(['git','show',manifest['sourceCommit']+':'+r['path']],cwd=ROOT,text=True)
        assert hashlib.sha256(original.encode()).hexdigest()==r['beforeSha256'],r['path']
        expected,details=convert(original)
        current=(ROOT/r['path']).read_text()
        assert current==expected,r['path']+': code outside state changed'
        assert details==r['classes']
        name,_,_,old=next(states(original))
        start=current.index('class '+name+' extends BaseWorkspaceState')
        new=current[start:current.index('// --- Controller',start)].strip()
        extra=", isShiftActive:true, clients:const[], tasks:const[], shiftDurationRemaining:'10', shiftProgress:0.5" if 'final bool isShiftActive;' in old else ''
        args="isLoading:false, error:'old', title:'title', logs:logs, hasData:true"+extra
        code="import 'package:primecare_models/primecare_models.dart';\nimport 'package:primecare_models/primecare_models.dart' as core;\n"+old.replace(name,'Original'+name)+'\n'+new+f'''
void verify() {{
  const logs=<String>['entry'];
  const original=Original{name}({args});
  const migrated={name}({args});
  if (migrated is! BaseWorkspaceState) throw StateError('Missing inheritance');
  for (final mode in [0,1,2]) {{
    final old=mode==0 ? original.copyWith() : mode==1 ? original.copyWith(isLoading:true,error:null,title:'new') : original.copyWith(error:'changed', logs:const[],hasData:false);
    final {name} next=mode==0 ? migrated.copyWith() : mode==1 ? migrated.copyWith(isLoading:true,error:null,title:'new') : migrated.copyWith(error:'changed', logs:const[],hasData:false);
    if(old.isLoading!=next.isLoading || old.error!=next.error || old.title!=next.title || old.hasData!=next.hasData || !identical(old.logs,next.logs)) throw StateError('Copy regression: {r['path']}');
  }}
'''
        if 'clearError' in old:
            code+="  if(migrated.copyWith(clearError:true).error!=original.copyWith(clearError:true).error) throw StateError('Clear error regression');\n"
        if extra:
            code+="  final next=migrated.copyWith(isLoading:true);\n  if(!next.isShiftActive || !identical(next.clients,migrated.clients) || !identical(next.tasks,migrated.tasks) || next.shiftProgress!=0.5 || next.shiftDurationRemaining!='10') throw StateError('PSW field regression');\n"
        code+='}\n'
        (work/f'model{i}.dart').write_text(code)
        imports.append(f"import 'model{i}.dart' as m{i};");calls.append(f'm{i}.verify();');count+=1
    for i,path in enumerate(['scripts/scaffold_30_empty_screens.py','scripts/generate_and_verify_planned_screens.py']):
        def template(source):
            tree=ast.parse(source)
            return next(ast.literal_eval(node.value) for node in tree.body if isinstance(node,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='TEMPLATE' for t in node.targets))
        old_source=subprocess.check_output(['git','show',manifest['sourceCommit']+':'+path],cwd=ROOT,text=True)
        old=template(old_source);new=template((ROOT/path).read_text())
        name='GeneratedState'+str(i)
        for token in ['{class_name}State','{state_class}']:
            old=old.replace(token,name);new=new.replace(token,name)
        def state_block(source):
            start=source.index('class '+name)
            return source[start:source.index('// --- Controller',start)].strip()
        old=state_block(old);new=state_block(new)
        code="import 'package:primecare_models/primecare_models.dart';\n"+old.replace(name,'Original'+name)+'\n'+new+f"\nvoid verify(){{ const logs=<String>['entry']; const old=Original{name}(isLoading:false,error:'error',title:'title',logs:logs); const next={name}(isLoading:false,error:'error',title:'title',logs:logs); final a=old.copyWith(isLoading:true,error:null,title:'new'); final b=next.copyWith(isLoading:true,error:null,title:'new'); if(a.isLoading!=b.isLoading || a.error!=b.error || a.title!=b.title || !identical(a.logs,b.logs)) throw StateError('Generated copy regression'); }}"
        filename=f'generator{i}.dart';(work/filename).write_text(code)
        imports.append(f"import '{filename}' as g{i};");calls.append(f'g{i}.verify();')
    (work/'all.dart').write_text('\n'.join(imports)+'\nvoid main(){\n'+'\n'.join(calls)+f"\nprint('{count} workspace states compiled and behavior matched to originals');\n}}")
    subprocess.run(['dart','--packages='+str(work/'packages.json'),str(work/'all.dart')],check=True)
