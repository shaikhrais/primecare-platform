# Security, sessions, and authorization specification

Evidence baseline: `3979ed1028c8b7dfdb9acca72b1ea53d4d034127`. This is an engineering specification, not a certification or approval of missing business policy. **Observed** means readable source behavior; **Required** means a release condition; **Open** means no implementation authority is conferred. Governance controls production permissions. Requirements below do not manufacture governance rows.

## Authority and evidence

SEC-001 — Resolve an operation by exact HTTP method plus exact canonical route. Preserve every declaration ID. Resolve governance `api_endpoints.id`; join grants using `api_permissions.api_id`, then `role_id` to `roles.id`. Never join permissions by a coincidentally similar screen name, role label, URL suffix, or endpoint permission string alone.

SEC-002 — A null `api_endpoints.permission_key` is incomplete endpoint metadata, **not proof that no role grant exists**. A positive `can_access=1` row linked to the exact `api_id` is evidence to review. Its role reference, duplicates, permission-key inconsistencies, deny semantics, tenant scope, subject ownership, and business workflow must still be reconciled. Do not automatically activate that evidence.

SEC-003 — At the baseline commit, `scripts/audit-pending-api-authority.py` excludes key-mismatched grants from `explicitGrants` and reports unknowns. Implementation package P00 adds `rawGrantEvidence`, preserving every linked grant row independently from conservative `explicitGrants`. Raw evidence includes endpoint/row/role IDs, role resolution, original permission key and canAccess value, key-match facts, and registry-origin correlation. This package is subject to its exact-head tests and CI; the baseline citation alone does not establish the new code is merged. Neither empty `explicitGrants` nor a null endpoint key proves no grant exists. Neither a positive raw row nor a correlated key proves authorization. Missing table/column or unresolved reference remains unknown.

SEC-005 — Keep identifier domains separate: `api_endpoints.id` identifies a canonical endpoint; `api_endpoint_registry.id` identifies a registry record; `api_endpoint_registry.api_id` is that registry record's referenced API identity. Equal integers across these domains do not prove they refer to the same operation. For permission evidence, retain the join that produced it, then compare exact method/path and referenced identity. A key correlation of `api_permission_` plus `endpoint_code` is naming evidence, not generator provenance or a verified foreign-key relation. P00 records `sameMethodPath`, `sameUnderlyingApiId` and `referencedRegistryIdEqualsEndpointId` independently; contradictory facts must remain visible rather than be collapsed into an allow.

SEC-006 — Reject the CNS/WHOAMI identifier collision as authority for whoami: a grant correlated to a CNS registry operation cannot authorize a distinct whoami operation merely because the registry row ID equals the canonical endpoint ID. Compare method/path and referenced API identity, preserve the mismatched source record, and require reconciliation. Do not create a whoami handler or extend role access based on this collision. Null endpoint keys do not invalidate all raw grants; inconsistent identity provenance prevents activation until the exact workflow is established.

SEC-004 — SQLite governance is design authority; PostgreSQL is runtime storage. A source snapshot, grant, passing unit test, or compiler result does not prove deployed schema compatibility, correct seeded tenant relationships, production access control, or operation readiness. Record commit, database hash, schema/migration evidence, test environment, and deployment version separately.

## Observed authentication behavior

Sources: `cloudflare/workers/src/auth.ts`, `auth-source-limit.ts`, `account-admin.ts`, `client-self.ts`, `gateway.ts`, `account-policy.json`.

| ID | Observed behavior | Verification or limitation |
|---|---|---|
| SEC-010 | Sessions use opaque random 32-byte tokens encoded as 43-character base64url; the database lookup uses SHA-256 token hash. | Do not describe this flow as JWT or OAuth. Other protocols require separate implementation evidence. |
| SEC-011 | An explicitly present invalid Authorization header does not fall back to cookie authentication. Bearer token syntax is bounded; duplicate session cookies are rejected. | Test malformed, empty, wrong-length, duplicate, revoked and expired inputs. |
| SEC-012 | Login trims/lowercases email, limits email length to 254, rejects password length above 72 UTF-8 bytes, uses bcrypt, and requires exactly one active account. | Generic credential error protects account ambiguity. Current validation is not a complete mailbox syntax specification. |
| SEC-013 | Session issuance rechecks password hash and active status under a lock before inserting; session lifetime is 12 hours. | Test concurrent password/status update versus login. Confirm real PostgreSQL lock behavior, not only mocks. |
| SEC-014 | Session cookie is Path=/, HttpOnly, Secure, SameSite=Lax, Max-Age=43200. Auth responses use no-store. | Cookie policy alone is not complete CSRF protection for all mutations. |
| SEC-015 | GET and POST `/me` identify an active, unexpired session and return projected identity. | This does not register `/whoami`, prove its response equivalence, or settle the pending governance GET/POST discrepancy. |
| SEC-016 | Administrative and password-change paths shown require an explicit Authorization header; maintenance also verifies tenant and role. | Do not extend a cookie-compatible read's policy to privileged writes. |
| SEC-017 | Parsed auth JSON is bounded to 50,000 wire bytes, including chunked input; top-level arrays/null are rejected. | Domain endpoints need their own limits; this is not a global gateway body limit. |
| SEC-018 | Unexpected authentication exceptions yield generic 503 without serializing connection strings, hashes or request data. | Internal telemetry must also redact sensitive values. |
| SEC-019 | `/logout` deletes matching session hash and expires cookie. | User-level or all-device revocation is a different contract. |

## Observed authority matrix: narrow scopes only

| Actor or relationship | Source-backed operation scope | Constraint |
|---|---|---|
| Active session owner | `/me`; session-specific logout | Session expiry/status checked; no arbitrary subject identity accepted for `/me`. |
| `ceo` | `accountAdministration` account detail, account/creation audit, target session read/revoke | Tenant required; targets bind to actor tenant. Self revocation forbidden in administrative revocation. This is not a universal CEO permission. |
| `ceo`, `hr_director` | Assignable role lists in `account-policy.json` | JSON is account-management policy data, not grants for financial, clinical, impersonation or global data access. Verify actual caller checks before reuse. |
| Authenticated client-profile owner | Reads implemented by `client-self.ts` | Actor user→owned client profile→tenant. Payment reads join through owned invoice because payment itself lacks tenant column. Family/delegate access is not established by this ownership relation. |

There is deliberately no fabricated matrix for every platform role. Build it from exact API grants plus reviewed resource predicates. Preserve explicit denials and unresolved roles in the matrix export; a list of all role names is not authorization.

## Required decision algorithm for a newly approved workflow

SEC-030 — Input consists of operation identity, authenticated actor, current session, server-resolved tenant, subject, resource relationship, state/version, and approved governance policy revision. Client-provided IDs are selectors, not trusted claims.

1. Match exact route and allowed method; reject incompatible methods with 405 and accurate Allow. Do not invoke a mutation through a read alias.
2. Parse only contract-allowed headers, query fields and body; reject malformed/repeated selectors according to the contract. Bound bytes before deserialization.
3. Authenticate with the contract mechanism. Resolve current active user/session from trusted storage. Rate-limit preflight does not replace the subsequent locked revalidation.
4. Resolve canonical governance endpoint and approved grant. Handle duplicate/missing/conflicting records as an unresolved policy condition; do not guess an allow.
5. Resolve tenant from trusted actor membership. If a tenant hint is accepted, compare it with authorized membership. A header must never override tenant authority.
6. Load the resource using tenant-scoped predicates. For indirect tenancy, verify every relation to the tenant and subject. An unscoped primary-key lookup followed by a superficial check is insufficient.
7. Evaluate action-specific owner, assignment, delegation, consent, role and lifecycle predicates. Delegation must include principal, delegate, resource scope, actions, effective/expiry times and revocation rules; these fields remain open until approved.
8. For writes, lock/revalidate authority and state in the same transaction used by the mutation. Apply version/concurrency and idempotency rules. Verify returned identifiers and affected-row counts.
9. Append required audit evidence atomically when the workflow requires it; failure must prevent success. External side effects need an approved durable delivery/compensation design.
10. Project only permitted response fields; emit the documented status and sanitized error. Do not return token hashes, password/reset secrets or unrestricted database rows.

SEC-031 — This algorithm is a proposed release design. Existing handlers must be checked individually; it is not a claim they already implement every step.

## Security control requirements and unresolved decisions

| ID | Required statement | Acceptance evidence |
|---|---|---|
| SEC-040 | Parameterize SQL values; allowlist dynamic identifiers from reviewed registries. | Injection tests for selectors/filter/sort; inspect every dynamic SQL table/field interpolation. |
| SEC-041 | Enforce browser origin policy independently from authentication. | Allowed/disallowed/no-origin OPTIONS cases and direct Worker bypass tests. Current gateway permits a specific PrimeCare Pages hostname regex; custom domains need explicit policy. |
| SEC-042 | Define CSRF protections for every cookie-authorized mutation. | State which methods use cookies, Origin checks/token strategy, and cross-origin tests. Gateway currently does not emit Allow-Credentials; do not assume cross-origin cookie login works. |
| SEC-043 | Define security headers for each website and API. | Source/config inspection and deployed header capture; header names/values must fit response type. “Secure headers” is a target, not observed completion. |
| SEC-044 | Define per-operation rate scope/window/burst and fail-open versus fail-closed dependency behavior. | Authenticated actor and source-IP limits, retry header, concurrent rejection tests. Do not invent numerical limits from another workflow. |
| SEC-045 | Audit actor, subject, tenant, operation, policy revision, outcome and correlation without secrets or unnecessary clinical payload. | Required event schema, atomicity tests, access rules, retention/deletion/legal hold decisions. Retention duration is open. |
| SEC-046 | Manage secrets by environment bindings with least privilege and rotation. | Inventory of names/owners, rotation and revocation exercise; no secret values in docs, code, logs or CI output. |
| SEC-047 | Define access to clinical data, minors/family records, exports and deletion under applicable jurisdiction. | Approved data inventory and legal/privacy review. No PHIPA/HIPAA certification is asserted. |
| SEC-048 | Record security verification against the selected ASVS version and applicable controls. | Versioned control-to-test mapping and exceptions. AGENTS requires OWASP ASVS/Top 10; that requirement alone is not compliance. |

Open business decisions: impersonation actor/subject attribution and consent; role-switch authority; email-change verification and account recovery; financial approval and separation of duties; family/delegation expiry and revocation; cross-tenant franchise access; clinical assignment/consent; AI automation allowed actions and human approval. Until each exact workflow is resolved, these must stay inactive.

## Verification gate

SEC-050 — Every activated operation requires positive grant, absent grant, explicit denial, wrong actor, wrong tenant, wrong owner, expired/revoked session, malformed input, concurrent revocation/state mutation, audit failure, storage error, output projection, direct Worker and gateway tests. Test names must identify exact method/path and policy predicate. Distinguish mock/unit, real PostgreSQL integration, deployment verification and production evidence. Never mark a missing test as passed.
