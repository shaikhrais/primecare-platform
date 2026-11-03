"""Verify an archived portal bundle before using it in an isolated rehearsal."""
import argparse
import json
from zipfile import ZipFile

from .typescript_release import STAMP, digest, validate


def verify_archive(archive, project, commit):
    with ZipFile(archive) as bundle:
        entries = bundle.namelist()
        prefix = project + '/'
        stamp_path = prefix + STAMP
        if entries.count(stamp_path) != 1:
            raise ValueError('Expected exactly one archived portal stamp')
        stamp = validate(json.loads(bundle.read(stamp_path)), project, commit)
        for name, expected in stamp['files'].items():
            path = prefix + name
            if entries.count(path) != 1 or digest(bundle.read(path)) != expected:
                raise ValueError('Archived portal file missing, duplicated or changed: ' + name)
        return stamp


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('archive')
    parser.add_argument('project')
    parser.add_argument('commit')
    args = parser.parse_args()
    print(json.dumps(verify_archive(args.archive, args.project, args.commit), sort_keys=True))
