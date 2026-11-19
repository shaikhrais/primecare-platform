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

## Reusable approval record (read-only contract)

Approve one exact release plan, not all future deploys. The tool
`python -m tools.deployment.api_release_approval digest plan.json` prints
the digest to attach to approval. A plan specifies the exact main `commit`,
`verified_run_id`, and sorted `targets`. Each target records its full
`worker` name, `prior_deployment`, `prior_version`, `candidate_version`,
and verified `bundle_sha256`. A change to any of those fields invalidates
the approval.

Check matching records without deploying:

```sh
python -m tools.deployment.api_release_approval check plan.json APPROVED_DIGEST verified.json live.json
```

The verified record includes `commit`, `verified_run_id`, the independently
reviewed sorted list of `required_workers`, and `versions` keyed by Worker
name (with `version` and `bundle_sha256`). The live record is keyed by Worker
name (with `deployment` and a `traffic` map from version IDs to percent).
This gate only accepts a single prior version serving 100% per target and
excludes Auth, the gateway and specialized Workers.

This command checks consistency, not who approved the plan or where the input
records came from. Do not use self-supplied JSON as approval or production
evidence. A future production-gated job must obtain approved digest and sealed
verification evidence through trusted GitHub sources, fetch Cloudflare's live
state directly, and verify that main, dependency scope, bindings and routing
remain current before any promotion. The existing verify-only run does not
create a verified Worker version, and cannot yet satisfy this gate.
