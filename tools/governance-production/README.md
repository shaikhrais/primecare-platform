# Complete governance snapshot in production PostgreSQL

Exports every SQLite table (including internal sequence state), every row and original SQLite schema objects. Imports into a new `governance_<manifest SHA prefix>` schema in the existing production PostgreSQL database. Application tables, credentials, tenants, permissions and business records in `public` are untouched. Local SQLite and its compressed recovery snapshot remain preserved.

Normal homogeneous columns become PostgreSQL bigint, double precision, text or bytea. Heterogeneous/empty columns use tagged JSONB to retain SQLite storage types. Each imported table has an additional `_primecare_import_row` ordinal for deterministic readback. Original SQLite DDL, foreign keys, indexes, views, declared types, defaults and primary-key declarations are retained in `_source_manifest`; they are not executed as PostgreSQL SQL. The import is a faithful governance data snapshot, not an application schema replacement or a runtime cutover. Existing APIs still use their current repositories until a separately reviewed integration changes them.

A single transaction and advisory lock cover all table creation, data loading and readback. Source-file hashes, table counts and complete ordered readback hashes must match before commit. A second import refuses to overwrite an existing schema. PostgreSQL PUBLIC receives no schema access. No completion or verification flags are promoted.

```sh
python3 tools/governance-production/export.py .agents/governance/governance.db /tmp/governance-export
node tools/governance-production/test-import.mjs
```

Production execution uses the `production` GitHub environment and existing `PRODUCTION_DATABASE_URL` secret through `.github/workflows/import-governance-production.yml`. The workflow binds the exact locally reviewed manifest and does not log credentials or row data. Its success receipt must be inspected before reporting production seeded.

Current source: 334 tables and 490765 rows. Manifest SHA256: `68b0b02dd1215f58630d2c1aea3c5e1cfd488a9cbcfe5c96bea9dcfd89944c42`.

Rollback before commit is automatic. After successful import, preserve the immutable schema; any later runtime cutover must keep its own reversible pointer and permissions. No destructive cleanup is included.
