import shutil
import subprocess
import tempfile
import unittest
from pathlib import Path

GENERATOR = Path(__file__).resolve().parents[2] / 'tools/mvc_generator/generate_screen.dart'


class MvcGeneratorTest(unittest.TestCase):
    @unittest.skipUnless(shutil.which('dart'), 'Dart SDK unavailable')
    def test_generated_view_uses_governed_base_and_requests_registration(self):
        with tempfile.TemporaryDirectory() as directory:
            result = subprocess.run(
                ['dart', str(GENERATOR), 'example', 'Booking'], cwd=directory,
                capture_output=True, text=True, check=True,
            )
            view = Path(directory, 'apps/example/lib/features/booking/booking_view.dart').read_text()
            self.assertIn('class BookingView extends GovernedConsumerWidget', view)
            self.assertIn('Widget buildScreen(BuildContext context, WidgetRef ref)', view)
            self.assertIn('Register the route', result.stdout)


if __name__ == '__main__':
    unittest.main()
