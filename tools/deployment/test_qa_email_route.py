import copy
import unittest
from unittest.mock import Mock, patch

from . import qa_email_route as q

Z, A, T, R = ('a' * 32, 'b' * 32, 'c' * 32, 'd' * 32)
ZONE = '/zones/' + Z
SETTINGS = ZONE + '/email/routing'
RULES = SETTINGS + '/rules'
DESTS = '/accounts/' + A + '/email/routing/addresses'


class Provider:
    def __init__(self):
        self.zone = {'id': Z, 'account': {'id': A}, 'name': q.DOMAIN, 'status': 'active'}
        self.settings = {'enabled': True, 'name': q.DOMAIN, 'status': 'ready'}
        self.catch_all = {'enabled': False}
        self.zones = [self.zone]
        self.dests = [{'id': T, 'email': q.DESTINATION, 'verified': '2025-01-01T00:00:00Z'}]
        self.rules = []
        self.calls = []
        self.post_fail = False
        self.unreadable = False
        self.bad_page = False

    @property
    def writes(self):
        return [row for row in self.calls if row[1] != 'GET']

    def __call__(self, path, method='GET', body=None):
        self.calls.append((path, method, copy.deepcopy(body)))
        if method != 'GET':
            if self.post_fail:
                raise q.Blocked('some provider payload with a secret')
            self.rules.append({**copy.deepcopy(body), 'id': R})
            return {'result': copy.deepcopy(self.rules[-1])}
        if path == ZONE:
            return {'result': self.zone}
        if path == SETTINGS:
            return {'result': self.settings}
        if path == RULES + '/catch_all':
            return {'result': self.catch_all}
        if path == RULES + '/' + R:
            if self.unreadable:
                return {'result': {}}
            return {'result': copy.deepcopy(self.rules[-1])}
        base, query = path.split('?', 1)
        data = self.zones if base == '/zones' else self.dests if base == DESTS else self.rules if base == RULES else None
        if data is None:
            raise AssertionError('Unexpected simulated endpoint')
        p = int(dict(pair.split('=', 1) for pair in query.split('&'))['page'])
        per_page = 2
        info = {'page': p, 'per_page': per_page, 'total_count': len(data),
                'total_pages': (len(data) + per_page - 1) // per_page}
        if self.bad_page:
            info.pop('total_count')
        return {'result': copy.deepcopy(data[(p - 1) * per_page:p * per_page]), 'result_info': info}


class Guards(unittest.TestCase):
    def setUp(self):
        self.cf = Provider()

    def verify(self):
        return q.run(self.cf, 'verify-only', '', Z, A)

    def apply(self):
        return q.run(self.cf, 'apply', q.APPROVAL, Z, A)

    def refuse_apply(self, message):
        with self.assertRaisesRegex(q.Blocked, message):
            self.apply()
        self.assertEqual(self.cf.writes, [])

    def test_verify_only_always_uses_only_reads(self):
        self.assertIn('no change', self.verify())
        self.assertEqual(self.cf.writes, [])

    def test_mock_apply_posts_exact_forward_once_and_repeated_runs_idempotent(self):
        self.assertIn('delivery was not tested', self.apply())
        self.assertEqual(self.cf.writes, [(RULES, 'POST', q.RULE)])
        self.assertIn('Already configured', self.apply())
        self.assertEqual(len(self.cf.writes), 1)
        self.assertIn((RULES + '/' + R, 'GET', None), self.cf.calls)

    def test_bad_confirmation_no_provider_reads(self):
        with self.assertRaisesRegex(q.Blocked, 'exact confirmation'):
            q.run(self.cf, 'apply', q.APPROVAL + '+alias', Z, A)
        self.assertEqual(self.cf.calls, [])

    def test_verified_destination_requires_real_timestamp_and_exact_single_address(self):
        self.cf.dests[0]['verified'] = None
        self.refuse_apply('not uniquely already verified')
        self.cf.dests[0]['email'] = q.DESTINATION.replace('@', '+qa@')
        self.refuse_apply('not uniquely already verified')

    def test_optional_zone_discovery_only_accepts_unique_exact_active_owned_zone(self):
        self.assertEqual(q.select_zone(self.cf, '', A), Z)
        self.assertIn(('/zones?name=15minutes-email.com&page=1&per_page=50', 'GET', None), self.cf.calls)
        self.cf.zones += [{**self.cf.zone, 'id': 'e' * 32}]
        with self.assertRaisesRegex(q.Blocked, 'Unique exact active zone'):
            q.select_zone(self.cf, '', A)
        self.assertEqual(q.select_zone(self.cf, Z, A), Z)
        self.assertFalse(self.cf.writes)

    def test_zone_owner_and_routing_settings_refuse_mismatch(self):

        self.cf.zone['account']['id'] = Z
        self.refuse_apply('zone/account')
        self.cf.zone['account']['id'] = A
        self.cf.settings['status'] = 'misconfigured'
        self.refuse_apply('not enabled and ready')

    def test_second_page_conflict_and_duplicate_match_are_not_written(self):
        unrelated = lambda i: {'id': f'{i:032x}', 'matchers': [
            {'type': 'literal', 'field': 'to', 'value': f'other{i}@{q.DOMAIN}'}]}
        self.cf.rules = [unrelated(1), unrelated(2), {**q.RULE, 'id': R, 'enabled': False}]
        self.refuse_apply('rule conflicts')
        self.assertIn((RULES + '?page=2&per_page=50', 'GET', None), self.cf.calls)
        self.cf.rules[-1] = {**q.RULE, 'id': R}
        self.cf.rules.append({**q.RULE, 'id': 'e' * 32})
        self.refuse_apply('Duplicate exact-address')

    def test_plus_address_and_broad_rule_are_not_overridden(self):
        self.cf.rules = [{'id': R, 'matchers': [
            {'type': 'literal', 'field': 'to', 'value': 'PrimeCare-QA+old@15minutes-email.com'}]}]
        self.refuse_apply('plus-address')
        self.cf.rules[0]['matchers'] = [{'type': 'all'}]
        self.refuse_apply('Broad routing rule ordering')

    def test_active_catchall_worker_is_blocked_drop_is_safe(self):
        self.cf.catch_all = {'enabled': True, 'actions': [{'type': 'worker', 'value': ['existing-worker']}]}
        self.refuse_apply('Active catch-all')
        self.cf.catch_all['actions'] = [{'type': 'drop'}]
        self.assertIn('no change', self.verify())

    def test_incomplete_pagination_stops_no_mutation(self):
        self.cf.bad_page = True
        self.refuse_apply('count changed')

    def test_uncertain_create_or_readback_never_retries_and_no_provider_body(self):
        self.cf.post_fail = True
        with self.assertRaisesRegex(q.Blocked, 'do not retry blindly') as ctx:
            self.apply()
        self.assertNotIn('secret', str(ctx.exception))
        self.assertEqual(len(self.cf.writes), 1)
        self.cf.post_fail = False
        self.cf.unreadable = True
        with self.assertRaisesRegex(q.Blocked, 'do not retry blindly'):
            self.apply()
        self.assertEqual(len(self.cf.writes), 2)

    def test_transport_only_allows_exact_single_post_even_when_write_enabled(self):
        client = q.Client('not-a-real-secret', RULES, writes=True)
        client.opener = Mock()
        for path, method, body in ((RULES, 'PUT', q.RULE), (DESTS, 'POST', q.RULE),
                                   (RULES, 'POST', {'enabled': True})):
            with self.assertRaisesRegex(q.Blocked, 'mutation refused'):
                client(path, method, body)
        client.opener.open.assert_not_called()

    def test_secret_fallback_opt_in_and_dedicated_takes_precedence(self):
        env = {'GITHUB_ACTIONS':'true','GITHUB_REPOSITORY':'shaikhrais/primecare-platform',
               'GITHUB_REF':'refs/heads/main','GITHUB_EVENT_NAME':'workflow_dispatch',
               'QA_EMAIL_MODE':'verify-only','CLOUDFLARE_API_TOKEN':'synthetic-fallback',
               'QA_EMAIL_ZONE_ID':Z,'CLOUDFLARE_ACCOUNT_ID':A}
        with patch.object(q, 'run', return_value='offline') as run, patch.object(q, 'Client') as client, patch('builtins.print'):
            self.assertEqual(q.main(env), 1)
            client.assert_not_called()
            env['QA_EMAIL_ALLOW_API_FALLBACK'] = 'true'
            self.assertEqual(q.main(env), 0)
            self.assertEqual(client.call_args.args[0], 'synthetic-fallback')
            env['CLOUDFLARE_EMAIL_ROUTING_TOKEN'] = 'synthetic-dedicated'
            self.assertEqual(q.main(env), 0)
            self.assertEqual(client.call_args.args[0], 'synthetic-dedicated')
            self.assertEqual(run.call_count, 2)


if __name__ == '__main__':
    unittest.main()
