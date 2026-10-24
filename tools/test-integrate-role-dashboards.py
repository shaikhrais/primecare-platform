import importlib.util
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('dashboard_integration', Path(__file__).with_name('integrate-role-dashboards.py'))
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


class Integration(unittest.TestCase):
    screen = {'id': 1, 'code': 'fixture_dashboard', 'route': '/fixture/dashboard', 'renderer': 'dashboard'}
    source = """// Generated directly from SQLite Database
class FixtureDashboard extends GovernedConsumerWidget {
// GOV: GOVERNANCE SPECIFICATIONS & ALL API ENDPOINTS
// '100% READY' 'status': 'success'
void render() { onPressed: () {}; }
}
"""

    def test_only_known_placeholder_is_eligible(self):
        self.assertEqual(module.classify(self.screen, self.source), ('template', 'FixtureDashboard'))
        for source in ['class FixtureDashboard extends RealWorkflow {}', self.source + '\nonPressed: save', None]:
            self.assertNotEqual(module.classify(self.screen, source)[0], 'template')

    def test_external_provider_reference_prevents_replacement(self):
        plan = module.make_plan({'screens': [self.screen]}, {'fixture_dashboard': self.source}, {'fixture_dashboard'})
        self.assertEqual(plan[0]['status'], 'referenced-provider')

    def test_existing_inherited_entry_must_match_registered_route(self):
        source = module.wrapper(self.screen, 'FixtureDashboard')
        self.assertEqual(module.classify(self.screen, source)[0], 'shared')
        self.assertEqual(module.classify({**self.screen, 'route': '/other'}, source)[0], 'preserved')
        self.assertNotIn('FutureProvider', source)
        self.assertNotIn('success', source)

    def test_non_dashboards_and_duplicate_identities(self):
        self.assertEqual(module.make_plan({'screens': [{**self.screen, 'renderer': 'workflow'}]}, {}), [])
        with self.assertRaisesRegex(ValueError, 'Duplicate'):
            module.make_plan({'screens': [self.screen, self.screen]}, {})

    def test_registered_identity_cannot_inject_dart(self):
        for field, value in [('code', '../bad'), ('route', "/x');bad()")]:
            with self.assertRaises(ValueError):
                module.wrapper({**self.screen, field: value}, 'FixtureDashboard')


if __name__ == '__main__':
    unittest.main()
