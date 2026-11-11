import unittest
import importlib.util
from pathlib import Path
from implement_screens_from_db import generate_custom_screen_widget

spec = importlib.util.spec_from_file_location('shared_boundary', Path(__file__).with_name('check-shared-ui-boundary.py'))
boundary = importlib.util.module_from_spec(spec)
spec.loader.exec_module(boundary)

class GeneratorSafetyTests(unittest.TestCase):
    def kwargs(self):
        return dict(sid=1, screen_code='test_dashboard', screen_name='TestDashboardScreen',
          app_name='Test', role_name='Test', app_code='test', role_code='test',
          route_path='/test', purpose='Test governed data', user_story='Review data', criteria='Real response',
          sections=[{'section_id':1,'section_name':'Data','section_type':'general','purpose':'Review data'}],
          elements=[{'section_id':1,'label':'Review','element_type':'button','test_id':'review'}],
          apis=[{'method':'GET','endpoint_path':'/v1/test'}])

    def test_incomplete_contract_does_not_invent_routes_or_sections(self):
        for key in ('sections','elements','apis'):
            with self.subTest(key=key):
                args=self.kwargs();args[key]=[]
                with self.assertRaises(ValueError):generate_custom_screen_widget(**args)

    def test_write_contract_is_not_silently_rewritten_as_get(self):
        args=self.kwargs();args['apis'][0]['method']='POST'
        with self.assertRaises(ValueError):generate_custom_screen_widget(**args)

    def test_generated_consumer_cannot_bypass_shared_controls_or_theme(self):
        dart = generate_custom_screen_widget(**self.kwargs())
        self.assertEqual(boundary.violations(dart, True), [])
        self.assertIn('ScreenScaffold(', dart)
        self.assertIn('PrimeText(', dart)
        self.assertIn('PrimeButton.secondary(', dart)
        self.assertIn('boxShadow: theme.shadowsSurface1', dart)

    def test_theme_runtime_fixture_matches_current_generator(self):
        args = self.kwargs()
        args.update(screen_code='theme_fixture', screen_name='ThemeFixtureScreen')
        fixture = Path(__file__).parents[1] / 'packages/primecare_ui/test/fixtures/generated_theme_fixture.dart'
        self.assertEqual(fixture.read_text(), generate_custom_screen_widget(**args))

    def test_template_preserves_failures_and_does_not_claim_verified(self):
        dart=generate_custom_screen_widget(**self.kwargs())
        self.assertIn('rethrow;',dart)
        self.assertIn('FormatException',dart)
        self.assertNotIn("'status': 'success'",dart)
        self.assertNotIn('100% READY',dart)
        self.assertNotIn('PASSED',dart)
        self.assertNotIn('onPressed: () {}',dart)
        self.assertIn('onPressed: null',dart)

if __name__=='__main__':unittest.main()
