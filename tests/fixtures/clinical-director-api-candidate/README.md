# Proposed Clinical Director branch mapping

Draft only. Nothing here is included in migrations, routes, grants, or production releases.

- Branches are provisioned explicitly within a tenant, then a named user is assigned a time-bound branch grant. No assignment is inferred from a booking, job title, or dashboard grant. Empty tables grant no access.
- The effective scope requires an active same-tenant Clinical Director, active tenant, and an active and unrevoked assignment on every request. The query takes actor/tenant from verified server context; caller-provided identity must never be passed through. Revocation, expiry, disabled identity, and mismatched tenant all return no scope. An authorized empty branch returns a measured zero.
- Before adding a migration, verify actual production identifier types and determine the approved branch directory or imported branch IDs, the provisioning role, and grant/revoke audit rules. A production writer must check role, ownership and same-tenant membership in its transaction and invalidate assignments on tenant or permanent role changes. The fixture deliberately tests that even a stale cross-tenant assignment cannot be used. Do not seed grants automatically.
- The example counts bookings in a fixed half-open UTC window only. It is not an approved dashboard metric or response schema. Only aggregate counts are projected. Bind the final metric definition, reporting timezone and authentication/permission checks before registering an endpoint.
- Verify migration and role privileges in a disposable native PostgreSQL database before requesting separate migration approval. Verify the API on the exact reviewed main commit in GitHub Actions; never use this draft as an alternate production data source or as publish approval.

## Approved access rule and separate migration review

The proposed migration and the grant/revoke statements are `migration-review.sql`, `grant-review.sql`, and `revoke-review.sql`. They are intentionally fixture files, not pieces of the live migration sequence. The original read prototype and its tests remain unchanged.

- Only a current active same-tenant `tenant_admin` with an explicit active authorization can assign or revoke a verified branch grant. Do not seed any tenant, user, branch, or authorization from these fixtures.
- The onboarding source for verified branch IDs and the operator that authorizes grant admins must be independently reviewed. Never accept a directory or administrative grant from caller payload. No database role is granted access by this candidate; implementation must bind a narrowly scoped service principal and trusted session identity before enabling a writer. Permanent role or tenant changes must explicitly invalidate old scope rather than allowing dormant grants to revive.
- Production metadata existence/type preflight, separate database release approval, and persistence/permissions verification are required before integration. If the application uses UUID instead of Prisma text identifiers, prepare an explicit compatible revision; never cast to bypass identity constraints.
- Rollback plan for a future approved deploy: turn off the grant writer and clinical dashboard read path first; preserve the access audit and existing grants for review. Do not drop or rewrite audit history as an automatic rollback.
