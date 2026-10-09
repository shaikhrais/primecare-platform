# Personal session controls (Batch 6)

| Method | Route | Behavior |
|---|---|---|
| GET | /v1/user/sessions | List active sessions belonging to the bearer actor; dates and current-session indicator only |
| DELETE | /v1/user/sessions | Revoke all actor sessions, active and expired, and append management audit atomically |

Every signed-in role can act on its own sessions. No userId, tenant override, arbitrary target or body is accepted. Explicit bearer authentication is required; cookie-only requests are rejected. An optional X-Tenant-Id must match the authenticated tenant. GET supports limit 1–100 and offset 0–100000. Unsupported methods return 405 with Allow. Source throttling and no-store apply. DELETE consumes the existing manageAccount mutation budget before its transaction, including denied attempts after valid authentication.

GET runs in a repeatable-read, read-only transaction. DELETE exclusively locks the actor user, rechecks the bearer, deletes that user's sessions and inserts auth_management_audit with actor=target, session counts and initiatedBy=self before committing. Login uses a shared user lock, serializing with the revocation. A later login can create a new session. Audit failure rolls back deletion and returns generic 503. Success clears the session cookie; callers must also discard their local bearer. A retry with the revoked bearer returns 401.

No schema migration is required: existing sessions, users, management audit and rate-limit tables are reused. Governance links this backend lifecycle capability to the registered shared login screen without changing screen activity or role grants. No session identifiers, hashes, tokens, IP addresses or device identities are exposed. The current flag is the only session-identifying information returned.

OpenAPI: self-sessions-batch-6.openapi.json. Six new fixtures exercise field projection, actor-only SQL, transaction/audit rollback, bearer rechecking, input/method validation, tenant rejection, mutation budget and gateway forwarding. Six PostgreSQL checks per text/UUID variant exercise real revocation, expired sessions, rollback, audit and isolation. 132 backend fixtures passed locally; PostgreSQL validation requires CI. No deployment or production readiness is asserted.
