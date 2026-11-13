"""Check one immutable Clinic artifact; startup liveness is not feature acceptance."""
import argparse
import json
import os
import plistlib
import stat
import subprocess
import sys
import tempfile
import time
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



def crash_summary(directory, pid, name, previous):
    """Read only a bounded new IPS report for this exact isolated child."""
    try:
        reports = sorted((p for p in directory.glob('*.ips')
                          if p.name not in previous and p.name.startswith(name + '-')),
                         key=lambda p: p.name, reverse=True)[:16]
    except OSError:
        return None
    for path in reports:
        try:
            if path.is_symlink():
                continue
            with path.open('rb') as stream:
                data = stream.read(2 * 1024 * 1024 + 1)
            if len(data) > 2 * 1024 * 1024:
                continue
            text = data.decode('utf-8')
            decoder = json.JSONDecoder()
            first, end = decoder.raw_decode(text.lstrip())
            report = decoder.decode(text.lstrip()[end:].strip())
            if not isinstance(first, dict) or not isinstance(report, dict):
                continue
            if report.get('pid') != pid or report.get('procName') != name:
                continue
            # Never serialize raw crash data, memory, paths or process environment.
            exception = report.get('exception', {})
            if not isinstance(exception, dict):
                continue
            result = {k: v[:200] for k, v in exception.items()
                      if k in ('type', 'signal') and isinstance(v, str)}
            threads, index = report.get('threads'), report.get('faultingThread')
            if isinstance(threads, list) and type(index) is int and 0 <= index < len(threads):
                thread = threads[index]
                frames = thread.get('frames') if isinstance(thread, dict) else None
                if isinstance(frames, list):
                    result['symbols'] = [f['symbol'][:200] for f in frames[:12]
                                         if isinstance(f, dict) and isinstance(f.get('symbol'), str)]
            return result or None
        except (OSError, ValueError, UnicodeError):
            continue
    return None


def startup_failure(code, log_path, crash=None):
    """Capture a bounded diagnostic before the isolated temporary HOME is removed."""
    limit = 8192
    try:
        with log_path.open('rb') as stream:
            stream.seek(0, os.SEEK_END)
            size = stream.tell()
            stream.seek(max(0, size - limit))
            tail = stream.read(limit).decode('utf-8', errors='replace')
        diagnostic = {'startupLogTail': tail, 'truncated': size > limit}
    except OSError as error:
        # A diagnostic read failure must not replace the original startup result.
        diagnostic = {'startupLogUnavailable': type(error).__name__}
    if crash is not None:
        diagnostic['crashSummary'] = crash
    # JSON escapes newlines/control characters: child output cannot become an
    # Actions workflow command or unbounded traceback content.
    return f'Application exited during startup: {code}\n' + json.dumps(diagnostic)

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
        reports = Path.home() / 'Library/Logs/DiagnosticReports'
        try:
            previous = {p.name for p in reports.glob('*.ips')}
        except OSError:
            reports, previous = None, set()
        with (home / 'startup.log').open('wb') as log:
            process = subprocess.Popen(['/usr/bin/sandbox-exec', '-p', profile, str(executable)],
                                       env=environment, stdout=log, stderr=log, start_new_session=True)
            try:
                try:
                    code = process.wait(timeout=10)
                except subprocess.TimeoutExpired:
                    code = None
                if code is not None:
                    crash = None
                    if code < 0 and reports is not None:
                        deadline = time.monotonic() + 2
                        while crash is None:
                            crash = crash_summary(reports, process.pid, name, previous)
                            if crash is not None or time.monotonic() >= deadline:
                                break
                            time.sleep(0.1)
                    raise RuntimeError(startup_failure(code, home / 'startup.log', crash))
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
