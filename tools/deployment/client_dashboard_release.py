"""Fail-closed source scope for the reviewed Client dashboard shell batch."""
import json

from .corporate_dashboard_release import (
    INTENT, MANIFEST, REGISTRY, content, exact_parent, git, paths, require, validate_entries,
)

PROJECT = "primecare-client"
BASE = "d4a7074ebddd3ec89608a6160f169c234f4193c7"
PREVIOUS_LIVE = "48e6d4edee1020cc059fa4cfb840c4ec690dddf0"
COHORT = "client-01"
KIND = "client-dashboard-cohort"
MANIFEST_BLOB = "0ce08a539b320d3c8a8625daf8f191913fd8413d"
REGISTRY_BLOB = "272bf83ff2c0391fec8b004b593dc49114aa69b8"
EXACT_PATHS = {
    INTENT, MANIFEST, "tools/deployment/client_dashboard_release.py",
    "tools/deployment/dashboard_publish_scope.py",
    ".github/workflows/smart-deploy-dashboard-portal.yml",
    "scripts/test-governed-master-navigation.mjs",
}
CODES = (
    "customer_support_dashboard", "dynamic_screen_dashboard", "family_member_dashboard",
    "guest_dashboard", "office_dashboard", "patient_dashboard", "portal_dashboard",
    "support_dashboard", "billing_admin_dashboard", "receptionist_dashboard",
)
SECOND_BASE = '4645a16c070a4bcb5b26469b13fae1fb1357f37e'
SECOND_LIVE = 'a3b1d1c5acd6e3bc731a70dbd0c7f5b4cd926f0d'
SECOND_BLOB = 'd5dc506b322a820d6aecff61bbc1028a50eedf2a'
SECOND_CODES = (
    "general_manager_dashboard",
    "operations_manager_dashboard",
    "partnership_manager_dashboard",
    "regional_bdm_dashboard",
    "regional_manager_usa_dashboard",
    "scrum_master_dashboard",
    "territory_expansion_manager_dashboard",
    "territory_sales_manager_dashboard",
    "infrastructure_dashboard",
    "system_verification_dashboard",
)
SECOND_PATHS = {INTENT, MANIFEST, "tools/deployment/client_dashboard_release.py", "scripts/test-governed-master-navigation.mjs"}
THIRD_BASE = "0a7d08822a8f819ff49377beebfb6df3494c015f"
THIRD_BLOB = "0b5265e7b18530a75c0b01f014d353807cf2226e"
THIRD_CODES = ('course_architect_dashboard', 'qa_dashboard', 'quality_assurance_dashboard', 'training_hub_dashboard')
FOURTH_BASE = "20325f668235fa72490ee75f575421e03369cec2"
FOURTH_LIVE = "b3b7d8a26fdfbeef95fb275962256a614aba8046"
FOURTH_BLOB = "9795954d259de4b6e327024aea45c2fc216e4c71"
FOURTH_CODES = (
    "employee_dashboard", "volunteer_dashboard", "compliance_dashboard",
    "scheduling_dashboard", "training_dashboard",
)
PROJECT_APPS = {"bd": "business-development", "go": "governance", "su": "support",
                "ma": "marketing", "fr": "franchise", "co": "corporate",
                "cl": "client", "ci": "clinic"}


def validate_delta(prior, candidate, registry, cohort=COHORT, codes=CODES):
    lookup = {(r["appCode"], r["code"], r["route"]): "primecare-" + PROJECT_APPS[r["appCode"]]
              for r in registry["screens"] if r["renderer"] == "dashboard" and r["appCode"] in PROJECT_APPS}
    validate_entries(prior, lookup)
    validate_entries(candidate, lookup)
    require(set(candidate) == set(prior) == {"version", "retained", "cohorts"}, "Unexpected manifest keys")
    require(candidate["retained"] == prior["retained"], "Retained activations changed")
    new = candidate["cohorts"][-1]
    require(candidate["cohorts"][:-1] == prior["cohorts"] and set(new) == {"id", "dashboards"}
            and new["id"] == cohort, "Require exactly one appended Client cohort")
    require(tuple(r["code"] for r in new["dashboards"]) == codes
            and all(r["project"] == PROJECT and r["appCode"] == "cl" for r in new["dashboards"]),
            "Unexpected Client dashboard activation set")


def preflight(before, after, project, prior_live):
    lanes = {BASE: (COHORT, PREVIOUS_LIVE, EXACT_PATHS, MANIFEST_BLOB, CODES),
             SECOND_BASE: ("client-02", SECOND_LIVE, SECOND_PATHS, SECOND_BLOB, SECOND_CODES),
             THIRD_BASE: ("client-03", THIRD_BASE, SECOND_PATHS, THIRD_BLOB, THIRD_CODES),
             FOURTH_BASE: ("client-04", FOURTH_LIVE, SECOND_PATHS, FOURTH_BLOB, FOURTH_CODES)}
    require(before in lanes, "Client release has an unreviewed parent")
    cohort, live, scope, manifest_blob, codes = lanes[before]
    require(project == PROJECT and prior_live == live,
            "Client source parent, target or prior live mismatch")
    require(exact_parent(after, before), "Client source does not have the exact sole parent")
    require(paths(before, after) == scope, "Unexpected path in Client dashboard release")
    intent = json.loads(content(after, INTENT))
    require(type(intent.get("version")) is int and intent == {
        "version": 1, "intent": KIND, "cohort": cohort, "base": before, "previous_live": live,
    }, "Client release intent mismatch")
    for path, blob in ((MANIFEST, manifest_blob), (REGISTRY, REGISTRY_BLOB)):
        require(git("ls-tree", after, "--", path) == f"100644 blob {blob}\t{path}",
                f"Unexpected exact source bytes: {path}")
    validate_delta(json.loads(content(before, MANIFEST)), json.loads(content(after, MANIFEST)),
                   json.loads(content(after, REGISTRY)), cohort, codes)
    return len(codes)


if __name__ == "__main__":
    import sys
    count = preflight(*sys.argv[1:])
    print(f"Client source and {count} activation rows validated")
