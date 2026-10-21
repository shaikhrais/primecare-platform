# Current deployed web authentication verification — 2026-10-21

The owner confirmed completing authenticator setup and reaching the dashboard. A fresh read-only production inspection (job119450089381, run39626666887) and the current verification public-auth job119452370737 independently confirmed ownerBound=true, accountExists=true, codeAdmin=true, pendingEnrollment=false, mfaEnabled=true, activated=true and activeSessions=1. No credential, seed, code or bearer was read or logged. This supersedes the earlier paused personal-enrollment checkpoint; preserve its historical deployment evidence.

## Repairs

Added `.github/workflows/verify-current-web-auth.yml` to verify the currently deployed web runtime rather than requiring an obsolete release workflow. Its source gate checks successful full release39654261251, all 12 Worker/gateway deployment checks, all nine portal deployment jobs and unchanged runtime/catalog/migration source. Existing live tests are reused; the original owned-inbox browser recovery script was extracted without behavior changes. No application endpoint, permission, schema or owner setting changed.

Retried recovery catalog registration39654260866 after its transient production lock timeout; both registration fixture tests and application passed.

The first account verification attempt preserved an unexpected account at the owned test inbox. Read-only inspection39667163006 identified an exact synthetic mutation tenant and generated fixture accounts. Canceled producer39620434335/job119295482070 had left this dataset behind. The bounded recovery script requires the exact four observed account IDs, generated nonce439c778b507c416a9a2fecd0f88e10d6, tenant name/slug, paired foreign actor, exact population, producer time window and attributed account-creation audit. Cleanup39667612137 passed rollback validation and removed only five synthetic accounts/two tenants and their auth records/counters. Real accounts and existing mailbox messages were preserved. The initial dry-run invocation used an invalid explicit rollback inside a psycopg transaction context; it rolled back without deletion, and was corrected to use the transaction rollback signal before application.

## Current proof

Verification producer [39666003000](https://github.com/shaikhrais/primecare-platform/actions/runs/39666003000), source `b2165e55ce4d985321403f7d647e04e7caca16a7`, checks unchanged deployed runtime `04b3f47f7eb395797477dfe833e4ef676d4938a4`. The failed account jobs were retried after the exact stranded-fixture cleanup; earlier successful jobs were preserved.

- Security and Code Admin hierarchy/MFA browser suites passed, including seven native MFA scenarios each for text and UUID identity storage.
- Native auth tests passed 90 lifecycle checks, 14 self-session checks and 37 account-administration checks for each text and UUID identity type, plus injected partial-invalidation rollback/retry proofs.
- Production public auth passed 22 checks: login, authorized creation, persistence, workspace access, role/tenant denials, deactivation/revocation, password change, old-credential denial and logout.
- Live MFA passed English320/French768/Spanish1440: browser→gateway→PostgreSQL, no premature session, wrong-code denial, enrollment, replay denial, hidden enrolled seed, reload, logout and exact cleanup.
- Account reads and mutations passed 36+49 checks for each locale: real browser creation, management, audits, role/tenant denials, current-password change, real receiving-Worker recovery email, hash correlation, reset/replay denial, logout/reload and exact synthetic/message cleanup.

Session controls passed 30 live checks in each locale (90 total), including denial, tenant isolation, exact database projection, cancellation/confirmation, committed revocation audit and signed-out reload. Standalone recovery passed 20 checks in each locale (60 total) with receiving-Worker delivery, reset field clearing, old-session/credential denial, replay prevention, logout/reload and exact account/message cleanup.

Producer39666003000 completed successfully on attempt2. Every required job passed; no remaining job was skipped. Main is the only remote branch and there are zero open pull requests. All production fixtures and correlated test messages reported successful exact cleanup. The deployed application source was unchanged by this verification/cleanup work, so no application redeployment was necessary. The result is completed verification of the stated deployed web auth flows, with the separate acceptance boundary below preserved.

## Acceptance boundary

This verifies the current deployed TypeScript web authentication surface. Native Flutter MFA remains a fail-closed placeholder; lost-factor recovery/key rotation need governed operator procedures. Independent security, accessibility and localization reviews and broader physical-device acceptance remain outstanding. The owner's successful Android dashboard login is a real device confirmation of that personal journey, not acceptance of every screen/device. No independent approval or whole-platform auth sign-off is claimed. Broader time-limited privilege elevation, emergency recovery drills and tenant support-access controls are separate unfinished security work.
