# Authenticated mutation throttling

Existing governed endpoints now consume user-scoped attempt counters:

| Operation | Attempts per 60 seconds |
|---|---|
| Change password | 5 |
| Create account | 10 |
| Manage account role/status | 10 |

The migration script records settings and endpoint rate-limit keys in governance.db
before generating auth-security-policy.json. The existing governance workflow
applies this migration on merge. No new roles, permission grants or routes are added.

An active bearer session is resolved before allocating a counter. Its backend
user ID and operation are hashed; changing session tokens cannot reset the limit.
Counters commit before the mutation transaction, so wrong current passwords,
forbidden roles, conflicts and other failed mutations still count. Authorization
and session validity are checked again under the existing mutation locks.

Malformed input and unauthenticated requests do not allocate counters. This is
not IP/edge protection and does not prevent unauthenticated database/read floods.
Session lookup and logout remain available after exhausting mutation limits.
429 responses include Retry-After and Cache-Control: no-store. Database failures
fail closed. The existing counter cleanup handles these hashes after expiry.

All 60 local tests and Worker type checks pass. New unit checks cover cross-session
limits, invalid sessions, independent endpoint budgets and access to logout.
PostgreSQL CI tests seven concurrent wrong-password attempts across two sessions:
five must reach password validation and two must be throttled. Expiry permits a
new attempt. Production smoke teardown removes these synthetic user counters.

Deployment and production verification of this change remain separate gates.
