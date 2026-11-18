"""Classify main pushes before legacy production jobs, without provider writes."""
import argparse
import json
import os
import re
from pathlib import Path
import subprocess

INTENT = "tools/deployment/dashboard-release-intent.json"
INFRA_MARKER = "tools/deployment/dashboard_release_intent.py"
SHA = re.compile(r"[0-9a-f]{40}")
INFRA = frozenset({
    INFRA_MARKER, "tools/deployment/test_dashboard_release_intent.py",
    "tools/deployment/dashboard-runtime-paths.txt",
    "tools/deployment/dashboard_portal_contract.py",
    "tools/deployment/test_dashboard_portal_contract.py",
    "tools/deployment/SMART_DASHBOARD_ROLLOUT.md",
    ".github/workflows/smart-deploy-dashboard-portal.yml",
    ".github/workflows/release-screen-text.yml",
    ".github/workflows/code-admin-look.yml",
    ".github/workflows/psw-workspace.yml",
    ".github/workflows/verify-account-mutations.yml",
    ".github/workflows/governance-pilot-publish-scope.yml",
    ".github/workflows/verify-live-own-sessions.yml",
    "tools/deployment/dashboard_publish_scope.py",
})
INFRA_REPAIR = frozenset({INFRA_MARKER, ".github/workflows/verify-account-mutations.yml"})
RUNTIME_PATHS = Path("tools/deployment/dashboard-runtime-paths.txt")


def classify(changed, runtime_paths, raw_intent=None):
    """Return a writer lane. Any malformed, mixed marked push must fail."""
    if not changed:
        raise ValueError("Cannot classify an empty push diff")
    if INFRA_MARKER in changed:
        if changed not in (INFRA, INFRA_REPAIR):
            raise ValueError("Unexpected file in Smart Deploy infrastructure install")
        return "smart-dashboard-infra"
    if INTENT not in changed:
        return "legacy"
    if changed != runtime_paths | {INTENT}:
        raise ValueError("Dashboard rollout intent must match exactly the reviewed runtime file set")
    if not isinstance(raw_intent, dict) or raw_intent != {
        "version": 1, "intent": "smart-dashboard-runtime"
    } or type(raw_intent["version"]) is not int:
        raise ValueError("Invalid dashboard rollout intent")
    return "smart-dashboard-runtime"


def changed_paths(before, after):
    for sha in (before, after):
        if not SHA.fullmatch(sha) or sha == "0" * 40:
            raise ValueError("Missing immutable before/after push SHAs")
        subprocess.run(
            ["git", "cat-file", "-e", f"{sha}^{{commit}}"], check=True
        )
    subprocess.run(["git", "merge-base", "--is-ancestor", before, after], check=True)
    raw = subprocess.check_output(
        ["git", "diff", "--name-only", "--no-renames", "-z", before, after, "--"]
    )
    return frozenset(path.decode("utf-8") for path in raw.split(b"\0") if path)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("before")
    parser.add_argument("after")
    args = parser.parse_args()
    checked_out = subprocess.check_output(["git", "rev-parse", "HEAD"], text=True).strip()
    if checked_out != args.after:
        raise ValueError("Checkout does not match the event SHA")
    paths = changed_paths(args.before, args.after)
    runtime_paths = frozenset(RUNTIME_PATHS.read_text().splitlines())
    intent = json.loads(Path(INTENT).read_text()) if INTENT in paths else None
    lane = classify(paths, runtime_paths, intent)
    with open(os.environ["GITHUB_OUTPUT"], "a") as output:
        output.write(f"lane={lane}\n")
    print(f"Production writer lane: {lane}")


if __name__ == "__main__":
    main()
