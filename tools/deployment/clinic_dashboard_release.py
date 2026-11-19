"""Fail-closed source scope for the first Clinic dashboard shell batch."""
import json

from .corporate_dashboard_release import (
    INTENT, MANIFEST, REGISTRY, content, exact_parent, git, paths, require, validate_entries,
)

PROJECT = "primecare-clinic"
BASE = "a3b1d1c5acd6e3bc731a70dbd0c7f5b4cd926f0d"
PREVIOUS_LIVE = "48e6d4edee1020cc059fa4cfb840c4ec690dddf0"
COHORT = "clinic-01"
KIND = "clinic-dashboard-cohort"
MANIFEST_BLOB = "6280d14c4826b6976849d80e03c3a3229ae6335a"
REGISTRY_BLOB = "272bf83ff2c0391fec8b004b593dc49114aa69b8"
EXACT_PATHS = {
    INTENT, MANIFEST, "tools/deployment/clinic_dashboard_release.py",
    "tools/deployment/dashboard_publish_scope.py",
    ".github/workflows/smart-deploy-dashboard-portal.yml",
    "scripts/test-governed-master-navigation.mjs",
}
CODES = (
    "chiropractor_dashboard",
    "clinic_dashboard",
    "physiotherapist_dashboard",
    "social_worker_dashboard",
    "rn_dashboard",
    "rpn_dashboard",
    "intake_coordinator_dashboard",
)
PROJECT_APPS = {"bd": "business-development", "go": "governance", "su": "support",
                "ma": "marketing", "fr": "franchise", "co": "corporate",
                "cl": "client", "ci": "clinic"}


def validate_delta(prior, candidate, registry):
    lookup = {(r["appCode"], r["code"], r["route"]): "primecare-" + PROJECT_APPS[r["appCode"]]
              for r in registry["screens"] if r["renderer"] == "dashboard" and r["appCode"] in PROJECT_APPS}
    validate_entries(prior, lookup)
    validate_entries(candidate, lookup)
    require(set(candidate) == set(prior) == {"version", "retained", "cohorts"}, "Unexpected manifest keys")
    require(candidate["retained"] == prior["retained"], "Retained activations changed")
    new = candidate["cohorts"][-1]
    require(candidate["cohorts"][:-1] == prior["cohorts"] and set(new) == {"id", "dashboards"}
            and new["id"] == COHORT, "Require exactly one appended Clinic cohort")
    require(tuple(r["code"] for r in new["dashboards"]) == CODES
            and all(r["project"] == PROJECT and r["appCode"] == "ci" for r in new["dashboards"]),
            "Unexpected Clinic dashboard activation set")


def preflight(before, after, project, prior_live):
    require(before == BASE and project == PROJECT and prior_live == PREVIOUS_LIVE,
            "Clinic source parent, target or prior live mismatch")
    require(exact_parent(after, before), "Clinic source does not have the exact sole parent")
    require(paths(before, after) == EXACT_PATHS, "Unexpected path in Clinic dashboard release")
    intent = json.loads(content(after, INTENT))
    require(type(intent.get("version")) is int and intent == {
        "version": 1, "intent": KIND, "cohort": COHORT, "base": BASE, "previous_live": PREVIOUS_LIVE,
    }, "Clinic release intent mismatch")
    for path, blob in ((MANIFEST, MANIFEST_BLOB), (REGISTRY, REGISTRY_BLOB)):
        require(git("ls-tree", after, "--", path) == f"100644 blob {blob}\t{path}",
                f"Unexpected exact source bytes: {path}")
    validate_delta(json.loads(content(before, MANIFEST)), json.loads(content(after, MANIFEST)),
                   json.loads(content(after, REGISTRY)))


if __name__ == "__main__":
    import sys
    preflight(*sys.argv[1:])
    print(f"Clinic source and {len(CODES)} activation rows validated")
