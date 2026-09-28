# Session lookup method mismatch

Status: user approved both methods on 2026-09-28. Implemented shared GET/POST
validation and an idempotent governance migration. Local export now succeeds for
seven operations. Production verification is still pending.

Evidence checked on 2026-09-28:

- Governance endpoint 779 registers `POST /v1/auth/me` with no permission key.
- `cloudflare/workers/src/auth.ts` implements `GET /me`.
- The gateway forwards `/v1/auth/me` to this handler without changing the method.
- Existing session lifecycle tests exercise GET. They do not prove compliance with the registered POST operation.

Affected roles: every authenticated role using session lookup. This does not grant
any new role permission. The handler reads only the presented active session's user.

Proposed resolution to validate: retain GET for existing clients and add the
registered POST as a read-only session lookup. Register GET as an explicitly
approved compatibility operation. Both methods must use identical active-user,
expiry, token precedence and no-store behavior. Do not infer approval from this proposal.

Proposed migration, only after validation: add the GET operation to api_endpoints
using the registry's required metadata and approved session-read permission;
clarify the existing POST response contract. Do not overwrite endpoint 779's method
or reuse a permission belonging to a different operation. Exact executable SQL is
deferred until the canonical method and permission are validated.

Required code/tests after validation: shared GET/POST handler; gateway forwarding
checks for both methods; success, missing/invalid/expired/revoked session and inactive
user cases; identical response schema; no account writes; rejected unsupported
methods; updated OpenAPI operation IDs and governance references.

The new scripts/export-auth-openapi.py intentionally fails on this mismatch instead
of generating a falsely governed contract. No production certification is implied.
