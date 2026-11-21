import copy, json, os, sys, unittest
from pathlib import Path
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).parent))
from catalog import assemble, digest, canonical, validate_master
from production_sync import validate_catalog, production_connection, ClassRegistryStore

MASTER = {
    "version": 1,
    "managers": [
        {"id": "master", "parentId": None, "purpose": "Root"},
        {"id": "external", "parentId": "master", "purpose": "External bases"},
    ],
    "scopes": [{"prefix": "packages/", "manager": "master"}],
    "externalBases": ["Object"],
    "descriptions": {},
    "baseBindings": {},
}


def inventory():
    path = "packages/core/lib/a.dart"
    name = "Item"
    row = {
        "id": "dart:" + digest(path + "::" + name),
        "language": "dart",
        "name": name,
        "path": path,
        "line": 1,
        "baseName": "Object",
        "sourceSha256": "a" * 64,
        "bodySha256": "b" * 64,
        "private": False,
        "sourceDescription": None,
        "parseValid": True,
        "kind": "class",
    }
    return {
        "language": "dart",
        "files": 1,
        "complete": True,
        "classes": [row],
        "diagnostics": [],
    }


def catalog():
    return assemble(MASTER, [inventory()], "a" * 40, False)


class CatalogTest(unittest.TestCase):
    def test_initial_presence_is_unknown_and_missing_purpose_is_honest(self):
        value = catalog()
        row = value["classes"][0]
        self.assertEqual(row["databaseStatus"], "unknown")
        self.assertEqual(row["descriptionStatus"], "missing")
        self.assertEqual(row["reviewStatus"], "needs_review")
        self.assertEqual(row["managerId"], "master")
        self.assertEqual(value["baseClasses"][0]["resolution"], "external_declared")
        validate_catalog(value, MASTER)

    def test_manager_cycle_unknown_parent_and_duplicate_scope_fail(self):
        for change in ["cycle", "unknown", "scope"]:
            config = copy.deepcopy(MASTER)
            if change == "cycle":
                config["managers"][1]["parentId"] = "external"
            elif change == "unknown":
                config["managers"][1]["parentId"] = "missing"
            else:
                config["scopes"].append(config["scopes"][0])
            with self.assertRaises(ValueError):
                validate_master(config)

    def test_description_proposals_are_bound_to_current_source(self):
        config = copy.deepcopy(MASTER)
        row = inventory()["classes"][0]
        config["descriptions"][row["id"]] = {
            "purpose": "Purpose",
            "rationale": "Reason",
            "sourceSha256": "c" * 64,
        }
        with self.assertRaisesRegex(ValueError, "stale"):
            assemble(config, [inventory()], "a" * 40, False)
        config["descriptions"][row["id"]]["sourceSha256"] = row["sourceSha256"]
        value = assemble(config, [inventory()], "a" * 40, False)
        self.assertEqual(value["classes"][0]["purpose"], "Purpose")
        self.assertEqual(value["classes"][0]["reviewStatus"], "needs_review")

    def test_overlap_is_candidate_not_merge_or_approval(self):
        first = inventory()
        second = copy.deepcopy(first["classes"][0])
        second["path"] = "packages/core/lib/b.dart"
        second["id"] = "dart:" + digest(second["path"] + "::Item")
        first["classes"].append(second)
        value = assemble(MASTER, [first], "a" * 40, False)
        self.assertTrue(value["findings"])
        self.assertTrue(all(f["automaticMerge"] is False for f in value["findings"]))
        self.assertTrue(
            all(c["reviewStatus"] == "needs_review" for c in value["classes"])
        )

    def test_same_name_in_other_file_does_not_guess_base_owner(self):
        first = inventory()
        first["classes"][0]["baseName"] = "Unknown"
        value = assemble(MASTER, [first], "a" * 40, False)
        self.assertEqual(value["baseClasses"][0]["resolution"], "needs_resolution")
        self.assertIsNone(value["baseClasses"][0]["managerId"])

    def test_source_catalog_cannot_forge_database_presence_or_approval(self):
        for key, value in [("databaseStatus", "present"), ("reviewStatus", "approved")]:
            data = catalog()
            data["classes"][0][key] = value
            data["scanId"] = digest(
                canonical({k: v for k, v in data.items() if k != "scanId"})
            )
            with self.assertRaises(ValueError):
                validate_catalog(data, MASTER)

    def test_fingerprint_drift_duplicate_ids_and_dirty_production_fail(self):
        data = catalog()
        data["classes"][0]["name"] = "Changed"
        with self.assertRaises(ValueError):
            validate_catalog(data, MASTER)
        data = catalog()
        data["workingTreeDirty"] = True
        data["scanId"] = digest(
            canonical({k: v for k, v in data.items() if k != "scanId"})
        )
        with self.assertRaisesRegex(ValueError, "clean committed"):
            validate_catalog(data, MASTER, True)

    def test_partial_scan_keeps_diagnostics_and_is_not_complete(self):
        value = inventory()
        value["complete"] = False
        value["diagnostics"] = [{"path": "bad.dart", "code": "syntax"}]
        data = assemble(MASTER, [value], "a" * 40, False)
        self.assertFalse(data["complete"])
        self.assertTrue(data["diagnostics"])

    def test_production_connection_refuses_missing_optin_and_fixture(self):
        with patch.dict(os.environ, {}, clear=True):
            with self.assertRaises(ValueError):
                production_connection()
        with patch.dict(
            os.environ,
            {"CLASS_REGISTRY_WRITES": "1", "CLASS_REGISTRY_TESTS": "1"},
            clear=True,
        ):
            with self.assertRaises(ValueError):
                production_connection()

    def test_target_guard_does_not_connect_to_unapproved_host(self):
        with patch.dict(
            os.environ,
            {
                "CLASS_REGISTRY_WRITES": "1",
                "PRODUCTION_DATABASE_URL": "postgres://fake:fake@localhost/other",
            },
            clear=True,
        ):
            with self.assertRaisesRegex(ValueError, "unexpected"):
                production_connection()

    def test_fixture_connection_cannot_masquerade_as_production(self):
        class Connection:
            autocommit = False

        with patch.dict(os.environ, {}, clear=True):
            with self.assertRaises(ValueError):
                ClassRegistryStore(
                    Connection(), {"schema": "governance_" + "a" * 24}, fixture=True
                )


if __name__ == "__main__":
    unittest.main()
