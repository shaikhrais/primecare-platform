# Code administrator hierarchy — 2026-10-21

User authorized Code_admin as the technical superuser responsible for training Platform Admin and Tenant Admin. Canonical code: `code_admin`; existing platform, central and tenant administrator identities remain intact.

## Implemented scope

- Registered role 80, access to existing administration screen 1269, and the approved hierarchy in pinned production PostgreSQL. Run 39587237622 passed exact-baseline rollback validation and idempotent application. No live user was created or promoted.
- Code Admin can provision tenants and appoint Platform Admin and Tenant Admin using existing audited administration APIs. Ordinary account creation and updates cannot grant Code Admin. Lower administrators cannot modify its account or revoke its sessions; self-modification is denied. Existing role/status changes revoke sessions and append audit atomically. Tenant Admin retains its active-tenant boundary.
- EN/FR/ES role labels and login routing use governed role metadata. Code Admin and Tenant Admin can access the existing self-study training panel. Progress remains local self-assessment, never certification or permission authority. Instructor assignment and central learner records are not implemented.
- Protected initial setup requires separately configured named email, existing root tenant and password secrets, plus explicit confirmation. It rejects duplicate first administrators, existing email identities, missing tenants and failed identity/audit persistence. No live setup was executed and no account owner was selected.

## Validation and deployment

Focused run [39589493317](https://github.com/shaikhrais/primecare-platform/actions/runs/39589493317) passed **73 tests**, including native PostgreSQL provisioning, tenant boundaries, protected accounts, initial-account audit rollback/duplicate rejection, role-change session revocation, audit failure rollback, method-capture regressions and API/UI type checks. Actual browser UI/handler journeys with isolated native PostgreSQL passed EN1440/FR1024/ES768: login redirect, Platform Admin appointment, database persistence/reload, training and logout.

Release [39587851613](https://github.com/shaikhrais/primecare-platform/actions/runs/39587851613) passed API deployment, all nine website deployments and smoke checks with the login-routing repair. Runtime source is 0dd867c1cdcfd3e4ab3260bc28e13bd7cd70d1b0. Later commits add tests and source-binding/report changes without changing runtime behavior.

The earlier backend failure from a duplicate old account-administration fingerprint is preserved. The amendment proves all account-administration bytes outside the new protected-target exclusion match the previous binding; four unsupported method-capture workflows remain blocked. Replacement Auth Worker suites 39589493303 are still in progress at this checkpoint; they are not counted as passed.

Planning/factory provenance was regenerated after stale bindings were detected. Contract/generated-code CI 39589493330 passed. All 1063 unresolved operations remain unresolved with zero activation, implementation or retirement credit. Nine planning, fifteen factory and seven code-generation tests and reproducibility checks passed locally. Technical operation-register provenance is updated as well; local document coverage/source checks pass. Historical reviews and unresolved dispositions are preserved.

## Remaining work

This is the implemented administrator hierarchy and training-access slice, not full completion of every proposed security control or full auth acceptance. MFA/security-key enforcement, time-limited privilege elevation, emergency recovery-account drills, reason-bound/time-limited tenant support access, general assigned-role switching, physical-device/manual accessibility acceptance and independent reviews remain unfinished. Live Code Admin activation needs an identified owner and secure credential/MFA setup. No universal database superuser or clinical-data bypass was introduced, and no independent approval was fabricated.

Main is the only branch; no work branch or pull request was created.

## Approved owner binding update

The user selected the first Code Admin email. Its normalized SHA256 is pinned in `tools/governance-production/code-admin-owner.json` and in production policy `code-admin-owner-v1`; no plaintext owner email or password is committed. Protected CLI setup validates both the configured email against that pin and the live policy against the production manifest before creating an account.

Run 39595638844 passed rolled-back validation, idempotent production binding and read-only activation preflight. The selected email has no existing account. The protected email setting does not match the approved identity (missing or mismatched), password configuration is absent, and no active root tenant is selected by the protected configuration. MFA setup remains unfinished. No account, password, role assignment, session or outbound email was changed. This supersedes the earlier note that no owner was selected; it does not claim activation.

The earlier replacement Auth Worker run 39589493303 subsequently passed both UUID and text PostgreSQL suites.

## Control-tenant provisioning and production schema repair

Source 3411af600ac996a62ddd29d2570ab27d09d38aa5 provisions the dedicated `primecare-platform-control` tenant and binds its generated identity to `code-admin-control-tenant-v1` in the pinned governance policy. Protected account setup resolves this binding rather than requiring a manually selected clinical/root tenant. An explicitly supplied conflicting tenant identifier is rejected.

Live diagnosis found required production columns absent from the earlier tenant INSERT statements: `allowed_vpn_ranges`, `cors_allowed_origins`, `cors_allowed_methods` and `cors_allowed_headers`. PostgreSQL rejected the insert with SQLSTATE23502; no partial tenant was committed. Shared `createTenantRecord` now initializes these fields with the existing empty VPN range and empty CORS-list convention used by production auth fixture/seed scripts, validates the returned identity/name/slug/status, and is used by control setup, platform provisioning and partner onboarding. It grants no new CORS origins. API response projection remains unchanged.

Run 39598240589 passed six native PostgreSQL tests across UUID/text identity, concurrent idempotence, unbound-slug collision rejection, policy drift, inactive binding and atomic rollback. The production policy registration and provisioning then passed, reporting `created:true`, `rootTenantBound:true`, `accountChanges:0`. No user, credential or email was created. The first attempt's governance lock timeout and subsequent required-field failure remain historical failures.

Focused run 39598240604 passed 74 security tests, API/UI type checks and EN/FR/ES browser journeys. The broader API release is running at this checkpoint. A fresh owner preflight confirms the root tenant is now configured; the protected email setting is still missing/mismatched, the bootstrap password is absent, and MFA enrollment remains unfinished. Account activation is not complete.

Protected first-account setup now also enforces the registered owner readiness state. The current `owner-bound-not-activated` policy blocks live activation even if bootstrap credentials are configured; a later governed MFA implementation/readiness transition is required. This is an activation interlock, not an implemented MFA enrollment service. Two owner-policy tests pass locally. GitHub's connected tools cannot edit protected secrets; the browser settings were used for this unsupported operation, with user entry of the new bootstrap password. No password should be supplied in chat.

The API release in run 39598240589 subsequently completed successfully, including type checks, source validation, Worker deployment and deployed API/gateway checks. The required-field tenant-creation repair is deployed. The configured owner still has no account and MFA enrollment remains unfinished.


## MFA verifier foundation (2026-10-21)

Production owner preflight job 119249896383 passed: selected email matches, password is configured, control tenant is bound, and no Code Admin account exists or was activated. Secret values were not read or logged.

Added an isolated Web Crypto RFC 6238 primitive, validated against all 18 Appendix B vectors for SHA-1/SHA-256/SHA-512, including post-2038 times. The six-digit verifier accepts only current/previous counters, rejects future/expired/replayed counters and malformed codes, and returns a counter for a future atomic database consumption. Six local tests passed. Added it to the existing security CI.

This is cryptographic foundation only, not an enabled MFA flow. Enrollment, encrypted secret storage, rate limiting, atomic counter consumption, challenge-limited login sessions, recovery and governed UI/API registrations remain required before integration. No new UI, API or permission has been introduced. Code Admin activation remains locked. Reference: https://www.rfc-editor.org/rfc/rfc6238.html (Appendix B with corrected key lengths).


## MFA encrypted storage foundation (2026-10-21)

Previous verifier security CI 39608775312 passed. Added a server-only AES-256-GCM envelope primitive with random 20-byte seeds, random 96-bit nonces, 128-bit tags and authenticated context binding version, key identifier, tenant and user. Exact envelope shape and lengths are validated, with generic decryption errors. Four new tests exercise roundtrip, nonce freshness, wrong keys, tenant/user/key copying, tampering and malformed inputs; all ten combined crypto tests passed locally. Included in security CI.

This does not store real seeds or configure a key. Enrollment storage schema, production governance registration, key provisioning/rotation, rate limits, atomic one-time counter consumption, restricted login challenges, UI and recovery remain unfinished. No live endpoint, schema or permissions changed. Activation remains locked.


## Full-auth continuation: live authority and evidence repair (2026-10-21)

Read-only production MFA audit 39619417816 confirmed route registry id5 `/mfa` still has flow type `challenge_contract_pending` and there are no MFA/TOTP/passkey API endpoint records. This is an incomplete auth feature, not a verification-only gap.

Registered pending policy `mfa-auth-policy-v1` in the pinned production metadata through run 39619980268. Both rolled-back validation and repeated/idempotent application passed. Requirements cover fresh-password setup, encrypted tenant/user-bound seeds, five-minute purpose-bound challenges, five failed attempts, atomic replay prevention and session issue, credential/status revalidation, audit rollback and EN/FR/ES browser/API/database acceptance. The record explicitly preserves pending reviews, unimplemented status and activation=false. No API grant, user or business schema was changed.

Investigated own-session evidence failure 39610477438: the first attempt could not see three proof jobs; retry succeeded unchanged after all jobs became visible. The successful live producer 39612151456 has exact EN320/FR768/ES1440 proof jobs. Added a bounded visibility retry requiring those exact successful completed jobs and valid timestamps. Failed, skipped, duplicate, substitute-language and missing proof jobs still fail closed. Four regression tests and ten crypto tests pass locally. This repairs evidence collection only; it does not grant whole-auth verification credit.

Remaining actual MFA implementation: governed API/screen/control/localization registration, database credential/challenge migrations, server-key provisioning, enrollment and verification handlers, restricted login challenge handling, atomic counter/challenge/session writes, native fault/rollback tests, browser enrollment/login tests and real owner enrollment. Existing Code Admin bootstrap remains locked, and the owner has no live account. Full auth acceptance remains false.

Evidence repair run 39620117852 subsequently passed all tests, exact live-producer checks, deployed asset comparison and pinned production evidence recording. No whole-auth acceptance was asserted.

## Implemented web MFA and live production acceptance (2026-10-21)

This section supersedes the earlier notes describing MFA as unimplemented. The web Code Admin enrollment/login slice now exists and has passed live verification; it does not establish independent review approvals or native Flutter MFA acceptance.

- Registered the challenge API, existing screen949 web controls, EN/FR/ES resources and dedicated migration scope before integration. The native generated screen was preserved.
- Added encrypted MFA credentials, hashed five-minute purpose-bound challenges, five-attempt limits and MFA audit records. No full session is issued before factor verification. User, tenant, role, password version and active/pending status are revalidated while locked. Counter consumption, challenge deletion, pending-account activation, audit and session issuance commit atomically.
- Enrollment displays a 32-character setup key only after password verification. Enrolled logins never return the key. A fresh password exchange invalidates an older challenge and renews an unconfirmed setup key. Password recovery does not disable MFA.
- MFA setup and verification use the shared login client. Challenge and setup key stay in memory; only the confirmed full session is stored. MFA cancellation clears credentials and returns keyboard focus. A CSS correction makes the hidden password form override its grid layout.
- Production migration was validated in rollback and applied idempotently. A dedicated random 256-bit server encryption key was provisioned without printing or retrieving its value. Existing secrets are retained; no automatic rotation occurs.
- GitHub security run39622762620 passed 85 security tests, seven native MFA scenarios for each text and UUID identity storage (including concurrent requests producing exactly one session), API/UI type checks, EN320/FR768/ES1440 MFA browser journeys and Code Admin delegation/training/logout journeys in all three languages. The final focus/cancellation build has additional client tests and passed security run39625187848.
- Production release39623349726 deployed the auth Worker and all nine portals. Its live browser/public gateway/native PostgreSQL tests passed EN320/FR768/ES1440 enrollment, wrong-code denial, no premature session, encrypted persistence, reload, logout, replay denial and exact synthetic cleanup. Release39624385792 repeated live acceptance after the abandoned-enrollment repair.
- The approved owner was created only as `mfa_pending` after successful current-source live proof in release39624385792. No full session or plaintext MFA seed was created for the owner by the workflow. The original active-account bootstrap readiness lock remains closed. Only successful personal authenticator confirmation can activate this pending account.
- Reconciled the legacy public login record (API2) with deployed password/session and MFA challenge responses. Its dry-run/idempotent production cutover passed run39625450029. No role grants or account assignments were changed by this metadata correction.
- Planning provenance was regenerated after auth.ts changed; 9 planning, 15 factory and 7 bulk-generator tests pass, with reproducible output, unchanged historical operation counts and zero activation/implementation credits.

Personal completion: sign in at https://primecare-clinic.pages.dev/login?enable-semantics=true using the approved email and the privately configured bootstrap password. Add the displayed setup key to an authenticator and enter its six-digit code directly in PrimeCare. Do not send a password, setup key or authentication code through chat. An interrupted setup requires a fresh sign-in and uses a new key.

Scope limits: automated production evidence is Chromium web at the stated locales/viewports. Physical devices, native Flutter MFA presentation, independent security/accessibility/localization reviews and broader privilege-elevation/support-access features have not been accepted by this work. Lost-factor recovery and key rotation require separately governed operator procedures; there is no automatic bypass. Whole-platform auth sign-off must not be inferred from this MFA slice.

Final UI/focus release39625187820 passed deployment of the auth Worker and all nine portals, live EN/FR/ES browser/API/PostgreSQL acceptance and preservation of the existing MFA-pending owner. Its security job passed 88 security tests, both sets of seven native MFA scenarios and the browser suites. Production evidence run39626585014 set only the challenge API and its six web controls to `implemented-scoped-tested` and stored source-bound live proof. It explicitly recorded reviewApprovals=false and wholePlatformAuthVerified=false. The owner-status diagnostic reads only booleans and aggregate session counts; no password, setup key, seed, token or account identifier is emitted.

Final owner diagnostic39626666887 confirmed accountExists=true, pendingEnrollment=true, mfaEnabled=false, activated=false and activeSessions=0. Personal authenticator enrollment remains the required activation handoff. Remote branch inventory remains main only.


## Owner enrollment completed and current web auth verified

The owner completed personal authenticator confirmation and reached the dashboard on Android. Fresh read-only diagnostics39626666887 (rerun job119450089381) and current production auth job119452370737 confirm pendingEnrollment=false, mfaEnabled=true, activated=true and activeSessions=1. This supersedes the earlier pending-owner status.

Complete current web verification39666003000 passed on attempt2: native text/UUID lifecycle and rollback proofs, 22 production auth checks, live MFA in EN/FR/ES, 255 account read/mutation checks, 90 live session checks and 60 standalone real-mail recovery checks. A cancelled prior producer had stranded exactly five synthetic accounts in two test tenants; guarded rollback/apply cleanup39667612137 removed only that fingerprinted fixture. Source/deployment identity, main-only state and exact cleanup were verified. Details and acceptance boundaries are in `auth-full-web-verification-20261021.md`. Native Flutter MFA, governed lost-factor recovery/key rotation, independent reviews and broader security controls remain outside this completed web proof.
