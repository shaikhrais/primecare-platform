# PrimeCare API Smart Deploy procedure

This is the verify-only phase of Smart Deploy. It checks 11 generic API Workers and the gateway. It does not upload a version, deploy any Worker, run migrations, change binding configuration, or change traffic. Auth and specialized Workers are not in scope. This complements, but does not modify, the dashboard Smart Deploy workflow.

## 1. Verify in GitHub Actions

1. Record the reviewed candidate `main` SHA and a reviewed ancestor to compare it with. The comparison SHA is not evidence of what's currently live. Check live Worker version IDs separately.
2. On GitHub, open **Actions → API Smart Deploy - Verify only → Run workflow**, select `main`, and enter both full SHAs. Use the existing production environment when prompted. Never copy `PRODUCTION_DATABASE_URL` to a local machine, chat, logs, or artifacts.
3. Read the run summary and check the exact SHA, pinned read-only governance check, catalog and type checks, release regressions, and dry-run bundles. If any step fails, record its name and stop. A green verify-only run does not establish live runtime behavior or approve publishing.

The generic Workers share a code entry point. Until dependency and binding scope is mapped and verified for each one, do not translate a changed filename into permission to deploy a single service or the whole fleet.

## 2. Requirements for a future publish workflow

There is no Smart Deploy publish mode yet. The existing full-fleet workflow is a separate release path and must not be launched automatically from preflight.

1. Review a named target list and capture each target's currently serving version/deployment IDs, routing, observability, and bindings. Require a prior verified release receipt and explicit approval for the exact targets and source.
2. Validate the exact tested artifact and target configuration; verify the live IDs again directly before mutating production. Serialize against other API and portal publishers. A separate, production-gated job promotes only the verified version; it must never rebuild unverified source or implicitly bulk deploy.
3. Smoke-test the service directly and through the gateway, including the intended contract and role restrictions with approved test identities. Record the run URL and old/new Worker versions and results. A healthy endpoint alone does not verify business behavior.
4. If publishing fails or is inconclusive, inspect live version/traffic state before any retry. If the new version is live and unhealthy, follow the approved rollback procedure for the affected service only; confirm prior version and traffic before continuing.

References: [GitHub manual workflows](https://docs.github.com/en/actions/how-tos/manage-workflow-runs/manually-run-a-workflow) · [Cloudflare Worker bundling](https://developers.cloudflare.com/workers/wrangler/bundling/) · [Cloudflare versions and deployments](https://developers.cloudflare.com/workers/versions-and-deployments/)
