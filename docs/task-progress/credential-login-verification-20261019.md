# Credential login recovery — 2026-10-19

Workflow: `auth.credential-login` — Sign in with credentials.
Production attempt: **315**. Verification status: **implemented-unverified**.
Test status: **scoped_pass**. This is not a verified business process.

## Registered requirements and inspection
Read the current main branch, branch policy, production pin, live workflow definition,
three steps, source links, shared credential route, login API metadata, 98 overlapping
role-flow guides and existing checkpoint 306 through the pinned production reader.
Definition SHA-256: `47871a7c0750f03de65847537bfadd5cbe02895eb7e04fce920907ed062c3791`.

The registered outcome requires one valid session and authorized workspace, no
password/hash projection, reload persistence, generic credential/inactive failures,
safe rate limiting, and revocation of a provisional session after identity-confirmation failure.

API record 2 (`API__V1_AUTH_LOGIN`, POST `/v1/auth/login`) still declares
`auth_required=1`, `service_name=PRISMA`, with no request/response schema or
permission key. Shared auth route record 1 specifies `/login` / `shared_credentials`.
Reconcile this metadata with the registered unauthenticated credential-entry contract;
do not invent grants or change production metadata via an unsupported writer.

## Execution
Tested main: `8d988803e620eeea863b78e6d98d58f98f90f04a`.
Existing `scripts/test-auth-client.mjs`: **7 passed**, for each identity-schema run.
Existing `scripts/test-auth-postgres.mjs`: **90 passed for UUID** and **90 passed for text**
against disposable PostgreSQL 16 through the actual gateway and auth handlers.

Coverage includes session hashes and expiry, incorrect/inactive credentials, session
revocation, concurrent rate-limit windows and lock waits, credential/status changes
between verification and session insertion, malformed/suppressed persistence results,
rollback, recovery and oversized-input regressions. These are native API/database
and client checks, not a new complete browser execution. No application defect was
found and no application source was changed in this attempt.

Native evidence: https://github.com/shaikhrais/primecare-platform/actions/runs/39318143744
Combined bound receipts/logs: https://github.com/shaikhrais/primecare-platform/actions/runs/39318365005/artifacts/12218359180

An initial operational inspection used the wrong API column; corrected to
`route_path` and the read succeeded. An initial recorder format assertion failed
before any production write. The corrected recorder validated the existing JSON
receipts, reused passing artifacts without rerunning tests, and atomically saved
attempt 315 through the shared production adapter.

## Remaining acceptance
Current-main full router/workspace browser journey and reload, applicable EN/FR/ES,
accessibility/PWA checks, recording playback delivery and independent review gates
are not proven by this attempt. Earlier scoped browser evidence must be checked
against current source/specification before reuse. Do not mark verified from these tests.

No production business data was accessed by native fixtures. Services were disposable.
Production credentials were present only in the separate protected governance recording
job. Only supported tracking/evidence/checkpoint records were written.

## Live totals and continuation
TOTAL = 147 = 11 MISSING + 131 IMPLEMENTED-UNVERIFIED + 0 VERIFIED + 5 BLOCKED.
DONE = 0. PENDING = 147. Attempt IDs count executions, not business processes.

No feature branch or PR was opened. Temporary operational workflows are removed in
this documentation commit. The protected handoff verifies final main CI and writes
its exact SHA, branch/PR state, attempt, evidence, blockers and next action to the
production checkpoint and `recovery-handoff-current` snapshot.

Next: execute the current main router through an authorized workspace with a native
database and real browser reload; resolve the precise API authentication metadata
ambiguity before full acceptance. Where a registered requirement blocks progress,
save the exact reason and select another unblocked workflow without creating a
parallel work branch. Preserve pre-existing local staged work and inactive refs.
