# Complete governance snapshot in production PostgreSQL

Exports every SQLite table (including internal sequence state), every row and original SQLite schema objects. Imports into a new `governance_<manifest SHA prefix>` schema in the existing production PostgreSQL database. Application tables, credentials, tenants, permissions and business records in `public` are untouched. Local SQLite and its compressed recovery snapshot remain preserved.

Normal homogeneous columns become PostgreSQL bigint, double precision, text or bytea. Heterogeneous/empty columns use tagged JSONB to retain SQLite storage types. Each imported table has an additional `_primecare_import_row` ordinal for deterministic readback. Original SQLite DDL, foreign keys, indexes, views, declared types, defaults and primary-key declarations are retained in `govt_source_manifest`; they are not executed as PostgreSQL SQL. The import is a faithful governance data snapshot, not an application schema replacement or a runtime cutover. Existing APIs still use their current repositories until a separately reviewed integration changes them.

A single transaction and advisory lock cover all table creation, data loading and readback. Source-file hashes, table counts and complete ordered readback hashes must match before commit. A second import refuses to overwrite an existing schema. The new schema must have no PUBLIC ACL entries before data loading; the importer refuses a schema with public access. No grants are changed. No completion or verification flags are promoted.

```sh
python3 tools/governance-production/export.py .agents/governance/governance.db /tmp/governance-export
node tools/governance-production/test-import.mjs
```

Production execution uses the `production` GitHub environment and existing `PRODUCTION_DATABASE_URL` secret through `.github/workflows/import-governance-production.yml`. The workflow binds the exact locally reviewed manifest and does not log credentials or row data. Its success receipt must be inspected before reporting production seeded.

Current source: 334 tables and 490765 rows. Manifest SHA256: `68b0b02dd1215f58630d2c1aea3c5e1cfd488a9cbcfe5c96bea9dcfd89944c42`.

Rollback before commit is automatic. After successful import, preserve the immutable schema; any later runtime cutover must keep its own reversible pointer and permissions. No destructive cleanup is included.

## Production table naming

Every imported PostgreSQL table uses `govt_`, including `govt_source_manifest`. SQLite source names and its recorded DDL stay unchanged; the importer maps each name through `govtTableName`. Already-prefixed names are kept, and collisions or names longer than PostgreSQL permits are rejected before creation.

`prefix-tables.mjs` upgrades the existing immutable production snapshot with transactional ALTER TABLE RENAME. It verifies the exact manifest, complete inventory, original counts, unchanged table OIDs, columns, and ACLs. It locks only governance tables, changes no application table or grant, rolls back on failure, and verifies safely without renaming when rerun. Index/constraint identities remain attached to their original tables. Test coverage includes injected rollback, unexpected inventory and application-table preservation.

Production execution: `.github/workflows/prefix-governance-tables.yml`, using the existing protected production environment and secret. Expect 335 prefixed tables: 334 source tables plus the manifest. Source records remain 490765.

## Reader diagnostics and main-only validation (2026-10-23)

The pinned production PostgreSQL database remains the only live authority. A diagnostic failure never opens another database or restores an operational SQLite copy. Historical fixture tests are isolated and do not verify current production registration or activate any communication route/provider.

`read-bridge.mjs` reports the actual failing phase (`configuration`, `connection`, `read-only-snapshot`, `manifest-validation`, `queries`) and a fixed safe code. `reader-errors.mjs` allows only known local faults, selected PostgreSQL/network codes and the Prisma `planLimitReached` marker. Provider messages, arbitrary error codes/names, credentials, SQL and URLs are not emitted. Missing/conflicting URLs and unexpected targets fail before connection. Successful access still requires a read-only transaction and the exact pinned manifest. No credential, target, TLS, manifest, query-authority or grant bypass is added.

| Code | Meaning and next action |
| --- | --- |
| `MISSING_DATABASE_URL`, `INVALID_DATABASE_URL`, `CONFLICTING_DATABASE_URLS` | Correct the existing configured connection variable; do not paste credentials into logs or chat. |
| `UNEXPECTED_DATABASE_TARGET` | Connection does not match the approved pooled PostgreSQL target. Preserve the pin and investigate configuration; do not redirect to an alternate authority. |
| `planLimitReached` | Prisma reported an account/project plan restriction. The account owner must resolve it with the provider before registration or live activation can continue. No automatic connection retry, billing change or fallback is added. |
| `28P01`, `28000` | Authentication/authorization failure. Check the current database credential through the existing secret-management process. |
| `42501` | Required read access was denied. Review the approved reader identity and least-privilege grants; this diagnostic never changes grants. |
| `MANIFEST_MISMATCH` | Connected database does not prove the pinned source manifest. Stop and review the authority; never silently update the pin to pass. |
| Known network/TLS code | Resolve connectivity/certificate configuration while retaining verified TLS. |
| `unavailable` | Unrecognized provider error. Details remain private; inspect the provider through its authorized administration tools. |

`.github/workflows/governance-production-reader.yml` now tests pushes to `main` rather than an obsolete work branch. Isolated fixture, reader, exporter-parity and diagnostic tests run automatically. Its broader production diagnostics require explicit workflow dispatch. Existing communication inventory/contract CI still performs its read-only production checks and now consumes these specific diagnostics; failures remain failures.

Run `node --test tools/governance-production/test-reader-errors.mjs`. Tests include real child-process protocol handling with an isolated fake PostgreSQL driver (no production network), specific plan/authentication/manifest/denied-read codes, required read-only snapshot sequencing, environment validation and secret redaction. Run the existing Python reader/fixture/export-parity suites too. No fake-driver result is evidence of production access.

The revived legacy exporter-parity check also needs the scripts import path and the explicit compatibility amendment from commit `17a5cd8dd`: a governed token with no CSS variable name must not become a JSON `"null"` CSS key. The immutable legacy exporter is preserved. The comparison removes only that legacy key and generation timestamps, asserts the invalid key is absent in current exports, and compares every other field across all nine portals. Dedicated theme-manifest validation remains required; no generalized baseline refresh or ignored theme object is used.

For a confirmed plan-limit restriction, Prisma documents that a Free-plan workspace may offer a one-time **Restore access for 24 hours** control; otherwise the account owner must resolve the plan/spending restriction or wait for the documented allowance reset. This code does not select a billing option. See [Prisma Postgres FAQ](https://www.prisma.io/docs/postgres/faq) and [billing/spending-limit documentation](https://www.prisma.io/docs/console/more/billing).

## Communication inventory after access restoration

The production inventory rerun at `2157ddc03ff9fda931d299f1333b906c714f0008`
passed after the Prisma upgrade (run `40032868609`, job `120728422719`).
It read the pinned production authority and deployed Worker binding names; it
did not send mail, call a phone, change grants or activate a communication route.
Twilio boundary rows were present, while matching native screen/API grants,
screen links and production media/provider integration remained incomplete.
The generic inventory is not a full-field comparison of those 21 rows.

Communication CI now also invokes the existing independent Twilio `--verify`
reader with no writer opt-ins. That check compares every pinned contract field
and ID; failure stays a failure and never invokes registration. The dedicated
registration workflow retains its explicit verify/register modes.

The metadata report recognizes deliberately closed empty request objects,
bounded XML responses, private WAV responses and explicit null callback responses.
Unconstrained empty objects, unknown response media and unbounded XML remain
gaps. This corrects JSON-only false negatives without changing any registry row,
grant, route or acceptance flag. Ten report tests include all 21 actual Twilio
definitions and prove that missing grants/screens still prevent completeness.
Run `python3 tools/governance-production/test-communication-contract-report.py`.
