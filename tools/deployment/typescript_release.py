"""Source-bound TypeScript portal stamps and exact public-asset verification."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import time
import urllib.error
from .http_client import read_public_asset

FILES = ('index.html', 'portal.json', 'assets/app.js', 'assets/app.css',
         'manifest.webmanifest', 'service-worker.js', 'flutter_service_worker.js',
         'icons/primecare-192.png', 'icons/primecare-512.png')
STAMP = 'primecare-build.json'

def digest(data):
    return hashlib.sha256(data).hexdigest()

def validate(stamp, project, commit):
    if not re.fullmatch(r'primecare-[a-z]+(?:-[a-z]+)*', project) or not re.fullmatch(r'[a-f0-9]{40}', commit):
        raise ValueError('Invalid release identity')
    if not isinstance(stamp, dict) or set(stamp) != {'runtime', 'commit', 'project', 'files'}:
        raise ValueError('Invalid TypeScript release stamp')
    if stamp['runtime'] != 'typescript' or stamp['commit'] != commit or stamp['project'] != project:
        raise ValueError('Live runtime, source or project differs from accepted release')
    files = stamp['files']
    if not isinstance(files, dict) or set(files) != set(FILES) or any(not isinstance(v, str) or not re.fullmatch(r'[a-f0-9]{64}', v) for v in files.values()):
        raise ValueError('Invalid release file digests')
    return stamp

def make_stamp(root, project, commit):
    return validate({'runtime': 'typescript', 'commit': commit, 'project': project,
                     'files': {name: digest((Path(root) / name).read_bytes()) for name in FILES}}, project, commit)

def verify_live(project, commit, expected=None, reader=read_public_asset):
    # Each resource is read independently; redirects/protection failures are not acceptance.
    base = 'https://' + project + '.pages.dev/'
    query = '?primecare-release=' + commit + '&probe=' + str(time.time_ns())
    # Validate identity before constructing a network destination.
    validate({'runtime': 'typescript', 'commit': commit, 'project': project,
              'files': {name: '0' * 64 for name in FILES}}, project, commit)
    raw = reader(base + STAMP + query)
    if len(raw) > 16384:
        raise ValueError('Oversized release stamp')
    stamp = validate(json.loads(raw), project, commit)
    if expected is not None and stamp != validate(expected, project, commit):
        raise ValueError('Live release stamp changed during verification')
    for name in FILES:
        # Pages serves index.html at / and redirects its noncanonical .html URL.
        # Read the canonical URL directly; never follow redirects to other content.
        route = '' if name == 'index.html' else name
        if digest(reader(base + route + query)) != stamp['files'][name]:
            raise ValueError('Live release asset digest differs: ' + name)
    # A second stamp read catches a publisher changing the release during the reads.
    if json.loads(reader(base + STAMP + query)) != stamp:
        raise ValueError('Live release stamp changed during asset reads')
    return stamp

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest='command', required=True)
    for name in ['stamp', 'verify-deploy']:
        cmd = sub.add_parser(name); cmd.add_argument('root'); cmd.add_argument('project')
    live = sub.add_parser('live'); live.add_argument('project'); live.add_argument('commit')
    live.add_argument('--baseline'); live.add_argument('--record')
    args = parser.parse_args()
    if args.command == 'live':
        baseline = json.loads(Path(args.baseline).read_text()) if args.baseline else None
        stamp = verify_live(args.project, args.commit, baseline)
        if args.record:
            path = Path(args.record); path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(json.dumps(stamp, sort_keys=True) + '\n')
    else:
        commit = os.environ.get('GITHUB_SHA') or subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip()
        actual = subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip()
        if commit != actual:
            raise ValueError('Build checkout differs from CI source')
        expected = make_stamp(args.root, args.project, commit)
        if args.command == 'stamp':
            (Path(args.root) / STAMP).write_text(json.dumps(expected, sort_keys=True) + '\n')
            stamp = expected
        else:
            if json.loads((Path(args.root) / STAMP).read_text()) != expected:
                raise ValueError('Local release stamp differs from deployed artifact')
            for attempt in range(18):
                try:
                    stamp = verify_live(args.project, commit, expected)
                    break
                except urllib.error.HTTPError as error:
                    if error.code in (401, 403) or attempt == 17:
                        raise
                except Exception:
                    if attempt == 17:
                        raise
                time.sleep(5)
    print('TYPESCRIPT_RELEASE_VERIFIED ' + json.dumps(stamp, sort_keys=True))

if __name__ == '__main__':
    main()
