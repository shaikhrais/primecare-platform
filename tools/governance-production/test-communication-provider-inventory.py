import json
import unittest
from communication_provider_inventory import inventory, summarize, SCRIPTS

class ProviderMetadata(unittest.TestCase):
    def test_values_and_unrelated_provider_data_never_reach_report(self):
        payload = {'success': True, 'result': {'secret': 'fixture-secret-value', 'bindings': [
            {'name': 'EMAIL', 'type': 'send_email', 'destination_address': 'private-address'},
            {'name': 'DB_URL', 'type': 'secret_text', 'text': 'fixture-secret-value'},
            {'name': 'CONFIG', 'type': 'json', 'json': {'secret': 'fixture-secret-value'}},
            {'name': 'PICTURES', 'type': 'r2_bucket', 'bucket_name': 'private-bucket'},
            {'name': 'MEDIA', 'type': 'service', 'service': 'owned-media'},
        ]}}
        report = summarize('owned', payload, 200)
        self.assertTrue(report['settingsRead']); self.assertTrue(report['nativeEmailBinding'])
        self.assertEqual(report['r2BindingNames'], ['PICTURES'])
        for hidden in ['fixture-secret-value', 'private-address', 'private-bucket']:
            self.assertNotIn(hidden, json.dumps(report))
    def test_only_known_workers_are_read_and_no_missing_credentials_probe(self):
        calls = []
        def fetch(path, token):
            calls.append(path); self.assertEqual(token, 'fixture-token'); return 403, {}
        self.assertEqual(inventory(None, None, fetch)['workers'], []); self.assertEqual(calls, [])
        report = inventory('fixture-account', 'fixture-token', fetch)
        self.assertEqual(len(calls), len(SCRIPTS)); self.assertTrue(all(p.endswith('/settings') for p in calls))
        self.assertFalse(report['writesAttempted']); self.assertFalse(report['readsMessages'])
        self.assertFalse(report['liveCommunicationVerified']); self.assertTrue(all(not w['settingsRead'] for w in report['workers']))
    def test_malformed_binding_metadata_cannot_create_readiness(self):
        for payload in [None, [], 'invalid', {}, {'success': False}, {'result': {'bindings': [None, {}, {'name': 'EMAIL'}]}}]:
            report = summarize('owned', payload, 200)
            self.assertFalse(report['nativeEmailBinding']); self.assertFalse(report['settingsRead'])

if __name__ == '__main__':
    unittest.main()
