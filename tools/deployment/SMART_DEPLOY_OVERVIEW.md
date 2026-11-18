# PrimeCare Smart Deploy

## Release order

1. Decide what changed: dashboard UI, API Worker, shared dependency, or database. Verify the exact reviewed commit on `main`. Identify all affected consumers for shared dependencies; when impact is unknown, verify more broadly and do not assume a narrow publish is safe.
2. Record the current live identity of every target separately from the source comparison commit, and keep the rollback target. Check for other active or queued production releases.
3. Run the correct verify-only workflow in GitHub Actions. Use the existing `PRODUCTION_DATABASE_URL` secret only for approved read-only database checks. Never copy it out of GitHub Actions or print it. Local checks use isolated fixtures, not production credentials.
4. Fix failed steps, then verify the new exact SHA. Build approval is not publish approval. If source, scope or live baseline changes, rerun the applicable checks before promoting.
5. Publish only explicitly approved targets through a workflow that checks the tested artifact against the candidate and current live baseline. Verify live identity and the relevant customer-facing behavior separately. If the publish outcome is unclear, inspect live state before retrying; roll back only affected targets to their identified prior versions under the applicable runbook.

## Dashboard UI: build together, publish gradually

- Use [Dashboard rollout](SMART_DASHBOARD_ROLLOUT.md) and [one-portal workflow](../../.github/workflows/smart-deploy-dashboard-portal.yml). The common build can generate multiple portals, but the release workflow verifies and retains the selected portal artifact.
- Run `verify-only` with the exact `expected_main`, portal `project` and independently verified `previous_live`. No deploy confirmation or prior run ID is used in verify-only.
- For an approved publish, select the same portal and SHAs and provide the successful `verified_run_id` and exact `DEPLOY <project>` confirmation. Keep batches to at most 10 newly activated dashboards per release. Do not modify API, DB, or unrelated portals through this workflow.
- Check that the production publish and live source/asset verification steps passed. Track UI shell availability separately from verified signed-in business functions. See the [Governance pilot runbook](SMART_DEPLOY.md) for that separate workflow.

## API: verification available, selective publish pending

- Use the [API runbook](SMART_API_DEPLOY.md) and [verify-only workflow](../../.github/workflows/smart-deploy-api-verify.yml). It checks 11 generic Workers and the gateway; Auth is not included.
- Inputs: `expected_main` and `comparison_base`. A comparison ancestor is not a live deployment receipt. The run checks governance read-only, catalog, Worker types and regressions, then runs dry-run builds. No version is uploaded.
- Selective publication still needs a reviewed service/dependency map, a sealed artifact or verified version receipt, exact prior live versions and a separately approved production promoter. Do not substitute the legacy full-fleet deployment.
- A database migration is a separate release. Neither the dashboard nor API verify-only path authorizes schema or data changes.

## Release record

Record commit, target list, prior live identity, verify-only run link, publish run link and final live identity. Report **verified build**, **published**, and **signed-in behavior verified** separately. For a failure, list the step and whether production was changed.
