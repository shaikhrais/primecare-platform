"""Reproducible source inventory; no network, business grants or deployment actions.

Requires PyYAML (also used by the existing reconstruction tooling).
"""
import argparse
import json
import os
import re
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parents[2]
OUTPUT = Path('packages/primecare_package_base/catalog.json')


def build(root=ROOT):
    entries, locations, names, manifests = [], {}, {}, {}
    for group in ('packages', 'services'):
        for directory in sorted((root / group).iterdir()):
            if not directory.is_dir() or directory.name.startswith('.'):
                continue
            if not any(directory.iterdir()):
                continue
            identity = directory.name
            if identity in locations:
                raise ValueError(f'Duplicate package id: {identity}')
            locations[identity] = directory.resolve()
            documents = {}
            for filename in ('pubspec.yaml', 'package.json'):
                source = directory / filename
                if source.exists():
                    documents[filename] = (yaml.safe_load(source.read_text())
                                           if filename.endswith('yaml') else json.loads(source.read_text()))
                    name = documents[filename]['name']
                    if name in names and names[name] != identity:
                        raise ValueError(f'Duplicate declared name: {name}')
                    names[name] = identity
            manifests[identity] = documents
            entries.append({
                'id': identity,
                'path': directory.relative_to(root).as_posix(),
                'kind': ('service' if group == 'services' else
                         'ui' if identity.startswith('primecare_ui') or identity == 'primecare_runtime' else
                         'library' if documents else 'source'),
                'contractVersion': 1,
                'manifests': sorted(documents),
                'declaredNames': sorted({doc['name'] for doc in documents.values()}),
                'dependencies': [],
                'developmentDependencies': [],
                'hosting': 'explicit-adapter-required' if group == 'services' else 'library-only',
            })
    for entry in entries:
        for filename, document in manifests[entry['id']].items():
            for section, target in (('dependencies', 'dependencies'),
                                    ('dev_dependencies', 'developmentDependencies'),
                                    ('devDependencies', 'developmentDependencies'),
                                    ('peerDependencies', 'dependencies'),
                                    ('optionalDependencies', 'dependencies')):
                for name, spec in (document.get(section) or {}).items():
                    dependency = names.get(name)
                    if isinstance(spec, dict) and 'path' in spec:
                        path = (locations[entry['id']] / spec['path']).resolve()
                        matches = [key for key, value in locations.items() if value == path]
                        if not matches and dependency and path == locations[dependency] / 'targets/server':
                            profile = path / 'pubspec.yaml'
                            if not profile.exists() or yaml.safe_load(profile.read_text())['name'] != name:
                                raise ValueError(f"Invalid master build profile: {entry['id']} -> {name}")
                            entry.setdefault('dependencyProfiles', {})[dependency] = 'server'
                            matches = [dependency]
                        if len(matches) != 1 or dependency != matches[0]:
                            raise ValueError(f"Unresolved local dependency: {entry['id']} -> {name}")
                        dependency = matches[0]
                    if dependency:
                        entry[target].append(dependency)
                    elif name.startswith('@primecare/'):
                        raise ValueError(f"Unresolved workspace dependency: {entry['id']} -> {name}")
        entry['dependencies'] = sorted(set(entry['dependencies']))
        entry['developmentDependencies'] = sorted(set(entry['developmentDependencies']))
    apply_source_dependencies(root, entries, locations)
    validate(entries)
    return {'schemaVersion': 1, 'authority': 'source-composition-only', 'packages': entries}


def apply_source_dependencies(root, entries, locations):
    # A reviewed ledger supplements manifest dependencies for source-only web gateways.
    # This is build impact metadata, never a runtime service or permission declaration.
    ledger = root / 'tools/package_master/source_dependencies.json'
    rows = json.loads(ledger.read_text()) if ledger.exists() else []
    gateways = root / 'packages/primecare_master/gateways.json'
    if gateways.exists():
        for gateway in json.loads(gateways.read_text())['gateways']:
            rows.append({
                'consumer': 'primecare_master',
                'provider': Path(gateway['target']).parts[1],
                'source': gateway['gateway'], 'target': gateway['target'],
            })
    by_id = {entry['id']: entry for entry in entries}
    seen = set()
    for row in rows:
        consumer, provider = row['consumer'], row['provider']
        if consumer == provider or consumer not in locations or provider not in locations:
            raise ValueError('Invalid reviewed source dependency')
        source, target = root / row['source'], root / row['target']
        if not source.resolve().is_relative_to(locations[consumer]) or not target.resolve().is_relative_to(locations[provider]):
            raise ValueError('Source dependency owner mismatch')
        if not source.is_file() or not target.is_file():
            raise ValueError('Missing reviewed source dependency evidence')
        # Current reviewed edges are relative import/export literals. Match both
        # explicit extensions and the extensionless TypeScript spelling.
        relative = Path(os.path.relpath(target, source.parent)).as_posix()
        if not relative.startswith('.'):
            relative = './' + relative
        variants = {relative}
        if target.suffix in ('.ts', '.tsx'):
            variants.add(relative[:-len(target.suffix)])
        text = source.read_text()
        if not any(re.search(r'(?P<quote>[\'"])' + re.escape(spec) + r'(?P=quote)', text) for spec in variants):
            raise ValueError(f'Reviewed source dependency import missing: {row["source"]}')
        key = (consumer, provider, row['source'], row['target'])
        if key in seen:
            raise ValueError('Duplicate reviewed source dependency')
        seen.add(key)
        entry = by_id[consumer]
        entry.setdefault('sourceDependencies', []).append(provider)
    for entry in entries:
        if 'sourceDependencies' in entry:
            entry['sourceDependencies'] = sorted(set(entry['sourceDependencies']))
            entry['dependencies'] = sorted(set(entry['dependencies'] + entry['sourceDependencies']))


def validate(entries):
    by_id = {entry['id']: entry for entry in entries}
    done, active = set(), set()

    def visit(identity):
        if identity in active:
            raise ValueError(f'Package dependency cycle: {identity}')
        if identity in done:
            return
        if identity not in by_id:
            raise ValueError(f'Unknown package: {identity}')
        active.add(identity)
        for dependency in by_id[identity]['dependencies']:
            visit(dependency)
        active.remove(identity)
        done.add(identity)

    for identity in sorted(by_id):
        visit(identity)


def outputs(data):
    dart = ["// Generated by tools/package_master/catalog.py. Do not edit.",
            "import 'package_registry.dart';", '',
            'PackageCatalog createPrimeCarePackageCatalog() => PackageCatalog([']
    for entry in data['packages']:
        dart.extend([
            '  PackageDescriptor(',
            f"    id: '{entry['id']}', kind: PackageKind.{entry['kind']},",
            f"    contractVersion: {entry['contractVersion']},",
            '    dependencies: ' + json.dumps(entry['dependencies']) + ',',
            '  ),',
        ])
    dart.append(']);')
    return {
        OUTPUT: json.dumps(data, indent=2) + '\n',
        Path('packages/primecare_package_base/lib/src/package_catalog.g.dart'): '\n'.join(dart) + '\n',
        Path('packages/primecare_package_base/src/catalog.g.mjs'):
            '// Generated by tools/package_master/catalog.py. Do not edit.\n'
            "import {PackageCatalog} from './index.mjs';\n"
            'export function createPrimeCarePackageCatalog() {\n'
            '  return new PackageCatalog(' + json.dumps(data['packages'], indent=2) + ');\n}\n',
    }


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true', help='Fail if the inventory differs from source')
    args = parser.parse_args()
    data = build()
    for path, rendered in outputs(data).items():
        destination = ROOT / path
        if args.check:
            if not destination.exists() or destination.read_text() != rendered:
                raise SystemExit(f'{path} is stale; regenerate with tools/package_master/catalog.py')
        else:
            destination.write_text(rendered)
    print(json.dumps({'packages': sum(x['path'].startswith('packages/') for x in data['packages']),
                      'serviceHosts': sum(x['kind'] == 'service' for x in data['packages']),
                      'catalog': str(OUTPUT), 'checked': args.check}))
