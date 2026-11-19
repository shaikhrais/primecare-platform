"""Require the exact reviewed, successful Governance-only verification run."""
import argparse
import json
from pathlib import Path


def verify_run(run, jobs, sha, run_id):
    expected = {
        'id': run_id,
        'path': '.github/workflows/deploy-governance-portal-only.yml',
        'event': 'workflow_dispatch',
        'head_branch': 'main',
        'head_sha': sha,
        'run_attempt': 1,
        'status': 'completed',
        'conclusion': 'success',
    }
    if any(run.get(key) != value for key, value in expected.items()):
        raise ValueError('Expected the original successful Governance verification on exact main')
    records = jobs.get('jobs', [])
    if len(records) != 2 or any(j.get('run_id') != run_id or j.get('conclusion') != 'success' for j in records):
        raise ValueError('Expected two successful jobs from the selected verification')
    checks = {j.get('name'): {s.get('name'): s.get('conclusion') for s in j.get('steps', [])}
              for j in records}
    build = checks.get('build', {})
    artifact = checks.get('Check artifact and publish only if requested', {})
    if any(build.get(s) != 'success' for s in (
        'Build with the existing read-only metadata export', 'Seal tested output'
    )) or artifact.get('Recheck prior live version and exact artifact') != 'success' \
       or artifact.get('Record successful verification without publishing') != 'success' \
       or artifact.get('Recheck production preconditions and publish only the tested Governance artifact') != 'skipped':
        raise ValueError('Run lacks the verified Governance artifact or was not verify-only')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('run', type=Path)
    parser.add_argument('jobs', type=Path)
    parser.add_argument('sha')
    parser.add_argument('run_id', type=int)
    opts = parser.parse_args()
    verify_run(json.loads(opts.run.read_text()), json.loads(opts.jobs.read_text()), opts.sha, opts.run_id)


if __name__ == '__main__':
    main()
