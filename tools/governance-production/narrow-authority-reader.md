# Fixed seven-route authority diagnostic (candidate)

## Status and purpose

This standalone, additive candidate prepares a narrowly scoped metadata read.
No workflow invokes it. It does not change the existing production reader,
register a screen/API/grant, publish anything, or establish a release gate pass.
Current production data, credential availability/privileges, environment
protections, deployed behavior and seven-route authority remain unverified.

The output is a public-friendly attestation of **observed metadata states**, not
an authorization decision. `productionAuthorityEstablished`, `releaseReady`,
`authorityEstablished`, tenant/runtime authorization, contract semantics and
runtime connectivity remain false even when every metadata query completes.
Absence of records is not a denied request, a successful empty business result,
or permission to create an identity. No business records are queried.

## Milestone 3.1: fixed scope and evidence

The seven fixed routes are:

- `/admin/reality-check`
- `/admin/role-screen-carousel`
- `/admin/screenshot-gallery`
- `/generated/corporate/ceo/growth-pipeline`
- `/generated/corporate/ceo/region-performance`
- `/generated/corporate/ceo/leadership-reports`
- `/governance/placeholder`

The first three are looked up only by their exact route or an exact route
registry owner reference. No guessed admin code or alias is used. The next
three additionally inspect the six distinct source-observed codes:
`ceo_growth_pipeline` / `growth_pipeline`, `ceo_region_performance` /
`regional_performance`, `ceo_leadership_reports` / `leadership_reports`.
Both records can exist without establishing equivalence. The source mismatch
remains explicit even when a native path has a unique active registry row.
The placeholder is always a separate nonbusiness fallback; unexpected metadata
is reported without making it a business screen or granting it access.

The complete column allowlist is `FIELDS` in `narrow_authority_reader.py`.
Minimums come from these existing conventions, rather than guessed columns:

- `scripts/migrate_architecture_tables.py:92-154,568-609` defines
  `route_registry` ownership, active/auth/guard fields and endpoint registry
  identity. It does not prove current database contents or effective policy.
- `scripts/register-workspace-governance.py:141-177` reads screen IDs/codes,
  app/role owners, active flags, `role_screen_permissions` flags and role active
  state; the endpoint contracts use request/response schema, method, route,
  permission, service and implementation metadata.
- `scripts/check-api-catalog-identity.py:21-60` distinguishes endpoint IDs from
  registry IDs and checks role and nullable runtime-artifact references. Its
  historical quarantine is not consulted and cannot authorize a grant.
- `scripts/register-workspace-governance.py:87-89,196` defines per-role
  `runtime_catalog_permissions.can_view_inventory/can_view_organization`.
  These flags alone do not grant a native admin tool or a tenant-wide read.
- `tools/governance-production/export.py:17-32` defines manifest encoding;
  `import.mjs:12-17,31-34` defines typed import storage and manifest JSONB.

All data reads are restricted to the pin's schema and these eleven logical
relations: screens, route_registry, role_screen_permissions, roles,
screen_api_links, screen_api_map, api_endpoints, api_endpoint_registry,
api_permissions, runtime_artifacts and runtime_catalog_permissions. IDs used
in later queries are derived only from preceding target-scoped results.
Endpoint rows can also match the three source-observed list paths exactly:
`/v1/growth-pipeline`, `/v1/regional-performance`, `/v1/leadership-reports`.
The output distinguishes a captured GET record from a verified live API.

**Legacy map ambiguity:** `screen_api_map.api_id` has conflicting historical
foreign-key domains in `tools/governance/migrate_database_schema.py:64-75`
(`api_registry`) and `scripts/migrate_governance_db.py:203-212` (`apis`). The
workspace exporter unions this column as endpoint IDs without proving that
equivalence. This reader records `SCREEN_API_MAP_ID_DOMAIN_UNVERIFIED` and does
not use those numeric IDs to select or validate endpoint contracts.

Scope-specific grant rows are read for selected screen/endpoint IDs only.
Raw grant rows, role names, IDs, permission keys and contract values never leave
the process. No generic tenant-scope column or role inheritance rule is assumed.
`EXPLICIT_VIEW_DENIAL_ONLY` and `EXPLICIT_API_DENIAL_ONLY` describe captured
metadata flags, not the outcome of a request by any actual actor. `NO_ROWS`,
inactive/missing roles, ambiguous identities and transport/read failures remain
separate states. A database permission denial uses `READ_DENIED`.

Only endpoint request/response JSON **syntax and shape** are inspected. Generic
object shapes, invalid JSON, duplicate object keys and non-finite JSON numbers
are flagged. Even a nonempty object remains unverified. No external schema ref
is followed, and no private examples/defaults/payloads are exported. Error/audit
semantics, rate enforcement, actor assignment/inheritance, tenant isolation and
deployment are not inferred from metadata. Endpoint active state and global
operation uniqueness remain unverified; the bounded selected set cannot prove
there are no unlinked duplicates elsewhere.

## Milestone 3.2: connection and read controls

- The CLI accepts **no arguments**, target/ref/schema overrides, SQL, fixture
  path or caller-supplied hash. Importing the module does not connect.
- The two existing credential variable names are accepted, with conflicting
  values rejected. No `.env`, service, passfile or credential file is loaded.
  The URL is parsed into explicit libpq keyword arguments, never forwarded as
  conninfo. Host `pooled.db.prisma.io`, database `postgres`, port 5432 and a
  nonempty user/password are required. All URL query/fragment options are
  rejected, including SSL overrides.
- TLS requires `sslmode=verify-full`, fixed system CA file
  `/etc/ssl/certs/ca-certificates.crt`, and `gssencmode=disable`; GSS encryption
  cannot supersede TLS. `PG*`, OpenSSL/CA override and fixture variables are
  rejected even when empty. Absolute HOME is required, and known libpq home
  credential/certificate files cause refusal based on existence only. The
  driver must report `db.pgconn.ssl_in_use is True` before any query.
- This targets the existing workflow's psycopg 3.2.13 interface. That driver is
  not installed in the preparation environment. Native libpq/TLS behavior is
  not validated by mocks. Dependency hashes, reviewed source provenance and
  runner/environment restrictions are independent future requirements.
- A repeatable-read, read-only transaction is opened before manifest/data
  reads, with fixed `search_path=pg_catalog` to prevent writable-schema function
  shadowing, 30-second statement, 3-second lock and 15-second idle-transaction
  timeouts. `transaction_read_only` must report `on`. No mutation/DDL/COMMIT is
  present; rollback is attempted on every snapshot exit, including errors.
  Rollback/close failure prevents a completed receipt.
- Each fixed SELECT requires the exact ordered result-column names before any
  rows are fetched, including zero-row results. Missing descriptions, missing,
  extra, reordered, duplicate or non-string names fail as `INVALID_METADATA`;
  unavailable metadata cannot become an apparently empty result. Fixed
  transaction controls use a separate non-result path and reject unexpected
  result metadata. Cleanup rollback also requires no result metadata; otherwise
  it fails as `ROLLBACK_UNVERIFIED`. No result-column mapping is inferred.
- POSIX alarms provide a 175-second soft limit and five-second hard-exit
  cleanup grace. On hard exit only a fixed timeout receipt is emitted. A
  server-side idle timeout and connection close provide additional cleanup;
  a timeout is never reported as verified rollback. Run under an independent
  process supervisor in any future credentialed lane as defense in depth.
- At most 24 normal SQL statements, 256 rows per result (257-row sentinel),
  16 KiB per selected text field and an 8 MiB aggregate decoded-JSON acceptance
  budget are enforced. The aggregate is checked after each bounded response,
  not a network-wire byte cap; one response can exceed it and is then rejected.
  The manifest has an 8 MiB server-side byte guard. Selected text/contract fields
  have server-side byte guards before returning content, plus client checks.
  Oversized/unavailable metadata causes an unverified failure, never a silently
  truncated or apparently empty result. Rollback is outside the query budget
  so budget exhaustion still permits cleanup.
- Manifest SHA label and actual JSON bytes must match the fixed pin. Actual
  bytes are reconstructed exactly as exporter Python JSON with
  `ensure_ascii=False, sort_keys=True, indent=2` plus newline. No SQLite
  schema/DDL is executed. Required relations/columns and integer/text or empty
  tagged import storage must be verified before target reads. Unknown/mixed
  storage fails closed. Malformed tags cannot become NULL/false permissions.

The pinned manifest binds the imported source structure. It does **not** prove
current row checksums, physical-schema equivalence, application enforcement,
least-privilege credentials or trusted execution. Missing live relations/columns
are separate failures. Public output contains only fixed route names, fixed
reason/status strings, booleans and bounded counts. No provider exception
message, URL, username, password, raw record, grant key or schema payload is
logged. There is no artifact upload or private-channel creation.

## Milestone 3.3: synthetic validation

Run `python3 tools/governance-production/test-narrow-authority-reader.py` only
in a cleared environment with a private empty HOME/TMPDIR. The test refuses
credential variables at startup. Its audit hook blocks network, subprocess and
credential-file reads. Test-only synthetic credentials are passed to pure config
functions or a mocked psycopg module; no production driver is called.

The in-memory fake evaluates scoped predicates and checks the fixed SQL shape.
Tests cover positive metadata, manifest label/JSON drift, relation/column/storage
failures, absent/inactive/ambiguous identities, denied/missing grants, foreign-key
and ownership conflicts, legacy map nonpromotion, generic/invalid contracts,
secret masking, read-only and rollback failures, budgets, strict TLS arguments,
URI/environment override refusal, and no production fixture fallback.
Result-metadata regressions cover every fixed SELECT with empty and populated
fixtures, exact-column empty data results, fail-before-fetch behavior, reordered
name/value pairs, transaction-control metadata and unchanged budget enforcement.

These tests do **not** execute PostgreSQL SQL, verify a certificate chain, inspect
production records or establish business authority. Synthetic IDs/rows in the
test file are fabricated test fixtures only and must never be registered.

## Milestone 3.4: remaining execution and release gate

Before any credentialed use: finish independent review of exact reader/test
bytes, validate actual SQL and import/tag handling in an isolated PostgreSQL
fixture, verify psycopg/libpq TLS behavior against valid/invalid certificates,
pin/audit dependencies, establish a trusted execution ref and appropriate
workflow/environment/credential restrictions, and obtain the applicable
approval for the exact narrow run. No environment flag or caller-supplied SHA
proves trusted execution. Do not enable this candidate merely by expanding the
existing broad workflow or rerunning unpublished code with production secrets.

A completed future read is still only diagnostic. Reconcile registered screen
and API identities/ownership with authorized business policy, then separately
test real actor/role/tenant access, revocation, failures versus legitimate empty
business data, source-to-runtime connection, Flutter navigation/accessibility,
and required CI. No current fixture or metadata-only result closes those gates.
