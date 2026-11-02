# PrimeCare repair package status

The plan contains **13 repair packages (R00–R12)** covering 18 feature batches (B01–B18). Each package has multiple tasks and acceptance tests. A finished fix or passing test does not close an entire package.

**1 complete · 7 partial · 5 pending.** No whole feature batch is closed.

| Package | Scope | Status | Accepted scope / remaining work |
|---|---|---|---|
| R00 | Reconcile scope and evidence | partial | Scope ledger exists; dynamic host-resolution evidence is incomplete. |
| R01 | Repair production identity safely | done | Original 192-row identity repair accepted. Broader quarantined catalog review belongs to R02; runtime activation belongs to R06/R09. |
| R02 | Map existing service contracts before building replacements | partial | 187 candidates indexed; action-level contract and authority review remains. |
| R03 | Make verified publication reliable | partial | Account registration now runs inside the publication lock, and four TypeScript publishers use the repository dependency lockfile. Both paths pass nine-file checks; other metadata-writer coordination and compatible API/UI rollback remain. |
| R04 | Finish one real web shell before portal-wide rollout | partial | Tenant history/deep-link denial, dialog drafts, pending saves and editable-node preservation pass actual browser/PostgreSQL checks. Footer and owned local-theme pilot remain accepted. Original Platform_admin binding and other host/role/route/overlay acceptance remain. |
| R05 | Mount native hosts progressively | pending | Real native host rollout and physical-device journeys are not accepted. |
| R06 | Complete preferences and durable recovery | partial | Tenant request recovery and web local-theme recovery shipped and tested. Registered API777 hosts, cloud/dashboard persistence, other commands and native recovery remain. |
| R07 | Complete data controls and configurable widgets | partial | Editor and dashboard-remount subsets pass; full control/widget adoption and persistence remain. |
| R08 | Complete the work applications | pending | Remaining work-app domain behavior and complete owned journeys are not accepted. |
| R09 | Complete communications and files | pending | Messaging role policy is staged; host, provider, member/tenant denial and file-lifecycle acceptance remain. |
| R10 | Complete application and financial families | pending | Application/finance business journeys and replacement of unavailable placeholders remain. |
| R11 | Finish reference/asset adoption and review | pending | Remaining app/reference/icon adoption and licensing/localization/accessibility review remain. |
| R12 | Run full release acceptance and close batches | partial | Owned deployed account/theme lifecycle accepted across EN/FR/ES at 320/768/1440 widths (58 mutation/theme and 36 tenant-read checks each); other feature families, actual devices, human review and coordinated rollback remain open. |

Latest verified web pilot:

[Release 41501329650](https://github.com/shaikhrais/primecare-platform/actions/runs/41501329650) published all nine portals and verified nine critical files per portal. Owned live account journeys passed **58 checks each in English (320px), French (768px) and Spanish (1440px)**. They include unreadable-theme protection, reset cancellation, explicit scoped recovery, named palette/font saving, sidebar/navigation saving, restoration after reload, and logout. Each locale also passed 36 tenant-account read checks. Source/file fingerprints were checked before and after every journey; synthetic accounts and correlated mail were cleaned up.

The later [same-source tenant publication](https://github.com/shaikhrais/primecare-platform/actions/runs/41501329419) independently verified nine files per portal and protected-route authentication. It regenerated portal metadata; all eight static critical files match the owned-tested account publication. The owned journeys were not repeated after that metadata regeneration.

These theme/layout values are saved on this browser. **API777 cloud preference synchronization remains off.** This is an owned physio/clinic pilot, not proof for all roles, every portal workflow, native devices, complete reference parity or all 13 packages.

Additional accepted repairs:

- [Tenant history and publication repair](theme-tenant-history-evidence.json): denied/unknown tenant destinations are normalized to an allowed view; Back/Forward, open task dialogs, pending saves and same-view editable nodes pass actual browser/PostgreSQL checks. Account registration runs inside the publication lock, with write flags scoped to those commands. All four TypeScript publishers use the repository dependency lockfile; three regression checks pass and JavaScript matches across all nine portals. The tenant publication passed on a failed-only retry after metadata recording finished. Coordination of other metadata writers and compatible API/UI rollback remain open.

- [Coordinated TypeScript publication](https://github.com/shaikhrais/primecare-platform/actions/runs/41486500369): four direct publishers share the production lock; current-main checks run before account registration and each portal upload. Two contract checks and nine retry-decision checks passed. The earlier overlap/source-mismatch failure remains recorded. Compatible API/UI rollback and full producer-lifecycle acceptance remain open.

- [Shared footer and description binding](https://github.com/shaikhrais/primecare-platform/actions/runs/41483421280): two markup checks, 13 lifecycle checks and 12 real-browser combinations (EN/FR/ES, LTR/RTL, 390/1440px) passed. [Actual tenant/PostgreSQL acceptance](https://github.com/shaikhrais/primecare-platform/actions/runs/41483793034) also passed footer enablement, sticky save/reload and original-node preservation after a preference redraw, alongside durable request/SQL regressions. These are isolated acceptance results; the last verified live pilot remains the release linked above.

- [Cached-worker migration](https://github.com/shaikhrais/primecare-platform/actions/runs/41470438175): a real isolated browser replaced a cached legacy worker through its original URL, preserving the draft and unrelated cache; all nine deployments and three account journeys passed. Physical installed-device migration remains unverified.
- [Unreadable-theme recovery](https://github.com/shaikhrais/primecare-platform/actions/runs/41472788148): four model checks and EN/FR/ES browser recovery cases passed before publication. Unknown records cannot be silently overwritten.
- [Theme closure component suites](https://github.com/shaikhrais/primecare-platform/actions/runs/41474757358): all seven jobs passed, including catalogue, browser, PostgreSQL and Linux/Windows/macOS components. No batch completion was requested or inferred.
- [Shared-shell lifecycle](https://github.com/shaikhrais/primecare-platform/actions/runs/41473038636) passed after moving its unsupported browser runner to Ubuntu24.04.

R01 completion covers its original 192-row repair only. Broader quarantined catalogue review remains in R02. Native hosts, cloud/dashboard persistence, unfinished feature families, registered communications/files, localization/accessibility review, coordinated rollback and full release acceptance remain open in their original packages. Full acceptance criteria remain in the JSON tracker and assessment plan.
