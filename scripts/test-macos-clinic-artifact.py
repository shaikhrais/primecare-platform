"""Check one immutable Clinic artifact; startup liveness is not feature acceptance."""
import argparse
import json
import os
import plistlib
import stat
import subprocess
import sys
import tempfile
import urllib.request
from pathlib import Path

REPOSITORY = 'shaikhrais/primecare-platform'
SOURCE = '785dcac644ef21e79aaa7e012154aee989bf71cf'
RUN = 43328101727
ARTIFACT = 13998842458


def verify_metadata():
    url = f'https://api.github.com/repos/{REPOSITORY}/actions/artifacts/{ARTIFACT}'
    request = urllib.request.Request(url, headers={
        'Authorization': 'Bearer ' + os.environ['GH_TOKEN'],
        'Accept': 'application/vnd.github+json',
        'X-GitHub-Api-Version': '2022-11-28',
    })
    with urllib.request.urlopen(request, timeout=30) as response:
        artifact = json.load(response)
    run = artifact.get('workflow_run', {})
    if (artifact.get('id') != ARTIFACT or artifact.get('expired') is not False
            or artifact.get('name') != 'macos-build-primecare_clinic'
            or artifact.get('size_in_bytes', 0) <= 0
            or run.get('id') != RUN or run.get('head_sha') != SOURCE
            or run.get('head_branch') != 'main'
            or not isinstance(run.get('repository_id'), int) or run['repository_id'] <= 0
            or run.get('repository_id') != run.get('head_repository_id')):
        raise ValueError('Artifact identity, source or retention mismatch')
    print(json.dumps({'artifact': ARTIFACT, 'source': SOURCE, 'identityVerified': True}))


def launch(root):
    if sys.platform != 'darwin':
        raise RuntimeError('Native execution requires the prescribed macOS Actions runner')
    apps = list(root.glob('*.app'))
    if len(apps) != 1:
        raise ValueError('Expected exactly one top-level application bundle')
    app = apps[0].resolve()
    info = plistlib.loads((app / 'Contents/Info.plist').read_bytes())
    name = info['CFBundleExecutable']
    if not isinstance(name, str) or Path(name).name != name or name in ('.', '..'):
        raise ValueError('Invalid bundle executable')
    executable = (app / 'Contents/MacOS' / name).resolve()
    if not executable.is_relative_to(app) or not executable.is_file():
        raise ValueError('Executable escapes or is absent from the bundle')
    # ZIP artifacts do not retain executable mode. Restore only the declared binary.
    executable.chmod(executable.stat().st_mode | stat.S_IXUSR)
    subprocess.run(['codesign', '--verify', '--deep', '--strict', str(app)], check=True)
    signed = subprocess.run(['codesign', '-d', '--entitlements', ':-', str(app)],
                            check=True, capture_output=True)
    entitlements = plistlib.loads(signed.stdout)
    if entitlements.get('com.apple.security.app-sandbox') is not True:
        raise ValueError('Application sandbox must remain enabled')
    with tempfile.TemporaryDirectory(prefix='clinic-startup-') as temporary:
        home = Path(temporary)
        # No production credentials or runner environment reach the process.
        environment = {'HOME': str(home), 'CFFIXED_USER_HOME': str(home),
                       'TMPDIR': str(home), 'PATH': '/usr/bin:/bin:/usr/sbin:/sbin'}
        profile = '(version 1) (allow default) (deny network*)'
        with (home / 'startup.log').open('wb') as log:
            process = subprocess.Popen(['/usr/bin/sandbox-exec', '-p', profile, str(executable)],
                                       env=environment, stdout=log, stderr=log, start_new_session=True)
            try:
                try:
                    code = process.wait(timeout=10)
                except subprocess.TimeoutExpired:
                    code = None
                if code is not None:
                    raise RuntimeError(f'Application exited during startup: {code}')
            finally:
                if process.poll() is None:
                    process.terminate()
                    try:
                        process.wait(timeout=5)
                    except subprocess.TimeoutExpired:
                        process.kill()
                        process.wait(timeout=5)
    print(json.dumps({'artifact': ARTIFACT, 'source': SOURCE, 'startupSeconds': 10,
                      'startupLivenessPassed': True, 'networkDenied': True,
                      'loginTested': False, 'featureAcceptance': False}))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--metadata', action='store_true')
    parser.add_argument('--bundle-root', type=Path)
    args = parser.parse_args()
    if args.metadata == (args.bundle_root is not None):
        parser.error('Choose exactly one of --metadata or --bundle-root')
    verify_metadata() if args.metadata else launch(args.bundle_root)
