import importlib.util
import tempfile
import unittest
from pathlib import Path

SCRIPT = Path(__file__).resolve().parents[1] / 'check_screen_inheritance.py'
spec = importlib.util.spec_from_file_location('screen_scan', SCRIPT)
scan = importlib.util.module_from_spec(spec)
spec.loader.exec_module(scan)


class ScreenScanTest(unittest.TestCase):
    def test_finds_direct_candidates_with_file_class_and_parent(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            path = root / 'apps/example/lib/pages/example.dart'
            path.parent.mkdir(parents=True)
            path.write_text('class BookingScreen extends ConsumerWidget {}\n'
                            'class LoginView extends StatefulWidget {}\n'
                            'class ManagedScreen extends GovernedConsumerWidget {}\n'
                            'class Button extends StatelessWidget {}\n')
            self.assertEqual(scan.scan(root), [
                {'file': 'apps/example/lib/pages/example.dart', 'class': 'BookingScreen', 'base': 'ConsumerWidget'},
                {'file': 'apps/example/lib/pages/example.dart', 'class': 'LoginView', 'base': 'StatefulWidget'},
            ])


if __name__ == '__main__':
    unittest.main()
