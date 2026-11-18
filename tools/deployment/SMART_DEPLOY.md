# PrimeCare Smart Deploy: Governance portal

Use [Deploy Governance portal only](../../.github/workflows/deploy-governance-portal-only.yml) for an approved, tested **Governance-only UI** release. It is manual and targets only the `primecare-governance` Cloudflare Pages project. It reads governed metadata during the build; it does not apply migrations, write database records, deploy the API, or publish the other eight portals.

Use the normal reviewed release path for shared UI changes that need multiple portals, API or database changes, permissions, governance metadata, or changes to multiple projects. Do not bypass the manifest comparison if it blocks the fast path.

## 1. Before running it

- Verify the exact reviewed commit is at the tip of `main` and that its relevant tests passed. A fixture-only preflight is not approval for different runtime source.
- Confirm the intended route change is present and that unrelated dashboards and roles are unchanged. For Governance Officer, verify an allowed Governance account and a denied account in acceptance testing.
- In Cloudflare Workers & Pages → `primecare-governance` → Deployments, record the current successful **production deployment ID** and its full commit. Confirm the commit against the live [build stamp](https://primecare-governance.pages.dev/primecare-build.json). If these disagree, or another publisher is active or queued, stop before starting.
- Use existing production approval and credentials. Do not grant a new role or add a secret to run this workflow.

## 2. Run it

In [GitHub Actions](https://github.com/shaikhrais/primecare-platform/actions/workflows/deploy-governance-portal-only.yml), choose **Deploy Governance portal only** → **Run workflow**. Select `main` and enter:

| Input | Value |
| --- | --- |
| `expected_main` | Full 40-character SHA of the tested tip of main |
| `previous_live` | Full 40-character SHA from the verified current Governance Pages deployment (not the deployment ID) |
| `confirm` | `DEPLOY GOVERNANCE` |

Approve the existing production environment gate if GitHub requests it. The workflow builds once, retains only the Governance artifact for publishing, and validates source, artifact bytes, prior live version, and manifest compatibility. The publisher reuses the artifact rather than rebuilding it.

## 3. Verify and record

- Require **Verify live source and exact assets** to pass, and confirm the live build stamp matches `expected_main`.
- Open the intended route with existing approved accounts. Confirm the authorized workflow works and access is denied for an account without the relevant permission. The asset check alone does not verify sign-in, roles, or a business task.
- Record the run URL, old/new commit and deployment ID, intended route, smoke-check outcomes, and the release time. Count a dashboard as live only after both the asset and route checks pass.

## 4. If a step fails

- Before publish: fix the reported blocker. When main or the live version moved, reverify and use the correct new inputs; never substitute a guessed SHA.
- After publish or if it is unclear whether publication completed: check the live stamp and the Cloudflare production deployment first. Do not retry blindly.
- If this run is the live deployment and the route fails, coordinate with the publisher, then roll back **only** `primecare-governance` to the recorded previous successful production deployment. Use its deployment actions menu and choose **Rollback to this deployment**. Confirm the prior stamp and rerun the route smoke check. Do not reset main or roll back Tenant Admin.

References: [GitHub manual workflow runs](https://docs.github.com/en/actions/how-tos/manage-workflow-runs/manually-run-a-workflow) · [Cloudflare Pages rollback](https://developers.cloudflare.com/pages/configuration/rollbacks/)
