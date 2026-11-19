"""Compare a selected registered portal's route and access contract with live."""
import argparse
import json
import sys
from pathlib import Path

from .http_client import read_public_asset
from .portal_artifact import receipt
from .typescript_release import digest, validate


def retain_clinic_live_manifest(bundle, commit, reader=read_public_asset):
    """Retain the deployed Clinic manifest for a shell-only release."""
    project = "primecare-clinic"
    base = f"https://{project}.pages.dev"
    query = f"?primecare-release={commit}"
    stamp = validate(json.loads(reader(f"{base}/primecare-build.json{query}")), project, commit)
    manifest = reader(f"{base}/portal.json{query}")
    if digest(manifest) != stamp["files"]["portal.json"] or json.loads(manifest).get("project") != project:
        raise ValueError("Clinic live manifest does not match the pinned build")
    Path(bundle, "portal.json").write_bytes(manifest)


def same_portal_contract(root, project, candidate_commit, prior_stamp, reader=read_public_asset):
    registry = json.loads(Path("websites/typescript/projects.json").read_text())
    if project not in registry:
        raise ValueError("Unregistered portal")
    # Bind the selected target and current build, not identities carried in the receipt.
    receipt(root, project, candidate_commit)
    commit = prior_stamp.get("commit")
    prior = validate(prior_stamp, project, commit)
    url = f"https://{project}.pages.dev/portal.json?primecare-release={commit}"
    content = reader(url)
    if digest(content) != prior["files"]["portal.json"]:
        raise ValueError("Live manifest differs from the previous release")
    live = json.loads(content)
    candidate = json.loads((Path(root) / "portal.json").read_text())
    for obj in (live, candidate):
        if obj.get("project") != project:
            raise ValueError("Invalid manifest project")
        obj.pop("generatedAt", None)
    if live != candidate:
        raise ValueError("Portal metadata changed; stop this dashboard-only release")



def verify_ci_run(run, jobs, accepted_sha):
    if (
        run.get("path", "").split("@", 1)[0] != ".github/workflows/smart-deploy-dashboard-portal.yml"
        or run.get("event") not in {"workflow_dispatch", "push"}
        or run.get("head_branch") != "main"
        or run.get("head_sha") != accepted_sha
        or run.get("status") != "completed"
        or run.get("conclusion") != "success"
    ):
        raise ValueError("Expected a successful Smart Deploy verification on this exact main commit")
    matching = [job for job in jobs.get("jobs", [])
                if job.get("name") == "Check artifact and publish only if requested"
                and job.get("conclusion") == "success"]
    if len(matching) != 1:
        raise ValueError("Expected exactly one successful artifact verification job")
    steps = {item.get("name"): item.get("conclusion") for item in matching[0].get("steps", [])}
    if (
        steps.get("Record successful verification without publishing") != "success"
        or steps.get("Recheck prior live version and exact artifact") != "success"
        or steps.get("Recheck production preconditions and publish only the tested portal artifact") != "skipped"
    ):
        raise ValueError("Expected verification-only receipt, not a prior publish")


def main():
    if len(sys.argv) > 1 and sys.argv[1] == "--verify-run":
        parser = argparse.ArgumentParser(description="Validate the immutable GitHub verify-only run")
        parser.add_argument("--verify-run", action="store_true")
        parser.add_argument("run", type=Path)
        parser.add_argument("jobs", type=Path)
        parser.add_argument("sha")
        args = parser.parse_args()
        verify_ci_run(json.loads(args.run.read_text()), json.loads(args.jobs.read_text()), args.sha)
        return
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("bundle", type=Path)
    parser.add_argument("project")
    parser.add_argument("commit")
    parser.add_argument("prior_receipt", type=Path)
    args = parser.parse_args()
    same_portal_contract(
        args.bundle, args.project, args.commit, json.loads(args.prior_receipt.read_text())
    )


if __name__ == "__main__":
    main()
