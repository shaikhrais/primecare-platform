"""Keep dependency-only/developer-package pushes in Look Manager verification, not activation."""
import fnmatch
import os
from pathlib import Path
import re
import subprocess

RUNTIME_PATHS = (
    'packages/shared/src/look/**', 'cloudflare/workers/src/look/**',
    'websites/typescript/src/look-review.ts', 'scripts/deploy-look-manager.mjs',
    'tools/governance-production/look_manager_registration.py',
    'tools/governance-production/look-manager-registration.json',
)


def should_activate(event, paths):
    if event == 'workflow_dispatch':
        return True
    if event != 'push':
        raise ValueError('Unsupported Look Manager release event')
    for path in paths:
        if not isinstance(path, str) or path.startswith('/') or '..' in path.split('/'):
            raise ValueError('Invalid changed source path')
    return any(fnmatch.fnmatchcase(path, pattern) for path in paths for pattern in RUNTIME_PATHS)


def main():
    event = os.environ['LOOK_RELEASE_EVENT']
    if event == 'workflow_dispatch':
        paths = []
    else:
        base = os.environ['LOOK_RELEASE_BEFORE']
        if not re.fullmatch(r'[0-9a-f]{40}', base) or base == '0' * 40:
            raise ValueError('An exact previous commit is required')
        paths = subprocess.check_output(['git', 'diff', '--name-only', '--no-renames', base, 'HEAD'], text=True).splitlines()
    decision = should_activate(event, paths)
    with Path(os.environ['GITHUB_OUTPUT']).open('a') as output:
        output.write('activate=' + str(decision).lower() + '\n')
    print('Look Manager activation scope:', decision)


if __name__ == '__main__':
    main()
