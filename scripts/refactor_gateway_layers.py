#!/usr/bin/env python3
"""Extract gateway classes from the merged source without changing proxy policy."""
import argparse
import json
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SOURCE = '04213b2d17199af8284062ef38edcd2b8c1df4fa'
PREFIX = 'services/api_gateway/lib/src/'
HOST = PREFIX + 'application/api_gateway_host.dart'
CORE = PREFIX + 'gateway_core.dart'
MANIFEST = ROOT / 'docs/refactoring/gateway-layer-migration.json'


def original(path):
    return subprocess.check_output(['git', 'show', SOURCE + ':' + path], cwd=ROOT, text=True)


def render():
    core = original(CORE)
    start = core.index('/// [GatewayController]')
    mesh_start = core.index('/// [ServiceMesh]')
    controller = core[start:mesh_start]
    controller = controller.replace('class GatewayController {', 'class GatewayController extends BaseController {')
    controller = controller.replace('final PlatformDatabase _db;', 'final GatewayRepository _repository;')
    controller = controller.replace('GatewayController(this._db);', 'GatewayController(PlatformDatabase database)\n      : _repository = GatewayRepository(database);')
    controller = controller.replace("await _db.query('SELECT 1');", 'await _repository.checkHealth();')
    controller_imports = "import 'package:server_core/server_core.dart';\nimport 'package:shelf/shelf.dart' as shelf;\nimport 'package:database_client/database_client.dart';\nimport '../repositories/gateway_repository.dart';\nimport '../mock_ui_service.dart';\n\n"
    mesh = core[mesh_start:].replace('class ServiceMesh {', 'class ServiceMesh extends BaseApiRoutes {').replace('  void registerRoutes(Router router) {', '  @override\n  void registerRoutes(Router router) {')
    mesh_imports = "import 'dart:io';\nimport 'dart:async';\nimport 'package:server_core/server_core.dart';\nimport 'package:shelf/shelf.dart' as shelf;\nimport 'package:shelf_router/shelf_router.dart';\nimport 'package:http/http.dart' as http;\n\n"
    host = original(HOST)
    router_start = host.index('    final router = Router();')
    return_start = host.index('    return router.call;', router_start)
    body = host[router_start + len('    final router = Router();\n'):return_start]
    routes = "import 'dart:io';\nimport 'package:server_core/server_core.dart';\nimport 'package:shelf_router/shelf_router.dart';\nimport '../controllers/gateway_controller.dart';\nimport '../infrastructure/service_mesh.dart';\n\nclass GatewayApiRoutes extends BaseApiRoutes {\n  final ServiceMesh mesh;\n  final GatewayController controller;\n  GatewayApiRoutes(this.mesh, this.controller);\n\n  @override\n  void registerRoutes(Router router) {\n" + body + '  }\n}\n'
    host = host[:router_start] + '    return GatewayApiRoutes(mesh, controller).router.call;\n' + host[return_start + len('    return router.call;\n'):]
    host = host.replace("import 'package:shelf_router/shelf_router.dart';\n", '').replace("import '../gateway_core.dart';", "import '../gateway_core.dart';\nimport '../routes/gateway_api_routes.dart';")
    repository = "import 'package:database_client/database_client.dart';\n\nclass GatewayRepository extends BasePlatformRepository {\n  GatewayRepository(super.database);\n\n  Future<DatabaseResult> checkHealth() => database.query('SELECT 1');\n}\n"
    return {
        CORE: "// Public compatibility exports for existing gateway callers.\nexport 'controllers/gateway_controller.dart';\nexport 'infrastructure/service_mesh.dart';\n",
        HOST: host,
        PREFIX + 'controllers/gateway_controller.dart': controller_imports + controller.rstrip() + '\n',
        PREFIX + 'infrastructure/service_mesh.dart': mesh_imports + mesh.replace('\n      \n', '\n\n'),
        PREFIX + 'repositories/gateway_repository.dart': repository,
        PREFIX + 'routes/gateway_api_routes.dart': routes,
    }


def verify_gateway():
    mock = PREFIX + 'mock_ui_service.dart'
    assert (ROOT / mock).read_text() == original(mock), 'Mock implementation changed'
    for path, content in render().items():
        assert (ROOT / path).read_text() == content, 'Gateway extraction changed: ' + path


def main():
    parser = argparse.ArgumentParser(); parser.add_argument('--check', action='store_true'); args = parser.parse_args()
    manifest = {'sourceCommit': SOURCE, 'files': list(render()), 'existingQueries': 1, 'completedWorkflows': 0}
    if args.check:
        verify_gateway(); assert json.loads(MANIFEST.read_text()) == manifest
        print(json.dumps(manifest))
    else:
        assert not MANIFEST.exists()
        for path in [HOST, CORE]: assert (ROOT / path).read_text() == original(path)
        for path, content in render().items():
            target = ROOT / path; target.parent.mkdir(parents=True, exist_ok=True); target.write_text(content)
        MANIFEST.write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__': main()
