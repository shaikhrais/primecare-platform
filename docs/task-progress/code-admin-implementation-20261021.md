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
