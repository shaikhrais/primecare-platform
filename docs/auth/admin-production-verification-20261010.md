# Admin production verification — 2026-10-10 Toronto

## Result and provenance

[Final verification run 38099908370](https://github.com/shaikhrais/primecare-platform/actions/runs/38099908370) passed both the reusable isolated gate and the live Support job. The [Support portal](https://primecare-support.pages.dev/) uses the production Gateway at `https://primecare-api-gateway.itpro-mohammed.workers.dev/v1/auth`.

[Deployment run 38099296450](https://github.com/shaikhrais/primecare-platform/actions/runs/38099296450) successfully built and published the Auth Worker and Support Pages from source commit `1086c7793d861723b4075eb705c4d56e78e64e75`. Auth Worker version: `133284ce-98a3-4496-852c-3f9147245e27`. That run’s first live test stopped because it clicked the status selector before refresh finished; the fixture was removed. The shared scenario now waits for the workspace response and enabled controls. Verification commit `e0704a5409e33bb32dbfbb010e503e52f2e2170a` changes verification synchronization and workflow controls, not the deployed business/UI implementation. The final run verified the existing deployment without republishing it.

## Verified behavior

The isolated gate passed Worker checks, 90 Auth plus 46 Admin PostgreSQL/Gateway cases, 37 model/90 core/17 UI tests (one additional core test skipped), 114-key EN/ES/FR catalog validation, a release build and all three language browser scenarios. Real two-page filtered pagination is covered in the isolated database; the live fixtures each contain only two accounts.

Live verification used one unique synthetic Admin tenant per language and the exact public Support/Gateway origins. Each language passed five policy cases: no session rejected, tenant-header mismatch rejected, invalid status filter rejected, Admin-role escalation rejected, and self-update rejected. These are 15 policy cases plus three complete browser scenarios, not additional API operations.

Every live browser scenario signed in with the Admin role, opened the inherited workspace and task overview, created a Client account, authenticated that account, rejected its Admin access, changed email/role and deactivated it, verified persisted state and session denial, reactivated it and authenticated again, deactivated it again and verified the new session was revoked, refreshed, combined email/status filters, checked empty Active results and Inactive results, cleared filters independently, reviewed account-bound and tenant audit history, and signed out. The browser and database checks use the same shared scenario as CI.

Cleanup ran in a transaction for each owned tenant: account and management audits, sessions, password-related fixtures, account/email rate counters, users and tenant were removed. The script verified no owned tenant, user or session remained. It neither modifies real users nor resets production rate policy. Passwords/tokens/database URLs and response bodies are not logged.

## Central structure and task scope

The nine workflows and their instructions remain in the [Admin task register](admin-task-register-20261010.md) and `packages/contracts/admin-tasks.json`; they use four unique Admin API operations. Server `AdminWorkflow`/`AdminSqlRepository` inherit tenant base classes. Dart models, `BaseAdminWorkflow`/`AdminController` and screens share serialized contracts and inherited presentation classes. One EN/ES/FR catalog drives labels and instructions across application shells. TypeScript and Dart do not inherit across runtimes; authorization stays on the server.

`publish-admin-support.yml` is manual after verification. Its default verifies the existing deployment; selecting its `publish` input builds/deploys Auth and Support first. The reusable CI gate is required in both modes. Support builds with the production API URL; the disposable loopback build is never published.

## Remaining acceptance work

This verifies Admin’s implemented account workspace on Support, not complete acceptance of the broader Admin role. Native Admin host/build verification, organization creation/global administration and elevated-role policy remain pending. The other eight portal deployments were not republished by this work package. Previous Auth native verification does not certify newer Admin code. The historical 64-role queue still has no broader business role marked fully accepted.
