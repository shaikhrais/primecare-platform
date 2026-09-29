# Shared session ordering repair

2026-09-29. PR #26 merged as 58c6ae8c0786b4fbd7c8f292b608a5897e3029bf.
Auth Gateway Verification run 36514363305 passed all 11 jobs: 272 core
session/transport/route-guard tests, 85 shared-page tests, three Clinic routing
tests, all eight product analyses/builds, and Dart/PostgreSQL checks.
Web deployments are tracked separately; CI does not prove an authenticated
production-browser journey.

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

## Current completion blockers

Verified against the repository registry and GitHub secret names on this date:

- BOOTSTRAP_CEO_EMAIL and BOOTSTRAP_CEO_PASSWORD exist; BOOTSTRAP_TENANT_ID
  does not. The protected bootstrap requires a real active tenant with no CEO.
  Do not guess a tenant or promote an existing account.
- Forgot/reset endpoints have no request/response schemas or permission keys.
  Email-provider and sender configuration are absent. Token lifetime, limits,
  retention and approved reset origins still need explicit governed definitions.
- No MFA endpoint is registered. The method, enrollment/recovery policy and
  challenge contracts are not defined.
- Consent endpoints lack contracts and permission keys; applicable consent
  text/version and user-consent persistence are not implemented.
- Actual-account login, protected role workflows and production logout in the
  browser remain unverified. Signup continues to require CEO/HR provisioning.

The .agents/AGENTS.md database-first rules require governed definitions before
implementing new routes, permission rules or screens. These gaps are not completed
by the shared-page rollout or by this session-ordering repair.
