"""Read-only contract check for one approved, already verified API release."""
import argparse
import hashlib
import hmac
import json
import re
from pathlib import Path


SERVICES = frozenset((
    'billing', 'client', 'compliance', 'franchise-reporting', 'governance',
    'notes', 'notification', 'provider', 'scheduling', 'verification', 'visit',
))
SHA = r'[0-9a-f]{40}'
DIGEST = r'[0-9a-f]{64}'
UUID = r'[0-9a-f]{8}(?:-[0-9a-f]{4}){3}-[0-9a-f]{12}'


def fields(value, *keys):
    if type(value) is not dict or value.keys() != set(keys):
        raise ValueError('Unexpected release record fields')


def token(value, pattern):
    if type(value) is not str or not re.fullmatch(pattern, value):
        raise ValueError('Malformed immutable release identifier')


def validate_version(entry):
    fields(entry, 'worker', 'prior_deployment', 'prior_version', 'candidate_version', 'bundle_sha256')
    token(entry['prior_deployment'], UUID)
    token(entry['prior_version'], UUID)
    token(entry['candidate_version'], UUID)
    token(entry['bundle_sha256'], DIGEST)
    if entry['prior_version'] == entry['candidate_version']:
        raise ValueError('Candidate already matches baseline; do not redeploy')


def approval_digest(plan):
    fields(plan, 'commit', 'verified_run_id', 'targets')
    token(plan['commit'], SHA)
    if type(plan['verified_run_id']) is not int or plan['verified_run_id'] <= 0:
        raise ValueError('Expected a GitHub Actions run ID')
    targets = plan['targets']
    if type(targets) is not list or not 1 <= len(targets) <= 11:
        raise ValueError('Explicit generic Worker targets are required')
    names = []
    for entry in targets:
        validate_version(entry)
        if entry['worker'] not in {f'primecare-{name}-api' for name in SERVICES}:
            raise ValueError('Worker is outside the generic API approval gate')
        names.append(entry['worker'])
    if names != sorted(set(names)):
        raise ValueError('Targets must be unique and sorted')
    return hashlib.sha256(json.dumps(plan, sort_keys=True, separators=(',', ':')).encode()).hexdigest()


def check_approval(plan, approved_digest, evidence, current):
    actual = approval_digest(plan)
    token(approved_digest, DIGEST)
    if not hmac.compare_digest(actual, approved_digest):
        raise ValueError('Approval does not match exact release plan')
    fields(evidence, 'commit', 'verified_run_id', 'required_workers', 'versions')
    if evidence['commit'] != plan['commit'] or type(evidence['verified_run_id']) is not int or evidence['verified_run_id'] != plan['verified_run_id']:
        raise ValueError('Wrong verification commit or run')
    expected_names = [entry['worker'] for entry in plan['targets']]
    if evidence['required_workers'] != expected_names:
        raise ValueError('Targets do not match reviewed dependency scope')
    expected_versions = {
        e['worker']: {'version': e['candidate_version'], 'bundle_sha256': e['bundle_sha256']}
        for e in plan['targets']
    }
    if evidence['versions'] != expected_versions:
        raise ValueError('Verified candidates do not match the approved versions')
    expected_live = {
        e['worker']: {'deployment': e['prior_deployment'], 'traffic': {e['prior_version']: 100}}
        for e in plan['targets']
    }
    if current != expected_live:
        raise ValueError('Live deployment or traffic changed; reverify before approval')
    return actual


def load(path):
    def unique(pairs):
        result = {}
        for key, value in pairs:
            if key in result:
                raise ValueError('Duplicate JSON key')
            result[key] = value
        return result

    return json.loads(Path(path).read_text(encoding='utf-8'), object_pairs_hook=unique)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest='action', required=True)
    sub.add_parser('digest').add_argument('plan')
    check = sub.add_parser('check')
    for name in ('plan', 'approved_digest', 'verified_evidence', 'live_evidence'):
        check.add_argument(name)
    args = parser.parse_args()
    try:
        plan = load(args.plan)
        if args.action == 'digest':
            print(approval_digest(plan))
        else:
            digest = check_approval(plan, args.approved_digest, load(args.verified_evidence), load(args.live_evidence))
            print(f'Approval records match: {digest}. No deployment performed.')
    except (OSError, ValueError, TypeError) as error:
        parser.exit(1, f'API approval blocked: {error}\n')


if __name__ == '__main__':
    main()
