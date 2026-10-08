# Authenticated identity work package

Status: source-grounded implementation proposal; no route registration, governance mutation, grant reassignment, or API completion credit.

The intended feature is a read of the authenticated user's own identity. The finite checklist contains `POST /v1/auth/whoami`, declaration 6. A historical generated specification instead describes `GET /v1/auth/whoami` with a richer response than the existing `/v1/auth/me`. These identities cannot be reconciled by adding an alias without resolving the source conflict.

## Evidence and contradictions

All repository evidence below was inspected at commit `3979ed1028c8b7dfdb9acca72b1ea53d4d034127`.

| Source | Exact evidence | Consequence |
|---|---|---|
| `packages/infrastructure/src/constants/route_metadata/auth.ts`, `AUTH_METADATA.WHOAMI` | “Get information about the currently authenticated user.” | Defines self-identity intent; does not define HTTP method, permission, storage projection, or rate policy. |
| `packages/domain/src/openapi_types.d.ts`, `/v1/auth/whoami` | GET, no request body; user id/email/roles array/tenantId/status; 200/401/404 | Draft DTO evidence; generated output cannot establish original authorization. |
| `docs/api-openapi.yaml` | Contains health, login, lead submission, visit check-in; no whoami | The original source available in this revision does not independently confirm the generated whoami contract. |
| `docs/api/api-delivery-checklist.json` | POST, declarationIds `[6]`, needs_contract_and_verification | Preserve exact baseline identity until a documented method reconciliation is approved. |
| `docs/api/api-grant-integrity-audit.json`, grant group api_id 6 | Key `api_permission_api_v1_cns_list_get`; origin registry endpoint 4253, GET `/v1/cns`; all 64 rows classified registry_endpoint_identity_mismatch | Stored key correlation identifies a CNS registry origin in the historical report; it does not establish approved WHOAMI authority. Do not reassign grants by numeric ID. |
| `packages/database/prisma/schema/01_platform.prisma`, User | id, email, roles **String**, tenantId, nullable status | Scalar role storage differs from generated roles array; conversion requires an explicit contract. |
| `cloudflare/workers/src/auth.ts`, `/me` branch | Existing session-backed id/role identity | Reusable session mechanics; a different DTO does not become equivalent by sharing authentication. |
| `cloudflare/workers/src/account-read-projection.ts`, `accountUser` | Preserves persisted roles string | Existing implementation does not establish comma splitting or an array encoding. |

The first implementation package is P00: read-only grant recovery and provenance classification. WHOAMI runtime implementation follows only after its source conflicts and authority are resolved.

No current application caller for whoami was found in repository code search. Historical impact reports mention a generated POST test, but that test could not be fetched at this revision. This is not positive caller or authorization evidence.

## Planned code after authority is established

No inactive runtime projection or placeholder handler is added. The first executable work is grant provenance recovery, so valid grants are preserved and registry-ID collisions are made explicit. Only after the canonical identity and self-read authority are established should a Worker handler and DTO validator be implemented.

The field validation choices below are technical proposals rather than approved business rules. They must not be treated as source-defined bounds or permission grants.

## Field and storage mapping

| Response field | Candidate validation | Database source | Remaining decision |
|---|---|---|---|
| user.id | Nonempty string; exact session user ID | users.id | Confirm response identifier encoding follows existing account ID rules. |
| user.email | Nonempty string, no controls | users.email | Confirm email disclosure for self-identity only. |
| user.roles | Nonempty array of distinct nonempty strings; no coercion | users.roles is String | Define single-role or multi-role serialization and allowed response role labels. |
| user.tenantId | Nonempty string; exact session tenant | users.tenant_id | Confirm tenant is derived from current active session user and caller tenant header cannot override it. |
| user.status | Exact `active` | users.status | Confirm whether disabled users receive 401 and whether status must be returned. |

## Activation decisions required

1. Recover or approve the canonical source contract and settle GET versus baseline POST. Document compatibility behavior for POST; do not silently retire it.
2. Establish an exact whoami grant with correct endpoint provenance or an explicit governed rule for all authenticated users reading themselves. Correct the registry-to-endpoint identity mapping before accepting grants. Generic CNS grants are excluded.
3. Define persisted role-string conversion, response role semantics, and email/tenant disclosure. Avoid mixing navigation role selection with authorization.
4. Bind the read to an unexpired active session, matching user and tenant; deny caller-selected user IDs and tenant overrides. Define cookie versus explicit bearer behavior consistently with auth contracts.
5. Approve query/body behavior, error disclosure, source-rate policy, audit retention/redaction, and duplicate/session-race behavior. This read creates no user, session, token, or role transitions.

## Implementation sequence after decisions

1. Add a governance migration that asserts declaration 6 identity and provenance before changing metadata; preserve the finite ledger's operation accounting and record old/new method evidence.
2. Add the confirmed request/response schema and permission association to governance, then export OpenAPI reproducibly. No migration may rely on unrelated numeric registry IDs.
3. Implement a read-only transaction in the auth Worker using the existing session hash mechanics. Select only the session-bound user projection. Check query/body/method before querying. Sanitize adapter/database failures as an approved unavailable response.
4. Normalize roles only using the approved persisted format, then validate the exact response projection. Set no-store; never expose password hashes, session hashes, recovery tokens, or grant rows.
5. Register the exact canonical path and reconcile actual callers. Test the real gateway-to-auth integration rather than only a pure function.
6. Run PostgreSQL integration and operation-specific negative tests; merge after exact-head CI. Unit evidence alone must remain distinct from production certification.

## Error and test matrix

| Trigger | Proposed behavior; final status requires contract approval | Evidence/test requirement |
|---|---|---|
| Activation attempted today | No route is added or activated; current behavior is retained | Source review confirms this package changes documentation only; the authority audit does not prove deployed runtime behavior |
| Missing session binding | Reject projection | Future empty-binding test |
| Foreign user or tenant | Reject; no identity disclosure | Future projection, SQL, and gateway isolation tests |
| Persisted scalar roles passed as candidate array | Reject; no inferred conversion | Future scalar-role test |
| Duplicate/empty roles, inactive status, malformed value | Reject; sanitized caller-facing failure after integration | Future validation tests |
| Extra password/session/private fields | Omit from projection | Future least-disclosure test |
| Missing/expired session | Proposed 401 | Future actual auth handler test |
| Unsupported method/body/query | Proposed 405/400 | Requires canonical method decision, then real gateway test |
| Missing bound user | Historical generated source says 404; decide disclosure | Future PostgreSQL fixture and contract assertion |
| Database unavailable or malformed adapter record | Proposed 503, no sensitive logs | Future actual Worker test |

Acceptance today is limited to the source-grounded plan and explicit unresolved decisions. Remaining API counts stay 1,049 pending and 14 blocked; this package claims zero API completions.
