"""Inspect all available artifacts from the exact Apple build source; no acceptance credit."""
import argparse
import hashlib
import importlib.util
import json
import os
import plistlib
import re
import subprocess
import tempfile
import urllib.request
from pathlib import Path

REPOSITORY = 'shaikhrais/primecare-platform'
SOURCE = '785dcac644ef21e79aaa7e012154aee989bf71cf'
RUNS = {'macos': 43328101727, 'ios': 43328101736}
# Only these reviewed immutable producers may supply an artifact. Historical ZIP
# failures retain their original identity; the preserved archive is a new source.
BUILDS = {
    43456846629: {'platform': 'ios', 'source': 'a41163b1da96015c05618b30a68d0af6c1929471', 'archiveFormat': 'raw'},
    43442916442: {'platform': 'ios', 'source': 'a94e222694c2875e0864e561905e7e4552a49107', 'archiveFormat': 'raw'},
    43328101727: {'platform': 'macos', 'source': SOURCE, 'archiveFormat': 'raw'},
    43328101736: {'platform': 'ios', 'source': SOURCE, 'archiveFormat': 'raw'},
    43349642502: {'platform': 'macos', 'source': '89273fca8fd30463a8b4c80f66106b8693601fa2', 'archiveFormat': 'tar'},
    43377825284: {'platform': 'ios', 'source': 'ab9ce22d10c8d947be437b584f4f9a73a48e1db6',
                  'archiveFormat': 'raw', 'app': 'primecare_enterprise_blueprint',
                  'workflowPath': '.github/workflows/ios-blueprint-diagnostic.yml',
                  'producer': 'unsigned_blueprint',
                  'artifactName': 'ios-blueprint-unsigned-ab9ce22d10c8d947be437b584f4f9a73a48e1db6',
                  'artifactId': 14016450032,
                  'executableSha256': '0a175e12567500cfbdccdcbc9e7bb7d9cfc853d447b661c29ba242e95c295bda'},
}
APPS = ('primecare_business_development', 'primecare_client', 'primecare_clinic',
        'primecare_corporate', 'primecare_franchise', 'primecare_marketing',
        'primecare_support', 'primecare_governance', 'primecare_enterprise_blueprint')


def api(path):
    request = urllib.request.Request(f'https://api.github.com/repos/{REPOSITORY}/{path}', headers={
        'Authorization': 'Bearer ' + os.environ['GH_TOKEN'],
        'Accept': 'application/vnd.github+json', 'X-GitHub-Api-Version': '2022-11-28'})
    with urllib.request.urlopen(request, timeout=30) as response:
        return json.load(response)


def matrix_scope(item):
    run = item.get('run')
    scope = BUILDS.get(run) if type(run) is int else None
    if (scope is None or item.get('app') not in APPS
            or any(item.get(key) != value for key, value in scope.items())
            or type(item.get('id')) is not int or item['id'] <= 0
            or scope.get('artifactId', item['id']) != item['id']):
        raise ValueError('Unexpected artifact matrix identity')
    return scope


def validate(artifact, platform, app, run_id=None):
    run = artifact.get('workflow_run', {})
    run_id = RUNS.get(platform) if run_id is None else run_id
    scope = BUILDS.get(run_id)
    if (scope is None or scope['platform'] != platform or app not in APPS
            or artifact.get('name') != scope.get('artifactName', f'{platform}-build-{app}')
            or scope.get('app', app) != app
            or scope.get('artifactId', artifact.get('id')) != artifact.get('id')
            or artifact.get('expired') is not False or artifact.get('size_in_bytes', 0) <= 0
            or run.get('id') != run_id or run.get('head_sha') != scope['source']
            or run.get('head_branch') != 'main'
            or not isinstance(run.get('repository_id'), int) or run['repository_id'] <= 0
            or run.get('repository_id') != run.get('head_repository_id')):
        raise ValueError('Untrusted, missing or expired artifact identity')


def discover():
    matrix, coverage = [], []
    selected = os.environ.get('BUILD_RUN_ID', '')
    if selected and selected not in {str(run) for run in BUILDS}:
        raise ValueError('Unexpected producer selection')
    for run_id, scope in BUILDS.items():
        platform = scope['platform']
        run = api(f'actions/runs/{run_id}')
        if (run.get('head_sha') != scope['source'] or run.get('head_branch') != 'main'
                or run.get('path') != scope.get('workflowPath', f'.github/workflows/build_{platform}.yml')
                or run.get('repository', {}).get('full_name') != REPOSITORY
                or run.get('head_repository', {}).get('full_name') != REPOSITORY):
            raise ValueError('Build run identity mismatch')
        artifacts = api(f'actions/runs/{run_id}/artifacts?per_page=100')
        jobs = api(f'actions/runs/{run_id}/jobs?per_page=100')
        if artifacts['total_count'] > 100 or jobs['total_count'] > 100:
            raise ValueError('Truncated build inventory')
        for app in ((scope['app'],) if 'app' in scope else APPS):
            matches = [a for a in artifacts['artifacts'] if a['name'] == scope.get('artifactName', f'{platform}-build-{app}')]
            producers = [j for j in jobs['jobs'] if j['name'] == scope.get('producer', f'build_{platform} ({app})')]
            state = producers[0].get('conclusion') or producers[0]['status'] if len(producers) == 1 else 'missing'
            if len(matches) > 1:
                raise ValueError('Ambiguous artifact')
            if state == 'success' and len(matches) == 1:
                validate(matches[0], platform, app, run_id)
                if not selected or selected == str(run_id):
                    matrix.append({**scope, 'app': app, 'id': matches[0]['id'],
                                   'run': run_id, 'runner': 'macos-26-intel' if platform == 'macos' else 'ubuntu-24.04'})
            coverage.append({**scope, 'run': run_id, 'app': app, 'build': state,
                             'artifactAvailable': state == 'success' and len(matches) == 1})
    report = {'sources': sorted({scope['source'] for scope in BUILDS.values()}),
              'selectedProducer': int(selected) if selected else None,
              'coverage': coverage, 'artifactTestsScheduled': len(matrix),
              'runtimeAcceptance': False}
    Path('apple-artifact-coverage.json').write_text(json.dumps(report, indent=2) + '\n')
    with open(os.environ['GITHUB_OUTPUT'], 'a') as output:
        output.write('matrix=' + json.dumps({'include': matrix}) + '\n')
        output.write('available=' + str(bool(matrix)).lower() + '\n')
    print(json.dumps(report))


def inspect(item, root):
    scope = matrix_scope(item)
    platform, app = scope['platform'], item['app']
    if platform == 'macos':
        # Reuse the same strict signature, sandbox and network-denied startup test.
        spec = importlib.util.spec_from_file_location('clinic_smoke', Path(__file__).with_name('test-macos-clinic-artifact.py'))
        smoke = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(smoke)
        smoke.ARTIFACT = item['id']
        smoke.SOURCE = scope['source']
        if scope['archiveFormat'] == 'tar':
            archive = root / f'macos-{app}.tar'
            if list(root.iterdir()) != [archive] or archive.is_symlink() or not archive.is_file():
                raise ValueError('Expected only the pinned producer application archive')
            package_spec = importlib.util.spec_from_file_location('macos_package', Path(__file__).with_name('package-test-macos-build.py'))
            package = importlib.util.module_from_spec(package_spec)
            package_spec.loader.exec_module(package)
            with tempfile.TemporaryDirectory(prefix='macos-downloaded-') as temporary:
                restored = Path(temporary)
                package.extract_application(archive, restored)
                # The same strict signature, entitlements and network-denied
                # launch gate runs after downloading and safely extracting tar.
                smoke.launch(restored)
            return
        # ZIP may have flattened versioned framework links: capture structural evidence.
        for framework in sorted(root.glob('*.app/Contents/Frameworks/*.framework')):
            current = framework / 'Versions/Current'
            print(json.dumps({'framework': framework.name, 'currentIsSymlink': current.is_symlink(),
                              'currentExists': current.exists()}), flush=True)
        smoke.launch(root)
    else:
        result = inspect_ios_bundle(root, app, scope['source'], item['id'])
        if scope.get('executableSha256', result['executableSha256']) != result['executableSha256']:
            raise ValueError('Downloaded executable differs from reviewed builder digest')
        print(json.dumps(result))

def inspect_ios_bundle(root, app, source, artifact=None):
    """Static unsigned device-bundle inspection shared by builders and downloads."""
    if app not in APPS or re.fullmatch('[0-9a-f]{40}', source) is None:
        raise ValueError('Unexpected built application identity')
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
    return {'artifact': artifact, 'source': source, 'app': app,
                      'bundleInspectionPassed': True, 'executableSha256': digest,
                      'runtimeLaunchTested': False, 'deviceSigningRequired': True}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('mode', choices=['discover', 'metadata', 'inspect'])
    args = parser.parse_args()
    if args.mode == 'discover':
        discover()
    else:
        item = json.loads(os.environ['ARTIFACT_ITEM'])
        matrix_scope(item)
        if args.mode == 'metadata':
            artifact = api(f"actions/artifacts/{item['id']}")
            if artifact.get('id') != item['id']:
                raise ValueError('Artifact ID mismatch')
            validate(artifact, item['platform'], item['app'], item['run'])
        else:
            inspect(item, Path('apple-artifact'))

