"""Corporate cohort release scope; no network or deployment side effects."""
import argparse
import hashlib
import json
import re
import subprocess
from pathlib import Path

PROJECT = "primecare-corporate"
MANIFEST = "websites/typescript/src/dashboard-activation.json"
REGISTRY = "cloudflare/workers/src/workspace-registry.json"
INTENT = "tools/deployment/dashboard-release-intent.json"
POLICY = "tools/deployment/corporate-dashboard-release-policy.json"
SHA = re.compile(r"[0-9a-f]{40}")
DIGEST = re.compile(r"[0-9a-f]{64}")
BATCHES = {"corporate-01": 10, "corporate-02": 1}
FIRST_LIVE = "48e6d4edee1020cc059fa4cfb840c4ec690dddf0"
NEXT_NINE = "de4801951fd89af8545f762984c4b3f6c9af8511"
NEXT_NINE_WORKFLOW = "dc47683d0b1eb71b91b162dca27c7cbf00ac8695"
WORKFLOW = ".github/workflows/smart-deploy-dashboard-portal.yml"
C1_LIVE = "3a0a1dc0e94d88f2f244eb01b5a6eff490e1364d"
C2_REVIEWED_BASE = "43ff6f3d2a266a490efbf1c1e447b47355ae1311"
INTERVENING_PATHS = {
    ".agents/AGENTS.md",
    ".github/workflows/smart-deploy-api-verify.yml",
    "tools/deployment/SMART_API_DEPLOY.md",
    "tools/deployment/SMART_DEPLOY_OVERVIEW.md",
}
C2_ALL_CODES = ['cx_director_dashboard', 'hr_hiring_dashboard', 'legal_dashboard', 'owner_dashboard', 'shareholder_dashboard', 'training_director_dashboard', 'volunteer_coordinator_dashboard']
C2_GUARD_PATHS = {
    POLICY,
    "tools/deployment/corporate_dashboard_release.py",
    "tools/deployment/test_corporate_dashboard_release.py",
    "tools/deployment/dashboard_publish_scope.py",
    "tools/deployment/test_dashboard_publish_scope.py",
}
VERIFY_ONLY = {"primecare-marketing": 44383231881, "primecare-franchise": 44383246960}


def require(condition, message):
    if not condition:
        raise ValueError(message)


def git(*args):
    return subprocess.check_output(["git", *args], text=True).strip()


def content(commit, path):
    return subprocess.check_output(["git", "show", f"{commit}:{path}"])


def paths(before, after):
    return set(git("diff", "--name-only", "--no-renames", before, after, "--").splitlines())


def exact_parent(commit, parent):
    return git("rev-list", "--parents", "-n1", commit).split() == [commit, parent]


def validate_next_nine(pin):
    require(pin.get("head") == NEXT_NINE and pin.get("workflow_blob") == NEXT_NINE_WORKFLOW,
            "Marketing/Franchise source is not the reviewed exact next-nine commit")
    require(set(pin.get("projects", {})) == set(VERIFY_ONLY), "Both next-nine release receipts are required")
    for project, verify in VERIFY_ONLY.items():
        receipt = pin["projects"][project]
        require(receipt.get("verify_run") == verify and receipt.get("head") == NEXT_NINE,
                f"{project} next-nine receipt source mismatch")
        require(type(receipt.get("publish_run")) is int and receipt["publish_run"] > 0
                and receipt["publish_run"] != verify,
                f"{project} actual successful publish run must be pinned")
        require(bool(DIGEST.fullmatch(receipt.get("asset_digest", ""))),
                f"{project} live readback asset receipt must be pinned")


def verify_published_next_nine(pin, verifier=None):
    if verifier is None:
        from .typescript_release import verify_live
        verifier = verify_live
    for project, receipt in pin["projects"].items():
        observed = verifier(project, NEXT_NINE)
        canonical = json.dumps(observed, sort_keys=True, separators=(",", ":")).encode()
        require(hashlib.sha256(canonical).hexdigest() == receipt["asset_digest"],
                f"{project} no longer matches its independently observed nine-asset stamp")


def validate_entries(doc, rows):
    require(doc.get("version") == 1 and type(doc.get("version")) is int, "Unsupported cohort manifest version")
    cohorts = doc.get("cohorts", [])
    require(len({entry["id"] for entry in cohorts}) == len(cohorts), "Duplicate cohort")
    flat = doc["retained"] + [entry for cohort in cohorts for entry in cohort["dashboards"]]
    seen = set()
    for row in flat:
        require(set(row) == {"project", "appCode", "code", "route"}, "Unexpected activation row shape")
        key = (row["appCode"], row["code"], row["route"])
        require(key in rows and rows[key] == row["project"], f"Activation row is not an exact registry entry: {key}")
        require(key not in seen, "Duplicate activation tuple")
        seen.add(key)


def validate_delta(prior, candidate, cohort, registry, expected_codes, *, count=None):
    validate_entries(prior, registry)
    validate_entries(candidate, registry)
    require(prior["retained"] == candidate["retained"], "Retained dashboards changed")
    require(candidate["cohorts"][:-1] == prior["cohorts"], "Existing cohorts changed")
    require(len(candidate["cohorts"]) == len(prior["cohorts"]) + 1, "Require exactly one appended cohort")
    latest = candidate["cohorts"][-1]
    require(latest["id"] == cohort and len(latest["dashboards"]) == (BATCHES[cohort] if count is None else count),
            "Unexpected Corporate activation count or cohort")
    require([row["code"] for row in latest["dashboards"]] == expected_codes,
            "Corporate activation codes differ from reviewed scope")
    require(all(row["project"] == PROJECT and row["appCode"] == "co" for row in latest["dashboards"]),
            "Only Corporate can be newly activated")


def c2_reviewed_continuation(cohort, before, prior_live):
    if cohort != "corporate-02" or before != C2_REVIEWED_BASE:
        return False
    require(prior_live == C1_LIVE, "Corporate continuation must use the exact verified C1 live version")
    require(git("merge-base", "--is-ancestor", C1_LIVE, before) == "", "Verified C1 is not an ancestor")
    require(paths(C1_LIVE, before) == INTERVENING_PATHS, "Unexpected changes since verified C1")
    return True


def preflight(before, after, project, prior_live, *, observe=False):
    # Only the reviewed browser-fixture repair may follow the seven-screen candidate.
    if before == "6664cde7e578b79018961be0c456cad9cbaa7ffe":
        require(project == PROJECT and prior_live == C1_LIVE and exact_parent(after, before),
                "Browser fixture repair must retain the reviewed Corporate source and live baseline")
        fixture = "scripts/test-governed-master-navigation.mjs"
        guard = "tools/deployment/corporate_dashboard_release.py"
        require(paths(before, after) == {fixture, guard}, "Unexpected path in browser fixture repair")
        require(git("ls-tree", after, "--", fixture) == f"100644 blob 881cecc769b992718738649679e3732fd7d781af\t{fixture}",
                "Unreviewed browser fixture bytes")
        preflight(C2_REVIEWED_BASE, before, project, prior_live, observe=observe)
        return
    require(project == PROJECT, "Corporate cohort cannot target another project")
    require(exact_parent(after, before), "Unexpected source ancestry")
    require(git("ls-tree", NEXT_NINE, "--", WORKFLOW) == f"100644 blob {NEXT_NINE_WORKFLOW}\t{WORKFLOW}",
            "Next-nine workflow byte pin mismatch")
    pin = json.loads(content(after, POLICY))
    validate_next_nine(pin["next_nine"])
    intent = json.loads(content(after, INTENT))
    cohort = intent.get("cohort")
    require(cohort in BATCHES, "Unrecognized Corporate cohort")
    require(type(intent.get("version")) is int and intent == {"version": 1, "intent": "corporate-dashboard-cohort", "cohort": cohort,
                       "base": before, "previous_live": prior_live}, "Source/prior-live pin mismatch")
    data = pin["batches"][cohort]
    require(SHA.fullmatch(prior_live), "Invalid prior live deployment identity")
    continuation = c2_reviewed_continuation(cohort, before, prior_live)
    expected_paths = set(data["blobs"]) | {INTENT}
    if continuation:
        expected_paths |= C2_GUARD_PATHS
        previous_pin = json.loads(content(before, POLICY))
        require(data["codes"] == C2_ALL_CODES and set(data["blobs"]) == {MANIFEST}, "Unreviewed Corporate target set")
        previous_pin["batches"]["corporate-02"] = data
        require(pin == previous_pin, "Unrelated release policy changes are prohibited")
    require(paths(before, after) == expected_paths, "Unexpected changed path set")
    for path, blob in data["blobs"].items():
        require(SHA.fullmatch(blob) and git("ls-tree", after, "--", path) == f"100644 blob {blob}\t{path}",
                f"Candidate changed bytes differ from reviewed scope: {path}")
    require(git("merge-base", "--is-ancestor", NEXT_NINE, before) == "", "Next-nine is not an ancestor")
    if cohort == "corporate-01":
        require(prior_live == FIRST_LIVE, "Corporate first prior live mismatch")
        require(exact_parent(before, NEXT_NINE), "First Corporate batch must follow the exact one-hop infrastructure install")
        require(paths(NEXT_NINE, before) == set(pin["infrastructure_paths"]), "Infrastructure source path mismatch")
        prior = pin["prior_manifest"]
    else:
        require(continuation or prior_live == before, "Second Corporate batch must follow first exact tested/live release")
        previous_parent = git("rev-parse", f"{prior_live}^1")
        preflight(previous_parent, prior_live, PROJECT, FIRST_LIVE)
        prior = json.loads(content(prior_live, MANIFEST))
    require(hashlib.sha256(content(after, REGISTRY)).hexdigest() == pin["registry_sha256"], "Workspace registry changed")
    projects = pin["app_projects"]
    registry = json.loads(content(after, REGISTRY))
    lookup = {(x["appCode"], x["code"], x["route"]):projects[x["appCode"]]
              for x in registry["screens"] if x["renderer"] == "dashboard"}
    count = len(C2_ALL_CODES) if continuation else BATCHES[cohort]
    validate_delta(prior, json.loads(content(after, MANIFEST)), cohort, lookup, data["codes"], count=count)
    if observe:
        verify_published_next_nine(pin["next_nine"])
    print(f"Corporate source and {count} activation rows approved against {prior_live}")


if __name__ == "__main__":
    arg = argparse.ArgumentParser()
    for name in ("before", "after", "project", "prior_live"):
        arg.add_argument(name)
    arg.add_argument("--observe", action="store_true", help="Verify exact Marketing and Franchise public assets read-only")
    a = arg.parse_args()
    preflight(a.before, a.after, a.project, a.prior_live, observe=a.observe)
