# Governed API inventory

## Complete endpoint comments

`npm run api:spec` now refreshes the complete catalogue from the pinned production
governance database and generates `ENDPOINT_REFERENCE.md`,
`API_DOCUMENTATION_INDEX.md` and `api-documentation-coverage.json` alongside the
OpenAPI inventory and readiness report. Production credentials are required;
there is no fallback to an old operational SQLite database.

Every exported endpoint receives purpose/behavior, authentication, request and
response, tenant/persistence, rate/audit, verification and blocker comments.
Exact method/path matches to repository OpenAPI documents add endpoint-specific
input fields, required/optional flags, constraints, response fields/content types,
declared security and linked source documents. Overlapping source versions remain
visible and are not silently merged. Invalid or duplicate registrations appear
in quarantine rather than receiving callable-operation documentation credit.

The coverage report measures **comments and source references**, not implemented
business functionality or production readiness. Unknown requirements stay explicit.
Raw registry schema examples/defaults are never copied into endpoint comments.

Validate generated coverage with `python3 scripts/check-api-documentation.py`.
The `Document all production-governed API endpoints` workflow reads production
metadata, validates all generated comments and saves only the five allowlisted
documentation outputs directly to main with an unchanged-head check. It grants
no roles, calls no business API and changes no governance rows.

For the typed communication/voice subset, use
[`communications.openapi.json`](communications.openapi.json) and
[`COMMUNICATION_API.md`](COMMUNICATION_API.md). That separate contract covers
28 exact registered operations with schemas, transport and security definitions.
It does not certify deployment or provide unimplemented Vapi appointment tools.
The inventory described below remains deliberately draft.

Run `npm run api:spec` from the repository root to generate `openapi.json` and
`api-readiness.json`. Python 3 and Node.js are required; no third-party Python
dependencies are needed. The database is opened read-only.

The export also generates `ENDPOINT_REFERENCE.md` with detailed comments for every
operation: registry identity, purpose limitations, authentication, permissions,
requests, responses, tenant isolation, persistence, rate limits, audit requirements,
proposed verification cases and blockers. OpenAPI `description` fields contain the
same comments because JSON has no comment syntax. Tags group operations by their
registered route prefix, not by an inferred Worker mapping.

The inspected database has 1,249 rows each in `api_registry` and
`api_endpoint_registry`, but neither has an exact method-and-path match with
`api_endpoints`. All explicit endpoint request/response schema links are null.
Those other registries are therefore not joined by coincident numeric IDs or used
to invent payloads. Resolving these mismatches is a prerequisite for full contracts.

This is a draft inventory, not a deployable API contract. It deliberately contains
no inferred permission grants, authentication schemes, payload examples, or success
schemas. It does not implement endpoints or establish that existing endpoints work.
Do not publish it as production documentation or use it to generate production clients.

Run `node scripts/export-openapi.mjs --check` for a read-only readiness gate.
It currently exits 1 intentionally: runtime security, persistence, and contract tests
have not been verified. Populating missing registry columns alone does not pass it.
Run `python3 scripts/test_governed_openapi.py` for fast exporter regression tests.

Before replacing the draft: resolve the contradictory auth requirements; approve
per-role permissions and tenant scope; register concrete request/response schemas,
rate limits and audit events; validate database mappings; and prove authorization
and database write/read-back tests against an isolated QA tenant. A reviewed change
must then add evidence-based readiness evaluation rather than remove the gate.
