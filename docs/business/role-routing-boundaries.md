# Role routing boundary repair

Source `f029fda98c6d1a3a79ecc513c4898e94a8e5ca62` removes substring role
inheritance from the shared Flutter RouteGuard. Previously an unregistered role
containing `admin` could use the legacy admin route prefix list. Prefix checks
also accepted sibling names such as `/commonality`. Roles now match an exact
normalized key and routes match an exact path or slash-delimited descendant.

Permission synchronization replaces the preceding snapshot even when the new
snapshot is empty. Both map and route lists are copied into immutable snapshots,
so mutation by a caller cannot expand access after synchronization. Explicit
server-supplied role entries remain supported. This client guard is navigation
defense; backend session, tenant and permission checks remain authoritative.
No production role, permission, route or grant is created by this repair.

The authenticated clinic browser confirmed account role `code_admin`, but
`/platform/administration` and `/dashboard` redirected to `/common/settings`.
The permissions page reported unavailable. Source inspection found the clinic's
explicit code-admin landing is `/success`; its static permissions do not contain
that exact role. The workspace snapshot registers platform administration as an
account renderer and has no code-admin landing. The separate TypeScript platform
administration implementation does not establish a functional Flutter clinic
administration route. Do not bypass these discrepancies by granting an admin
substring, changing the signed-in role, or writing tenant data directly in SQL.

Live tenant selection and HR department creation remain unverified. The login
itself succeeded; repeated login is not the repair for this routing discrepancy.
No live departments, provider handlers, extensions or permissions were changed.

Regression tests cover unknown role substrings, sibling route prefixes, existing
valid descendants, explicit server registration, empty-snapshot revocation and
caller mutation. The existing Flutter MFA verification workflow runs this suite
with auth/session/transport regressions and builds the clinic bundle. Its result
must be checked before claiming full validation or deployment.

The dashboard migration also changes one source fingerprint used by the existing
workflow contract review. The reversible amendment reconstructs the exact
historical business-development dashboard bytes and validates their original
SHA256; it does not replace that hash or award operation completion credit.
Local contract-plan validation and its 15 tests pass with all 1,063 unresolved
operation states preserved. Local sales-quality/OTP/task-approval checks passed
37 tests; one PostgreSQL-only check was skipped without its database fixture.
These are isolated checks, not live carrier, mailbox or clinical-task acceptance.
