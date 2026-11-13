"""Inspect all available artifacts from the exact Apple build source; no acceptance credit."""
import argparse
import hashlib
import importlib.util
import json
import os
import plistlib
import subprocess
import urllib.request
from pathlib import Path

REPOSITORY = 'shaikhrais/primecare-platform'
SOURCE = '785dcac644ef21e79aaa7e012154aee989bf71cf'
RUNS = {'macos': 43328101727, 'ios': 43328101736}
APPS = ('primecare_business_development', 'primecare_client', 'primecare_clinic',
        'primecare_corporate', 'primecare_franchise', 'primecare_marketing',
        'primecare_support', 'primecare_governance', 'primecare_enterprise_blueprint')


def api(path):
    request = urllib.request.Request(f'https://api.github.com/repos/{REPOSITORY}/{path}', headers={
        'Authorization': 'Bearer ' + os.environ['GH_TOKEN'],
        'Accept': 'application/vnd.github+json', 'X-GitHub-Api-Version': '2022-11-28'})
    with urllib.request.urlopen(request, timeout=30) as response:
        return json.load(response)


def validate(artifact, platform, app):
    run = artifact.get('workflow_run', {})
    if (platform not in RUNS or app not in APPS
            or artifact.get('name') != f'{platform}-build-{app}'
            or artifact.get('expired') is not False or artifact.get('size_in_bytes', 0) <= 0
            or run.get('id') != RUNS[platform] or run.get('head_sha') != SOURCE
            or run.get('head_branch') != 'main'
            or not isinstance(run.get('repository_id'), int) or run['repository_id'] <= 0
            or run.get('repository_id') != run.get('head_repository_id')):
        raise ValueError('Untrusted, missing or expired artifact identity')


def discover():
    matrix, coverage = [], []
    for platform, run_id in RUNS.items():
        run = api(f'actions/runs/{run_id}')
        if (run.get('head_sha') != SOURCE or run.get('head_branch') != 'main'
                or run.get('path') != f'.github/workflows/build_{platform}.yml'
                or run.get('repository', {}).get('full_name') != REPOSITORY
                or run.get('head_repository', {}).get('full_name') != REPOSITORY):
            raise ValueError('Build run identity mismatch')
        artifacts = api(f'actions/runs/{run_id}/artifacts?per_page=100')
        jobs = api(f'actions/runs/{run_id}/jobs?per_page=100')
        if artifacts['total_count'] > 100 or jobs['total_count'] > 100:
            raise ValueError('Truncated build inventory')
        for app in APPS:
            matches = [a for a in artifacts['artifacts'] if a['name'] == f'{platform}-build-{app}']
            producers = [j for j in jobs['jobs'] if j['name'] == f'build_{platform} ({app})']
            state = producers[0].get('conclusion') or producers[0]['status'] if len(producers) == 1 else 'missing'
            if len(matches) > 1:
                raise ValueError('Ambiguous artifact')
            if state == 'success' and len(matches) == 1:
                validate(matches[0], platform, app)
                matrix.append({'platform': platform, 'app': app, 'id': matches[0]['id'],
                               'run': run_id, 'runner': 'macos-26-intel' if platform == 'macos' else 'ubuntu-24.04'})
            coverage.append({'platform': platform, 'app': app, 'build': state,
                             'artifactAvailable': state == 'success' and len(matches) == 1})
    report = {'source': SOURCE, 'coverage': coverage, 'artifactTestsScheduled': len(matrix),
              'runtimeAcceptance': False}
    Path('apple-artifact-coverage.json').write_text(json.dumps(report, indent=2) + '\n')
    with open(os.environ['GITHUB_OUTPUT'], 'a') as output:
        output.write('matrix=' + json.dumps({'include': matrix}) + '\n')
        output.write('available=' + str(bool(matrix)).lower() + '\n')
    print(json.dumps(report))


def inspect(item, root):
    platform, app = item['platform'], item['app']
    if platform not in RUNS or app not in APPS or item['run'] != RUNS[platform]:
        raise ValueError('Unexpected matrix scope')
    if platform == 'macos':
        # Reuse the same strict signature, sandbox and network-denied startup test.
        spec = importlib.util.spec_from_file_location('clinic_smoke', Path(__file__).with_name('test-macos-clinic-artifact.py'))
        smoke = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(smoke)
        smoke.ARTIFACT = item['id']
        # ZIP may have flattened versioned framework links: capture structural evidence.
        for framework in sorted(root.glob('*.app/Contents/Frameworks/*.framework')):
            current = framework / 'Versions/Current'
            print(json.dumps({'framework': framework.name, 'currentIsSymlink': current.is_symlink(),
                              'currentExists': current.exists()}), flush=True)
        smoke.launch(root)
    else:
        # The iOS producer uploads Runner.app contents, without its enclosing folder.
        info = plistlib.loads((root / 'Info.plist').read_bytes())
        name = info.get('CFBundleExecutable')
        if (info.get('CFBundlePackageType') != 'APPL'
                or 'iPhoneOS' not in info.get('CFBundleSupportedPlatforms', [])
                or not isinstance(name, str) or Path(name).name != name or name in ('.', '..')
                or not isinstance(info.get('CFBundleIdentifier'), str) or not info['CFBundleIdentifier']):
            raise ValueError('Invalid iPhone device application metadata')
        executable = (root / name).resolve()
        if not executable.is_relative_to(root.resolve()) or not executable.is_file():
            raise ValueError('Missing or escaping iOS executable')
        result = subprocess.run(['file', str(executable)], check=True, capture_output=True, text=True, timeout=30)
        if 'Mach-O' not in result.stdout or 'arm64' not in result.stdout:
            raise ValueError('Expected an arm64 Mach-O device executable')
        with executable.open('rb') as binary:
            digest = hashlib.file_digest(binary, 'sha256').hexdigest()
        print(json.dumps({'artifact': item['id'], 'source': SOURCE, 'app': app,
                          'bundleInspectionPassed': True, 'executableSha256': digest,
                          'runtimeLaunchTested': False, 'deviceSigningRequired': True}))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('mode', choices=['discover', 'metadata', 'inspect'])
    args = parser.parse_args()
    if args.mode == 'discover':
        discover()
    else:
        item = json.loads(os.environ['ARTIFACT_ITEM'])
        if (item.get('platform') not in RUNS or item.get('app') not in APPS
                or item.get('run') != RUNS[item['platform']]
                or not isinstance(item.get('id'), int) or item['id'] <= 0):
            raise ValueError('Unexpected artifact matrix identity')
        if args.mode == 'metadata':
            artifact = api(f"actions/artifacts/{item['id']}")
            if artifact.get('id') != item['id']:
                raise ValueError('Artifact ID mismatch')
            validate(artifact, item['platform'], item['app'])
        else:
            inspect(item, Path('apple-artifact'))
