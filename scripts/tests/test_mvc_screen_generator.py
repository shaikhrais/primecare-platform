import shutil
import subprocess
import tempfile
import unittest
from pathlib import Path

GENERATOR = Path(__file__).resolve().parents[2] / 'tools/mvc_generator/generate_screen.dart'


class MvcGeneratorTest(unittest.TestCase):
    @unittest.skipUnless(shutil.which('dart'), 'Dart SDK unavailable')
    def test_generated_view_registers_without_overwriting(self):
        with tempfile.TemporaryDirectory() as directory:
            result = subprocess.run(
                ['dart', str(GENERATOR), 'example', 'Booking', '/example/booking'], cwd=directory,
                capture_output=True, text=True, check=True,
            )
            view = Path(directory, 'apps/example/lib/features/booking/booking_view.dart').read_text()
            self.assertIn('class BookingView extends GovernedConsumerWidget', view)
            self.assertIn('Widget buildScreen(BuildContext context, WidgetRef ref)', view)
            self.assertIn('Registered presentation route /example/booking', result.stdout)
            catalog = Path(directory, 'packages/primecare_ui/lib/src/features/auth/generated_managed_routes.g.dart')
            self.assertIn("  '/example/booking',", catalog.read_text())
            retry = subprocess.run(
                ['dart', str(GENERATOR), 'example', 'Booking', '/example/booking'], cwd=directory,
                capture_output=True, text=True,
            )
            self.assertNotEqual(retry.returncode, 0)
            self.assertEqual(catalog.read_text().count("  '/example/booking',"), 1)
            self.assertEqual(view, Path(directory, 'apps/example/lib/features/booking/booking_view.dart').read_text())
            conflict = subprocess.run(
                ['dart', str(GENERATOR), 'example', 'Booking', '/example/other'], cwd=directory,
                capture_output=True, text=True,
            )
            self.assertNotEqual(conflict.returncode, 0)
            self.assertNotIn('/example/other', catalog.read_text())
            subprocess.run(['dart', str(GENERATOR), 'example', 'Reports', '/example/reports'],
                           cwd=directory, capture_output=True, text=True, check=True)
            self.assertIn("  '/example/booking',", catalog.read_text())
            self.assertIn("  '/example/reports',", catalog.read_text())
            subprocess.run(['dart', str(GENERATOR), 'example', 'Details', '/example/:bookingId'],
                           cwd=directory, capture_output=True, text=True, check=True)
            self.assertIn("  '/example/:bookingId',", catalog.read_text())

    @unittest.skipUnless(shutil.which('dart') and shutil.which('flutter'), 'Flutter SDK unavailable')
    def test_generated_files_analyze_with_shared_packages(self):
        with tempfile.TemporaryDirectory() as directory:
            subprocess.run(['dart', str(GENERATOR), 'example', 'Booking'], cwd=directory,
                           capture_output=True, text=True, check=True)
            ui_package = GENERATOR.parents[2] / 'packages/primecare_ui'
            Path(directory, 'pubspec.yaml').write_text(
                "name: generated_fixture\n"
                "environment:\n  sdk: ^3.11.3\n"
                "dependencies:\n"
                "  flutter:\n    sdk: flutter\n"
                f"  primecare_ui:\n    path: {ui_package}\n"
                "  flutter_riverpod: ^3.3.1\n"
                "  easy_localization: ^3.0.8\n"
            )
            resolve = subprocess.run(['flutter', 'pub', 'get'], cwd=directory,
                                     capture_output=True, text=True)
            self.assertEqual(resolve.returncode, 0, resolve.stdout + resolve.stderr)
            analysis = subprocess.run(
                ['flutter', 'analyze', '--no-fatal-infos', 'apps/example/lib/features/booking'],
                cwd=directory, capture_output=True, text=True,
            )
            self.assertEqual(analysis.returncode, 0, analysis.stdout + analysis.stderr)


if __name__ == '__main__':
    unittest.main()
