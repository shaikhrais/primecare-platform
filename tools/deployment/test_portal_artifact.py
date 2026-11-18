import json
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest
from .portal_artifact import receipt, same_portal_contract
from .typescript_release import FILES, STAMP, make_stamp


class PortalArtifact(unittest.TestCase):
    project = "primecare-governance"
    sha = "1" * 40

    def setUp(self):
        tmp = TemporaryDirectory()
        self.addCleanup(tmp.cleanup)
        self.root = Path(tmp.name)
        for name in (*FILES, "_headers", "_redirects", "assets/lazy.js"):
            file = self.root / name
            file.parent.mkdir(parents=True, exist_ok=True)
            file.write_text(name)
        (self.root / "portal.json").write_text(json.dumps({"project": self.project}))
        self.stamp()

    def stamp(self):
        (self.root / STAMP).write_text(json.dumps(make_stamp(self.root, self.project, self.sha)))

    def read(self):
        return receipt(self.root, self.project, self.sha)

    def test_repeatable(self):
        self.assertEqual(self.read(), self.read())

    def test_extra_asset_and_pages_config_are_bound(self):
        base = self.read()
        (self.root / "_headers").write_text("changed")
        self.assertNotEqual(base, self.read())
        (self.root / "assets/lazy.js").unlink()
        self.assertNotIn("assets/lazy.js", self.read()["files"])

    def test_wrong_project(self):
        (self.root / "portal.json").write_text(json.dumps({"project": "primecare-support"}))
        self.stamp()
        with self.assertRaisesRegex(ValueError, "manifest project"):
            self.read()

    def test_stamp_mismatch(self):
        (self.root / "assets/app.js").write_text("different")
        with self.assertRaisesRegex(ValueError, "source stamp"):
            self.read()

    def test_refuse_link(self):
        (self.root / "assets/link").symlink_to(self.root / "portal.json")
        with self.assertRaisesRegex(ValueError, "link"):
            self.read()

    def test_wrong_commit(self):
        with self.assertRaisesRegex(ValueError, "source stamp"):
            receipt(self.root, self.project, "2" * 40)

    def test_build_time_is_not_a_contract_change(self):
        prior = json.loads((self.root / STAMP).read_text())
        old = (self.root / "portal.json").read_bytes()
        manifest = json.loads(old)
        manifest["generatedAt"] = "new build"
        (self.root / "portal.json").write_text(json.dumps(manifest))
        same_portal_contract(self.root, prior, lambda _: old)

    def test_live_metadata_diff_blocks_fast_path(self):
        prior = json.loads((self.root / STAMP).read_text())
        old = (self.root / "portal.json").read_bytes()
        (self.root / "portal.json").write_text(json.dumps({"project": self.project, "roles": ["unexpected"]}))
        with self.assertRaisesRegex(ValueError, "metadata changed"):
            same_portal_contract(self.root, prior, lambda _: old)
        with self.assertRaisesRegex(ValueError, "previous release"):
            same_portal_contract(self.root, prior, lambda _: b"other")
