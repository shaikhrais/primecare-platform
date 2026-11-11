# Offline API permission quarantine

`quarantine-api-grants.py` removes only proven corrupt permission links from an explicitly selected offline SQLite file. It never remaps IDs, copies grants to another endpoint, or invents business authority. The repository database and production databases were not changed.

Run a read-only preflight with `python scripts/quarantine-api-grants.py --db /absolute/path/to/offline-copy.db`. Inspect the returned classifications and `planDigest`. Apply that exact plan with the same command plus `--apply-digest <planDigest>`. Before either action, the CLI scans Cloudflare, services, packages and apps for `api_permissions` references. Only a finite code-reviewed set of current PostgreSQL sources is admitted, with exact SHA-256, `authority=pinned-production-postgresql` and literal `historicalCatalogAccess=false` in `docs/business/evidence/communication-runtime-reader-review.json`. An entry in that manifest alone cannot admit another path. Source drift, missing review, incorrect authority or historical access fails closed. Historical catalog consumers remain forbidden.

A candidate requires exact generator-key provenance (`api_permission_` plus the same-numbered registry endpoint code) and either a different method/path identity in the foreign-key endpoint or an absent endpoint. Unknown key origins and identity-matching rows stay untouched and require explicit authority review. Table columns, primary/unique keys, declared foreign keys, triggers, and incoming foreign-key references are validated before writes. Unreviewed incoming references or triggers stop the migration.

Within `BEGIN IMMEDIATE`, the source snapshot and candidate digests must match preflight. Every complete source row, including original ID, nullable values, timestamp and access flag, is stored as canonical JSON in `api_permission_quarantine`, with its digest, classification, immutable endpoint/registry provenance, and plan digest. Stored values are checked before deleting the original link. Any error rolls back rows and newly created quarantine tables together. A source-ID conflict is rejected. A run record permits a repeat of the same digest only when the post-migration source and schema are unchanged.

Isolated regression tests cover exact preservation, foreign keys, repeat application, transaction rollback, stale-plan rejection, unknown-key retention, incoming references, unreviewed triggers, changed post-apply state, and runtime-consumer rejection. Run `python scripts/test-quarantine-api-grants.py`.

Validation on a scratch backup of the current repository database quarantined **79,936** rows (**57,984** identity mismatches and **21,952** missing endpoints), preserved **79,936** exact source snapshots, left zero links, and repeated with zero additional changes. No new `api_permissions` foreign-key violations occurred. The original database has an unrelated invalid `translations` → `languages` foreign-key definition, so global `PRAGMA foreign_key_check` cannot run. Validation checks the modified grant table specifically, preserves its schema, rejects incoming dependencies, and touches no parent tables. This does not claim that unrelated database constraints are repaired.

Quarantine repairs corrupt metadata links; it earns **zero completed API operations**. Grant reactivation requires explicit reconciled business authority and is outside this migration.


## Current PostgreSQL consumer review (2026-11-05)

Six source snapshots were reviewed at `b4b9c078490774831139bf28bc0eecc196ec47a3`; the manifest records their independently recalculated exact hashes and source-specific limitations. The existing account-preferences admission is unchanged. The finite list adds five paths and refreshes the previously admitted endpoint-policy hash:

- `cloudflare/workers/src/business-tasks/endpoint-policy.ts`
- `cloudflare/workers/src/vapi-administration-policy.ts`
- `cloudflare/workers/src/look/access.ts`
- `packages/database/migrations/20261025_internal_call_context.sql`
- `packages/database/migrations/20261025_internal_call_permission_indexes.sql`
- `packages/shared/src/communications/internal-call-context-query.mjs`

This review establishes separation from the corrupt historical SQLite grant catalog, not complete security certification, production activation or permission to run migrations. The production pin and caller authorization gates remain mandatory. Query leaves depend on authenticated caller/session, manifest validation and result validation; a source hash does not establish those dependencies in deployment.

- Endpoint policy: its wrapper checks the manifest inside a read-only transaction. Direct users of the query builder must provide those checks. The legacy messaging branch with a null endpoint code does not independently check active tenant status.
- Vapi administration: the query requires active native user/tenant, code-admin role and current API/screen grants, but relies on its caller for authenticated session, manifest and unique result enforcement.
- Look: authorization checks manifest and current grants. Session/current actor checks and the privileged global review visibility are caller responsibilities. The `screens()` global flag is not safe to trust from request input.
- Internal-call query/function: generated source checks current session, grants, tenant and pinned manifest for permitted context; callers must validate the returned envelope. Installing the function requires an authorized runner to verify generated source, target/manifest and function ACL. The function is SECURITY INVOKER; its creation is DDL.
- Internal-call indexes: additive nonunique DDL does not grant access or read the historical catalog, but has no embedded manifest check. An authorized runner must validate source, target/manifest and privileges, and execute concurrent index statements outside a transaction.

Regression coverage exercises admission and source drift for each of the six snapshots, missing/hash/authority/historical-access metadata failures, matching-hash unknown paths across every scanned area and extension, and the exact repository inventory. These are offline scanner tests. They do not execute migrations, access production, validate native PostgreSQL behavior or certify deployment ACLs. Native integration evidence must be reported separately, including fixture-dependent skips.
