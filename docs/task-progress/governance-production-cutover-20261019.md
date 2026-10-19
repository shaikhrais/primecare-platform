# Production governance cutover checkpoint

Branch: work/governance-production-cutover-20261019. PR: https://github.com/shaikhrais/primecare-platform/pull/204. Base main: 5fd2de0177461653416443546d7b7c4c2bc9954f.

Production has 335 govt_ tables in governance_68b0b02dd1215f58630d2c1a; 490765 source rows preserved. Rename evidence: https://github.com/shaikhrais/primecare-platform/actions/runs/39238510770. Connection authority is tools/governance-production/production-pin.json. SQLite remains historical/isolated test data only.

## Completed code migrations

The shared reader pins the PostgreSQL target and manifest, maps only registered relations to govt_ tables, resolves CTE scope, and uses a read-only snapshot. It refuses absent/conflicting credentials, unknown/cross-schema relations and mutations. Source-schema introspection uses an empty in-memory schema, never historical source records. There is no production-to-SQLite fallback.

Seven entrypoints now use production by default: db_table_counts.py, inspect_architecture_counts.py, inspect_tables_content.py, export-typescript-websites.py, export_governed_openapi.py, check-api-catalog-identity.py, audit-api-grant-integrity.py. The website builder runs legacy registration scripts only with explicit isolated fixture mode and rejects that mode when production credentials are present. The production website build receives the protected database secret and pinned driver/parser dependencies. Isolated CI steps explicitly opt into fixture mode.

The formerly pending exporter/audit changes are applied; do not reapply them. Historical old-exporter code is retained only in legacy-export-fixture.py for parity testing.

## Evidence and practical limits

Four reader fixture tests pass, including nested-CTE allowlist enforcement. All nine portal JSON exports match the original SQL implementation against the complete restored fixture, excluding generation timestamp. Eight catalog-identity and six OpenAPI tests pass. The source catalog identity guard retains 2498 quarantined groups, zero new violations; no grants were reassigned or accepted.

Protected production read/count validation passed: https://github.com/shaikhrais/primecare-platform/actions/runs/39242527957 (205ea0209870b539029599c49ed12874a05195cf). Receipt artifact 12182142386 ZIP SHA256 e5374a43a54fe8cec4872a421405f1abaa520e66924bd24f17fce99aa51fd068 was checked after download. Actual three diagnostic entrypoints passed: https://github.com/shaikhrais/primecare-platform/actions/runs/39242759513 (070bae0250a9b02db24eb3247fe5cc361f3de7c7).

Production portal-export validation: https://github.com/shaikhrais/primecare-platform/actions/runs/39243335707 (5f1e262e2d33231bfd33e2c0529210299c3d9ccd). Inspect its completed outcome and the newer expanded audit validation https://github.com/shaikhrais/primecare-platform/actions/runs/39243440915 (b37eedbe5b531bb67cac534d633fbe86fe28effc). Required latest-head regression/review gates must pass before merge. A green fixture job is not production evidence or business-process verification.

## Remaining work / next action

First inspect latest-head CI and protected production exporter/audit results. Fix failures without changing quarantines or bypassing gates; then merge this completed portion under the user's existing authorization.

Continue reader inventory one entrypoint at a time. The original inventory was from a sparse checkout, not exhaustive: 44 reader candidates, 180 writer candidates, 12 workflows and 977 documentation/generated references. Three migrated diagnostics plus four exporter/audit readers do not exhaust it. Explicitly preserve archival tools and historical evidence. Re-inventory the full repository before declaring all references cut over.

Next read candidates: export_governance_to_xlsx.py, generate-api-execution-inventory.py, generate-api-family-reconciliation.py, audit-admin-read-authority.py, audit-pending-api-authority.py, audit-role-dashboards.py; review static SQL, view dependencies and exact query semantics before switching. Check active API/generated-registry consumers separately.

Writer dependency: the data snapshot did not recreate natural keys, identities/defaults, constraints, indexes or executable views. It has 751 all-null columns encoded as JSONB, and no mixed-type columns. SQLite-specific PRAGMA/DDL/INSERT OR REPLACE/last_insert_rowid and transaction semantics require migration and verification. Do not point legacy reset/write scripts at production by substituting a URL, change grant ID domains, or invent permissions. Source metadata retains original DDL for review.

Live status count from production: TOTAL 147 = MISSING 11 + IMPLEMENTED-UNVERIFIED 134 + VERIFIED 0 + BLOCKED 2; DONE 0; PENDING 147. Full authenticated browser/API/database/reload/negative-case/evidence gates remain required. No business workflow was promoted by this database consumer migration.
