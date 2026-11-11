import subprocess
import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]


class LegacyScreenGeneratorTest(unittest.TestCase):
    def test_legacy_generators_fail_before_creating_screens(self):
        for path in (
            'scripts/scaffold_30_empty_screens.py',
        ):
            with self.subTest(path=path):
                result = subprocess.run(
                    [sys.executable, str(ROOT / path)],
                    cwd=ROOT,
                    text=True,
                    capture_output=True,
                    check=False,
                )
                self.assertNotEqual(result.returncode, 0)
                self.assertIn('disabled', result.stderr)
                self.assertIn('generate_screen.dart', result.stderr)


if __name__ == '__main__':
    unittest.main()
