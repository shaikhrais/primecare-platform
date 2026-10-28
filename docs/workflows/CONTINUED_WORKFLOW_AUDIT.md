# Continued workflow audit

## Expanded tenant launch and client acquisition — 2026-10-28

After the CEO marketing correction, [run 40679400005](https://github.com/shaikhrais/primecare-platform/actions/runs/40679400005), source `2f144b3841790e69c13000ea31dd29ef0eba2111`, passed its expanded tenant job, client job, growth, account and workspace jobs.

| Added suite | Passing evidence |
| --- | --- |
| Territory allocation | 17 native database/browser cases covering catalogue/readiness boundaries and authorized service-area allocation. |
| Tenant launch, documents and support | 35 native database/browser cases, including uploads/downloads, signature/size checks, versioned review, renewal/expiry, human launch approval, correction/resubmission, support deadlines/resolution/reopen, audit rollback and real concurrent enquiry delivery. Includes six EN/FR/ES operational flows and six workflow-filter cases at 320/1440 pixels. |
| Public marketing enquiry handoff | 19 native database/browser cases, including six full marketing-link → public-form → recipient-acceptance journeys in EN/FR/ES at 320/1440 pixels. Consent, first-touch attribution, readiness, withdrawal, opt-outs, contact concealment, rate limiting, transactional rollback and native concurrent submissions are exercised. |

The tenant job also retained its 159 authority tests, 16 operations cases and 120 PostgreSQL authority checks per text/UUID identifier format. The client job retained 296 API tests and 329 native PostgreSQL checks per identifier format; the auth fixture's 90 baseline checks ran per format as a prerequisite. These counts overlap earlier evidence and are not distinct workflow totals.

No new tenant/client runtime defect was reproduced in these added suites. Their assertions were retained. No production approval, customer account, clinical appointment, message, advertisement or charge was created. Real launch acceptance and external provider integrations remain separate.

## Report drafts and business navigation continuation — 2026-10-28

Reproduced and fixed another CEO workflow failure: opening a successful report cleared unfinished lead and campaign forms. Read-only report and PDF actions now restore drafts after a successful list reload only when the user, tenant and role remain the same. Successful creation still clears its form; report failure preserves retry drafts. Existing row version checks still prevent restoring a stale row over newly returned server values.

The marketing sidebar now exposes its existing website-enquiry, business/finance and plan sections using server capabilities and existing EN/FR/ES labels. No authorization grant or new business endpoint was introduced. The source seed and generated policy contain the same navigation definitions; the complete policy export is also checked against registered metadata in memory after its inherited media dependencies.

[Run 40678970392](https://github.com/shaikhrais/primecare-platform/actions/runs/40678970392), runtime source `02cc055349f39c8aa9f6f1e26e67f7aa7bb1e712`, passed the growth, tenant, client, account and workspace jobs. Growth evidence: 45 contract/workforce/renderer checks, eight native PostgreSQL groups, 34 marketing browser cases, eight partner/admin browser cases and six loading/retry cases. Six EN/FR/ES browser cases at 320/1440 pixels check draft preservation through both real report rendering and actual PDF download. Eight controlled renderer cases cover statements/downloads, failure, tenant/role changes and successful create clearing; these are included in the 45 checks.

[Production publication succeeded](https://github.com/shaikhrais/primecare-platform/actions/runs/40678970314). No message, advertisement, charge or production business record was created by these tests. Live provider launch/delivery and broader unimplemented operations remain open.

## CEO marketing priority and tenant/client continuation — 2026-10-28

The user prioritized CEO marketing before tenant and client work. The [current operating checklist](../marketing/CEO_MARKETING_READINESS.md) separates usable manual business workflows from unavailable advertising-provider launch, live outbound delivery and payment collection.

Two application defects were reproduced and fixed: overlapping marketing reads could overwrite newer figures or replace success with a stale error; workspace sidebar/search navigation opened a generic `/growth` overview instead of the working marketing renderer. Regression checks failed before the corresponding fixes and passed afterward. Dedicated growth landings now hand off to that renderer too.

[Run 40631136226](https://github.com/shaikhrais/primecare-platform/actions/runs/40631136226), runtime source `63e1a0f2604ccc4372cbc5d121f840599200592c`, passed the growth, workspace, account, tenant and client jobs. Counts below are test/check evidence, not a count of distinct completed workflows.

| Area | Evidence |
| --- | --- |
| CEO marketing | 37 contract/workforce/refresh-order checks; eight PostgreSQL groups; 34 marketing browser cases; eight partner/admin browser cases; six loading/retry cases. |
| Workspace | 18 screen-text/training checks, 43 workspace/client checks and six credential-login/sign-out browser cases. The two new navigation checks cover the CEO sidebar and universal search. |
| Tenant | 159 authority tests; 16 database/browser cases including six EN/FR/ES operations correction flows at 320/1440 pixels; 120 native PostgreSQL authority checks for each text/UUID identity format. |
| Client | 296 API tests; for each text/UUID auth format: 68 self-service read checks, 42 booking lifecycle checks, 63 owned-record checks, 38 care-metadata checks, 96 PSW record-metadata checks and 22 family-notification checks. These are selected authorized reads and booking mutations, not all client actions. |

The auth fixture also passed its 90 baseline checks per identifier format in the account, tenant and client jobs. These are repeated prerequisites, not additional business workflows. All domain data was synthetic in disposable PostgreSQL databases. No production tenant/client record, permission, provider action or formal review status was changed.

The continuation runner now includes dedicated tenant/client suites and validates named loopback database targets before resetting its disposable auth database. Local client/tenant contract verification passed 455 tests. The final JSDOM harness correction also passed all 43 workspace/client checks locally and asserts that navigation has no uncaught event failures.

## Earlier snapshot

Snapshot: 2026-10-27, America/Toronto. This is a test-evidence snapshot for selected implemented workflows, not a statement that every platform workflow is complete or production-approved.

[Download/read the workflow status list](WORKFLOW_TEST_STATUS.csv). It distinguishes passing isolated checks, unsupported account deletion, live-provider checks, and unresolved contracts.

## Result

[Business workflow continuation audit](https://github.com/shaikhrais/primecare-platform/actions/runs/40625134473): **all four jobs passed** on source `ebda6865848d92381106d09fabd3606b86bc8ad6`.

| Area | Passing evidence |
| --- | --- |
| Accounts | 106 client/API tests; auth setup/acceptance 90 checks per identifier type; account administration 37 PostgreSQL checks per type; personal care metadata 33 PostgreSQL checks per type. Both text and UUID identities were used. |
| Care | 211 tests across contracts, real PostgreSQL, state transitions, concurrency, rollback, staffing, schedules, dependencies and browser interactions. Six loading/retry cases passed. Six credential-login/availability browser cases plus eight API check groups passed against embedded PGlite; those are sequential, not native concurrency evidence. |
| Growth | 35 contract/workforce tests, eight database test groups, 34 growth browser tests, eight partner/admin browser cases and six loading/retry cases passed. |
| Workspace | 18 screen-text/training checks, 41 workspace/transport checks and six real-browser credential-login/sign-out cases passed. Sign-out covers database failure, offline retry, malformed acknowledgements, lost responses, session replacement and foreign-session preservation. |
| Calls and tools | [Independent call audit run](https://github.com/shaikhrais/primecare-platform/actions/runs/40625602769) passed: 77 tests with native grant evaluation, PostgreSQL concurrent append/deduplication/conflict/isolation/tamper checks, and real workerd provider-projection, synthetic spoken-SMS and callback-boundary tests. Its production deployment job was skipped. |

Counts describe tests/checks and include overlap. They must not be added together and called a count of distinct completed business workflows.

## Repairs made

The reproduced failures in this continuation were test infrastructure and outdated navigation expectations. No application runtime behavior was patched in this batch.

- Installed the shared voice SDK needed to bundle the screen-text release tests, and included the QR decoder required by growth tests.
- Provisioned the pinned Python governance-reader dependencies and explicit isolated fixture mode for the care login/availability test.
- Updated partner/admin and workspace browser tests to use the current page headings, dedicated administrator destination, dashboard summaries and More menu. Tenant/role checks and save/failure assertions remain in place.
- Restored the DOM constructors required by the workspace unit harness. Its bundled source now has a file URL so exceptions remain readable instead of producing multi-megabyte base64 stack traces.
- Reused the attributed-JSON source-path helper when recording workspace source hashes; source hashing remains enabled.
- Added a repeatable continuation workflow with separate account, care, growth and workspace jobs. The runner writes a receipt after every group, retains failures, streams readable logs and terminates the entire stalled test process group at its deadline. A timeout remains a failed result.
- Expanded the independent call audit tests to cover voice-tool failure boundaries and native PostgreSQL endpoint grants instead of skipping that native check.

## What remains

- Account deactivation and session revocation are implemented and tested. Permanent account deletion is not supported by the current platform administration handler; this audit did not invent a destructive deletion policy.
- These results use disposable databases, test identities and controlled provider responses. Real SMS delivery, real Vapi call completion and current production caller registration still require live end-to-end evidence.
- The existing [workflow contract plan](../api/WORKFLOW_CONTRACT_PLAN.md) contains 1,063 unresolved API operations. That is API catalogue debt, not a count of workflow test failures. No pending operation was silently marked implemented, retired or approved.
- Generic role-page navigation is read-only presentation evidence. Pending business actions on those pages remain pending.
- Formal workflow review states, production-ready flags and independent approvals are not inferred from this passing test batch.

## Reproduce

The workflow is `.github/workflows/business-workflow-audit.yml`. It installs isolated tools and runs `node scripts/run-business-workflow-audit.mjs account`, `care`, `growth` or `workspace` with its disposable database/fixture configuration. Per-group logs and JSON receipts are uploaded in the `business-workflows-*` artifacts.
