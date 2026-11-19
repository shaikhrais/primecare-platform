# Proposed Clinical Director branch mapping

Draft only. Nothing here is included in migrations, routes, grants, or production releases.

- Branches are provisioned explicitly within a tenant, then a named user is assigned a time-bound branch grant. No assignment is inferred from a booking, job title, or dashboard grant. Empty tables grant no access.
- The effective scope requires an active same-tenant Clinical Director, active tenant, and an active and unrevoked assignment on every request. The query takes actor/tenant from verified server context; caller-provided identity must never be passed through. Revocation, expiry, disabled identity, and mismatched tenant all return no scope. An authorized empty branch returns a measured zero.
- Before adding a migration, verify actual production identifier types and determine the approved branch directory or imported branch IDs, the provisioning role, and grant/revoke audit rules. A production writer must check role, ownership and same-tenant membership in its transaction and invalidate assignments on tenant or permanent role changes. The fixture deliberately tests that even a stale cross-tenant assignment cannot be used. Do not seed grants automatically.
- The example counts bookings in a fixed half-open UTC window only. It is not an approved dashboard metric or response schema. Only aggregate counts are projected. Bind the final metric definition, reporting timezone and authentication/permission checks before registering an endpoint.
- Verify migration and role privileges in a disposable native PostgreSQL database before requesting separate migration approval. Verify the API on the exact reviewed main commit in GitHub Actions; never use this draft as an alternate production data source or as publish approval.
