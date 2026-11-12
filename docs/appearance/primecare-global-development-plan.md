# PrimeCare global development plan — 10 parallel tracks

Created November 12, 2026, America/Toronto. Master: [#229](https://github.com/shaikhrais/primecare-platform/issues/229). This is the user's explicitly requested GitHub coordination plan, superseding local-only shared planning; keep temporary analysis local and add no task-tracking application code.

## Current delivery and estimate

**Overall: behind.** Source mapped 72/72; fully accepted 0/72; pending 72; strict shared-control/theme findings 0; screen readiness 0/344; workflow readiness 0/147. Source presence and green component suites do not prove host/device/release acceptance.

Verified product baseline `f69b31efc0fe0592dc85bb64901f708244d90fe2`: all 7 triggered workflows succeeded, including dashboard projection [43219304247](https://github.com/shaikhrais/primecare-platform/actions/runs/43219304247), all 5 web/PostgreSQL/native jobs, and workspace publication [43219930277](https://github.com/shaikhrais/primecare-platform/actions/runs/43219930277). Re-read current main and exact-source runs before implementation.

Budget: **234–468 active engineering hours**, low confidence, for documented remaining B01–B18 scope. The ranges below partition the existing budget; they are not measured team velocity or 10 times less calendar time. Exclude unsized API dependencies (current finite checklist 1063 unresolved operations), CI queues, gaps between sessions and waiting for business/provider/registered authority/device/review availability. Shared dependencies and integration remain serial where necessary. Ten chat windows do not guarantee 10× throughput.

| Track | Development lane | Coverage | Remaining budget | Initial owner/state |
|---|---|---|---:|---|
| [PC-01](https://github.com/shaikhrais/primecare-platform/issues/230) | Integration, CI, governance and release | B01 B17 B18 | 40–80 h | Existing continuation / integration |
| [PC-02](https://github.com/shaikhrais/primecare-platform/issues/231) | Shell, layouts, navigation and page hosts | B02 B03 B04 B05 | 26–52 h | Unclaimed; not started |
| [PC-03](https://github.com/shaikhrais/primecare-platform/issues/232) | Theme Center, preferences and recovery | B06 B07 | 14–28 h | Unclaimed; not started |
| [PC-04](https://github.com/shaikhrais/primecare-platform/issues/233) | Shared base controls and feedback | B09 | 12–24 h | Unclaimed; not started |
| [PC-05](https://github.com/shaikhrais/primecare-platform/issues/234) | Tables, forms, editors and uploads | B10 | 16–32 h | Unclaimed; not started |
| [PC-06](https://github.com/shaikhrais/primecare-platform/issues/235) | Charts, widgets and dashboard layout | B11 | 16–32 h | Unclaimed; not started |
| [PC-07](https://github.com/shaikhrais/primecare-platform/issues/236) | Original assets, icons and adoption | B12 | 6–12 h | Unclaimed; not started |
| [PC-08](https://github.com/shaikhrais/primecare-platform/issues/237) | Work applications and tenant task host | B13 | 24–48 h | Unclaimed; not started |
| [PC-09](https://github.com/shaikhrais/primecare-platform/issues/238) | Utilities, communication, mail and files | B08 B14 | 32–64 h | Unclaimed; not started |
| [PC-10](https://github.com/shaikhrais/primecare-platform/issues/239) | Applications, profile, settings and read pages | B15 B16 | 48–96 h | Unclaimed; not started |

PC-01 is both a development lane for CI/governance/release repairs and the integrator. PC-02–PC-10 are parallel product authors. These issues are ready to claim; creating them does not start ten chat workers or count any feature as complete.

## Fixed checkpoints

Preserve the original recovery targets. The 08:15 verification checkpoint was met early, and the previous host/read-page verification due 10:15 was confirmed green by 08:10. The new parallel plan starts at 08:15; target lane setup/claims 08:30, with a 09:30 first evidence checkpoint for lanes activated at 08:30. Record actual activation; unclaimed lanes are not active work.

| Toronto target, November 12 | Expected outcome | Current state |
|---|---|---|
| 08:30 | Master plan and 10 prompts ready; user can claim one lane per chat | Plan/issue setup; workers need activation |
| 09:30 | Each activated lane has source reproduction, bounded estimate and first handoff or precise blocker | Not yet due |
| 10:15 | Integrate ready approved patches; exact-source checks and original host-verification checkpoint | Prior host/read-page gate passed early; new patches must pass independently |
| 12:15 | Approved preference recovery binding | Blocked on exact revoked-reference action/resource/host authority; existing conflict controls are already present |
| 14:15 | Approved data-control/asset adoption batch | Pending |
| 15:15 | Full-suite/acceptance checkpoint and revised remaining estimate | Pending |

Keep original target, actual completion and revised forecast/reason separate. Report a missed target directly. A blocker or an unsized provider requirement is not completion. Estimate the first bounded product batch in each claimed lane at 30–120 active minutes after source inspection, plus actual CI waiting; use a 60-minute evidence checkpoint. Do not label the whole project ahead because one checkpoint finished early.

## Main publication protocol

No work branches or PRs. Keep existing main-only policy. The existing hourly continuation is the default PC-01 publisher; only one publisher may move main at a time. Manual PC-01 takeover requires a recorded handoff in #229 and the scheduled runner must yield while that publisher owns the slot. An issue ownership note is coordination, not an atomic lock.

Workers use isolated current-main source copies. They prepare product code and meaningful tests, then submit a patch/file diff or, within existing authorization, create tree/commit objects without moving any ref. Preserve reconstructable changes in their lane issue; an unreferenced object is preparation and has no fresh CI acceptance. They never push main or edit another lane's paths.

PC-01 re-reads remote main, inspects every changed path, rebases/reconstructs prepared changes without overwriting concurrent work, runs appropriate local checks, creates trees with at most five entries per call and publishes one coherent batch with expected-head protection. Inspect new-source CI and repair confirmed failures. Queued work is pending; no duplicate dispatch, force overwrite, cancellation, check weakening or stale predecessor pass credit.

## Shared-file and handoff rules

Only PC-01 edits workflow files, governance/registration catalogs, shared foundation, global export barrels, historical replay/native receipts and global feature/gap registers. Feature-specific Dart entry barrels and corresponding native test directories follow the feature's owner. Tests named for a feature follow that track; cross-domain integration fixtures belong to PC-01. Unassigned app/host files require an exact-path delegation recorded in the master issue before editing. Files imported from another lane may be read; request their owner to implement any API/export change.

A handoff contains lane ID, current owner/chat name, immutable base SHA, changed paths, reconstructable patch or file diff, optional unreferenced commit SHA, local test output, required runtime checks and blocked dependencies. PC-01 rejects out-of-scope edits, reconciles against current main, supplies required workflow/proof/export amendments and runs affected checks. Native/browser execution stays in GitHub Actions. No lane may refresh hashes, widen limits, add exemptions, invent authority or enable production/provider actions merely to finish its issue.

## Acceptance and authority

Follow [.agents/AGENTS.md](../../.agents/AGENTS.md), [the consolidated execution plan](../task-progress/consolidated-execution-plan.md), [gap register](theme-gap-register.md), [closure checklist](theme-closure-repair-plan.md), [72-feature register](skeleton-feature-adoption-status-20261111.md) and current pinned governance. Use existing original shared factories and approved contracts; no copied vendor implementation or per-app factory duplication. Preserve replay v2, all original dependency/source identities and exact reversible amendment limits.

Business/host activation, API/database/reload, scope denial, actual devices and required human reviews remain separate gates. No plan or source patch authorizes new grants, production DB changes, deployment or live provider communications. Block only the affected item and continue authorized work.

## Start a chat

Open one chat per track issue. Paste its exact prompt from [the prompt pack](primecare-parallel-chat-prompts.md), or use: `Use $plan-and-quick-fix. Continue PrimeCare PC-XX from issue #229 and its linked lane issue. Claim one lane, respect ownership, implement a bounded product batch, and hand off to PC-01.` Never claim that ten workers are running until those chats are actually started.

## Track source ownership

The following source/test paths belong to exactly one lane. PC-03's theme wildcard explicitly excludes theme-control-base.ts, owned by PC-01. Corresponding feature entry barrels and tests are listed; everything not assigned requires a PC-01 delegation.

### PC-01 — Integration, CI, governance and release

- `.github/workflows/**`
- `tools/governance-production/**`
- `scripts/check-*.py`
- `scripts/workflow_theme_replay.py`
- `scripts/native-widget-repairs.json`
- `docs/api/**`
- `docs/appearance/*register*`
- `docs/appearance/primecare-*plan*.md`
- `packages/primecare_ui_foundation/**`
- `packages/primecare_ui/catalogs/**`
- `packages/primecare_ui/web/theme-control-base.ts`
- `packages/flutter_core/lib/flutter_core.dart`
- `packages/primecare_ui/lib/primecare_ui.dart`
- `scripts/test-theme-control-base.mjs`
- `scripts/test-tenant-manager-children.mjs`

### PC-02 — Shell, layouts, navigation and page hosts

- `packages/primecare_ui/web/shell.ts`
- `packages/primecare_ui/web/shell-environment.ts`
- `packages/primecare_ui/web/workspace-*.ts`
- `packages/primecare_ui/web/navigation.ts`
- `packages/primecare_ui/web/layout-manager.ts`
- `packages/primecare_ui/web/page-*.ts`
- `packages/flutter_core/lib/workspace/**`
- `packages/flutter_core/lib/navigation/**`
- `packages/flutter_core/lib/page/**`
- `scripts/test-page-template*.mjs`
- `scripts/test-workspace-*.mjs`
- `packages/domain/src/workspace_layout.ts`
- `packages/domain/src/workspace_navigation.ts`
- `packages/domain/src/page_template.ts`
- `packages/flutter_core/test/workspace/**`
- `packages/flutter_core/test/navigation/**`
- `packages/flutter_core/test/page/**`
- `packages/flutter_core/lib/workspace_navigation.dart`
- `packages/primecare_ui/lib/workspace_navigation.dart`
- `packages/flutter_core/lib/page_template.dart`
- `packages/primecare_ui/lib/page_template.dart`

### PC-03 — Theme Center, preferences and recovery

- `packages/primecare_ui/web/advanced-theme*.ts`
- `packages/primecare_ui/web/theme*.ts (except theme-control-base.ts)`
- `packages/primecare_ui/web/preference-sync.ts`
- `packages/shared/src/preference-sync/**`
- `packages/domain/src/preference_sync.ts`
- `packages/flutter_core/lib/advanced_theme/**`
- `packages/flutter_core/lib/preference_sync/**`
- `packages/flutter_core/lib/theme/**`
- `scripts/test-advanced-theme*.mjs`
- `scripts/test-preference*.mjs`
- `packages/domain/src/advanced_theme.ts`
- `packages/flutter_core/test/advanced_theme/**`
- `packages/flutter_core/test/preference_sync/**`
- `packages/flutter_core/lib/advanced_theme.dart`
- `packages/primecare_ui/lib/advanced_theme.dart`
- `packages/flutter_core/lib/preference_sync.dart`
- `packages/primecare_ui/lib/preference_sync.dart`

### PC-04 — Shared base controls and feedback

- `packages/primecare_ui/web/component-catalogue.ts`
- `packages/shared/src/component-catalogue/**`
- `packages/domain/src/component_catalogue.ts`
- `packages/flutter_core/lib/component_catalogue/**`
- `packages/flutter_core/test/component_catalogue/**`
- `scripts/test-component-catalogue*.mjs`
- `packages/flutter_core/lib/component_catalogue.dart`
- `packages/primecare_ui/lib/component_catalogue.dart`

### PC-05 — Tables, forms, editors and uploads

- `packages/primecare_ui/web/data-controls.ts`
- `packages/shared/src/data-controls/**`
- `packages/domain/src/data_controls.ts`
- `packages/flutter_core/lib/data_controls/**`
- `packages/flutter_core/test/data_controls/**`
- `scripts/test-data-controls*.mjs`
- `scripts/test-upload-removal.mjs`
- `packages/flutter_core/lib/data_controls.dart`
- `packages/primecare_ui/lib/data_controls.dart`

### PC-06 — Charts, widgets and dashboard layout

- `packages/primecare_ui/web/dashboard-widgets.ts`
- `packages/shared/src/dashboard-widgets/**`
- `packages/domain/src/dashboard_widgets.ts`
- `packages/flutter_core/lib/dashboard_widgets/**`
- `packages/flutter_core/test/dashboard_widgets/**`
- `scripts/test-dashboard-widgets*.mjs`
- `packages/flutter_core/lib/dashboard_widgets.dart`
- `packages/primecare_ui/lib/dashboard_widgets.dart`

### PC-07 — Original assets, icons and adoption

- `packages/primecare_ui/assets/original/**`
- `packages/primecare_ui/web/original-assets.ts`
- `packages/primecare_ui/web/original-asset-view.ts`
- `packages/primecare_ui/web/icons.ts`
- `packages/flutter_core/lib/original_assets/**`
- `packages/flutter_core/test/original_assets/**`
- `scripts/test-original-assets*.mjs`
- `scripts/audit-original-asset-usage.py`
- `scripts/test-original-asset-compiler.py`
- `packages/flutter_core/lib/original_assets.dart`
- `packages/primecare_ui/lib/original_assets.dart`

### PC-08 — Work applications and tenant task host

- `packages/primecare_ui/web/work-modules.ts`
- `packages/shared/src/work-modules/**`
- `packages/domain/src/work_modules.ts`
- `packages/flutter_core/lib/work_modules/**`
- `packages/flutter_core/test/work_modules/**`
- `websites/typescript/src/tenant-dashboard/index.ts`
- `websites/typescript/src/tenant-dashboard/work-module-host.ts`
- `websites/typescript/src/tenant-dashboard/work-module-transport.ts`
- `scripts/test-work-modules*.mjs`
- `scripts/test-tenant-work-module-host.mjs`
- `scripts/test-tenant-manager-entry.mjs`
- `packages/flutter_core/lib/work_modules.dart`
- `packages/primecare_ui/lib/work_modules.dart`

### PC-09 — Utilities, communication, mail and files

- `packages/primecare_ui/web/shell-utilities.ts`
- `packages/primecare_ui/web/communication-modules.ts`
- `packages/shared/src/shell-utilities/**`
- `packages/shared/src/communications/**`
- `packages/domain/src/communication_modules.ts`
- `packages/flutter_core/lib/shell_utilities/**`
- `packages/flutter_core/lib/communication_modules/**`
- `packages/flutter_core/lib/communications/**`
- `scripts/test-shell-utilities*.mjs`
- `scripts/test-communication*.mjs`
- `packages/flutter_core/lib/shell_utilities.dart`
- `packages/primecare_ui/lib/shell_utilities.dart`
- `packages/flutter_core/lib/communication_modules.dart`
- `packages/primecare_ui/lib/communication_modules.dart`

### PC-10 — Applications, profile, settings and read pages

- `packages/primecare_ui/web/application-modules.ts`
- `packages/primecare_ui/web/dashboard-pages.ts`
- `packages/primecare_ui/web/record-pages.ts`
- `packages/primecare_ui/web/supporting-pages.ts`
- `packages/shared/src/application-modules/**`
- `packages/shared/src/dashboard-pages/**`
- `packages/flutter_core/lib/application_modules/**`
- `packages/flutter_core/lib/dashboard_pages/**`
- `packages/flutter_core/test/application_modules/**`
- `packages/flutter_core/test/dashboard_pages/**`
- `scripts/test-application-modules*.mjs`
- `scripts/test-dashboard-pages*.mjs`
- `scripts/test-dashboard-record-pages.mjs`
- `packages/flutter_core/lib/application_modules.dart`
- `packages/primecare_ui/lib/application_modules.dart`
- `packages/flutter_core/lib/dashboard_pages.dart`
- `packages/primecare_ui/lib/dashboard_pages.dart`

