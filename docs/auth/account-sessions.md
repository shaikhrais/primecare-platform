# Shared account session controls

The shared authenticated account route `/success` now renders the registered own-session controls from `packages/shared/src/account-sessions.json`. Production metadata owns screen 2519, route registry 7, API 16425 (GET) and API 16426 (DELETE), the existing `authenticated_self_session` permission, eleven controls and English/French/Spanish resources. No new role grants or tenant selectors are introduced.

The presentation uses SessionsController for loading, pagination, explicit confirmation and navigation, and SessionsClient for session-bound transport and strict response projection. The shared account form retains password change. A failed revocation preserves the browser session for retry. A replaced browser session cannot be erased by an older request.

Validation: contract/controller tests and TypeScript compilation passed in Actions run 39444999407. Tests reject malformed responses and unexpected fields (including token hashes), check query bounds and stale-session rejection, require confirmation, prevent duplicate submission, preserve failed requests and isolate replacement sessions. Browser coverage is isolated presentation evidence with synthetic API responses; it must not be counted as deployed API/database verification.

Production builds compare the catalog with the pinned production registration. Explicit isolated fixture builds compare its immutable specification and refuse production credentials.

Pending: deployed browser/API/database/reload proof, revocation rollback/fault checks, denied and cross-tenant evidence, required accessibility/performance/localization/security review and independent acceptance. Database tags and whole-workflow verification remain pending; this change does not declare either business process fully verified.

Native revocation fault evidence: Actions run [39445829796](https://github.com/shaikhrais/primecare-platform/actions/runs/39445829796) reproduced the previous handler returning success with an active bearer session left behind after a suppressed deletion. The candidate checked the remaining-session count, returned 503, and rolled back both the partial deletion and audit; a retry removed both own sessions while preserving the other account. Run [39446063832](https://github.com/shaikhrais/primecare-platform/actions/runs/39446063832) repeated that proof with the fix committed. The handler now requires exactly zero remaining own sessions before creating its audit or committing.

Browser presentation evidence: [39445151306](https://github.com/shaikhrais/primecare-platform/actions/runs/39445151306) passed EN/320, FR/768 and ES/1440 pagination, focus, cancel, failure preservation, retry and sign-out navigation with isolated API responses.

The nine portal deployments passed in [39445372653](https://github.com/shaikhrais/primecare-platform/actions/runs/39445372653). Deployed own-session verification is tracked separately from isolated presentation evidence. The targeted auth Worker fix release requires current native and Worker checks; publication is not inferred from a committed source file.

Production source binding: [39450337865](https://github.com/shaikhrais/primecare-platform/actions/runs/39450337865) passed eleven native registration/binding tests and applied both own-session process bindings. Each process retains its registered actor list and now has 34 governance links and current source hashes. Both are `implemented-unverified`; prior whole-process evidence remains stale. Screen/component review and readiness flags remain pending.

The release pipeline now runs from successful Auth Worker checks, verifies unchanged Worker source, publishes only the auth Worker, and triggers the deployed own-session proof. Manual live verification resolves a successful auth deployment rather than assuming a queued release succeeded. A failed prerequisite cannot publish the fix or produce a passing live receipt.
