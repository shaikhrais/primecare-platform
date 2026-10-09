"""Verify shared custom states against their actual original implementations."""
import ast, hashlib, json, re, subprocess, tempfile
from pathlib import Path
from urllib.parse import urljoin
from refactor_custom_screen_states import extract, model_source, screen_source, write_screen_model
ROOT = Path(__file__).resolve().parents[1]
manifest = json.loads((ROOT/'docs/refactoring/custom-screen-state-migration.json').read_text())
def original(path):
    return subprocess.check_output(['git','show',manifest['sourceCommit']+':'+path],cwd=ROOT,text=True)
def tokens(source):
    pattern = r'''"(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*'|//[^\n]*|/\*[\s\S]*?\*/|[A-Za-z_][\w]*|[^\s]'''
    return [t for t in re.findall(pattern,source) if not t.startswith(('//','/*'))]
with tempfile.TemporaryDirectory() as temp:
    work=Path(temp)
    cp=ROOT/'packages/primecare_models/.dart_tool/package_config.json'
    config=json.loads(cp.read_text())
    for p in config['packages']:p['rootUri']=urljoin(cp.as_uri(),p['rootUri'])
    (work/'packages.json').write_text(json.dumps(config))
    imports=[];calls=[]
    for i,r in enumerate(manifest['files']):
        source=original(r['path']);name=r['class'];_,_,block=extract(source,name)
        assert hashlib.sha256(source.encode()).hexdigest()==r['beforeSha256'],r['path']
        assert (ROOT/r['path']).read_text()==screen_source(source,name,r['shared']),r['path']+': presentation or validation changed'
        assert tokens((ROOT/r['shared']).read_text())==tokens(model_source(block,name)),r['shared']
        fields=re.findall(r'final\s+([^;]+?)\s+(\w+)\s*;',block)
        fields=[(typ.strip(),field) for typ,field in fields]
        assignments=[]
        for typ,field in fields:
            value='true' if typ=='bool' else '7' if typ=='int' else '1.5' if typ=='double' else "'updated'" if typ in ['String','String?'] else "const ['updated']" if typ=='List<String>' else "const [{'id':'row'}]" if typ=='List<Map<String, dynamic>>' else None
            assert value is not None,(typ,field)
            assignments.append(field+':'+value)
        comparisons=' || '.join(('!identical(a.'+field+', b.'+field+')') if typ.startswith('List') else ('a.'+field+'!=b.'+field) for typ,field in fields)
        shared=(ROOT/r['shared']).as_uri()
        program=f"import '{shared}' as m;\n"+block.replace(name,'Original'+name)+f'''
void compare(Original{name} a, m.{name} b) {{
  if ({comparisons}) throw StateError('Copy regression: {name}');
}}
void verify() {{
  const logs=<String>['old'];
  const a=Original{name}(isLoading:false,error:'old',title:'title',logs:logs);
  const b=m.{name}(isLoading:false,error:'old',title:'title',logs:logs);
  compare(a,b);
  compare(a.copyWith(),b.copyWith());
  compare(a.copyWith(isLoading:true,error:null,title:'next'),b.copyWith(isLoading:true,error:null,title:'next'));
  final m.{name} typed=b.copyWith({','.join(assignments)});
  compare(a.copyWith({','.join(assignments)}),typed);
'''
        if 'clearError' in block:program+='  compare(a.copyWith(clearError:true),b.copyWith(clearError:true));\n'
        program+='}\n';(work/f'model{i}.dart').write_text(program)
        imports.append(f"import 'model{i}.dart' as m{i};");calls.append(f'm{i}.verify();')
    # Exercise actual generator templates without executing their database writers.
    for i,path in enumerate(['scripts/scaffold_30_empty_screens.py','scripts/generate_and_verify_planned_screens.py']):
        tree=ast.parse((ROOT/path).read_text())
        template=next(ast.literal_eval(n.value) for n in tree.body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='TEMPLATE' for t in n.targets))
        name='GeneratedState'+str(i)
        for token in ['{class_name}State','{state_class}']:template=template.replace(token,name)
        screen=work/'packages/primecare_ui/lib'/f'generated{i}.dart'
        model=write_screen_model(work,screen,template,name)
        first=screen.read_text();write_screen_model(work,screen,template,name)
        assert first==screen.read_text(),'Generation changed on second run'
        assert ('class '+name+' ') not in screen.read_text(),'State remained in UI'
        assert 'package:flutter' not in model.read_text(),'Generated model depends on Flutter'
        (work/f'generator{i}.dart').write_text(f"import '{model.as_uri()}' as m;\nvoid verify(){{ const s=m.{name}(isLoading:false,error:'old',title:'title',logs:['old']); final m.{name} n=s.copyWith(isLoading:true,error:null); if(!n.isLoading || n.error!='old' || !identical(n.logs,s.logs)) throw StateError('Generated state regression'); }}")
        imports.append(f"import 'generator{i}.dart' as g{i};");calls.append(f'g{i}.verify();')
    # Identical class names in different apps must create separate model libraries.
    _,_,block=extract(template,name)
    a=write_screen_model(work,work/'apps/one/lib/screen.dart',block+'\n',name)
    b=write_screen_model(work,work/'apps/two/lib/screen.dart',block+'\n',name)
    assert a!=b and a.is_file() and b.is_file(),'App model paths collided'
    (work/'all.dart').write_text('\n'.join(imports)+'\nvoid main(){\n'+'\n'.join(calls)+"\nprint('5 shared states and 2 real generator templates matched original behavior');\n}")
    subprocess.run(['dart','--packages='+str(work/'packages.json'),str(work/'all.dart')],check=True)
route=manifest['governanceRoute']
old=original(route['path'])
assert hashlib.sha256(old.encode()).hexdigest()==route['beforeSha256']
expected=old.replace("import 'package:shelf/shelf.dart';","import 'package:server_core/server_core.dart';\nimport 'package:shelf/shelf.dart';",1)
expected=expected.replace('class GovernanceRoutes {\n  static Router get router {\n    final router = Router();','class GovernanceRoutes {\n  static Router get router => _GovernanceRouteBindings().router;\n}\n\nclass _GovernanceRouteBindings extends BaseApiRoutes {\n  @override\n  void registerRoutes(Router router) {',1).replace('    return router;\n','')
assert (ROOT/route['path']).read_text()==expected,'Governance handlers changed'
print('Static governance interface and all original registrations preserved')
