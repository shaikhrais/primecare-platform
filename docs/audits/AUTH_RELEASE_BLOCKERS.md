# Auth release evidence and remaining work

Verified GitHub run 36456902193 passed unit tests, type checking and real PostgreSQL
registration/session integration tests. It is evidence for an isolated fixture
database only. No production login or registration claim is made.

First-CEO bootstrap is available as a manually triggered workflow using the
production environment. It requires PRODUCTION_DATABASE_URL, BOOTSTRAP_TENANT_ID,
BOOTSTRAP_CEO_EMAIL and BOOTSTRAP_CEO_PASSWORD secrets. The tenant must already be
active. Existing accounts are never promoted, moved, reset or overwritten. A tenant
with any CEO cannot be bootstrapped again. A missing required migration causes a
rollback. The workflow never outputs passwords or database connection details.

Apply the account and bootstrap audit SQL migrations only after verifying actual
production schema compatibility. The bootstrap workflow does not apply migrations
or create a tenant automatically. Deployment and production credential entry have
not occurred as part of these changes.

Account modification/deactivation, password change and login rate limiting now have
passing isolated PostgreSQL CI evidence (run 36458402955). The deployment workflow
now includes a read-only required-column/type and basic table-privilege preflight.
This gate does not validate all constraints, indexes, row-level policies or production journeys.

Still incomplete: password recovery, broader abuse controls,
email delivery/verification, tenant membership lifecycle, production
schema verification and migration, protected first-CEO execution, Cloudflare
deployment, and authenticated public-URL verification. The auth pages remain deferred.

Do not mark the 100-task auth plan complete based on the passing subset of tests.
