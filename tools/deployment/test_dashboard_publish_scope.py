import unittest
from .dashboard_publish_scope import GATE_PATHS, MARKER, PILOT_PATHS, allow_legacy

class DashboardPublishScopeTest(unittest.TestCase):
    def test_guard_install_is_test_only(self):
        self.assertFalse(allow_legacy("push", GATE_PATHS))

    def test_only_pilot_skips_unrelated_publish(self):
        self.assertFalse(allow_legacy("push", PILOT_PATHS))

    def test_unrelated_push_keeps_existing_behavior(self):
        self.assertTrue(allow_legacy("push", {"websites/typescript/src/workspace.ts"}))
        self.assertTrue(allow_legacy("push", {"cloudflare/workers/src/screen-text.ts"}))

    def test_mixed_pilot_fails_closed(self):
        with self.assertRaises(ValueError):
            allow_legacy("push", {MARKER, "cloudflare/workers/src/screen-text.ts"})

    def test_manual_publish_remains_available(self):
        self.assertTrue(allow_legacy("workflow_dispatch", set()))

    def test_missing_identity_does_not_publish(self):
        for event in ("push", "pull_request"):
            with self.assertRaises(ValueError):
                allow_legacy(event, set())
