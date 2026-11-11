import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from check_module_screen_registrations import check


class ModuleRegistrationCheckTest(unittest.TestCase):
    def test_simple_interpolation_and_local_class_shadowing(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            groups = root / 'packages/flutter_core/lib/routes/groups'
            groups.mkdir(parents=True)
            (groups / 'example.dart').write_text("class Routes { static const String path = '/global'; }")
            catalog = root / 'packages/primecare_ui/lib/src/screens/module_screen_registrations.dart'
            catalog.parent.mkdir(parents=True)
            catalog.write_text("const routes = <String>{\n  '/local',\n  '/generated/local',\n};\n")
            route_file = root / 'apps/sample/lib/routes.dart'
            route_file.parent.mkdir(parents=True)
            route_file.write_text("""class Routes { static const String path = '/local'; }
class Example {
  final a = PrimeCareScreen(route: Routes.path, builder: (_) => const LocalScreen());
  final b = PrimeCareScreen(route: '/generated${Routes.path}', builder: (_) => const GeneratedScreen());
}
""")
            self.assertEqual(check(root), (2, []))

    def test_missing_screen_and_dynamic_route_report_file_and_class(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            groups = root / 'packages/flutter_core/lib/routes/groups'
            groups.mkdir(parents=True)
            (groups / 'example.dart').write_text("class Routes { static const String missing = '/missing'; }")
            catalog = root / 'packages/primecare_ui/lib/src/screens/module_screen_registrations.dart'
            catalog.parent.mkdir(parents=True)
            catalog.write_text("const routes = <String>{\n  '/known',\n};\n")
            route_file = root / 'apps/sample/lib/routes.dart'
            route_file.parent.mkdir(parents=True)
            route_file.write_text("""class Example {
  final a = PrimeCareScreen(route: Routes.missing, builder: (_) => const MissingScreen());
  final b = PrimeCareScreen(route: runtimeRoute(), builder: (_) => const DynamicScreen());
}
""")
            count, issues = check(root)
            self.assertEqual(count, 2)
            self.assertEqual(len(issues), 2)
            self.assertIn('apps/sample/lib/routes.dart:2 MissingScreen: screen route /missing is not registered', issues)
            self.assertIn('apps/sample/lib/routes.dart:3 DynamicScreen: cannot resolve route runtimeRoute(); review manually', issues)


if __name__ == '__main__':
    unittest.main()
