"""Controls only automatic production writers during the Governance UI pilot."""
import argparse
import subprocess
import re

SHA = re.compile(r"[0-9a-f]{40}")
GATE_PATHS = {
    ".github/workflows/release-screen-text.yml",
    ".github/workflows/code-admin-look.yml",
    ".github/workflows/governance-pilot-publish-scope.yml",
    "tools/deployment/dashboard_publish_scope.py",
    "tools/deployment/test_dashboard_publish_scope.py",
}
MARKER = "websites/typescript/src/governance-officer-pilot.ts"
PILOT_PATHS = {MARKER, "websites/typescript/src/workspace.ts"}


def allow_legacy(event, paths):
    if event == "workflow_dispatch":
        return True
    if event != "push" or not paths:
        raise ValueError("Cannot determine approved release scope")
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
        if not all(SHA.fullmatch(x) and x != "0" * 40 for x in (args.before, args.after)):
            raise ValueError("Missing before/after commit")
        raw = subprocess.check_output(["git", "diff", "--name-only", "--no-renames", "-z", args.before, args.after, "--"])
        paths = {p.decode() for p in raw.split(b"\0") if p}
    print("allow_legacy_publish=" + str(allow_legacy(args.event, paths)).lower())


if __name__ == "__main__":
    main()
