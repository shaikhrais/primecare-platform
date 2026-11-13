"""Independently inspect/start the exact newly preserved Clinic archive."""
import argparse
import importlib.util
import json
import os
import tempfile
import urllib.request
from pathlib import Path

SOURCE = '723dd19b0d6a1cab4a0342686880c61ec6db2cd0'
RUN = 43493359962
ARTIFACT = 14071577404
JOB = 132119991690
REPOSITORY = 'shaikhrais/primecare-platform'


def module(name, filename):
    spec = importlib.util.spec_from_file_location(name, Path(__file__).with_name(filename))
    value = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(value)
    return value


def api(path):
    request = urllib.request.Request(f'https://api.github.com/repos/{REPOSITORY}/{path}', headers={
        'Authorization': 'Bearer ' + os.environ['GH_TOKEN'],
        'Accept': 'application/vnd.github+json', 'X-GitHub-Api-Version': '2022-11-28'})
    with urllib.request.urlopen(request, timeout=30) as response:
        return json.load(response)


def smoke():
    value = module('clinic_startup', 'test-macos-clinic-artifact.py')
    # Explicit new producer; the original raw ZIP constants stay historical.
    value.SOURCE, value.RUN, value.ARTIFACT = SOURCE, RUN, ARTIFACT
    return value


def verify_metadata():
    smoke().verify_metadata()
    run = api(f'actions/runs/{RUN}')
    jobs = api(f'actions/runs/{RUN}/jobs?per_page=100')
    producers = [job for job in jobs['jobs'] if job.get('name') == 'build_macos (primecare_clinic)']
    if (run.get('head_sha') != SOURCE or run.get('head_branch') != 'main'
            or run.get('path') != '.github/workflows/build_macos.yml'
            or run.get('repository', {}).get('full_name') != REPOSITORY
            or run.get('head_repository', {}).get('full_name') != REPOSITORY
            or jobs['total_count'] > 100 or len(producers) != 1
            or producers[0].get('id') != JOB or producers[0].get('conclusion') != 'success'):
        raise ValueError('Preserved Clinic producer identity or completed job mismatch')
    print(json.dumps({'source': SOURCE, 'run': RUN, 'job': JOB, 'artifact': ARTIFACT, 'producerVerified': True}))


def inspect(root):
    archive = root / 'macos-primecare_clinic.tar'
    if list(root.iterdir()) != [archive] or archive.is_symlink() or not archive.is_file():
        raise ValueError('Expected only the exact preserved Clinic tar')
    package = module('macos_package', 'package-test-macos-build.py')
    with tempfile.TemporaryDirectory(prefix='clinic-download-roundtrip-') as temporary:
        destination = Path(temporary)
        app = package.extract_application(archive, destination)
        if app.name != 'primecare_clinic.app':
            raise ValueError('Unexpected restored application')
        package.verify(app)
        smoke().launch(destination)
    print(json.dumps({'artifact': ARTIFACT, 'source': SOURCE, 'downloadedPreservedArchiveStartupPassed': True,
                      'loginTested': False, 'featureAcceptance': False}))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--metadata', action='store_true')
    group.add_argument('--archive-root', type=Path)
    args = parser.parse_args()
    verify_metadata() if args.metadata else inspect(args.archive_root)
