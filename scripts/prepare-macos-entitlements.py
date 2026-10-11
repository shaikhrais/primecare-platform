#!/usr/bin/env python3
"""Preserve the sandbox and allow the existing app APIs in macOS builds."""
import argparse
import plistlib
import subprocess
from pathlib import Path

NETWORK_CLIENT = 'com.apple.security.network.client'
SANDBOX = 'com.apple.security.app-sandbox'


def prepare(app_directory):
    for name in ('DebugProfile.entitlements', 'Release.entitlements'):
        path = Path(app_directory) / 'macos' / 'Runner' / name
        values = plistlib.loads(path.read_bytes())
        if values.get(SANDBOX) is not True:
            raise ValueError(f'{path}: app sandbox must remain enabled')
        values[NETWORK_CLIENT] = True
        path.write_bytes(plistlib.dumps(values, sort_keys=False))


def verify_built(app_directory):
    products = Path(app_directory) / 'build/macos/Build/Products/Release'
    apps = list(products.glob('*.app'))
    if len(apps) != 1:
        raise ValueError(f'Expected one macOS application in {products}, found {len(apps)}')
    result = subprocess.run(['codesign', '-d', '--entitlements', ':-', str(apps[0])],
                            check=True, capture_output=True)
    values = plistlib.loads(result.stdout)
    if values.get(SANDBOX) is not True or values.get(NETWORK_CLIENT) is not True:
        raise ValueError(f'{apps[0]}: signed sandbox/network entitlements are missing')
    print(f'Verified signed sandbox and outgoing network entitlement: {apps[0].name}')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('app_directory', type=Path)
    parser.add_argument('--verify-built', action='store_true')
    arguments = parser.parse_args()
    if arguments.verify_built:
        verify_built(arguments.app_directory)
    else:
        prepare(arguments.app_directory)
