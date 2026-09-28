# Approved account creation

User approved this policy on 2026-09-28: CEO creates accounts in their own tenant;
HR Director creates allowed staff accounts in their own tenant; other roles cannot
create accounts. Public registration is disabled. Reporting relationships confer
no API access. HR cannot assign CEO, HR Director, ownership, executive, or governance
roles. The exact conservative HR allowlist is in the reviewed governance migration.

`POST /v1/auth/register` accepts a bearer session and JSON fields `email`, `password`,
and `role`. Passwords require at least 12 characters and at most 72 UTF-8 bytes.
No tenant ID, organization ID, arbitrary permissions, or status is accepted in the
body. A supplied X-Tenant-Id must equal the authenticated creator's tenant.

Responses: 201 created (safe account fields), 400 invalid fields, 401 invalid session,
403 forbidden role/tenant, 409 account cannot be created, 503 service unavailable.
All auth responses are no-store. No password or hash is returned. Account insertion
and `account_created` audit insertion share a transaction; audit failure rolls back
the account. Existing normalized email matches are rejected rather than reassigned.

Before production deployment, apply `20260928_auth_account_audit.sql` after checking
production UUID user/tenant types and existing user constraints. The Worker fails
closed if its required schema is missing. The JSON permission policy is generated
from `auth_account_creation_policy` in governance.db, not from reporting lines.

The implementation does not yet provide account modification, password recovery,
email verification, rate limiting, or a first-CEO bootstrap workflow. Production
readiness and full auth completion must not be inferred from the registration tests.
