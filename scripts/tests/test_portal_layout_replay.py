"""The portal evolution receipt must preserve strict historical migration pins."""
import hashlib
import json
from pathlib import Path
import sys
import unittest
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'scripts'))
from reviewed_migration_history import before_portal_layout, before_complete_theme_settings, before_user_settings_isolation, before_fuse_center_match, before_navbar_style, before_shell_metrics, before_avatar_fallback, before_shell_border_frame, before_sidebar_default, before_sidebar_render, before_sidebar_slogan, before_sidebar_states, before_full_render_navigation_focus, before_navigation_theme_boundary, before_full_render_toolbar_actions, before_toolbar_shared_tokens, before_sidebar_account_footer, before_sidebar_account_style_boundary

class SidebarAccountStyleBoundaryReplayTest(unittest.TestCase):
    def test_exact_account_style_delta_rejects_drift(self):
        receipt=json.loads((ROOT/'scripts/sidebar-account-style-boundary-replay.json').read_text())
        self.assertEqual(len(receipt['files']),2)
        for row in receipt['files']:
            source=(ROOT/row['path']).read_text()
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            restored=before_sidebar_account_style_boundary(source,row['path'])
            self.assertEqual(hashlib.sha256(restored.encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_sidebar_account_style_boundary(source+'\n',row['path']),source+'\n')

class SidebarAccountFooterReplayTest(unittest.TestCase):
    def test_exact_account_footer_delta_rejects_drift(self):
        receipt=json.loads((ROOT/'scripts/sidebar-account-footer-replay.json').read_text())
        self.assertEqual(len(receipt['files']),3)
        for row in receipt['files']:
            source=before_sidebar_account_style_boundary((ROOT/row['path']).read_text(),row['path'])
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            restored=before_sidebar_account_footer(source,row['path'])
            self.assertEqual(hashlib.sha256(restored.encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_sidebar_account_footer(source+'\n',row['path']),source+'\n')

class ToolbarSharedTokensReplayTest(unittest.TestCase):
    def test_exact_shared_token_delta_rejects_drift(self):
        receipt=json.loads((ROOT/'scripts/toolbar-shared-tokens-replay.json').read_text())
        self.assertEqual(len(receipt['files']),2)
        for row in receipt['files']:
            source=before_sidebar_account_footer((ROOT/row['path']).read_text(),row['path'])
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            restored=before_toolbar_shared_tokens(source,row['path'])
            self.assertEqual(hashlib.sha256(restored.encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_toolbar_shared_tokens(source+'\n',row['path']),source+'\n')

class FullRenderToolbarActionsReplayTest(unittest.TestCase):
    def test_exact_toolbar_delta_rejects_drift(self):
        receipt=json.loads((ROOT/'scripts/full-render-toolbar-actions-replay.json').read_text())
        self.assertEqual(len(receipt['files']),4)
        for row in receipt['files']:
            source=before_toolbar_shared_tokens((ROOT/row['path']).read_text(),row['path'])
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            restored=before_full_render_toolbar_actions(source,row['path'])
            self.assertEqual(hashlib.sha256(restored.encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_full_render_toolbar_actions(source+'\n',row['path']),source+'\n')

class NavigationThemeBoundaryReplayTest(unittest.TestCase):
    def test_exact_theme_boundary_delta_rejects_drift(self):
        receipt=json.loads((ROOT/'scripts/navigation-theme-boundary-replay.json').read_text())
        self.assertEqual(len(receipt['files']),2)
        for row in receipt['files']:
            current=(ROOT/row['path']).read_text()
            source=before_full_render_toolbar_actions(current,row['path'])
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            restored=before_navigation_theme_boundary(current,row['path'])
            self.assertEqual(hashlib.sha256(restored.encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_navigation_theme_boundary(source+'\n',row['path']),source+'\n')

class FullRenderNavigationFocusReplayTest(unittest.TestCase):
    def test_exact_full_render_navigation_delta_rejects_drift(self):
        receipt=json.loads((ROOT/'scripts/full-render-navigation-focus-replay.json').read_text())
        self.assertEqual(len(receipt['files']),5)
        for row in receipt['files']:
            source=before_navigation_theme_boundary((ROOT/row['path']).read_text(),row['path'])
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            restored=before_full_render_navigation_focus(source,row['path'])
            self.assertEqual(hashlib.sha256(restored.encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_full_render_navigation_focus(source+'\n',row['path']),source+'\n')

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
            source=before_sidebar_slogan((ROOT/row['path']).read_text(),row['path'])
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            self.assertEqual(hashlib.sha256(before_sidebar_render(source,row['path']).encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_sidebar_render(source+'\n',row['path']),source+'\n')

class SidebarSloganReplayTest(unittest.TestCase):
    def test_exact_slogan_delta_rejects_drift(self):
        receipt=json.loads((ROOT/'scripts/sidebar-slogan-replay.json').read_text())
        for row in receipt['files']:
            source=before_sidebar_states((ROOT/row['path']).read_text(),row['path'])
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            self.assertEqual(hashlib.sha256(before_sidebar_slogan(source,row['path']).encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_sidebar_slogan(source+'\n',row['path']),source+'\n')

class SidebarStatesReplayTest(unittest.TestCase):
    def test_exact_state_delta_rejects_drift(self):
        receipt=json.loads((ROOT/'scripts/sidebar-states-replay.json').read_text())
        for row in receipt['files']:
            from reviewed_migration_history import before_shared_navigation_render
            source=before_shared_navigation_render((ROOT/row['path']).read_text(),row['path'])
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            self.assertEqual(hashlib.sha256(before_sidebar_states(source,row['path']).encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_sidebar_states(source+'\n',row['path']),source+'\n')

class SharedNavigationRenderReplayTest(unittest.TestCase):
    def test_exact_navigation_delta_rejects_drift(self):
        from reviewed_migration_history import before_shared_navigation_render
        receipt=json.loads((ROOT/'scripts/shared-navigation-render-replay.json').read_text())
        for row in receipt['files']:
            source=before_full_render_navigation_focus((ROOT/row['path']).read_text(),row['path'])
            self.assertEqual(hashlib.sha256(source.encode()).hexdigest(),row['afterSha256'])
            restored=before_shared_navigation_render(source,row['path'])
            self.assertEqual(hashlib.sha256(restored.encode()).hexdigest(),row['beforeSha256'])
            self.assertEqual(before_shared_navigation_render(source+'\n',row['path']),source+'\n')
