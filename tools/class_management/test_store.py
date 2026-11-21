"""Real PostgreSQL/PGlite SQL tests; never uses production credentials."""

import copy, json, os, subprocess, sys, unittest
from pathlib import Path
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).parent))
from test_catalog import MASTER, catalog
from production_sync import ClassRegistryStore, PIN_PATH


class PGliteConnection:
    """Minimal test transport to actual PostgreSQL-compatible PGlite SQL execution."""

    autocommit = False

    def __init__(self):
        self.process = subprocess.Popen(
            ["node", str(Path(__file__).with_name("pglite_fixture.mjs"))],
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL,
            text=True,
        )
        if json.loads(self.process.stdout.readline()) != {"ready": True}:
            raise RuntimeError("Fixture startup failed")

    def execute(self, sql, params=()):
        index = 0
        while "%s" in sql:
            index += 1
            sql = sql.replace("%s", "$" + str(index), 1)
        self.process.stdin.write(
            json.dumps({"sql": sql, "params": list(params)}) + "\n"
        )
        self.process.stdin.flush()
        reply = json.loads(self.process.stdout.readline())
        if "error" in reply:
            raise RuntimeError("Fixture SQL " + reply["error"])
        rows = [tuple(row) for row in reply["rows"]]

        class Result:
            def fetchall(self):
                return rows

        return Result()

    def cursor(self):
        return self

    def __enter__(self):
        return self

    def __exit__(self, *_):
        pass

    def executemany(self, sql, rows):
        for row in rows:
            self.execute(sql, row)

    def close(self):
        self.process.stdin.write('{"close":true}\n')
        self.process.stdin.flush()
        self.process.stdin.close()
        self.process.wait(timeout=15)
        self.process.stdout.close()


def connection():
    if os.environ.get("PRODUCTION_DATABASE_URL"):
        raise RuntimeError("Production credentials forbidden in tests")
    url = os.environ.get("CLASS_REGISTRY_TEST_DATABASE_URL")
    if url:
        from urllib.parse import urlsplit

        if urlsplit(url).hostname not in {"localhost", "127.0.0.1"}:
            raise RuntimeError("Only isolated local PostgreSQL fixtures allowed")
        import psycopg

        return psycopg.connect(url, prepare_threshold=None)
    if not os.environ.get("CLASS_REGISTRY_PGLITE"):
        raise unittest.SkipTest("Set isolated PostgreSQL URL or CLASS_REGISTRY_PGLITE")
    return PGliteConnection()


class StoreTest(unittest.TestCase):
    def setUp(self):
        self.env = patch.dict(os.environ, {"CLASS_REGISTRY_TESTS": "1"})
        self.env.start()
        self.db = connection()
        self.pin = json.loads(PIN_PATH.read_text())
        self.schema = '"' + self.pin["schema"] + '"'
        self.db.execute("DROP SCHEMA IF EXISTS " + self.schema + " CASCADE")
        self.db.execute("CREATE SCHEMA " + self.schema)
        self.db.execute(
            "CREATE TABLE "
            + self.schema
            + ".govt_source_manifest(manifest_sha256 text NOT NULL)"
        )
        self.db.execute(
            "INSERT INTO " + self.schema + ".govt_source_manifest VALUES (%s)",
            (self.pin["manifestSha256"],),
        )
        self.db.execute("COMMIT")
        self.db.execute("BEGIN")
        self.store = ClassRegistryStore(self.db, self.pin, fixture=True)

    def tearDown(self):
        try:
            self.db.execute("ROLLBACK")
        finally:
            self.db.close()
            self.env.stop()

    def count(self, name):
        return int(
            self.db.execute(
                "SELECT count(*) FROM " + self.store.table(name)
            ).fetchall()[0][0]
        )

    def test_sync_readback_idempotency_and_no_review_approval(self):
        data = catalog()
        first = self.store.sync(data, MASTER)
        self.db.execute("COMMIT")
        self.db.execute("BEGIN")
        second = self.store.sync(data, MASTER)
        self.assertEqual(first, second)
        self.assertEqual(first["databaseStatus"], "present_verified_readback")
        self.assertEqual(self.count("class_registry_scans"), 1)
        self.assertEqual(self.count("class_registry_observations"), 1)
        self.assertEqual(self.count("class_registry_events"), 1)
        self.assertEqual(self.count("class_registry_reviews"), 0)

    def test_manifest_mismatch_is_rejected_before_extension_ddl(self):
        self.db.execute(
            "UPDATE " + self.schema + ".govt_source_manifest SET manifest_sha256=%s",
            ("b" * 64,),
        )
        with self.assertRaisesRegex(ValueError, "manifest mismatch"):
            self.store.sync(catalog(), MASTER)
        rows = self.db.execute(
            "SELECT tablename FROM pg_tables WHERE schemaname=%s AND tablename LIKE 'govt_class_registry_%%'",
            (self.pin["schema"],),
        ).fetchall()
        self.assertFalse(rows)

    def test_migration_scope_drift_is_rejected(self):
        pin = copy.deepcopy(self.pin)
        pin["classRegistryWriter"]["migrationSha256"] = "bad"
        store = ClassRegistryStore(self.db, pin, fixture=True)
        with self.assertRaisesRegex(ValueError, "not pinned"):
            store.sync(catalog(), MASTER)

    def test_database_manager_cycle_constraint_is_enforced(self):
        self.store.sync(catalog(), MASTER)
        self.db.execute(
            "UPDATE "
            + self.store.table("class_registry_managers")
            + " SET parent_id=%s WHERE manager_id=%s",
            ("external", "master"),
        )
        with self.assertRaises(Exception):
            self.db.execute("COMMIT")

    def test_automatic_sync_preserves_existing_human_metadata_review(self):
        data = catalog()
        self.store.sync(data, MASTER)
        row = data["classes"][0]
        self.db.execute(
            "INSERT INTO "
            + self.store.table("class_registry_reviews")
            + " (class_id,source_sha256,reviewer_identity,purpose,rationale,disposition) VALUES (%s,%s,%s,%s,%s,%s)",
            (
                row["id"],
                row["sourceSha256"],
                "isolated-fixture-reviewer",
                "Fixture purpose",
                "Fixture reason",
                "approved",
            ),
        )
        receipt = self.store.sync(data, MASTER)
        self.assertEqual(self.count("class_registry_reviews"), 1)
        snapshot = self.store.snapshot(data, receipt)
        self.assertEqual(snapshot["classes"][0]["databaseReviewStatus"], "approved")
        self.assertEqual(snapshot["classes"][0]["reviewedPurpose"], "Fixture purpose")
        changed = copy.deepcopy(data)
        changed["classes"][0]["sourceSha256"] = "c" * 64
        stale = self.store.snapshot(changed, receipt)
        self.assertEqual(stale["classes"][0]["databaseReviewStatus"], "stale_review")
        self.assertNotIn("reviewedPurpose", stale["classes"][0])


if __name__ == "__main__":
    unittest.main()
