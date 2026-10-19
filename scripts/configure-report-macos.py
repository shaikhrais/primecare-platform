"""Apply shared report prerequisites to an existing/generated macOS runner."""
import argparse
import plistlib
from pathlib import Path


def configure(app: Path):
    runner = app / 'macos' / 'Runner'
    files = list(runner.glob('*.entitlements'))
    if not files:
        raise FileNotFoundError(f'No macOS entitlements in {runner}')
    for file in files:
        with file.open('rb') as stream:
            data = plistlib.load(stream)
        data['com.apple.security.network.client'] = True
        data['com.apple.security.files.user-selected.read-write'] = True
        with file.open('wb') as stream:
            plistlib.dump(data, stream, sort_keys=False)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('app', type=Path)
    configure(parser.parse_args().app)
