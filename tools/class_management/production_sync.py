"""Transaction-bound class-governance metadata sync. No business data or grants.

Production requires the pinned target/manifest and explicit write opt-in. Reviews
are never created or approved by automated source discovery.
"""

import argparse, hashlib, json, os, re, ssl, sys
from pathlib import Path
from urllib.parse import urlsplit, unquote

sys.path.insert(0, str(Path(__file__).resolve().parent))
from catalog import ROOT, canonical, digest, validate_master, owner
from organization import classify
from libraries import library_binding, build_subpackages

SQL_PATH = Path(__file__).parent / "sql/001_class_registry.sql"
PIN_PATH = ROOT / "tools/governance-production/production-pin.json"
TABLES = [
    "class_registry_meta",
    "class_registry_managers",
    "class_registry_scans",
    "class_registry_classes",
    "class_registry_bases",
    "class_registry_observations",
    "class_registry_findings",
    "class_registry_reviews",
    "class_registry_events",
]


def validate_catalog(value, master, production=False):
    validate_master(master)
    if value.get("format") != 1 or value.get("registrySha256") != digest(
        canonical(master)
    ):
        raise ValueError("Master declaration mismatch")
    expected = dict(value)
    scan_id = expected.pop("scanId", None)
    if digest(canonical(expected)) != scan_id:
        raise ValueError("Catalog fingerprint mismatch")
    if production and value.get("workingTreeDirty") is not False:
        raise ValueError("Production requires a clean committed source snapshot")
    if not re.fullmatch(r"[a-f0-9]{40,64}", value.get("sourceCommit", "")):
        raise ValueError("Source commit required")
    if value.get("managers") != master["managers"]:
        raise ValueError("Catalog manager declarations differ")
    if value.get("subpackages", []) != build_subpackages(
        value["classes"], value.get("libraries", [])
    ):
        raise ValueError("Subpackage hierarchy differs from source directories")
    managers = {m["id"] for m in master["managers"]}
    ids = set()
    for row in value["classes"]:
        if row["id"] in ids or row.get("managerId") not in managers:
            raise ValueError("Duplicate or unmanaged class")
        if row["id"] != row["language"] + ":" + digest(
            row["path"] + "::" + row["name"]
        ):
            raise ValueError("Class identity does not match source namespace")
        if row["managerId"] != owner(master, row["path"]):
            raise ValueError("Class owner differs from master scope")
        ids.add(row["id"])
        if any(
            row.get(key) != item
            for key, item in library_binding(row, value.get("libraries", [])).items()
        ):
            raise ValueError("Class library binding differs from manifest inventory")
        if any(row.get(key) != item for key, item in classify(row).items()):
            raise ValueError("Class organization differs from source rules")
        if (
            row.get("databaseStatus") != "unknown"
            or row.get("reviewStatus") != "needs_review"
        ):
            raise ValueError(
                "Source catalog cannot assert database presence or approval"
            )
        if (
            row["language"] not in {"dart", "typescript", "python"}
            or not row["name"]
            or not re.fullmatch(r"[a-f0-9]{64}", row["sourceSha256"])
        ):
            raise ValueError("Invalid source observation")
        if Path(row["path"]).is_absolute() or ".." in Path(row["path"]).parts:
            raise ValueError("Invalid source path")
    for base in value["baseClasses"]:
        if base.get("sourceClassId") is not None and base["sourceClassId"] not in ids:
            raise ValueError("Unknown source base class")
        if base.get("managerId") is not None and base["managerId"] not in managers:
            raise ValueError("Unknown base manager")
    for finding in value["findings"]:
        if finding.get("automaticMerge") is not False or any(
            cid not in ids for cid in finding["classIds"]
        ):
            raise ValueError("Invalid overlap finding")
    return scan_id


class ClassRegistryStore:
    def __init__(self, connection, pin, *, fixture=False):
        if getattr(connection, "autocommit", False):
            raise ValueError("Class registry requires a transaction-bound connection")
        if fixture:
            if os.environ.get("CLASS_REGISTRY_TESTS") != "1" or os.environ.get(
                "PRODUCTION_DATABASE_URL"
            ):
                raise ValueError("Explicit isolated fixture mode required")
        elif os.environ.get("CLASS_REGISTRY_WRITES") != "1":
            raise ValueError("Class registry write opt-in required")
        self.db = connection
        self.pin = pin
        self.schema = pin["schema"]
        self.fixture = fixture
        if not re.fullmatch(r"governance_[a-f0-9]{24}", self.schema):
            raise ValueError("Unexpected governance schema")

    def table(self, name):
        if name not in TABLES + ["source_manifest"]:
            raise ValueError("Unapproved class registry relation")
        return '"' + self.schema + '"."govt_' + name + '"'

    def initialize(self):
        sql = SQL_PATH.read_text()
        sha = hashlib.sha256(sql.encode()).hexdigest()
        scope = self.pin.get("classRegistryWriter", {})
        if (
            scope.get("migrationSha256") != sha
            or scope.get("tables") != TABLES
            or scope.get("schemaChanges") is not True
            or scope.get("businessDataWrites") is not False
            or scope.get("roleGrants") is not False
        ):
            raise ValueError("Class registry write scope is not pinned")
        self.db.execute("SET LOCAL lock_timeout='10s'")
        self.db.execute("SET LOCAL statement_timeout='300s'")
        self.db.execute("SELECT pg_advisory_xact_lock(137930,1)")
        rows = self.db.execute(
            "SELECT manifest_sha256 FROM " + self.table("source_manifest")
        ).fetchall()
        if len(rows) != 1 or rows[0][0] != self.pin["manifestSha256"]:
            raise ValueError("Production governance manifest mismatch")
        existing = self.db.execute(
            "SELECT to_regclass(%s)", (self.table("class_registry_meta"),)
        ).fetchall()
        if existing and existing[0][0] is not None:
            registered = self.db.execute(
                "SELECT migration_sha256,source_manifest_sha256 FROM "
                + self.table("class_registry_meta")
                + " WHERE version=1"
            ).fetchall()
            if registered != [(sha, self.pin["manifestSha256"])]:
                raise ValueError("Class registry migration drift")
            return
        self.db.execute(sql.replace("__SCHEMA__", '"' + self.schema + '"'))
        rows = self.db.execute(
            "SELECT migration_sha256,source_manifest_sha256 FROM "
            + self.table("class_registry_meta")
            + " WHERE version=1"
        ).fetchall()
        if rows and rows != [(sha, self.pin["manifestSha256"])]:
            raise ValueError("Class registry migration drift")
        self.db.execute(
            "INSERT INTO "
            + self.table("class_registry_meta")
            + " (version,migration_sha256,source_manifest_sha256) VALUES (1,%s,%s) ON CONFLICT(version) DO NOTHING",
            (sha, self.pin["manifestSha256"]),
        )

    def bulk(self, sql, rows):
        with self.db.cursor() as cursor:
            cursor.executemany(sql, rows)

    def sync(self, value, master):
        scan_id = validate_catalog(value, master, production=not self.fixture)
        self.initialize()
        self.bulk(
            "INSERT INTO "
            + self.table("class_registry_managers")
            + " (manager_id,parent_id,purpose) VALUES (%s,%s,%s) ON CONFLICT(manager_id) DO UPDATE SET parent_id=EXCLUDED.parent_id,purpose=EXCLUDED.purpose",
            [(m["id"], m["parentId"], m["purpose"]) for m in master["managers"]],
        )
        self.db.execute(
            "INSERT INTO "
            + self.table("class_registry_scans")
            + " (scan_id,source_commit,complete,registry_sha256,coverage,limitations) VALUES (%s,%s,%s,%s,%s::jsonb,%s::jsonb) ON CONFLICT(scan_id) DO NOTHING",
            (
                scan_id,
                value["sourceCommit"],
                value["complete"],
                value["registrySha256"],
                canonical(value["coverage"]),
                canonical(value["limitations"]),
            ),
        )
        self.bulk(
            "INSERT INTO "
            + self.table("class_registry_classes")
            + " (class_id,language,class_name,source_path,manager_id,first_seen_scan) VALUES (%s,%s,%s,%s,%s,%s) ON CONFLICT(class_id) DO UPDATE SET manager_id=EXCLUDED.manager_id",
            [
                (c["id"], c["language"], c["name"], c["path"], c["managerId"], scan_id)
                for c in value["classes"]
            ],
        )
        self.bulk(
            "INSERT INTO "
            + self.table("class_registry_bases")
            + " (base_id,source_name,manager_id,source_class_id,resolution,candidates) VALUES (%s,%s,%s,%s,%s,%s::jsonb) ON CONFLICT(base_id) DO UPDATE SET manager_id=EXCLUDED.manager_id,source_class_id=EXCLUDED.source_class_id,resolution=EXCLUDED.resolution,candidates=EXCLUDED.candidates",
            [
                (
                    b["id"],
                    b["name"],
                    b["managerId"],
                    b["sourceClassId"],
                    b["resolution"],
                    canonical(b["candidateClassIds"]),
                )
                for b in value["baseClasses"]
            ],
        )
        self.bulk(
            "INSERT INTO "
            + self.table("class_registry_observations")
            + " (scan_id,class_id,source_sha256,metadata) VALUES (%s,%s,%s,%s::jsonb) ON CONFLICT(scan_id,class_id) DO NOTHING",
            [
                (scan_id, c["id"], c["sourceSha256"], canonical(c))
                for c in value["classes"]
            ],
        )
        self.bulk(
            "INSERT INTO "
            + self.table("class_registry_findings")
            + " (scan_id,finding_id,finding_kind,metadata) VALUES (%s,%s,%s,%s::jsonb) ON CONFLICT(scan_id,finding_id) DO NOTHING",
            [(scan_id, f["id"], f["kind"], canonical(f)) for f in value["findings"]],
        )
        observed = dict(
            self.db.execute(
                "SELECT class_id,source_sha256 FROM "
                + self.table("class_registry_observations")
                + " WHERE scan_id=%s",
                (scan_id,),
            ).fetchall()
        )
        if len(observed) != len(value["classes"]) or any(
            observed.get(c["id"]) != c["sourceSha256"] for c in value["classes"]
        ):
            raise ValueError("Production read-back mismatch")
        self.db.execute(
            "UPDATE "
            + self.table("class_registry_meta")
            + " SET current_scan_id=%s WHERE version=1",
            (scan_id,),
        )
        self.db.execute(
            "INSERT INTO "
            + self.table("class_registry_events")
            + " (scan_id,source_commit,event_kind,metadata) VALUES (%s,%s,'metadata_sync',%s::jsonb) ON CONFLICT DO NOTHING",
            (
                scan_id,
                value["sourceCommit"],
                canonical(
                    {
                        "classes": len(observed),
                        "businessDataWrites": False,
                        "approvals": 0,
                        "libraryInventory": value.get("libraries", []),
                        "subpackageInventory": value.get("subpackages", []),
                    }
                ),
            ),
        )
        library_readback = self.db.execute(
            "SELECT metadata->'libraryInventory' FROM "
            + self.table("class_registry_events")
            + " WHERE scan_id=%s AND source_commit=%s AND event_kind='metadata_sync'",
            (scan_id, value["sourceCommit"]),
        ).fetchall()
        if library_readback != [(value.get("libraries", []),)]:
            raise ValueError("Library inventory read-back mismatch")
        modules = self.db.execute(
            "SELECT metadata->'subpackageInventory' FROM "
            + self.table("class_registry_events")
            + " WHERE scan_id=%s AND source_commit=%s AND event_kind='metadata_sync'",
            (scan_id, value["sourceCommit"]),
        ).fetchall()
        if modules != [(value.get("subpackages", []),)]:
            raise ValueError("Subpackage inventory read-back mismatch")
        return {
            "scanId": scan_id,
            "sourceCommit": value["sourceCommit"],
            "classes": len(observed),
            "subpackageDirectories": sum(
                node["depth"] > 0 for node in value.get("subpackages", [])
            ),
            "manifestLibraries": sum(
                item["status"] == "manifest_declared"
                for item in value.get("libraries", [])
            ),
            "sourceGroupsWithoutManifest": sum(
                item["status"] == "source_group_only"
                for item in value.get("libraries", [])
            ),
            "databaseStatus": "present_verified_readback",
            "reviewApprovals": 0,
            "businessDataWrites": False,
            "roleGrants": False,
        }

    def snapshot(self, value, receipt):
        result = json.loads(canonical(value))
        reviews = self.db.execute(
            "SELECT DISTINCT ON (class_id) class_id,source_sha256,purpose,rationale,disposition FROM "
            + self.table("class_registry_reviews")
            + " ORDER BY class_id,review_id DESC"
        ).fetchall()
        reviews = {row[0]: row[1:] for row in reviews}
        for row in result["classes"]:
            row["databaseStatus"] = "present_current"
            review = reviews.get(row["id"])
            row["databaseReviewStatus"] = (
                "no_review"
                if review is None
                else review[3]
                if review[0] == row["sourceSha256"]
                else "stale_review"
            )
            if review and review[0] == row["sourceSha256"]:
                row["reviewedPurpose"] = review[1]
                row["reviewedRationale"] = review[2]
        result["dataKind"] = "production_readback"
        result["databaseReadback"] = {
            "scanId": receipt["scanId"],
            "schema": self.schema,
            "sourceManifestSha256": self.pin["manifestSha256"],
        }
        return result


def production_connection():
    if os.environ.get("CLASS_REGISTRY_WRITES") != "1":
        raise ValueError("Explicit CLASS_REGISTRY_WRITES=1 required")
    if (
        os.environ.get("GOVERNANCE_ALLOW_SQLITE_FIXTURES") == "1"
        or os.environ.get("CLASS_REGISTRY_TESTS") == "1"
    ):
        raise ValueError("Production cannot use fixture mode")
    url = urlsplit(os.environ.get("PRODUCTION_DATABASE_URL", ""))
    if (
        url.scheme not in {"postgres", "postgresql"}
        or url.hostname != "pooled.db.prisma.io"
        or url.path != "/postgres"
    ):
        raise ValueError("Missing or unexpected production governance target")
    ca = ssl.get_default_verify_paths().cafile
    if not ca or not Path(ca).is_file():
        raise ValueError("System trust bundle unavailable")
    import psycopg

    return psycopg.connect(
        host=url.hostname,
        port=url.port or 5432,
        dbname="postgres",
        user=unquote(url.username or ""),
        password=unquote(url.password or ""),
        sslmode="verify-full",
        sslrootcert=ca,
        connect_timeout=10,
        prepare_threshold=None,
    )


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--catalog", type=Path, required=True)
    parser.add_argument("--receipt", type=Path, required=True)
    parser.add_argument("--snapshot", type=Path)
    args = parser.parse_args()
    value = json.loads(args.catalog.read_text())
    master = json.loads((Path(__file__).parent / "master_registry.json").read_text())
    pin = json.loads(PIN_PATH.read_text())
    try:
        with production_connection() as db:
            store = ClassRegistryStore(db, pin)
            receipt = store.sync(value, master)
            snapshot = store.snapshot(value, receipt) if args.snapshot else None
    except Exception as error:
        # Connection strings and provider exception bodies must never enter logs.
        print(
            "Class registry sync failed; transaction not confirmed ("
            + type(error).__name__
            + ").",
            file=sys.stderr,
        )
        raise SystemExit(1)
    receipt["commitConfirmed"] = True
    args.receipt.write_text(canonical(receipt))
    if args.snapshot:
        args.snapshot.write_text(canonical(snapshot))
    print(canonical(receipt))


if __name__ == "__main__":
    main()
