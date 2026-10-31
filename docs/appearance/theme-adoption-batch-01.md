# B01 — Verified theme metadata pilot

The optional workspace layout controls and draft translations are now registered on the existing Tenant Admin workspace. A separate read-only database connection verified the committed records. The live layout editor is not enabled by this batch.

| Result | Verified value |
| --- | --- |
| Existing host | Screen 2534, `tenant_admin_command_center`, `/tenant-dashboard` |
| Registered optional controls | 25 |
| Optional required-element descriptors | 25 |
| Resources and translations | 40 resources; 120 EN/FR/ES text entries |
| Component mapping | Existing active `prime_button`, `prime_text_field`, `prime_dropdown_web` |
| New screens, routes, APIs or role grants | 0 |
| UI implementation status | `registered-unimplemented` |
| Translation review | Pending; reviewed/approved flags are not promoted |
| Runtime activation | False |

The feature proposal still covers 72 capability groups, all 24 reference core families, 389 catalogued source files and 78 component/style/type imports. Inventory coverage is not implementation or runtime parity.

## Evidence

The successful GitHub production job was run `41226841005`, attempt 2, job `124613105486`, on commit `b912b61002c671faaf16d8910ff2765c489309b2`. It used the existing GitHub production environment secret without retrieving its value.

The job passed the dry run, rolled it back, then applied the exact scoped registration. The registration was run twice within the transaction to verify idempotence. After commit, a separate pinned read-only connection verified resource identities, all three translations for each resource, control IDs/types/status and optional-element flags. A further independent reconciliation found no missing pilot records; its 120 remaining issues are translation-review flags only. The registration workflow passed.

Attempt 1 stopped before writing because an unrelated governance writer held a lock. Attempt 2 completed successfully; no existing reviewed text was overwritten.

- `docs/appearance/theme-adoption-registration-receipt.json`: actual commit/readback receipt and IDs.
- `docs/appearance/theme-adoption-production-preflight.json`: post-registration read-only reconciliation, including review-pending labels.
- `packages/primecare_ui/catalogs/theme-workspace.registration.json`: reproducible shared metadata export; `runtimeEnabled: false`, `allAppsAdopted: false`.
- `tools/governance-production/production-pin.json`: exact four-table writer scope, target host, contract hash and no-grant/no-runtime limits.

## Reproduce

```sh
node --test scripts/test-theme-adoption-preflight.mjs scripts/test-theme-workspace-export.mjs
python tools/governance-production/test-theme-adoption-registration.py
node scripts/export-theme-workspace-registration.mjs --receipt docs/appearance/theme-adoption-registration-receipt.json --readback docs/appearance/theme-adoption-production-preflight.json
```

Python checks require `tools/governance-production/requirements.txt`. Tests use isolated synthetic metadata, not a SQLite production fallback. The export rejects dry-run receipts, missing independent readback, stale contract/manifest hashes, denied hosts, missing controls and conflicted translations. It never enables a runtime.

The GitHub workflow `.github/workflows/theme-adoption-registration.yml` performs the real dry-run/apply/readback sequence. It is restricted to main and the existing production environment. The writer only inserts namespaced metadata in `screen_components`, `screen_required_elements`, `language_resources` and `language_resource_values`. It checks the exact existing route/source/active host and pre-existing view grants, validates physical column storage, preserves existing records on conflicts and adds no permissions.

## Next integration gate

B02 can now bind this registered pilot to the shared web shell and Theme Center. It must preserve unsaved input, handlers, focus, tenant/role scope and existing authentication. The metadata export supplies actual IDs and draft localized labels; the renderer and live interaction tests remain B02 work.

Translation review is still pending before release approval. Non-pilot app hosts and feature-specific workflow/API requirements need their own registrations before their later-batch activation. Neither this pilot nor its inventory means that all 18 batches or all apps are complete.
