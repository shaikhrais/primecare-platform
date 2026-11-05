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


if __name__ == '__main__':
    unittest.main()
