# Core authentication deployment evidence

Verified 2026-09-28, America/Toronto. No credentials are included in this report.

| Gate | Result | GitHub Actions run |
|---|---|---|
| 50 local tests and Worker type checking | Passed | Local; auth suite also executed in CI |
| PostgreSQL UUID and text-ID matrices | Both passed | 36462832340 |
| Additive production auth migrations | Passed | 36463366031 |
| 12 API Workers, then service-bound gateway | Passed | 36463534382 |
| Production public-API smoke | 17 checks passed | 36465061031 |
| Temporary QA tenant, accounts and counters | Removed | 36465061031 |

Public gateway: https://primecare-api-gateway.itpro-mohammed.workers.dev

Auth Worker: https://primecare-auth-api.itpro-mohammed.workers.dev

The deployed API release commit is de7f8db722a97fef42a91d75b29d8cbbe95aeb46.
The successful smoke workflow used dfb8ee5ca7cf576235c3a0f8585bfa3d10ef5b58.
Later documentation/operator-script commits do not imply another Worker release.

## Production checks

1. Invalid login rejected.
2. Successful login resolves the fixture CEO from backend data.
3. GET session identity matches the authenticated user.
4. POST session identity matches the authenticated user.
5. Cross-tenant account-creation header rejected.
6. Authorized same-tenant account creation succeeds.
7. Created account is read back from PostgreSQL with the correct tenant/role.
8. Created RMT account authenticates through the public gateway.
9. Ordinary role cannot create a CEO.
10. CEO deactivates the fixture account.
11. Deactivation revokes its session.
12. Current-password-authenticated password change succeeds.
13. Password change revokes the old session.
14. Old password is rejected.
15. New password authenticates.
16. Logout succeeds.
17. Logged-out session is rejected.

## Corrections made

Production uses text identity columns, while initial fixtures assumed UUID. The
additive migration derives compatible types without converting existing users or
tenants. Account inserts supply an ID explicitly and maintain Prisma's required
updated_at field. The schema preflight uses a client-side timeout compatible with
the pooled database and returns only sanitized diagnostic categories.

Governance supports the registered POST session lookup and approved GET compatibility
using one handler. Generated OpenAPI documents seven operations. Native-build trigger
filters exclude isolated auth operator scripts; superseded native runs were cancelled
to release test/deployment runner capacity.

## Scope limits

Recovery/delivery, broader abuse controls and counter-retention automation remain
unfinished. The permanent first CEO has not been created. QA fixtures were synthetic,
isolated and removed; they are not reusable login accounts. No UI-login or complete
portal verification is claimed. See AUTH_TASK_STATUS.md for current task indicators.
