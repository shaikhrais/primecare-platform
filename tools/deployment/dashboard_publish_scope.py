"""Controls automatic production writers for the selected dashboard release lanes."""
import argparse
from contextlib import redirect_stdout
import sys
import subprocess
import json
from pathlib import Path

from .dashboard_release_intent import INFRA_MARKER, INTENT, RUNTIME_PATHS, changed_paths, classify

GATE_PATHS = {
    ".github/workflows/release-screen-text.yml",
    ".github/workflows/account-sessions-production-registration.yml",
    ".github/workflows/internal-calls-production.yml",
    ".github/workflows/code-admin-look.yml",
    ".github/workflows/governance-pilot-publish-scope.yml",
    "tools/deployment/dashboard_publish_scope.py",
    "tools/deployment/test_dashboard_publish_scope.py",
}
THEME_CI_REPAIR_BLOBS = {
    "docs/appearance/theme-execution-ledger.json": "d2c792927dabd348487ce5f37bf0026fdb96c029",
    "docs/appearance/theme-service-contract-triage.json": "b8a1179673a93ef063349c5b8e9f368f4172847d",
    "packages/primecare_ui/catalogs/developer-catalogue.json": "75a10656e788c8d63b1972a1238bfc0de805c435",
    "packages/shared/src/guarded-json.ts": "43a2e4c041eccec0a31011b7dc1cdda7d1e3353d",
    "scripts/test-work-modules-transport.mjs": "959f8bdc0b40526a4b459297bdeb26a66e42b8c0",
    "tools/governance-production/theme-source-revisions.json": "d9cb552b248eb75861333ad351191d1ce51785dc",
}
MARKER = "websites/typescript/src/governance-officer-pilot.ts"
PILOT_PATHS = {MARKER, "websites/typescript/src/workspace.ts"}
CLINICAL_API_MARKER = "cloudflare/workers/src/clinical-dashboard.ts"


def matches_theme_ci_repair(after):
    if not after:
        raise ValueError("Theme repair scope must bind the exact after commit")
    entries = subprocess.check_output(
        ["git", "ls-tree", "-z", after, "--", *THEME_CI_REPAIR_BLOBS],
        text=True,
    )
    expected = {f"100644 blob {blob}\t{path}" for path, blob in THEME_CI_REPAIR_BLOBS.items()}
    return set(entries.split("\0")[:-1]) == expected


def allow_legacy(event, paths, before=None, after=None):
    if event == "workflow_dispatch":
        return True
    if event != "push" or not paths:
        raise ValueError("Cannot determine approved release scope")
    # Only the complete reviewed repair cohort is a checks-only push. Do not
    # reclassify an arbitrary subset or a mixed change as this repair.
    if paths == THEME_CI_REPAIR_BLOBS.keys() and matches_theme_ci_repair(after):
        return False
    # This API-only release uses separate verification and promotion.
    # A mixed push cannot re-enable a legacy dashboard production writer.
    if CLINICAL_API_MARKER in paths:
        return False
    if INFRA_MARKER in paths or INTENT in paths:
        raw_intent = json.loads(Path(INTENT).read_text()) if INTENT in paths else None
        if isinstance(raw_intent, dict) and raw_intent.get("intent") == "clinic-psw-safety-maintenance":
            if after is None:
                raise ValueError("PSW push must bind the exact checkout SHA")
            from .psw_dashboard_release import preflight, PROJECT
            with redirect_stdout(sys.stderr):
                preflight(before, after, PROJECT, raw_intent["previous_live"])
            return False
        if isinstance(raw_intent, dict) and raw_intent.get("intent") == "client-dashboard-cohort":
            if after is None:
                raise ValueError("Client push must bind the exact checkout SHA")
            from .client_dashboard_release import preflight, PROJECT
            preflight(before, after, PROJECT, raw_intent["previous_live"])
            return False
        if isinstance(raw_intent, dict) and raw_intent.get("intent") == "clinic-dashboard-cohort":
            if after is None:
                raise ValueError("Clinic push must bind the exact checkout SHA")
            from .clinic_dashboard_release import preflight, PROJECT
            preflight(before, after, PROJECT, raw_intent["previous_live"])
            return False
        if isinstance(raw_intent, dict) and raw_intent.get("intent") == "corporate-dashboard-cohort":
            if after is None:
                raise ValueError("Corporate push must bind the exact checkout SHA")
            from .corporate_dashboard_release import preflight, PROJECT
            # Keep GitHub output machine-readable, including recursive diagnostics.
            with redirect_stdout(sys.stderr):
                preflight(before, after, PROJECT, raw_intent["previous_live"])
            return False
        runtime_paths = frozenset(RUNTIME_PATHS.read_text().splitlines())
        return classify(paths, runtime_paths, raw_intent, before) == "legacy"
    if paths <= GATE_PATHS:
        return False
    if MARKER in paths:
        if paths - PILOT_PATHS:
            raise ValueError("Pilot changes must be released separately")
        return False
    return True


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("event")
    parser.add_argument("before")
    parser.add_argument("after")
    args = parser.parse_args()
    paths = set()
    if args.event == "push":
        if subprocess.check_output(["git", "rev-parse", "HEAD"], text=True).strip() != args.after:
            raise ValueError("Checkout does not match the event SHA")
        paths = changed_paths(args.before, args.after)
    print("allow_legacy_publish=" + str(allow_legacy(args.event, paths, args.before, args.after)).lower())


if __name__ == "__main__":
    main()
