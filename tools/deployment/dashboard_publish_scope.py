"""Controls automatic production writers for the selected dashboard release lanes."""
import argparse
import subprocess
import json
from pathlib import Path

from .dashboard_release_intent import INFRA_MARKER, INTENT, RUNTIME_PATHS, changed_paths, classify

GATE_PATHS = {
    ".github/workflows/release-screen-text.yml",
    ".github/workflows/code-admin-look.yml",
    ".github/workflows/governance-pilot-publish-scope.yml",
    "tools/deployment/dashboard_publish_scope.py",
    "tools/deployment/test_dashboard_publish_scope.py",
}
MARKER = "websites/typescript/src/governance-officer-pilot.ts"
PILOT_PATHS = {MARKER, "websites/typescript/src/workspace.ts"}


def allow_legacy(event, paths, before=None, after=None):
    if event == "workflow_dispatch":
        return True
    if event != "push" or not paths:
        raise ValueError("Cannot determine approved release scope")
    if INFRA_MARKER in paths or INTENT in paths:
        raw_intent = json.loads(Path(INTENT).read_text()) if INTENT in paths else None
        if isinstance(raw_intent, dict) and raw_intent.get("intent") == "corporate-dashboard-cohort":
            if after is None:
                raise ValueError("Corporate push must bind the exact checkout SHA")
            from .corporate_dashboard_release import preflight, PROJECT
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
