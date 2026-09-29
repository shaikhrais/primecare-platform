# Shared session ordering repair

2026-09-29. Implementation pending CI and web deployment verification.

Delayed startup identity checks, login responses and logout responses previously
could overwrite a newer session decision. Shared AuthNotifier now versions session
operations, serializes persisted credential mutations, and clears local authority
at the start of logout. Revocation sends the captured bearer token rather than
whichever session happens to be current later. Superseded successful login tokens
are revoked. Legacy URL credentials cannot create or destroy a session. Invalid
startup identity removes all stored account fields. Local language selection is
retained across logout.

Scope: existing governed login, session lookup and logout operations. No new route,
role, permission or database schema. The server remains the session authority.

Regression coverage includes delayed startup after logout, login after logout,
logout after a new login, out-of-order login responses, invalid cached identity,
and explicit bearer token revocation. These are client concurrency tests, not
proof of production credentials or a completed business workflow.

Recovery delivery/reset redemption, MFA and consent remain unavailable. Permanent
CEO bootstrap requires the actual existing tenant identifier. None of those
capabilities should be represented as complete by this repair.
