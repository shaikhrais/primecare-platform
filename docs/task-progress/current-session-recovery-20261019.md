# Current-session recovery — 2026-10-19

Business process: `auth.read-current-session` — Inspect authenticated identity and restore session.

## Current result

Implemented-unverified; successful producer execution: 3 browser cases, 74 registered-role API checks and 4 security/read consistency groups. The protected recorder saves this through the pinned production writer. No application code, permissions, grants or production accounts were changed. The operational run binds actual main-router, gateway, service-dispatcher and transitive source hashes.

| Workflow ID | Issue found | Fix | Test result | Status | Evidence | Source commit |
| --- | --- | --- | --- | --- | --- | --- |
| auth.read-current-session | Attempt 307 source proof was stale; POST identity permission rows and service ownership metadata are inconsistent | Refreshed isolated native PostgreSQL/browser proof; exact metadata dependencies retained without inventing grants | 3 credential-entry locale/viewport browser cases; 74 registered-role credential/API cases; 4 security/read consistency groups | implemented-unverified / scoped_pass; production attempt confirmed by the transactional recorder | [Receipt, videos and source bindings](https://github.com/shaikhrais/primecare-platform/actions/runs/39334113636/artifacts/12226321626) | d970697f61c89b8a70a356f06665668c960c34ee |

The producer must pass before the recorder can write a scoped pass. The recorder is run [39334144074](https://github.com/shaikhrais/primecare-platform/actions/runs/39334144074); its `CURRENT_SESSION_ATTEMPT_COMMITTED` and `CURRENT_SESSION_HANDOFF_COMMITTED` markers identify the committed attempt and final main SHA. Production checkpoint and `recovery-handoff-current` remain authoritative.

## Demonstrated scope

- Real Platform Admin credential login through the actual main entry, gateway and inherited service pipeline, with EN/FR/ES credential-entry inputs at 320/1440/768 widths. The Platform Admin renderer initializes English after navigation; localized shell acceptance was not demonstrated by this script and remains pending.
- GET and POST identity have exactly userId, roles and authenticated status, no tenant or secret fields, and no-store responses. Identity agrees with native PostgreSQL session/user records and hashed bearer token.
- Displayed tenant options match native records. Existing session survives reload and an offline refresh/retry.
- Expired sessions and server-revoked sessions cannot restore protected UI; browser token is cleared. Reauthentication produces a new valid token; expired tokens remain denied.
- All 74 registered actor roles use separate synthetic active accounts, real credential login and both registered identity methods. This is API coverage, not all-role UI approval.
- PSW denied Platform Administration; a tenant administrator cannot read the other tenant. Forged user/tenant headers do not change self identity.
- Missing, malformed and inactive sessions are denied without session mutations. Twelve concurrent native identity reads preserve session records.
- Videos, receipt, source hashes, governed specification/theme and replay script are saved in the execution artifact. The synthetic schema is dropped.

## Exact unresolved requirements

1. POST endpoint 779 declares `authenticated_self_session`, but api_permissions rows 49793–49856 carry `api_permission_api_v1_client_treatment_history_list_get`. Approved production metadata reconciliation is required. The tracking adapter does not authorize arbitrary registration/grant changes.
2. GET endpoint 16402 has null service ownership; POST 779 says PRISMA, while current gateway executes the auth service. Reconcile registered ownership without inventing routing.
3. Definition source hashes remain historical. Rebind through a supported writer before completion review.
4. Other role UI destinations, deployed Cloudflare/cookie/edge-policy acceptance, database-outage UI behavior, full accessibility/PWA, governed video playback and independent reviews remain unproven. Loopback supplies trusted origin/IP and a controlled Cloudflare source limiter; it is not a deployed-policy test.
5. Browser-generated redirects can omit the semantics flag. Explicit test navigation appends it; this run does not claim universal navigation compliance.

## Harness corrections and CI honesty

Four superseded diagnostic runs were unsuccessful: 39333129502 (response body read after navigation), 39333376642 (expected redirect wait), 39333651444 (shared synthetic account correctly rate-limited), 39333849786 (browser-only query parameter rejected by strict API validation). They remain historical failed runs. Test fixtures/waits were corrected; no failing check was forced or bypassed. Only the successful canonical producer can update tracking.

## Live inventory and lifecycle

Production inspection: 147 business processes = 11 missing + 131 implemented-unverified + 0 verified + 5 blocked. DONE=0; PENDING=147. Supporting entries overlap: 954 screen journeys, 1,760 action journeys, 2,474 API contracts and 3 legacy candidates; complete definition catalogue=5,338. These are not additional business processes.

No feature implementation or work branch/PR was needed. Main remains the sole remote branch. Temporary inspection/recording workflows are removed in the documentation checkpoint commit. The final recorder verifies their removal, main-only/zero-open-PR state, source freshness and successful main checks before committing the cleaned production handoff. No deployment is required for these operational/test-evidence changes.

Next action is the first live `not_run`, unblocked business process selected and saved by the recorder, with its exact ID/title in the production handoff. Continue from that record; do not repeat this scoped run unless source/specification/evidence changes.
