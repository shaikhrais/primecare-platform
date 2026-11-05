#!/usr/bin/env python3
"""Report changes to native governance routes lacking workspace mappings.

Mapping is not authorization: permissions and active server behavior still
need verification. This check only compares literal paths in two source files.
"""
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ROUTER = 'apps/primecare_governance/lib/core/governance/route_registry.dart'
REGISTRY = 'cloudflare/workers/src/workspace-registry.json'
EXCEPTIONS = 'docs/screen-management/governance-workspace-exceptions.json'


def check(root=ROOT):
    source = (root / ROUTER).read_text(encoding='utf-8')
    block = source.split('const governanceNativeScreenRoutes = <String>{', 1)[1].split('};', 1)[0]
    routes = re.findall(r"'([^']+)'", block)
    if len(routes) != len(set(routes)):
        raise ValueError(f'{ROUTER}: duplicate native route')
    registry = json.loads((root / REGISTRY).read_text(encoding='utf-8'))
    mapped = {screen['route'] for screen in registry['screens']}
    exceptions = json.loads((root / EXCEPTIONS).read_text(encoding='utf-8'))
    known = set()
    for entry in exceptions:
        if set(entry) != {'route', 'reason', 'next'} or not all(isinstance(v, str) and v for v in entry.values()):
            raise ValueError(f'{EXCEPTIONS}: invalid exception')
        if entry['route'] in known:
            raise ValueError(f'{EXCEPTIONS}: duplicate exception {entry["route"]}')
        known.add(entry['route'])
    missing = set(routes) - mapped
    problems = [f'{ROUTER}: {route}: missing workspace grant mapping' for route in sorted(missing - known)]
    problems += [f'{EXCEPTIONS}: {route}: exception no longer matches an unmapped native route' for route in sorted(known - missing)]
    return len(routes), len(missing), problems


if __name__ == '__main__':
    total, missing, problems = check()
    for problem in problems:
        print(problem)
    print(f'{total} native governance paths; {missing} documented without exact workspace mapping; {len(problems)} changes need review')
    raise SystemExit(bool(problems))
