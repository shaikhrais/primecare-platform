"""Preserve and test the actual signed macOS app before publishing its artifact."""
import argparse
import importlib.util
import json
import os
import plistlib
import re
import subprocess
import sys
import tarfile
import tempfile
from pathlib import Path


def application(products):
    apps = list(products.glob('*.app'))
    if len(apps) != 1 or apps[0].is_symlink() or not apps[0].is_dir():
        raise ValueError('Expected one actual application bundle')
    return apps[0]


def archive_application(app, destination):
    destination.parent.mkdir(parents=True, exist_ok=True)
    # Never dereference framework aliases: the signed bundle seals these links.
    with tarfile.open(destination, 'w', dereference=False) as archive:
        archive.add(app, arcname=app.name)


def extract_application(archive, destination):
    with tarfile.open(archive, 'r') as contents:
        contents.extractall(destination, filter='data')
    return application(destination)


def verify(app):
    subprocess.run(['codesign', '--verify', '--deep', '--strict', str(app)], check=True)
    info = plistlib.loads((app / 'Contents/Info.plist').read_bytes())
    name = info.get('CFBundleExecutable')
    if not isinstance(name, str) or Path(name).name != name or name in ('.', '..'):
        raise ValueError('Invalid executable name')
    executable = (app / 'Contents/MacOS' / name).resolve()
    if (not executable.is_relative_to(app.resolve()) or not executable.is_file()
            or not os.access(executable, os.X_OK) or not executable.stat().st_mode & 0o100):
        raise ValueError('Missing, escaping or nonexecutable application binary')


def main(products, destination):
    if sys.platform != 'darwin':
        raise RuntimeError('Native packaging/signature/startup tests run only in macOS Actions')
    source = os.environ['GITHUB_SHA']
    if re.fullmatch('[0-9a-f]{40}', source) is None:
        raise ValueError('Exact source commit required')
    app = application(products)
    # A failure here is a builder defect; do not disguise it as ZIP corruption.
    verify(app)
    archive_application(app, destination)
    with tempfile.TemporaryDirectory(prefix='macos-roundtrip-') as temporary:
        root = Path(temporary)
        restored = extract_application(destination, root)
        verify(restored)
        spec = importlib.util.spec_from_file_location('macos_smoke', Path(__file__).with_name('test-macos-clinic-artifact.py'))
        smoke = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(smoke)
        # This is a fresh builder roundtrip, not the historical Clinic artifact.
        smoke.ARTIFACT = None
        smoke.SOURCE = source
        smoke.launch(root)
    print(json.dumps({'source': source, 'app': app.name, 'archive': destination.name,
                      'strictSignatureBeforeAndAfterArchive': True,
                      'isolatedStartupPassed': True, 'featureAcceptance': False}))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--products', required=True, type=Path)
    parser.add_argument('--archive', required=True, type=Path)
    args = parser.parse_args()
    main(args.products, args.archive)
