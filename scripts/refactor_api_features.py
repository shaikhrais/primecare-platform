#!/usr/bin/env python3
"""Split reviewed existing route libraries; never generate new operations."""
import hashlib
import json
import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MANIFEST = ROOT / 'docs/refactoring/api-feature-migration.json'


def render(path, source):
    """Return deterministic files and route counts from the exact source."""
    library, implementation = source.split('class ApiRoutes extends BaseApiRoutes {', 1)
    method = '  @override\n  void registerRoutes(Router router) {'
    members, rest = implementation.split(method, 1)
    assert rest.endswith('\n  }\n}\n'), path
    body = rest[:-len('\n  }\n}\n')]
    parts = []
    root = Path(path).parent
    if 'static const screenPaths' in members:
        # Keep the public static route list and unsupported response unchanged.
        name = 'SchedulingScreenRoutes'
        part = 'scheduling_screen_routes'
        content = ("part of '../../../routes.dart';\n\n"
                   f'class {name} extends BaseApiRoutes {{'
                   + members + method + body + '\n  }\n}\n')
        parts.append((part, name, content, 26))
        retained = f'\n  static const screenPaths = {name}.screenPaths;\n'
        constructors = [f'{name}()']
    else:
        assert members == '\n  final prisma = PrismaClient();\n\n', path
        starts = list(re.finditer(r"    router\.(\w+)\('([^']+)'", body))
        assert starts and not body[:starts[0].start()].strip(), path
        groups = []
        for index, match in enumerate(starts):
            end = starts[index + 1].start() if index + 1 < len(starts) else len(body)
            segment = body[match.start():end]
            assert segment.rstrip().endswith('});'), path
            endpoint = match.group(2)
            key = endpoint.removeprefix('/api/').removesuffix('/action')
            assert re.fullmatch(r'[a-z0-9.-]+', key), endpoint
            if groups and groups[-1][0] == key:
                groups[-1][1].append(segment)
            else:
                assert key not in [g[0] for g in groups], 'Non-contiguous feature '+key
                groups.append((key, [segment]))
        for key, segments in groups:
            part = re.sub(r'[-.]', '_', key) + '_routes'
            name = ''.join(word.title() for word in re.split(r'[-.]', key)) + 'Routes'
            assert part not in [p[0] for p in parts], 'Feature name collision: '+key
            content = ("part of '../../../routes.dart';\n\n"
                       f'class {name} extends BaseApiRoutes {{\n'
                       f'  final PrismaClient prisma;\n  {name}(this.prisma);\n\n'
                       + method + body[:starts[0].start()]
                       + ''.join(segments) + '\n  }\n}\n')
            parts.append((part, name, content, len(segments)))
        retained = members
        constructors = [f'{name}(prisma)' for _, name, _, _ in parts]
    directives = ''.join(f"part 'src/features/{part}/{part}.dart';\n" for part, _, _, _ in parts)
    root_source = (library + directives + '\nclass ApiRoutes extends BaseModularApiRoutes {'
                   + retained + '\n  @override\n  Iterable<BaseApiRoutes> get modules => [\n'
                   + ''.join(f'    {constructor},\n' for constructor in constructors)
                   + '  ];\n}\n')
    outputs = {path: root_source}
    for part, _, content, _ in parts:
        outputs[str(root / 'src/features' / part / (part + '.dart'))] = content
    return outputs, sum(part[3] for part in parts), len(parts)


def verify_service(path, source):
    outputs, routes, features = render(path, source)
    for target, expected in outputs.items():
        assert (ROOT / target).read_text() == expected, 'Feature source changed: '+target
    actual = {str(p.relative_to(ROOT)) for p in (ROOT / Path(path).parent / 'src/features').rglob('*_routes.dart')}
    assert actual == set(outputs) - {path}, 'Feature file coverage changed: '+path
    return routes, features


def main():
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    if args.check:
        manifest = json.loads(MANIFEST.read_text())
        routes = features = 0
        for record in manifest['services']:
            source = subprocess.check_output(['git', 'show', manifest['sourceCommit']+':'+record['path']], cwd=ROOT, text=True)
            assert hashlib.sha256(source.encode()).hexdigest() == record['beforeSha256']
            count, modules = verify_service(record['path'], source)
            assert count == record['routes'] and modules == record['features']
            routes += count
            features += modules
        assert {str(p.relative_to(ROOT)) for p in ROOT.glob('services/*/lib/routes.dart')} == {r['path'] for r in manifest['services']}
        print(json.dumps({'services': len(manifest['services']), 'features': features, 'preservedRoutes': routes, 'completedWorkflows': 0}))
        return
    assert not MANIFEST.exists(), 'Already migrated; use --check'
    revision = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    records = []
    pending = {}
    for route_file in sorted(ROOT.glob('services/*/lib/routes.dart')):
        path = str(route_file.relative_to(ROOT))
        source = route_file.read_text()
        original = subprocess.check_output(['git', 'show', revision+':'+path], cwd=ROOT, text=True)
        assert source == original, 'Uncommitted source changes: '+path
        outputs, routes, features = render(path, source)
        for target in outputs:
            assert target == path or not (ROOT / target).exists(), 'Refusing overwrite: '+target
        pending.update(outputs)
        records.append({'path': path, 'beforeSha256': hashlib.sha256(source.encode()).hexdigest(), 'routes': routes, 'features': features})
    # Validate all services before writing any file.
    for target, content in pending.items():
        (ROOT / target).parent.mkdir(parents=True, exist_ok=True)
        (ROOT / target).write_text(content)
    MANIFEST.write_text(json.dumps({'sourceCommit': revision, 'completedWorkflows': 0, 'services': records}, indent=2)+'\n')
    print(json.dumps({'files':len(pending),'services':len(records),'features':sum(r['features'] for r in records),'preservedRoutes':sum(r['routes'] for r in records)}))


if __name__ == '__main__':
    main()
