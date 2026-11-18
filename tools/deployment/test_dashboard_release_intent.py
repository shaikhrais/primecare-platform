import unittest
from .dashboard_release_intent import INFRA, INTENT, REPAIR_BASE, REPAIR_INTENT, REPAIR_PATHS, classify

RUNTIME = frozenset({"one.ts", "two.ts"})
VALID = {"version": 1, "intent": "smart-dashboard-runtime"}


class DashboardReleaseIntentTests(unittest.TestCase):
    def test_unmarked_push_uses_legacy_ownership(self):
        self.assertEqual(classify({"unrelated.ts"}, RUNTIME, VALID), "legacy")

    def test_exact_infrastructure_install_blocks_legacy_writers(self):
        self.assertEqual(classify(INFRA, RUNTIME), "smart-dashboard-infra")

    def test_mixed_infrastructure_fails(self):
        with self.assertRaises(ValueError):
            classify(INFRA | {"scripts/deploy.py"}, RUNTIME)

    def test_exact_runtime_activation_blocks_legacy_writers(self):
        self.assertEqual(classify(RUNTIME | {INTENT}, RUNTIME, VALID), "smart-dashboard-runtime")

    def test_unrelated_path_cannot_hide_in_smart_rollout(self):
        with self.assertRaises(ValueError):
            classify(RUNTIME | {INTENT, "prod.sql"}, RUNTIME, VALID)

    def test_truncated_scope_cannot_hide_in_smart_rollout(self):
        with self.assertRaises(ValueError):
            classify({"one.ts", INTENT}, RUNTIME, VALID)

    def test_malformed_or_missing_intent_never_falls_back_to_legacy(self):
        for value in (None, {}, {**VALID, "version": True}, {**VALID, "extra": True}):
            with self.subTest(value=value), self.assertRaises(ValueError):
                classify(RUNTIME | {INTENT}, RUNTIME, value)

    def test_empty_diff_fails(self):
        with self.assertRaises(ValueError):
            classify(frozenset(), RUNTIME)

    def test_exact_activation_repair_remains_smart_only(self):
        self.assertEqual(classify(REPAIR_PATHS, RUNTIME, REPAIR_INTENT, REPAIR_BASE),
                         "smart-dashboard-runtime")

    def test_repair_rejects_wrong_parent_and_unrelated_files(self):
        for paths, before in [(REPAIR_PATHS, "a" * 40), (REPAIR_PATHS | {"prod.sql"}, REPAIR_BASE)]:
            with self.subTest(paths=paths, before=before), self.assertRaises(ValueError):
                classify(paths, RUNTIME, REPAIR_INTENT, before)
