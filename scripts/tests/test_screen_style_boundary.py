"""Tests executed by the shared UI boundary workflow in GitHub Actions."""
from importlib.machinery import SourceFileLoader
import importlib.util
from pathlib import Path
import unittest

loader = SourceFileLoader(
    'screen_style_boundary', str(Path(__file__).resolve().parents[1] / 'check-screen-style-boundary.py'))
spec = importlib.util.spec_from_loader(loader.name, loader)
guard = importlib.util.module_from_spec(spec)
loader.exec_module(guard)

DART = 'apps/primecare_corporate/lib/features/coo/screens/dashboard.dart'
SHARED_SCREEN = 'packages/primecare_ui/lib/src/screens/executive/dashboard.dart'
WEB = 'websites/typescript/src/leadership/dashboard.ts'
CSS = 'websites/typescript/src/leadership/independent.css'


class ScreenStyleBoundaryTest(unittest.TestCase):
    def test_rejects_appearance_constructors_and_font_override(self):
        found = guard.regressions(DART, '', '''
          final s = ui.TextStyle(fontFamily: 'Family', fontSize: 12);
          final i = TextStyle.new;
          final c = BoxDecoration(borderRadius: BorderRadius.circular(4));
          final d = Theme(data: ThemeData(), child: child);
          final t = typedef SomeStyle = ui.TextStyle;
        ''')
        self.assertEqual({x[1] for x in found}, {
            'local-style-constructor', 'local-font-override',
            'local-design-dimension', 'local-theme-alias',
        })

    def test_allows_shared_widgets_tokens_theme_read_and_literals_in_comments(self):
        source = '''
          // TextStyle(fontFamily: 'Family')
          const x = 'GoogleFonts.jost()';
          final theme = Theme.of(context);
          final base = ColorScheme.of(context);
          return PrimeText(title, style: context.tokens.typography.heading);
        '''
        self.assertFalse(guard.regressions(DART, '', source))

    def test_checks_interpolation_aliases_and_token_mutation(self):
        source = '''
          final String test = "${TextTheme()}";
          final s = ButtonStyle();
          final c = theme.colorScheme.surface.withOpacity(.5);
        '''
        found = guard.regressions(SHARED_SCREEN, '', source)
        self.assertEqual([x[1] for x in found],
                         ['local-style-constructor', 'local-style-constructor', 'local-style-composition'])

    def test_allowed_legacy_is_counted_and_does_not_follow_files(self):
        old = 'final s = TextStyle(fontSize: 10);\n'
        self.assertFalse(guard.regressions(DART, old, '\n\n'+old))
        self.assertTrue(guard.regressions(DART, old, old+old))
        self.assertTrue(guard.regressions(DART, '', old))
        self.assertFalse(guard.regressions(DART, old, ''))

    def test_multiline_font_change_is_not_grandfathered(self):
        old = "final style = TextStyle(\nfontFamily:\n  'Former',\n);\n"
        new = old.replace("'Former'", "'Replacement'")
        self.assertTrue(guard.regressions(DART, old, new))

    def test_rejects_web_inline_dynamic_and_stylesheets(self):
        source = """
          const html = `<style>.a{color:red}</style><div style="color:red"></div>`;
          el.style.fontFamily = 'Individual';
          el.style.setProperty('--skin', next);
          el.setAttribute('style', declaration);
          document.createElement('style');
          const chart = `<svg><path fill="#fff" stroke="currentColor"></svg>`;
        """
        found = [x[1] for x in guard.regressions(WEB, '', source)]
        self.assertEqual(set(found), {'screen-html-style', 'screen-dom-style',
                                     'screen-created-style', 'screen-svg-color'})
        self.assertEqual(found.count('screen-svg-color'), 1)
        self.assertTrue(guard.regressions(CSS, '', '.local { color: red; }'))
        self.assertFalse(guard.regressions('websites/typescript/src/styles.css', '', ':root{--core:blue}'))

    def test_exact_registration_must_be_connected_and_uncommented(self):
        workspace = """const workspaceScreenRegistrations = <String>{
  '/corporate/actual',
  // '/corporate/commented',
  '/corporate/actual-child',
};
"""
        catalog = """final m = ScreenManager([
  ManagedScreenRegistration(id: '/standalone'),
  // ManagedScreenRegistration(id: '/standalone-comment'),
]).withAdditionalRoutes(workspaceScreenRegistrations);"""
        self.assertEqual(guard.registered_literals(workspace, catalog),
                         {'/corporate/actual', '/corporate/actual-child', '/standalone'})
        self.assertEqual(guard.registered_literals(workspace, catalog.split('.withAdditionalRoutes')[0]),
                         {'/standalone'})

    def test_current_all_eighteen_primary_routes_are_registered(self):
        workspace = (guard.ROOT / guard.WORKSPACE).read_text()
        catalog = (guard.ROOT / guard.CATALOG).read_text()
        routes = set(guard.LEADERSHIP_LANDINGS.values())
        self.assertEqual(len(routes), 18)
        self.assertEqual(routes - guard.registered_literals(workspace, catalog), set())


if __name__ == '__main__':
    unittest.main()
