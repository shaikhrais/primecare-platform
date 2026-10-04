#!/usr/bin/env python3
"""Generate source-backed Archify inputs and a searchable repository index."""
import argparse, hashlib, html, json, re, sqlite3, subprocess
from pathlib import Path
import yaml, tomllib

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / 'docs/architecture/generated'
REV = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
REMOTE = 'https://github.com/shaikhrais/primecare-platform'

def source(path, line=1, end=None):
    item = {'path': str(path), 'line': line}
    if end: item['end_line'] = end
    return item

def node(identifier, label, kind, path, pos, sublabel='', line=1, end=None):
    return {'id': identifier, 'label': label, 'type': kind, 'sublabel': sublabel,
            'pos': pos, 'size': [240, 84], 'sources': [source(path, line, end)]}

def diagram(slug, title, nodes, edges, notes):
    folder = OUT / slug
    folder.mkdir(parents=True, exist_ok=True)
    spec = {'schema_version': 1, 'diagram_type': 'architecture',
            'meta': {'title': title, 'locale': 'en', 'quality_profile': 'showcase',
                     'output': str((folder / 'map.html').relative_to(ROOT)),
                     'repository': {'url': REMOTE + '.git', 'revision': REV}},
            'components': nodes, 'connections': edges,
            'cards': [{'dot': 'amber', 'title': 'Evidence and limits', 'items': notes}]}
    (folder / 'candidate.json').write_text(json.dumps(spec, indent=2) + '\n')
    return {'slug': slug, 'title': title, 'href': f'{slug}/map.html'}

def edge(a, b, label):
    return {'id': a + '-to-' + b, 'from': a, 'to': b, 'label': label}

def project_inventory():
    projects = []
    for top in ['apps', 'services', 'packages', 'websites']:
        for manifest in sorted((ROOT / top).glob('*/pubspec.yaml')) + sorted((ROOT / top).glob('*/package.json')):
            rel = manifest.relative_to(ROOT)
            data = yaml.safe_load(manifest.read_text()) if manifest.suffix == '.yaml' else json.loads(manifest.read_text())
            projects.append({'name': data['name'], 'root': str(rel.parent), 'manifest': str(rel),
                             'group': top, 'runtime': 'Dart / Flutter' if manifest.suffix == '.yaml' else 'TypeScript / Node',
                             'dependencies': data.get('dependencies', {}), 'local_dependencies': []})
    for config in sorted((ROOT/'apps').glob('*/wrangler.toml')):
        if not (config.parent/'pubspec.yaml').exists():
            data=tomllib.loads(config.read_text())
            projects.append({'name':data.get('name',config.parent.name),'root':str(config.parent.relative_to(ROOT)),
                             'manifest':str(config.relative_to(ROOT)),'group':'apps','runtime':'Cloudflare Worker',
                             'dependencies':{},'local_dependencies':[]})
    registry = ROOT / 'websites/typescript/projects.json'
    if registry.exists():
        projects.append({'name':'typescript-web-runtime','root':'websites/typescript',
                         'manifest':'websites/typescript/src/main.ts','group':'packages',
                         'runtime':'Shared TypeScript website entry','dependencies':{},'local_dependencies':[]})
        for name in json.loads(registry.read_text()):
            projects.append({'name':name,'root':'websites/typescript','manifest':str(registry.relative_to(ROOT)),
                             'group':'websites','runtime':'Registered TypeScript website',
                             'dependencies':{'typescript-web-runtime':'registered build entry'},'local_dependencies':[]})
    names = {p['name']: p for p in projects}
    roots = {p['root']: p for p in projects}
    for p in projects:
        for name, value in p['dependencies'].items():
            target = None
            if isinstance(value, dict) and 'path' in value:
                target = roots.get(str((ROOT / p['root'] / value['path']).resolve().relative_to(ROOT)))
            elif name in names: target = names[name]
            if target: p['local_dependencies'].append(target['name'])
    return projects, names

def code_inventory():
    files = []
    tracked = set(subprocess.check_output(['git','ls-files'],cwd=ROOT,text=True).splitlines())
    excludes = {'node_modules', '.dart_tool', 'build', 'dist', 'generated', 'test', 'tests', 'integration_test', 'scratch'}
    for top in ['apps', 'services', 'packages', 'websites', 'cloudflare']:
        for path in sorted((ROOT / top).rglob('*')):
            if not path.is_file() or path.suffix not in {'.dart', '.ts', '.tsx', '.js', '.mjs', '.prisma', '.sql'}: continue
            rel = path.relative_to(ROOT)
            if str(rel) not in tracked: continue
            if any(part in excludes for part in rel.parts): continue
            text = path.read_text(errors='replace')
            declarations = []
            for number, line in enumerate(text.splitlines(), 1):
                # Candidate declarations, not an inferred executable call graph.
                m = re.match(r'\s*(?:export\s+)?(?:abstract\s+)?(?:class|enum|mixin|interface)\s+(\w+)', line)
                if m: declarations.append({'name': m[1], 'line': number, 'kind': 'type'}); continue
                m = re.match(r'\s*(?:export\s+)?(?:async\s+)?function\s+(\w+)\s*\(', line)
                if not m:
                    m = re.match(r'\s*(?:(?:static|async|Future<[^>]+>|Future|void|bool|String|int|double|Widget|[A-Z]\w*(?:<[^>]+>)?)\s+)+(\w+)\s*\(', line)
                if m and m[1] not in {'if','for','while','switch','catch'}:
                    declarations.append({'name': m[1], 'line': number, 'kind': 'function candidate'})
            imports = [{'target': m[1], 'line': text[:m.start()].count('\n')+1}
                       for m in re.finditer(r'''(?:import\s+(?:(?:[^;\n]+?)\s+from\s+)?|export\s+(?:\{[^}]*\}|\*)\s+from\s+)["']([^"'\n]+)["']''', text)]
            files.append({'path': str(rel), 'lines': len(text.splitlines()), 'sha256': hashlib.sha256(path.read_bytes()).hexdigest(),
                          'declarations': declarations, 'imports': imports})
    return files

def governance_inventory():
    path = ROOT / '.agents/governance/governance.db'
    result = {'path': str(path.relative_to(ROOT)), 'sha256': hashlib.sha256(path.read_bytes()).hexdigest()}
    with sqlite3.connect(path.as_uri() + '?mode=ro', uri=True) as db:
        db.row_factory = sqlite3.Row
        for table, columns in {
            'apps': 'id,app_code,app_name,active',
            'logical_apps': 'id,app_code,app_name,deployment_type',
            'screen_functions': 'id,screen_id,function_code,function_name,function_type,api_id,implementation_status',
            'api_endpoints': 'id,app_id,route_path,http_method,implementation_status',
            'route_registry': 'id,app_id,screen_id,route_path,active',
        }.items():
            result[table] = [dict(row) for row in db.execute(f'SELECT {columns} FROM {table} ORDER BY id')]
    return result

def generate():
    OUT.mkdir(parents=True, exist_ok=True)
    tracked = set(subprocess.check_output(['git','ls-files'],cwd=ROOT,text=True).splitlines())
    if subprocess.run(['git','diff','--quiet','HEAD','--','apps','services','packages','websites','cloudflare','.agents/governance/governance.db'],cwd=ROOT).returncode:
        raise SystemExit('Commit runtime/source or governance edits before generating revision-backed evidence.')
    projects, names = project_inventory()
    maps = []
    for p in projects:
        slug = re.sub('[^a-zA-Z0-9-]', '-', p['root'] + ('-' + p['name'] if p['group']=='websites' else ''))
        kind = 'cloud' if p['runtime']=='Cloudflare Worker' else ('frontend' if p['group'] in {'apps','websites'} else 'backend')
        nodes = [node('project', p['name'], kind, p['manifest'], [40, 170], p['runtime'],
                      end=min(60,len((ROOT/p['manifest']).read_text().splitlines())))]
        if p['group']=='websites':
            nodes[0]['sources'].append(source('scripts/build-typescript-websites.mjs',10,15))
        edges = []
        for i, dep in enumerate(p['local_dependencies']):
            target = names[dep]
            nodes.append(node('dep'+str(i), dep, 'backend', target['manifest'], [500, 60+i*220], 'Shared package'))
            edges.append(edge('project', 'dep'+str(i), 'build entry' if p['group']=='websites' else 'dependency'))
        maps.append(diagram(slug, p['name'] + ' dependencies', nodes, edges,
                    ['Manifest dependency or registered build-entry relationship; not runtime call coverage.',
                     'Source links are pinned to the recorded repository revision.']))
        p['diagram'] = maps[-1]['href']
    api = 'packages/flutter_core/lib/src/network/api_client.dart'
    worker = 'cloudflare/workers/src/gateway.ts'
    service = 'cloudflare/workers/src/service.ts'
    auth = 'cloudflare/workers/src/auth.ts'
    maps.insert(0, diagram('worker-request', 'Cloudflare request path', [
        node('client', 'Shared API client', 'frontend', api, [40, 60], 'Native default URL', 606, 610),
        node('gateway', 'Worker gateway', 'cloud', worker, [500, 60], 'Prefix routing', 65, 70),
        node('handler', 'Service worker', 'backend', service, [500, 310], 'SERVICE_NAME dispatch', 63, 88),
        node('database', 'PostgreSQL client', 'database', auth, [40, 310], 'DB_URL connection', 41, 48),
    ], [edge('client','gateway','native default'), edge('gateway','handler','service binding'), edge('handler','database','withDb')],
    ['Web defaults to same-origin; native defaults to the Worker gateway. API_BASE_URL can override both.',
     'The configured proxy path is source evidence, not proof of a live deployment.',
     'Unsupported domain routes can return 404; bindings do not imply complete API coverage.']))
    dart = 'services/api_gateway/lib/src/gateway_core.dart'
    db = 'packages/database_client/lib/database_client.dart'
    maps.insert(1, diagram('dart-gateway', 'Dart gateway service mesh', [
        node('entry','Shelf gateway','backend','services/api_gateway/bin/server.dart',[40,60],'Router + middleware',10,27),
        node('mesh','ServiceMesh','backend',dart,[500,60],'Environment URLs',39,53),
        node('proxy','HTTP upstream','backend',dart,[500,310],'Streaming + timeout',60,98),
        node('health','Gateway DB health','database',dart,[40,310],'SELECT 1',17,25),
    ], [edge('entry','mesh','registerRoutes'),edge('mesh','proxy','HTTP proxy'),edge('entry','health','healthCheck')],
    ['This is the Dart runtime path, separate from TypeScript Worker service bindings.',
     'Proxy timeout produces 504; transport failure produces 502.',
     'Mock UI handlers are registered only when ENABLE_MOCK_UI is true.']))
    inventory = {'revision': REV, 'repository': REMOTE, 'projects': projects, 'files': code_inventory(),
                 'governance': governance_inventory(), 'diagrams': maps,
                 'limits': 'Declaration extraction is heuristic. Manifest dependencies are not runtime calls. Governance statuses are recorded claims, not verified test results.'}
    (OUT/'inventory.json').write_text(json.dumps(inventory, indent=2)+'\n')
    template = (ROOT/'tools/architecture/index.template.html').read_text()
    payload = json.dumps(inventory, separators=(',', ':')).replace('<','\\u003c').replace('>','\\u003e').replace('&','\\u0026')
    (OUT/'index.html').write_text(template.replace('__INVENTORY__', payload))
    print(json.dumps({'projects':len(projects),'files':len(inventory['files']), 'diagrams':len(maps), 'revision':REV}))

if __name__ == '__main__': generate()
