# Smart Deploy: dashboard-only portal releases

This manual workflow publishes exactly one of the eight registered dashboard portal projects. It never deploys the API, writes deployment metadata to the database, or applies migrations. The build reads the existing governed portal manifest via the established read-only export. It compares that manifest against the selected portal's current live contract and rejects changes beyond its generation timestamp. The existing Governance-only workflow is unchanged.

## Release procedure

1. Confirm the reviewed dashboard implementation is active on the exact tip of main, not merely present inside a test fixture. Review every push-triggered production job for the runtime change; prevent unrelated automatic writers before merging. Keep all acceptance checks.
2. Select one project, record its current Cloudflare production deployment ID and full build-stamp SHA, and verify no other production publisher is active or pending.
3. Run **Smart Deploy one dashboard portal** from main in **verify-only** mode. Enter the full reviewed main SHA and the selected portal's full previous-live SHA. Leave confirmation and verified run ID blank. Record the successful verify-only run ID. A green verification is not a deployment.
4. With the two SHAs unchanged, run in **publish** mode, supply that **verified run ID**, and enter `DEPLOY <project>` (for example, `DEPLOY primecare-business-development`). This job does not rebuild. It downloads the exact input artifact from that run, validates the previous live source and exact assets immediately before publication, and publishes only the selected Cloudflare Pages project. Do not queue parallel portal publishes.
5. Require exact live asset verification, confirm the public build stamp, and smoke-check the intended dashboards with existing authorized and denied roles; record the release URL, full old/new SHA, deployment ID and signed-in outcome. Do not count a tested artifact, responsive page shell, or successful assets as signed-in acceptance.
6. On any failure, stop. Read back the live build and provider deployment before considering a retry. If a bad release went live, restore only this project's recorded previous successful production deployment using Cloudflare Pages rollback. Verify the previous SHA and repeat the route smoke checks. Never reset main or roll back unrelated projects.

Use Business Development (two dashboards) as the first new canary. Enterprise Blueprint isn't a dashboard target in this rollout. The Governance pilot copy and Tenant Admin guard are independent prior releases; do not treat either as acceptance of the 115-dashboard rollout.
