#!/usr/bin/env python3
"""Extract existing governance SQL without adding operations or permissions."""
import hashlib
import json
import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SOURCE = 'b41d21be2ac6de9ae8b32e4adadf24c66081c440'
PREFIX = 'services/governance_api/lib/src/'


def original(path):
    return subprocess.check_output(['git','show',SOURCE+':'+path],cwd=ROOT,text=True)


def render():
    controller_path = PREFIX+'controllers/governance_controller.dart'
    source = original(controller_path)
    functions = list(re.finditer(r'  static Future<Response> (\w+)\(Request request\) async \{',source))
    assert len(functions) == 20
    concrete = ["import 'dart:convert';\nimport 'package:shelf/shelf.dart';\nimport 'package:server_core/server_core.dart';\nimport '../repositories/governance_repository.dart';\n\n",
                '/// HTTP adaptation only; reviewed SQL remains in the repository.\n',
                'class GovernanceHttpController extends BaseController {\n',
                '  final GovernanceRepository repository;\n  GovernanceHttpController(this.repository);\n\n']
    facade = ["import 'package:shelf/shelf.dart';\nimport '../database/database_controller.dart';\nimport '../repositories/governance_repository.dart';\nimport 'governance_http_controller.dart';\n\n",
              '/// Compatibility facade preserves existing static handler tear-offs.\n',
              'class GovernanceController {\n  static final db = DatabaseController.connection;\n',
              '  static final _controller = GovernanceHttpController(GovernanceRepository(db));\n',
              '  static GovernanceHttpController get instance => _controller;\n\n']
    repository = original(PREFIX+'repositories/governance_repository.dart').replace("import '../core/base_repository.dart';", "import 'package:postgres/postgres.dart';\nimport '../core/base_repository.dart';")
    additions = []
    for i, match in enumerate(functions):
        name = match.group(1)
        end = functions[i+1].start() if i+1<len(functions) else source.rindex('\n}')
        segment = source[match.end():end]
        facade.append(f'  static Future<Response> {name}(Request request) => _controller.{name}(request);\n')
        if name.startswith('get'):
            sql = re.search(r"await db.execute\('([^']+)'\)", segment)[1]
            concrete.append(f'  Future<Response> {name}(Request request) async => success(await repository.{name}());\n\n')
            if f' {name}()' not in repository:
                additions.append(f"  Future<List<Map<String, dynamic>>> {name}() async {{\n    final result = await connection.execute('{sql}');\n    return mapResult(result);\n  }}\n\n")
        else:
            start = segment.index('    await db.execute(')
            finish = segment.index('\n    return Response.ok',start)
            statement = segment[start:finish].replace('await db.execute(', 'await connection.execute(',1)
            additions.append(f'  Future<void> {name}(dynamic data) async {{\n'+statement+'\n  }\n\n')
            concrete.append(f'  Future<Response> {name}(Request request) async {{\n'
                '    final payload = await request.readAsString();\n    final data = jsonDecode(payload);\n'
                f'    await repository.{name}(data);\n'
                '    return _created();\n  }\n\n')
    concrete.append('  Response _created() => Response.ok(\'{"status": "ok"}\', headers: {\'Content-Type\': \'application/json\'});\n}\n')
    facade.append('}\n')
    controller_base = original(PREFIX+'core/base_controller.dart')
    repository_base = original(PREFIX+'core/base_repository.dart')
    route_source = original(PREFIX+'routes/governance_routes.dart')
    instance_routes = route_source.replace("import '../controllers/governance_controller.dart';", "import '../controllers/governance_http_controller.dart';\nimport 'package:server_core/server_core.dart';")
    instance_routes = instance_routes.replace('class GovernanceRoutes {', 'class GovernanceApiRoutes extends BaseApiRoutes {\n  final GovernanceHttpController Function() _controller;\n  GovernanceApiRoutes(this._controller);')
    instance_routes = instance_routes.replace('  static Router get router {\n    final router = Router();', '  @override\n  void registerRoutes(Router router) {').replace('    return router;\n', '')
    instance_routes = re.sub(r'GovernanceController\.(\w+)',r'(Request request) => _controller().\1(request)',instance_routes)
    outputs = {
        controller_path: ''.join(facade),
        PREFIX+'controllers/governance_http_controller.dart': ''.join(concrete),
        PREFIX+'repositories/governance_repository.dart': repository[:-2]+'\n'+''.join(additions)+'}\n',
        'packages/server_core/lib/src/base_controller.dart': controller_base,
        'packages/database_client/lib/src/base_repository.dart': repository_base,
        PREFIX+'core/base_controller.dart': "export 'package:server_core/src/base_controller.dart';\n",
        PREFIX+'core/base_repository.dart': "export 'package:database_client/src/base_repository.dart';\n",
        PREFIX+'routes/governance_api_routes.dart': instance_routes,
        PREFIX+'routes/governance_routes.dart': "import 'package:shelf_router/shelf_router.dart';\nimport '../controllers/governance_controller.dart';\nimport 'governance_api_routes.dart';\n\n/// Compatibility entrypoint; controller creation stays lazy until a request.\nclass GovernanceRoutes {\n  static Router get router => GovernanceApiRoutes(() => GovernanceController.instance).router;\n}\n",
    }
    return outputs


def main():
    import argparse
    parser=argparse.ArgumentParser();parser.add_argument('--check',action='store_true');args=parser.parse_args()
    outputs=render()
    manifest=ROOT/'docs/refactoring/governance-layer-migration.json'
    if args.check:
        for path,expected in outputs.items():
            assert (ROOT/path).read_text()==expected, 'Governance extraction changed: '+path
        record=json.loads(manifest.read_text())
        assert record['sourceCommit']==SOURCE and record['existingHandlers']==20 and record['completedWorkflows']==0
        for path,digest in record['originalHashes'].items():
            assert hashlib.sha256(original(path).encode()).hexdigest()==digest,path
        print(json.dumps({'existingHandlers':20,'sharedParents':2,'controllerSQLStatements':0,'completedWorkflows':0}))
        return
    assert not manifest.exists(), 'Already migrated; use --check'
    hashes={}
    for path in outputs:
        if path.startswith(PREFIX) and 'governance_http_controller' not in path and 'governance_api_routes' not in path:
            assert (ROOT/path).read_text()==original(path), 'Refusing changed source: '+path
            hashes[path]=hashlib.sha256(original(path).encode()).hexdigest()
        elif (ROOT/path).exists():
            raise AssertionError('Refusing overwrite: '+path)
    for path,content in outputs.items():
        (ROOT/path).parent.mkdir(parents=True,exist_ok=True);(ROOT/path).write_text(content)
    manifest.write_text(json.dumps({'sourceCommit':SOURCE,'existingHandlers':20,'completedWorkflows':0,'originalHashes':hashes},indent=2)+'\n')


if __name__=='__main__':
    main()
