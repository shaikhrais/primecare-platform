import unittest
from export_governed_openapi import build


def endpoint(**overrides):
    row = dict(id=1, endpoint_code='LOGIN', route_path='/v1/auth/login', http_method='POST',
               auth_required=1, implementation_status='active', request_schema=None,
               response_schema=None, permission_key=None, rate_limit_key=None)
    return {**row, **overrides}


class ExportTests(unittest.TestCase):
    def test_missing_contract_is_blocked(self):
        spec, report = build([endpoint()])
        self.assertFalse(report['production_ready'])
        self.assertEqual(report['blocked_endpoints'], 1)
        self.assertIn('missing_permission_key', report['findings'][0]['gaps'])
        self.assertNotIn('security', spec['paths']['/v1/auth/login']['post'])

    def test_duplicate_not_silently_overwritten(self):
        spec, report = build([endpoint(), endpoint(id=2)])
        self.assertEqual(report['exported_operations'], 1)
        self.assertIn('duplicate_operation', report['findings'][1]['gaps'])

    def test_invalid_schema_and_route(self):
        spec, report = build([endpoint(route_path='bad', request_schema='broken')])
        self.assertEqual(spec['paths'], {})
        self.assertIn('invalid_request_schema', report['findings'][0]['gaps'])

    def test_no_secret_or_raw_schema_export(self):
        spec, report = build([endpoint(request_schema='{"example":"sensitive-sentinel"}')])
        self.assertNotIn('sensitive-sentinel', str(spec) + str(report))

    def test_empty_registry_never_passes(self):
        spec, report = build([])
        self.assertFalse(report['production_ready'])

    def test_each_operation_has_detailed_comments(self):
        spec, _ = build([endpoint()])
        operation = spec['paths']['/v1/auth/login']['post']
        for heading in ('Request contract', 'Response contract', 'Persistence and tenant isolation',
                        'Authentication and permissions', 'Required verification', 'Blocking findings'):
            self.assertIn(heading, operation['description'])
        self.assertEqual(operation['tags'], ['auth'])


if __name__ == '__main__':
    unittest.main()
