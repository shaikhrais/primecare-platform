# Temporary elevation and tenant support

Status: deployed scoped engineering is verified for source `116d1eb30108f4590493a3cf1a209d7d5312ac63`. The [EN/FR/ES browser/API/database/reload producer](https://github.com/shaikhrais/primecare-platform/actions/runs/39733869467) and [scoped production evidence recorder](https://github.com/shaikhrais/primecare-platform/actions/runs/39735678464) passed. No role grant, independent review approval or whole-platform production readiness is implied.

Code Admin verifies the current password and a fresh, unreplayed authenticator code for one explicit action: `tenant_security_summary`. The server issues an opaque elevation ID bound to the verified user, home tenant and hashed current session. It expires within 900 seconds. The normal role and session lifetime do not change.

A support request adds a target tenant, ticket and reason. Its deadline cannot exceed the elevation deadline or 900 seconds from creation. A current active Tenant Admin of that target tenant must explicitly approve it using their current password. Code Admin cannot approve their own request. A Tenant Admin of another tenant cannot list, approve or revoke it.

Each summary request rechecks the requesting session, current account status and role, originating tenant, current elevation, exact action scope, approval and target tenant status. It returns aggregate counts of active accounts, active sessions and enrolled authenticators for the approved tenant. It returns no names, email addresses, individual account records, clinical records or impersonated session. An audit failure prevents the response.

| Registered operation | Authority and result |
| --- | --- |
| `POST /v1/auth/mfa/elevation` | Code Admin session plus fresh password and authenticator; scoped elevation only |
| `POST /v1/auth/mfa/elevation/revoke` | Same Code Admin and originating session; revoke elevation and dependent use |
| `POST /v1/auth/mfa/support/request` | Current scoped elevation; request target-tenant approval |
| `GET /v1/auth/mfa/support/requests` | Tenant Admin sees up to 50 current requests for their own tenant |
| `POST /v1/auth/mfa/support/approve` | Target Tenant Admin plus current password; explicit approval before expiry |
| `POST /v1/auth/mfa/support/revoke` | Target Tenant Admin or requesting Code Admin plus current password |
| `POST /v1/auth/mfa/support/summary` | Same requester and originating session, current elevation and tenant approval; audited aggregate counts |

## Persistence and transaction boundaries

`auth_privilege_elevations` stores user, home tenant, session hash, reason, exact scope, creation, expiry and revocation. `auth_tenant_support_requests` stores the original elevation and session binding, target tenant, ticket, reason, approval and revocation. `auth_privileged_access_audit` records actor and tenant, referenced elevation/request, action and server timestamp. It contains no password, factor, seed or raw session token.

Lock the actor before capability records, matching MFA/session mutation ordering. Fresh authenticator consumption and elevation issuance must commit with their audit. Approval, revocation and summary access must commit with their audit. Recheck actor and session inside the transaction. Use current database time for expiry and server-derived identity for all authority decisions. Role changes, disabling the actor, logout, password change, MFA replacement, session expiry or revocation must deny later use without relying on a UI timer.

A rejected proof is bounded by the registered per-user proof limit. List and summary operations need bounded authenticated traffic limits. Denied requests must disclose no other tenant's records. The UI clears passwords, factors and transient capability IDs on cancellation, expiry, logout, actor replacement and disposal. Core services own endpoints, scope and authority validation; presentation renders the registered EN/FR/ES catalog.

The tenant account view loads pending requests after verified session restoration. Actor replacement or sign-out clears proof state and discards queued or late reads. Core services and the server retain authority over every request.

## Required acceptance

Verify text and UUID database identities, 900-second constraints, rollback, explicit scope, wrong/replayed factor, wrong password, missing/revoked/expired session, changed actor/tenant/role, disabled account, cross-tenant approval denial, self-approval denial, approval expiry, tenant revocation, originating-session binding, concurrent revocation and audit fault rollback. Seed two tenants with different aggregate counts and verify each approved summary remains scoped. Repeat browser/API/database/reload checks in EN320, FR768 and ES1440, with exact synthetic cleanup.

Architecture, database, security, accessibility and localization reviews remain independently pending. Physical-device acceptance is separate from browser and widget checks.

The review follow-up at `4ada3b8729a626d10560a7c2980035bf172b3640` passed the full [EN/FR/ES lifecycle/support producer 39774933735](https://github.com/shaikhrais/primecare-platform/actions/runs/39774933735) and [scoped recorder 39777265212](https://github.com/shaikhrais/primecare-platform/actions/runs/39777265212). Auth API/UI behavior is unchanged; browser interaction verification was repaired. See [the technical review](auth-review-20261022.md) for preserved failures, actual owned-inbox delivery evidence and separate remaining acceptance gates.
