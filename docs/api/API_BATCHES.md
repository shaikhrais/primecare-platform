# PrimeCare API batches 1–3

These changes implement backend endpoints only. No UI changes are included in this API branch.

| Batch | Method and route | Data and access |
|---|---|---|
| 1 | GET /v1/governance/overview | Live tenant account/session totals and safely scoped domain counts; existing organization authority |
| 1 | GET /v1/governance/page-progress | Registered completion totals per application; existing inventory authority |
| 1 | GET /v1/governance/screen-health | Registered routes and concrete implementation blockers; existing inventory authority |
| 1 | GET /v1/governance/role-coverage | Active roles, authorized page counts and landing coverage; existing inventory authority |
| 1 | GET /v1/governance/pending-tasks | Outstanding bindings, evidence and named actions; existing inventory authority |
| 1 | GET /v1/governance/api-contracts | Linked API methods, schema/permission status and recorded health/test evidence; existing inventory authority |
| 1 | GET /v1/governance/organization-map | Approved administrative reporting and live tenant account counts; existing screen grant |
| 2 | GET /v1/admin/users | CEO-only tenant account list, assignable roles and self-modification indicator |
| 3 | GET /v1/admin/users/{userId}/sessions | CEO-only target session dates; active-only by default; no hashes |
| 3 | DELETE /v1/admin/users/{userId}/sessions | Atomic target-session revocation and management audit; self revocation denied |
| 3 | GET /v1/admin/users/audit | Tenant-scoped management history with approved role, status and session-count projections |

All endpoints require an active explicit bearer session, reject conflicting tenant headers, disable caching and return bounded results. Read endpoints use read-only transactions. Session revocation uses a write transaction and target-user lock, with audit and deletion committed together. Failed audits roll back the deletion. Reporting relationships never grant permissions. Metadata evidence is labeled `registered_governance`; it does not represent a live health probe. Missing tenant bindings remain unavailable rather than global counts.

Queries support `limit` (1–100), `offset` (0–100000), and bounded literal search. Governance endpoints additionally support application and role filters. The account list supports approved role and active/inactive filters; SQL search metacharacters are escaped. Secrets, password hashes and session tokens are excluded from account responses.

The gateway now forwards account-list GET requests and unsupported account methods to the auth service. Method errors include an Allow header. Account-list and governance request budgets use separate Cloudflare rate-limit namespaces.

## Reproducible governance and contracts

`scripts/register-workspace-governance.py` invokes the batch registration migrations before catalog generation. The registrations add endpoint contracts, source permission mappings and screen/API links without creating new role grants. OpenAPI 3.1 documents are `governance-batch-1.openapi.json` , `account-batch-2.openapi.json` and `account-batch-3.openapi.json`. The generated runtime catalog is rebuilt from governance.db and is excluded from git.

`node scripts/verify-api-batches.mjs` runs the backend fixture suites, hashes the tested Worker sources/catalogs and records their limited scope in `api_batch_test_evidence`. It marks the three API batches unit-tested while leaving production and PostgreSQL verification false. It sets no screen production-ready flag or release gate. `batch-test-evidence.json` records this run.

## Validation and remaining work

120 API fixture tests passed locally; Worker TypeScript compilation and governance delta checks passed. Tests cover seven governance routes, gateway forwarding, session expiration/deactivation, tenant rejection, authorization, source throttling, query validation, pagination, literal SQL search and generic failure responses.

Real PostgreSQL integration checks are added to CI for text and UUID identities. They verify literal wildcard searches, actual tenant isolation, account field exclusion, overview/reporting counts, and session revocation. PostgreSQL is unavailable locally, so those checks are pending CI. Deployment and production smoke tests are also pending. This does not implement the remaining clinical, billing, scheduling or other business-action endpoints.

## Batch 3 validation

Eight new fixture tests verify target locking, atomic revocation/audit behavior, rollback on failed audit insertion, token exclusion, strict method/query/body handling, tenant boundaries, self protection, mutation throttling and gateway forwarding. Existing account-management permissions are retained.

New CI PostgreSQL checks cover real deletion, cross-tenant rejection, expired-session filtering, repeated revocation, deactivation, and a deliberately failed audit trigger proving that sessions survive a rolled-back revocation. Creation and password-change history are separate audit sources; this endpoint reads account-management history only. No UI files are changed.
