#!/usr/bin/env python3
"""Verify that inheritance preserves all original route handler bytes."""
import hashlib,json,subprocess
from refactor_api_features import verify_service
from pathlib import Path
root=Path(__file__).resolve().parents[1]
manifest=json.loads((root/'docs/refactoring/api-route-migration.json').read_text())
actual={str(p.relative_to(root)) for p in root.glob('services/*/lib/routes.dart')}
assert actual=={r['path'] for r in manifest['files']}, 'Route class coverage changed'
for r in manifest['files']:
    path=r['path']
    old=subprocess.check_output(['git','show',manifest['sourceCommit']+':'+path],cwd=root,text=True)
    assert hashlib.sha256(old.encode()).hexdigest()==r['beforeSha256'],path
    expected=old.replace("import 'dart:convert';", "import 'dart:convert';\nimport 'package:server_core/server_core.dart';")
    expected=expected.replace('class ApiRoutes {','class ApiRoutes extends BaseApiRoutes {')
    expected=expected.replace('  Router get router {\n    final router = Router();','  @override\n  void registerRoutes(Router router) {').replace('    return router;\n','')
    verify_service(path, expected)
    assert 'server_core:' in (root/Path(path).parents[1]/'pubspec.yaml').read_text(),path
print(json.dumps({'routeClasses':len(actual),'originalHandlersPreserved':True,'newRoutes':0}))
