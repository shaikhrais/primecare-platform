"""The portal evolution receipt must preserve strict historical migration pins."""
import hashlib
import json
from pathlib import Path
import sys
import unittest
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'scripts'))
from reviewed_migration_history import before_portal_layout, before_complete_theme_settings

class PortalLayoutReplayTest(unittest.TestCase):
    def test_only_exact_reviewed_outputs_are_replayed(self):
        receipt = json.loads((ROOT / 'scripts/portal-layout-replay.json').read_text())
        self.assertEqual(len(receipt['files']), 2)
        for row in receipt['files']:
            current = before_complete_theme_settings((ROOT / row['path']).read_text(), row['path'])
            self.assertEqual(hashlib.sha256(current.encode()).hexdigest(), row['afterSha256'])
            original = before_portal_layout(current, row['path'])
            self.assertEqual(hashlib.sha256(original.encode()).hexdigest(), row['beforeSha256'])
            self.assertEqual(before_portal_layout(original, row['path']), original)
            self.assertEqual(before_portal_layout(current + '\n', row['path']), current + '\n')
            self.assertEqual(before_portal_layout(current, 'unregistered.dart'), current)

class CompleteThemeReplayTest(unittest.TestCase):
    def test_complete_settings_receipt_is_exact_and_rejects_drift(self):
        receipt=json.loads((ROOT/'scripts/theme-complete-replay.json').read_text())
        self.assertEqual(len(receipt['files']),3)
        for row in receipt['files']:
            source=(ROOT/row['path']).read_text()
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            original=before_complete_theme_settings(source,row['path'])
            self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_complete_theme_settings(source+'\n',row['path']),source+'\n')
