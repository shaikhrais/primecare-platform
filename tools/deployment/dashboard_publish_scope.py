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
MARKER = "websites/typescript/src/governance-officer-pilot.ts"
PILOT_PATHS = {MARKER, "websites/typescript/src/workspace.ts"}
CLINICAL_API_MARKER = "cloudflare/workers/src/clinical-dashboard.ts"


def allow_legacy(event, paths, before=None, after=None):
    if event == "workflow_dispatch":
        return True
    if event != "push" or not paths:
        raise ValueError("Cannot determine approved release scope")
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
