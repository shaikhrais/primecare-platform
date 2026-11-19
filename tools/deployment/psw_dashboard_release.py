"""Fail-closed source scope for the Clinic PSW safety-label maintenance release."""
import json
import sys

from .corporate_dashboard_release import (
    INTENT, content, exact_parent, paths, require,
)

KIND = "clinic-psw-safety-maintenance"
PROJECT = "primecare-clinic"
BASE = "ffa8c3114d24dd71a3071c551cdc97a67c125676"
PREVIOUS_LIVE = "4645a16c070a4bcb5b26469b13fae1fb1357f37e"
EXACT_PATHS = {
    INTENT,
    ".github/workflows/smart-deploy-dashboard-portal.yml",
    "tools/deployment/dashboard_publish_scope.py",
    "tools/deployment/psw_dashboard_release.py",
    "scripts/test-care-live-manager.mjs",
    "scripts/test-personal-care-manager.mjs",
    "websites/typescript/src/psw-personal/view.mjs",
    "websites/typescript/src/psw-workspace/live.ts",
}


def preflight(before, after, project, prior_live):
    require((before, project, prior_live) == (BASE, PROJECT, PREVIOUS_LIVE),
            "PSW release parent, portal or previous live commit differs")
    require(exact_parent(after, before), "PSW release must have the exact sole parent")
    require(paths(before, after) == EXACT_PATHS, "Unexpected PSW release path set")
    intent = json.loads(content(after, INTENT))
    require(type(intent.get("version")) is int and intent == {
        "version": 1, "intent": KIND, "base": BASE, "previous_live": PREVIOUS_LIVE,
    }, "PSW release intent differs")
    print("Clinic PSW label maintenance verified; no new dashboard activation")


if __name__ == "__main__":
    preflight(*sys.argv[1:])
