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

Protected first-account setup now also enforces the registered owner readiness state. The current `owner-bound-not-activated` policy blocks live activation even if bootstrap credentials are configured; a later governed MFA implementation/readiness transition is required. This is an activation interlock, not an implemented MFA enrollment service. Two owner-policy tests pass locally. GitHub's connected tools cannot edit protected secrets; browser fallback requires user approval before configuration of the selected email and a generated bootstrap password. No password should be supplied in chat.

The API release in run 39598240589 subsequently completed successfully, including type checks, source validation, Worker deployment and deployed API/gateway checks. The required-field tenant-creation repair is deployed. The configured owner still has no account and MFA enrollment remains unfinished.
