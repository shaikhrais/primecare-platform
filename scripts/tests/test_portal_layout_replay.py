"""The portal evolution receipt must preserve strict historical migration pins."""
import hashlib
import json
from pathlib import Path
import sys
import unittest
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'scripts'))
from reviewed_migration_history import before_portal_layout, before_complete_theme_settings, before_user_settings_isolation, before_fuse_center_match, before_navbar_style, before_shell_metrics, before_avatar_fallback, before_shell_border_frame, before_sidebar_default, before_sidebar_render

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
            source=before_user_settings_isolation((ROOT/row['path']).read_text(),row['path'])
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            original=before_complete_theme_settings(source,row['path'])
            self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_complete_theme_settings(source+'\n',row['path']),source+'\n')

class UserSettingsIsolationReplayTest(unittest.TestCase):
    def test_user_settings_receipt_is_exact(self):
        receipt=json.loads((ROOT/'scripts/user-settings-isolation-replay.json').read_text())
        self.assertEqual(len(receipt['files']),2)
        for row in receipt['files']:
            source=before_fuse_center_match((ROOT/row['path']).read_text(),row['path'])
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            before=before_user_settings_isolation(source,row['path'])
            self.assertEqual(hashlib.sha256(before.encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_user_settings_isolation(source+'\n',row['path']),source+'\n')

class FuseCenterMatchReplayTest(unittest.TestCase):
    def test_reference_rebuild_receipt_is_exact(self):
        receipt=json.loads((ROOT/'scripts/fuse-center-match-replay.json').read_text())
        self.assertEqual(len(receipt['files']),3)
        for row in receipt['files']:
            source=before_navbar_style((ROOT/row['path']).read_text(),row['path'])
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            before=before_fuse_center_match(source,row['path'])
            self.assertEqual(hashlib.sha256(before.encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_fuse_center_match(source+'\n',row['path']),source+'\n')


class ThemePaletteMatchReplayTest(unittest.TestCase):
    def test_only_exact_palette_bridge_changes_are_replayed(self):
        from reviewed_migration_history import before_theme_palette_match
        receipt=json.loads((ROOT/'scripts/theme-palette-match-replay.json').read_text())
        self.assertEqual(len(receipt['files']),1)
        for row in receipt['files']:
            source=before_navbar_style((ROOT/row['path']).read_text(),row['path'])
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            before=before_theme_palette_match(source,row['path'])
            self.assertEqual(hashlib.sha256(before.encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_theme_palette_match(source+'\n',row['path']),source+'\n')

class NavbarStyleReplayTest(unittest.TestCase):
    def test_exact_change_reverses_and_rejects_drift(self):
        receipt=json.loads((ROOT/'scripts/navbar-style-replay.json').read_text())
        self.assertEqual(len(receipt['files']),3)
        for row in receipt['files']:
            source=before_shell_metrics((ROOT/row['path']).read_text(),row['path'])
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            before=before_navbar_style(source,row['path'])
            self.assertEqual(hashlib.sha256(before.encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_navbar_style(source+'\n',row['path']),source+'\n')
            self.assertEqual(before_navbar_style(source,'unregistered.dart'),source)

class SkeletonShellMetricsReplayTest(unittest.TestCase):
    def test_exact_shell_delta_and_rejects_drift(self):
        receipt=json.loads((ROOT/'scripts/skeleton-shell-metrics-replay.json').read_text())
        self.assertEqual(len(receipt['files']),1)
        for row in receipt['files']:
            source=before_avatar_fallback((ROOT/row['path']).read_text(),row['path'])
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            before=before_shell_metrics(source,row['path'])
            self.assertEqual(hashlib.sha256(before.encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_shell_metrics(source+'\n',row['path']),source+'\n')
            self.assertEqual(before_shell_metrics(source,'unregistered.dart'),source)

class AvatarFallbackReplayTest(unittest.TestCase):
    def test_exact_fallback_delta_rejects_drift(self):
        receipt=json.loads((ROOT/'scripts/shell-avatar-fallback-replay.json').read_text())
        for row in receipt['files']:
            source=before_shell_border_frame((ROOT/row['path']).read_text(),row['path'])
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            self.assertEqual(hashlib.sha256(before_avatar_fallback(source,row['path']).encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_avatar_fallback(source+'\n',row['path']),source+'\n')

class ShellBorderFrameReplayTest(unittest.TestCase):
    def test_exact_border_delta_rejects_drift(self):
        receipt=json.loads((ROOT/'scripts/shell-breakpoint-border-replay.json').read_text())
        for row in receipt['files']:
            source=before_sidebar_default((ROOT/row['path']).read_text(),row['path'])
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            self.assertEqual(hashlib.sha256(before_shell_border_frame(source,row['path']).encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_shell_border_frame(source+'\n',row['path']),source+'\n')

class SidebarDefaultReplayTest(unittest.TestCase):
    def test_exact_default_delta_rejects_drift(self):
        receipt=json.loads((ROOT/'scripts/shell-sidebar-default-replay.json').read_text())
        for row in receipt['files']:
            source=before_sidebar_render((ROOT/row['path']).read_text(),row['path'])
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            self.assertEqual(hashlib.sha256(before_sidebar_default(source,row['path']).encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_sidebar_default(source+'\n',row['path']),source+'\n')

class SidebarRenderReplayTest(unittest.TestCase):
    def test_exact_sidebar_delta_rejects_drift(self):
        receipt=json.loads((ROOT/'scripts/sidebar-full-render-replay.json').read_text())
        for row in receipt['files']:
            source=(ROOT/row['path']).read_text()
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            self.assertEqual(hashlib.sha256(before_sidebar_render(source,row['path']).encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_sidebar_render(source+'\n',row['path']),source+'\n')
