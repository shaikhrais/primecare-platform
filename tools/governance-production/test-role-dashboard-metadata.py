import runpy
import unittest
from pathlib import Path

verify = runpy.run_path(str(Path(__file__).with_name('verify-role-dashboard-metadata.py')))['verify_identities']


class Metadata(unittest.TestCase):
    def test_exact_id_code_and_route_without_readiness_claim(self):
        expected = [{'id': 1, 'code': 'fixture_dashboard', 'route': '/fixture'}]
        result = verify(expected, [(1, 'fixture_dashboard', '/fixture')])
        self.assertEqual(result['registeredIdentitiesVerified'], 1)
        self.assertFalse(result['writesAttempted'])
        self.assertFalse(result['domainWorkflowsVerified'])

    def test_missing_renamed_or_reassigned_metadata_aborts(self):
        expected = [{'id': 1, 'code': 'fixture_dashboard', 'route': '/fixture'}]
        for rows in [[], [(2, 'fixture_dashboard', '/fixture')], [(1, 'fixture_dashboard', '/other')],
                     [(1, 'fixture_dashboard', '/fixture'), (2, 'fixture_dashboard', '/fixture')]]:
            with self.assertRaises(ValueError):
                verify(expected, rows)


if __name__ == '__main__':
    unittest.main()
