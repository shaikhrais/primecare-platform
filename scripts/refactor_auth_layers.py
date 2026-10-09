#!/usr/bin/env python3
"""Extract the existing auth handlers and SQL without changing their behavior."""
import argparse
import json
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SOURCE = 'e0709f8b832ad21b574295e1b5975674a0694057'
HOST = 'services/auth_api/lib/src/application/auth_api_host.dart'
CONTROLLER = 'services/auth_api/lib/src/controllers/auth_http_controller.dart'
REPOSITORY = 'services/auth_api/lib/src/repositories/auth_repository.dart'
ROUTES = 'services/auth_api/lib/src/routes/auth_session_routes.dart'
MANIFEST = ROOT / 'docs/refactoring/auth-layer-migration.json'


def original():
    return subprocess.check_output(['git', 'show', SOURCE + ':' + HOST], cwd=ROOT, text=True)


def render(source):
    helper_start = source.index('String? _bearerToken')
    class_start = source.index('class AuthApiHost')
    helpers = source[helper_start:class_start]
    start = source.index("    router.post('/login'")
    end = source.index("    router.mount('/', ApiRoutes().router.call);")
    handlers = source[start:end]
    queries = [
        ("final users = await db.query(\n        'SELECT id, roles, password_hash, status FROM users WHERE LOWER(email) = @email LIMIT 1',\n        substitutionValues: {'email': email},\n      );", 'final users = await repository.findUser(email);', "Future<DatabaseResult> findUser(String email) => database.query(\n    'SELECT id, roles, password_hash, status FROM users WHERE LOWER(email) = @email LIMIT 1',\n    substitutionValues: {'email': email},\n  );"),
        ("await db.query(\n        'INSERT INTO auth_sessions (token_hash, user_id, expires_at) '\n        \"VALUES (@hash, @id, NOW() + INTERVAL '12 hours')\",\n        substitutionValues: {'hash': _hashToken(token), 'id': user[0]},\n      );", 'await repository.createSession(_hashToken(token), user[0]);', "Future<DatabaseResult> createSession(String hash, dynamic id) => database.query(\n    'INSERT INTO auth_sessions (token_hash, user_id, expires_at) '\n    \"VALUES (@hash, @id, NOW() + INTERVAL '12 hours')\",\n    substitutionValues: {'hash': hash, 'id': id},\n  );"),
        ("final users = await db.query(\n        'SELECT u.id, u.roles FROM auth_sessions s '\n        'JOIN users u ON u.id = s.user_id '\n        'WHERE s.token_hash = @hash AND s.expires_at > NOW() '\n        \"AND LOWER(u.status) = 'active' LIMIT 1\",\n        substitutionValues: {'hash': _hashToken(token)},\n      );", 'final users = await repository.findSession(_hashToken(token));', "Future<DatabaseResult> findSession(String hash) => database.query(\n    'SELECT u.id, u.roles FROM auth_sessions s '\n    'JOIN users u ON u.id = s.user_id '\n    'WHERE s.token_hash = @hash AND s.expires_at > NOW() '\n    \"AND LOWER(u.status) = 'active' LIMIT 1\",\n    substitutionValues: {'hash': hash},\n  );"),
        ("await db.query(\n          'DELETE FROM auth_sessions WHERE token_hash = @hash',\n          substitutionValues: {'hash': _hashToken(token)},\n        );", 'await repository.deleteSession(_hashToken(token));', "Future<DatabaseResult> deleteSession(String hash) => database.query(\n    'DELETE FROM auth_sessions WHERE token_hash = @hash',\n    substitutionValues: {'hash': hash},\n  );"),
    ]
    methods = []
    for before, after, method in queries:
        assert handlers.count(before) == 1, before
        handlers = handlers.replace(before, after)
        methods.append('  ' + method.replace('\n', '\n  '))
    controller = "import 'dart:convert';\nimport 'dart:math';\nimport 'package:bcrypt/bcrypt.dart';\nimport 'package:crypto/crypto.dart';\nimport 'package:server_core/server_core.dart';\nimport 'package:shelf/shelf.dart';\nimport 'package:shelf_router/shelf_router.dart';\nimport '../repositories/auth_repository.dart';\n\n" + helpers + "class AuthHttpController extends BaseController {\n  final AuthRepository repository;\n  AuthHttpController(this.repository);\n\n  void registerRoutes(Router router) {\n" + handlers + "  }\n}\n"
    repository = "import 'package:database_client/database_client.dart';\n\n/// Existing auth queries; session policy remains in the HTTP controller.\nclass AuthRepository extends BasePlatformRepository {\n  AuthRepository(super.database);\n\n" + '\n\n'.join(methods) + '\n}\n'
    host = "import 'dart:io';\nimport 'package:server_core/server_core.dart';\nimport 'package:shelf/shelf.dart';\nimport 'package:shelf_router/shelf_router.dart';\nimport 'package:database_client/database_client.dart';\nimport 'package:auth_api/routes.dart';\nimport '../controllers/auth_http_controller.dart';\nimport '../repositories/auth_repository.dart';\n\n" + source[class_start:start] + '    AuthHttpController(AuthRepository(db)).registerRoutes(router);\n\n' + source[end:]
    routes = "import 'package:server_core/server_core.dart';\nimport 'package:shelf_router/shelf_router.dart';\nimport 'package:auth_api/routes.dart';\nimport '../controllers/auth_http_controller.dart';\n\nclass AuthSessionRoutes extends BaseApiRoutes {\n  final AuthHttpController controller;\n  AuthSessionRoutes(this.controller);\n\n  @override\n  void registerRoutes(Router router) {\n    controller.registerRoutes(router);\n    router.mount('/', ApiRoutes().router.call);\n  }\n}\n"
    host = host.replace("import 'package:shelf_router/shelf_router.dart';\n", '').replace("import 'package:auth_api/routes.dart';\n", "import '../routes/auth_session_routes.dart';\n")
    host = host.replace("    final router = Router();\n\n    AuthHttpController(AuthRepository(db)).registerRoutes(router);\n\n    router.mount('/', ApiRoutes().router.call);\n\n    return router.call;", "    return AuthSessionRoutes(AuthHttpController(AuthRepository(db))).router.call;")
    return {HOST: host, CONTROLLER: controller, REPOSITORY: repository, ROUTES: routes}


def verify_auth():
    for path, content in render(original()).items():
        assert (ROOT / path).read_text() == content, 'Auth extraction changed: ' + path


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    manifest = {'sourceCommit': SOURCE, 'host': HOST, 'controller': CONTROLLER, 'repository': REPOSITORY, 'routes': ROUTES, 'existingRoutes': 4, 'existingQueries': 4, 'completedWorkflows': 0}
    if args.check:
        verify_auth()
        assert json.loads(MANIFEST.read_text()) == manifest
        print(json.dumps(manifest))
    else:
        assert not MANIFEST.exists(), 'Already migrated; use --check'
        assert (ROOT / HOST).read_text() == original()
        for path, content in render(original()).items():
            (ROOT / path).parent.mkdir(parents=True, exist_ok=True)
            (ROOT / path).write_text(content)
        MANIFEST.write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__':
    main()
