from copy import deepcopy
import unittest
from .api_release_approval import approval_digest, check_approval


def inputs():
    ids = [f'88888888-8888-4888-8888-{i:012}' for i in range(3)]
    name = 'primecare-governance-api'
    plan = {
        'commit': 'a' * 40, 'verified_run_id': 100,
        'targets': [dict(worker=name, prior_deployment=ids[0], prior_version=ids[1],
                         candidate_version=ids[2], bundle_sha256='e' * 64)],
    }
    return plan, approval_digest(plan), {
        'commit': plan['commit'], 'verified_run_id': 100, 'required_workers': [name],
        'versions': {name: {'version': ids[2], 'bundle_sha256': 'e' * 64}},
    }, {name: {'deployment': ids[0], 'traffic': {ids[1]: 100}}}


class ReleaseApprovalTest(unittest.TestCase):
    def test_exact_records(self):
        p, a, e, l = inputs()
        self.assertEqual(check_approval(p, a, e, l), a)
        self.assertEqual(approval_digest(dict(reversed(list(p.items())))), a)

    def test_changed_approval_or_candidate(self):
        p, a, e, l = inputs()
        with self.assertRaisesRegex(ValueError, 'exact release plan'):
            check_approval(p, 'c' * 64, e, l)
        p['targets'][0]['bundle_sha256'] = 'd' * 64
        with self.assertRaisesRegex(ValueError, 'exact release plan'):
            check_approval(p, a, e, l)
        with self.assertRaisesRegex(ValueError, 'Verified candidates'):
            check_approval(p, approval_digest(p), e, l)

    def test_out_of_scope_and_duplicates(self):
        p, _, _, _ = inputs()
        p['targets'].append(deepcopy(p['targets'][0]))
        with self.assertRaisesRegex(ValueError, 'unique'):
            approval_digest(p)
        p['targets'].pop()
        for name in ('primecare-auth-api', 'primecare-api-gateway', '*'):
            p['targets'][0]['worker'] = name
            with self.subTest(name=name), self.assertRaisesRegex(ValueError, 'outside'):
                approval_digest(p)

    def test_verification_and_dependency_drift(self):
        p, a, e, l = inputs()
        for key, value, pattern in (
            ('verified_run_id', 101, 'verification commit or run'),
            ('commit', 'b' * 40, 'verification commit or run'),
            ('required_workers', ['primecare-governance-api', 'primecare-notes-api'], 'dependency scope'),
        ):
            changed = dict(e, **{key: value})
            with self.subTest(key=key), self.assertRaisesRegex(ValueError, pattern):
                check_approval(p, a, changed, l)

    def test_refuses_stale_baseline_or_split_traffic(self):
        p, a, e, l = inputs()
        for field, bad in (('deployment', p['targets'][0]['candidate_version']),
                           ('traffic', {p['targets'][0]['prior_version']: 95,
                                        p['targets'][0]['candidate_version']: 5})):
            changed = deepcopy(l)
            changed['primecare-governance-api'][field] = bad
            with self.subTest(field=field), self.assertRaisesRegex(ValueError, 'traffic changed'):
                check_approval(p, a, e, changed)

    def test_rejects_noop_and_unknown_fields(self):
        p, _, _, _ = inputs()
        p['targets'][0]['candidate_version'] = p['targets'][0]['prior_version']
        with self.assertRaisesRegex(ValueError, 'already matches'):
            approval_digest(p)
        p['wildcard'] = True
        with self.assertRaisesRegex(ValueError, 'Unexpected'):
            approval_digest(p)
