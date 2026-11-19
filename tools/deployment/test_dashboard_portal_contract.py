import json
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

from . import dashboard_portal_contract as contract
from .typescript_release import FILES, digest

PROJECT = "primecare-business-development"
OTHER = "primecare-support"
PREVIOUS = "a" * 40
CANDIDATE = "b" * 40


class DashboardPortalContractTests(unittest.TestCase):
    def setUp(self):
        directory = tempfile.TemporaryDirectory()
        self.addCleanup(directory.cleanup)
        self.root = Path(directory.name)
        self.manifest = {"project": PROJECT, "generatedAt": "old", "roles": ["example"]}
        self.candidate = {**self.manifest, "generatedAt": "new"}
        (self.root / "portal.json").write_text(json.dumps(self.candidate))
        self.prior_payload = json.dumps(self.manifest).encode()
        self.stamp = {"project": PROJECT, "commit": PREVIOUS, "runtime": "typescript",
                      "files": {f: "0" * 64 for f in FILES}}
        self.stamp["files"]["portal.json"] = digest(self.prior_payload)

    def check(self, project=PROJECT, stamp=None, reader=None):
        registry_path = contract.Path("websites/typescript/projects.json")
        real_read_text = Path.read_text

        def read_text(path, *args, **kwargs):
            if path == registry_path:
                return json.dumps([PROJECT, OTHER])
            return real_read_text(path, *args, **kwargs)

        with patch.object(Path, "read_text", read_text), patch.object(contract, "receipt") as seal:
            result = contract.same_portal_contract(
                self.root, project, CANDIDATE, self.stamp if stamp is None else stamp,
                reader or (lambda _: self.prior_payload)
            )
            seal.assert_called_once_with(self.root, project, CANDIDATE)
            return result

    def test_timestamp_only_and_selected_host(self):
        seen = []
        self.check(reader=lambda url: (seen.append(url), self.prior_payload)[1])
        self.assertEqual(seen, [f"https://{PROJECT}.pages.dev/portal.json?primecare-release={PREVIOUS}"])

    def test_refuses_unregistered_target_without_fetching(self):
        with self.assertRaisesRegex(ValueError, "Unregistered portal"):
            self.check(project="primecare-unknown", reader=lambda _: self.fail("unexpected fetch"))

    def test_refuses_prior_stamp_from_another_project(self):
        with self.assertRaisesRegex(ValueError, "differs from accepted release"):
            self.check(stamp={**self.stamp, "project": OTHER}, reader=lambda _: self.fail("unexpected fetch"))

    def test_refuses_wrong_live_bytes(self):
        with self.assertRaisesRegex(ValueError, "differs from the previous release"):
            self.check(reader=lambda _: b"{}")

    def test_refuses_metadata_change(self):
        (self.root / "portal.json").write_text(json.dumps({**self.candidate, "roles": ["different"]}))
        with self.assertRaisesRegex(ValueError, "metadata changed"):
            self.check()

    def test_refuses_wrong_candidate_project_even_with_matching_prior(self):
        (self.root / "portal.json").write_text(json.dumps({**self.candidate, "project": OTHER}))
        with self.assertRaisesRegex(ValueError, "Invalid manifest project"):
            self.check()


class VerificationRunTests(unittest.TestCase):
    def setUp(self):
        self.run = {"path": ".github/workflows/smart-deploy-dashboard-portal.yml",
                    "event": "workflow_dispatch", "head_branch": "main",
                    "head_sha": CANDIDATE, "status": "completed", "conclusion": "success"}
        self.jobs = {"jobs": [{
            "name": "Check artifact and publish only if requested", "conclusion": "success",
            "steps": [
                {"name": "Record successful verification without publishing", "conclusion": "success"},
                {"name": "Recheck prior live version and exact artifact", "conclusion": "success"},
                {"name": "Recheck production preconditions and publish only the tested portal artifact",
                 "conclusion": "skipped"},
            ],
        }]}

    def test_successful_exact_verification(self):
        for event in ("workflow_dispatch", "push"):
            contract.verify_ci_run({**self.run, "event": event}, self.jobs, CANDIDATE)

    def test_wrong_workflow_source_or_state(self):
        for altered in ({"path": "other.yml"}, {"head_sha": PREVIOUS}, {"event": "pull_request"},
                        {"status": "in_progress"}, {"conclusion": "failure"}):
            with self.subTest(altered=altered), self.assertRaises(ValueError):
                contract.verify_ci_run({**self.run, **altered}, self.jobs, CANDIDATE)

    def test_prior_publish_is_not_a_verification_receipt(self):
        self.jobs["jobs"][0]["steps"][-1]["conclusion"] = "success"
        with self.assertRaisesRegex(ValueError, "not a prior publish"):
            contract.verify_ci_run(self.run, self.jobs, CANDIDATE)

    def test_failed_or_missing_artifact_check_cannot_be_promoted(self):
        self.jobs["jobs"][0]["steps"].pop(1)
        with self.assertRaises(ValueError):
            contract.verify_ci_run(self.run, self.jobs, CANDIDATE)

    def test_ambiguous_jobs_cannot_be_promoted(self):
        self.jobs["jobs"] *= 2
        with self.assertRaisesRegex(ValueError, "exactly one"):
            contract.verify_ci_run(self.run, self.jobs, CANDIDATE)
