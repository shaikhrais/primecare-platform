# Auth completion work in progress

User instruction: continue until all stated auth tasks are done. Work remains main-only. Do not represent the following foundations or registrations as active features.

## Completed baseline

Deployed web auth previously passed real login, account management, owned receiving-Worker recovery, session controls and MFA tests. Native Flutter MFA and its code-clearing/cancellation/malformed-response cleanup fixes passed 416 focused tests, Auth Gateway/contract CI and all nine portal deployments. Evidence is in the individual auth task-progress records.

## Current work

The live Flutter MFA producer is `.github/workflows/verify-live-flutter-mfa.yml`, with `tools/auth-verification/test-live-flutter-mfa.py`. It deploys a source-bound clinic bundle and tests EN320/FR768/ES1440 against synthetic Code Admin fixtures and the actual gateway/PostgreSQL. Initial producer39695647961 failed a test catalog parser before any fixture; that parser was corrected. Producer39695686227 completed cancellation, fresh password exchange and old challenge denial, then failed its setup-key semantics assertion; cleanup succeeded. The assertion now inspects Flutter accessible text/values with redacted failure diagnostics. Check the latest producer before claiming success.

`record-flutter-mfa-evidence.yml` will record only complete source-bound live proof for the six existing native controls, with independent approvals and whole-auth credit explicitly false. Its receipt validator passed 11 local rejection/acceptance tests. No native live evidence has been assumed from failed producers.

Lifecycle policy registration39696298467 succeeded. Surface registration39696620118 passed rollback validation, then hit a transient production lock timeout during apply; it was retried. Confirm its latest attempt and the notification-resource amendment before implementation. The defined APIs are recovery-code issuance, authenticator replacement initiation, saved-code recovery and new-factor confirmation. The existing MFA screen is949. The initial dry run allocated API ids16497–16500; use actual applied values, not this historical allocation, as authority.

The lifecycle foundation and exact production schema pipeline passed in run39698578870. It validated rollback and native PostgreSQL text/UUID identities, then applied the four empty recovery/replacement/audit/outbox tables. Existing accounts and MFA credentials were unchanged. The expanded foundation suite passed 59 checks. The management entry on the existing account screen was registered successfully in run39699777091.

Recovery/replacement routes, Flutter core authority handling, localized presentation and leased notification delivery remain an isolated candidate, not enabled production features. The source patch and SHA256 manifest under `tools/auth-verification/auth-lifecycle-candidate.*` preserve the candidate on main without triggering runtime deployments. Its workflow applies the patch, checks generated catalog reproducibility, runs native PostgreSQL suites and Flutter regressions, and builds the clinic bundle without production secrets. The first candidate run39700796022 stopped at an incorrect baseline comparison in the harness; native lifecycle checks passed before the worker test found a missing TypeScript dependency. Both harness issues were corrected. Check the latest run before claiming candidate success.

Local draft validation: keyring/recovery primitives24 passed; worker inheritance/routes20 passed; MFA database flow7 passed in PGlite with the native concurrency case explicitly skipped. Native concurrency remains a CI requirement. Worker TypeScript checking passed. Dual-key MFA login now exists only in the candidate and defaults to v1; no new production key has been provisioned or activated.

Shared-account registration tests exposed a literal LIKE-percent parameter issue in the production adapter. The namespace is now passed as a bound parameter. Related recovery registration and workflow-evidence recording also hit production lock timeouts; retries and latest results must be checked. No failed attempt is accepted as completion evidence.

## Remaining implementation

1. Finish live Flutter MFA proof and record scoped production evidence. Fix actual failures without weakening tests.
2. Recovery/replacement backend: fresh password/current-factor checks, self-only Code Admin session proof, atomic single-use saved codes, purpose/password/envelope-bound five-minute replacement challenges, five-attempt limits, audit plus durable localized notification outbox, old factor retained until new proof, then revoke sessions/codes/challenges and issue one confirmed new session. Connect registered APIs only after their production registration succeeds.
3. Flutter lifecycle presentation and core authority: management on the existing MFA route, saved-code entry during a password-verified MFA challenge, new-factor setup/confirmation, one-time saved-code display. Core owns API calls and session confirmation; UI may never manufacture authority. Do not leave codes/keys in logs, storage, screenshots or expired form state.
4. Server key rotation: wire the fixed v1/v2 keyring, preserve old-key reads during migration, verify every rewrap, support controlled rollback, provision a separate new key without reading/exporting the existing Worker secret, and retire nothing until old envelopes are zero and a recovery drill passes.
5. Time-limited elevation and tenant support: requirements are registered but their API/screen/action metadata and implementation are not. Require fresh MFA, explicit narrow actions/reason, max900 seconds, session binding, audit, and tenant-admin approval/revocation for tenant support. No impersonation or clinical-data access.
6. Reconcile stale historical implementation labels with scoped live evidence; registration snapshots are not current implementation status. Preserve review/approval history.
7. Independent security/accessibility/localization/architecture/database approval and real physical-device acceptance remain separate human/external gates. Do not fabricate them from automated tests or the owner's one successful Android login.

Recovery requirements follow the saved-code and authenticator lifecycle guidance in https://pages.nist.gov/800-63-4/sp800-63b.html. The new policy requires 128-bit saved codes plus a fresh password and confirmation of a new factor; no code/no factor continues to deny access.
