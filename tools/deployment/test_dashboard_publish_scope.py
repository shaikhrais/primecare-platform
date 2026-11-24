import unittest
import contextlib
import io
import json
import sys
from unittest.mock import patch
from . import dashboard_publish_scope as scope
from .dashboard_publish_scope import GATE_PATHS, MARKER, PILOT_PATHS, allow_legacy

class DashboardPublishScopeTest(unittest.TestCase):
    def test_guard_install_is_test_only(self):
        self.assertFalse(allow_legacy("push", GATE_PATHS))

    def test_clinical_api_push_cannot_trigger_legacy_publish(self):
        for paths in ({scope.CLINICAL_API_MARKER},
                      {scope.CLINICAL_API_MARKER, "cloudflare/workers/src/gateway.ts"},
                      {scope.CLINICAL_API_MARKER, scope.INTENT, "websites/typescript/src/workspace.ts"}):
            with self.subTest(paths=paths):
                self.assertFalse(allow_legacy("push", paths))

    def test_only_pilot_skips_unrelated_publish(self):
        self.assertFalse(allow_legacy("push", PILOT_PATHS))

    def test_theme_ci_repair_disables_only_exact_automatic_release_scope(self):
        paths = {
            "docs/appearance/theme-execution-ledger.json",
            "docs/appearance/theme-service-contract-triage.json",
            "packages/primecare_ui/catalogs/developer-catalogue.json",
            "packages/shared/src/guarded-json.ts",
            "scripts/test-work-modules-transport.mjs",
            "tools/governance-production/theme-source-revisions.json",
        }
        after = "3" * 40
        entries = [f"100644 blob {blob}\t{path}" for path, blob in scope.THEME_CI_REPAIR_BLOBS.items()]
        with patch.object(scope.subprocess, "check_output", return_value="\0".join(entries) + "\0") as git:
            self.assertFalse(allow_legacy("push", paths, after=after))
            git.assert_called_once_with(["git", "ls-tree", "-z", after, "--", *scope.THEME_CI_REPAIR_BLOBS], text=True)
        for wrong in (entries[:-1], [*entries[:-1], entries[-1].replace("100644", "100755", 1)],
                      [*entries[:-1], entries[-1].replace(next(reversed(scope.THEME_CI_REPAIR_BLOBS.values())), "f" * 40)]):
            with patch.object(scope.subprocess, "check_output", return_value="\0".join(wrong) + "\0"):
                self.assertTrue(allow_legacy("push", paths, after=after))
        with self.assertRaises(ValueError):
            allow_legacy("push", paths)
        for excluded in paths:
            with self.subTest(excluded=excluded):
                self.assertTrue(allow_legacy("push", paths - {excluded}))
        self.assertTrue(allow_legacy("push", paths | {"websites/typescript/src/workspace.ts"}))
        self.assertTrue(allow_legacy("workflow_dispatch", paths))

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

class CorporateOutputTest(unittest.TestCase):
    def test_cli_emits_only_output_assignment_despite_recursive_diagnostics(self):
        intent = json.dumps({"intent": "corporate-dashboard-cohort", "previous_live": "old"})
        out, err = io.StringIO(), io.StringIO()
        def noisy(*args):
            print("first approval diagnostic")
            print("recursive approval diagnostic")
        with patch("sys.argv", ["scope", "push", "before", "after"]), \
             patch.object(scope.subprocess, "check_output", return_value="after\n"), \
             patch.object(scope, "changed_paths", return_value={scope.INTENT}), \
             patch.object(scope.Path, "read_text", return_value=intent), \
             patch("tools.deployment.corporate_dashboard_release.preflight", side_effect=noisy), \
             contextlib.redirect_stdout(out), contextlib.redirect_stderr(err):
            scope.main()
        self.assertEqual(out.getvalue(), "allow_legacy_publish=false\n")
        self.assertIn("recursive approval diagnostic", err.getvalue())

    def test_failed_preflight_never_emits_approval(self):
        intent = json.dumps({"intent": "corporate-dashboard-cohort", "previous_live": "old"})
        out = io.StringIO()
        with patch("sys.argv", ["scope", "push", "before", "after"]), \
             patch.object(scope.subprocess, "check_output", return_value="after\n"), \
             patch.object(scope, "changed_paths", return_value={scope.INTENT}), \
             patch.object(scope.Path, "read_text", return_value=intent), \
             patch("tools.deployment.corporate_dashboard_release.preflight", side_effect=ValueError("rejected")), \
             contextlib.redirect_stdout(out), self.assertRaises(ValueError):
            scope.main()
        self.assertEqual(out.getvalue(), "")
