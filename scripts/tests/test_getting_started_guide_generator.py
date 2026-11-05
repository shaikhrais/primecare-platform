import json
import shutil
import subprocess
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
FILES = (
    'scripts/generate-getting-started-guide.mjs',
    'packages/shared/src/getting-started-guide.json',
    'packages/shared/src/getting-started-guide-i18n.json',
    'packages/primecare_ui/lib/src/features/training/getting_started_catalog.g.dart',
)


class GuideGeneratorTest(unittest.TestCase):
    @unittest.skipUnless(shutil.which('node'), 'Node.js is required')
    def test_generator_check_and_incomplete_translation_failure(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            for name in FILES:
                destination = root / name
                destination.parent.mkdir(parents=True, exist_ok=True)
                shutil.copyfile(ROOT / name, destination)
            command = ['node', 'scripts/generate-getting-started-guide.mjs']
            self.assertEqual(subprocess.run(command + ['--check'], cwd=root, capture_output=True).returncode, 0)
            target = root / FILES[-1]
            target.write_text('stale', encoding='utf-8')
            self.assertNotEqual(subprocess.run(command + ['--check'], cwd=root, capture_output=True).returncode, 0)
            self.assertEqual(subprocess.run(command, cwd=root, capture_output=True).returncode, 0)
            translations = root / FILES[2]
            data = json.loads(translations.read_text(encoding='utf-8'))
            data['fr'][0]['body'] = ''
            translations.write_text(json.dumps(data), encoding='utf-8')
            failure = subprocess.run(command, cwd=root, capture_output=True, text=True)
            self.assertNotEqual(failure.returncode, 0)
            self.assertIn('Invalid fr lesson 1', failure.stderr)


if __name__ == '__main__':
    unittest.main()
