import importlib.util
import tempfile
import unittest
from pathlib import Path

SCRIPT = Path(__file__).resolve().parents[1] / 'check_route_sites.py'
spec = importlib.util.spec_from_file_location('route_sites', SCRIPT)
scanner = importlib.util.module_from_spec(spec)
spec.loader.exec_module(scanner)


class RouteSitesTest(unittest.TestCase):
    def test_reports_source_and_screen_and_tracks_builder_changes(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            file = root / 'apps/example/lib/router.dart'
            file.parent.mkdir(parents=True)
            file.write_text("GoRoute(path: '/a', builder: (c, s) => const BookingScreen());\n")
            first = scanner.scan(root)
            self.assertEqual(first[0]['file'], 'apps/example/lib/router.dart')
            self.assertEqual(first[0]['line'], 1)
            self.assertEqual(first[0]['class'], 'BookingScreen')
            file.write_text("GoRoute(path: '/a', builder: (c, s) => const OtherScreen());\n")
            second = scanner.scan(root)
            self.assertEqual(second[0]['class'], 'OtherScreen')
            self.assertNotEqual(first[0]['digest'], second[0]['digest'])

    def test_parentheses_in_strings_do_not_end_call(self):
        text = "GoRoute(path: '/a', builder: (c,s) => Screen(label: 'x)y'));"
        self.assertEqual(text[scanner.end_of_call(text, text.index('(')):], ';')


if __name__ == '__main__':
    unittest.main()
