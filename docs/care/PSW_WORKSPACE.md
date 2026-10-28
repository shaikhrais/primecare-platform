# PSW workspace

The `/psw` and `/care` routes use the approved named-provider workspace. Care staff default to live care; central administrators default to the populated database training demo. Code administrators can open the demo from their sidebar.

## Database training demo

`GET/POST /v1/governance/care/workspace` uses the current account session. Every active tenant receives a `team-demo` template with five named synthetic providers, six synthetic clients, thirteen visits and two unfilled requests. Ordinary care staff receive a private practice workspace restricted to their practice provider. Central administrators may select an active tenant; ordinary staff cannot override their tenant. No login accounts, clinical approvals or real patient appointments are seeded.

The server accepts explicit commands for booking and recurring appointments, rescheduling, cancellation, synthetic clock-in, task outcomes, notes, review, time review, incidents, availability, time-off requests, handovers, travel buffers and feedback. Commands enforce versions, idempotency, role restrictions and scheduling constraints. Changes are saved to PostgreSQL with immutable actor audit events. Conflicts restore the last saved UI state and require refresh. No offline save is advertised. Training time is not payroll. Handovers create database records; no external notification is sent.

## Live care

The live board reads native visits and provider profiles, scoped to the tenant and existing care authorization. Assigned staff only receive authorized appointments. Global code administration does not confer access to clinical records. Day, week and agenda views use Toronto time and include appointments crossing midnight. The read limit is 1,000 appointments over at most 31 days, with a visible truncation message.

Opening a record mounts the existing care workflow. Assignments, recurrence, nurse plans, independent supervisor approval, worker acknowledgement, consent, task outcomes, visit review, reported time, handovers and operational follow-up keep their existing server requirements. Missing credentials or readiness remain visible blockers. Real clinical records are never manufactured to populate the design.

## Verification and publication

`node scripts/test-psw-scheduling.mjs` covers scheduling, recurrence, conflicts, shifts and protected breaks. `PSW_TEST_DATABASE_URL=... node scripts/test-psw-workspace.mjs` runs isolated native PostgreSQL acceptance, including saves, direct SQL readback, tenant/account isolation, immutable audit and concurrent version conflicts. The test URL must be loopback and use the disposable `psw_test` database. PGlite is available for local acceptance through `PSW_PGLITE_MODULE`. `preview-psw-workspace.mjs` bundles the actual project UI and care API against isolated synthetic fixtures.

The PSW workflow runs acceptance before applying migrations, seeding missing tenant demos, publishing the governance worker and all existing portal builds. Seeding is idempotent and preserves previously saved demo edits. Release receipts contain counts and source revision, not patient data or credentials.
