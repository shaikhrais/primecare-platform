#!/usr/bin/env python3
"""Execute each moved binding against its pinned original using Shelf Requests."""
import argparse
import json
import re
import subprocess
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--dart', default='dart')
    parser.add_argument('--offline', action='store_true')
    args = parser.parse_args()
    manifest = json.loads((ROOT/'docs/refactoring/api-feature-migration.json').read_text())
    # Resolve only dependencies imported by these libraries, not unrelated host
    # build tools. The production service entrypoints are checked separately.
    with tempfile.TemporaryDirectory(prefix='primecare-route-parity-') as directory:
        harness = Path(directory)
        (harness/'pubspec.yaml').write_text(
            'name: route_parity_harness\nenvironment:\n  sdk: ^3.11.3\n'
            'dependencies:\n  shelf: ^1.4.2\n  shelf_router: ^1.1.4\n'
            f'  server_core:\n    path: {ROOT / "packages/server_core"}\n'
            f'  database_client:\n    path: {ROOT / "packages/database_client"}\n')
        subprocess.run([args.dart,'pub','get']+(['--offline'] if args.offline else []),cwd=harness,check=True,stdout=subprocess.DEVNULL)
        run_checks(args, manifest, harness/'.dart_tool/package_config.json')


def run_checks(args, manifest, package_config):
    total = 0
    for record in manifest['services']:
        path = record['path']
        service = ROOT/Path(path).parents[1]
        source = subprocess.check_output(['git','show',manifest['sourceCommit']+':'+path], cwd=ROOT, text=True)
        bindings = [(m.upper(), p) for m,p in re.findall(r"router\.(get|post|put|patch|delete)\('([^']+)'", source)]
        if 'static const screenPaths' in source:
            paths = re.findall(r"'(/api/[^']+)'", source.split('];',1)[0])
            bindings = [(method, p + ('/action' if method == 'POST' else '')) for p in paths for method in ['GET','POST']]
        assert len(bindings) == record['routes'], path
        baseline = service/'lib/api_feature_migration_baseline.dart'
        runner = service/'test/api_feature_migration_runner.dart'
        assert not baseline.exists() and not runner.exists(), 'Temporary parity files already exist'
        try:
            baseline.write_text(source)
            runner.parent.mkdir(parents=True, exist_ok=True)
            runner.write_text("""import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../lib/routes.dart' as migrated;
import '../lib/api_feature_migration_baseline.dart' as baseline;

Future<void> main() async {
  final bindings = jsonDecode(r'''BINDINGS''') as List;
  final oldRouter = baseline.ApiRoutes().router;
  final newRouter = migrated.ApiRoutes().router;
  for (final binding in [...bindings, ['DELETE', '/api/migration-unknown']]) {
    final method = binding[0] as String;
    final uri = Uri.parse('https://api.example${binding[1]}');
    Future<List<Object>> result(Handler handler) async {
      final response = await handler(Request(method, uri, body: '{}'));
      final headers = response.headers.entries.toList()..sort((a,b) => a.key.compareTo(b.key));
      return [response.statusCode, Map.fromEntries(headers), await response.readAsString()];
    }
    final before = await result(oldRouter);
    final after = await result(newRouter);
    if (jsonEncode(before) != jsonEncode(after)) {
      throw StateError('Response changed for $method $uri: $before vs $after');
    }
  }
  print('Preserved ${bindings.length} bindings and unknown route behavior');
}
""".replace('BINDINGS',json.dumps(bindings)))
            subprocess.run([args.dart,'--packages='+str(package_config),str(runner)],cwd=service,check=True)
            total += len(bindings)
        finally:
            baseline.unlink(missing_ok=True)
            runner.unlink(missing_ok=True)
    print(json.dumps({'services':len(manifest['services']),'runtimeParityBindings':total,'completedWorkflows':0}))


if __name__ == '__main__':
    main()
