# Code administrator hierarchy — 2026-10-21

User authorized Code_admin as the technical superuser, responsible for training Platform Admin and Tenant Admin. Canonical role code: `code_admin`; existing `platform_admin`, `tenant_admin` and `central_admin` identities remain intact.

Production governance registration 39587237622 passed exact-baseline rollback validation and idempotent application. It adds role 80 and access to existing screen 1269, and extends the existing platform hierarchy policy. No live user was created or promoted, and no independent approval was fabricated.

The implementation adds Code Admin to existing global tenant/account/reference administration. It can appoint Platform Admin and Tenant Admin. Code Admin remains bootstrap-only: no ordinary creation or role-update form can assign it. Code Admin accounts are protected from management and session revocation by lower administrators. Existing role/status changes revoke sessions and append audit atomically. Tenant Admin retains its active-tenant boundary. The shared EN/FR/ES administration view recognizes the role; Code Admin and Tenant Admin can use the existing self-study training panel. Training completion remains local self-study progress, not an approval or permission grant.

A protected first-Code-Admin workflow requires separately configured named email, existing root tenant and password secrets and explicit confirmation. It rejects existing accounts, duplicate first administrators, missing tenants and failed identity/audit persistence. It is not executed automatically, and this change does not choose an account owner.

Security run 39587583178 passed protected-bootstrap and existing platform/admin unit tests, native PostgreSQL provisioning/scope/revocation/audit-rollback tests, and API/UI type checks. Browser coverage and deployment remain pending at this checkpoint. MFA/security-key enforcement, time-limited elevation, emergency-account drills, tenant support approvals, trainer-assigned curricula, and general multi-role switching are not implemented by this bounded change. Full auth acceptance remains false. No universal database superuser or clinical-data bypass is introduced.
