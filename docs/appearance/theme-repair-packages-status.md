# PrimeCare repair package status

The plan contains **13 repair packages (R00–R12)** covering 18 feature batches (B01–B18). Each package has multiple tasks and acceptance tests. A finished fix or passing test does not close an entire package.

**1 complete · 7 partial · 5 pending.** No whole feature batch is closed.

| Package | Scope | Status | Accepted scope / remaining work |
|---|---|---|---|
| R00 | Reconcile scope and evidence | partial | Scope ledger exists; dynamic host-resolution evidence is incomplete. |
| R01 | Repair production identity safely | done | Original 192-row identity repair accepted. Broader quarantined catalog review belongs to R02; runtime activation belongs to R06/R09. |
| R02 | Map existing service contracts before building replacements | partial | 187 candidates indexed; action-level contract and authority review remains. |
| R03 | Make verified publication reliable | partial | All-nine stamped publication and three-locale owned account acceptance pass. Coordination of remaining publishers and compatible API/UI rollback remain. |
| R04 | Finish one real web shell before portal-wide rollout | partial | One owned clinic web pilot passes 58 live checks in each locale, including theme/layout recovery/save/reload. Original Platform_admin binding, footer/route/overlay adoption and LTR/RTL acceptance remain. |
| R05 | Mount native hosts progressively | pending | Real native host rollout and physical-device journeys are not accepted. |
| R06 | Complete preferences and durable recovery | partial | Tenant request recovery and web local-theme recovery shipped and tested. Registered API777 hosts, cloud/dashboard persistence, other commands and native recovery remain. |
| R07 | Complete data controls and configurable widgets | partial | Editor and dashboard-remount subsets pass; full control/widget adoption and persistence remain. |
| R08 | Complete the work applications | pending | Remaining work-app domain behavior and complete owned journeys are not accepted. |
| R09 | Complete communications and files | pending | Messaging role policy is staged; host, provider, member/tenant denial and file-lifecycle acceptance remain. |
| R10 | Complete application and financial families | pending | Application/finance business journeys and replacement of unavailable placeholders remain. |
| R11 | Finish reference/asset adoption and review | pending | Remaining app/reference/icon adoption and licensing/localization/accessibility review remain. |
| R12 | Run full release acceptance and close batches | partial | Owned deployed account lifecycle accepted across EN/FR/ES at 320/768/1440 widths (49 checks each); other feature families, actual devices, human review and coordinated rollback remain open. |

Latest verified web pilot:

[Release 41475732794](https://github.com/shaikhrais/primecare-platform/actions/runs/41475732794) published all nine portals and verified nine critical files per portal. Owned live account journeys passed **58 checks each in English (320px), French (768px) and Spanish (1440px)**. They include unreadable-theme protection, reset cancellation, explicit scoped recovery, named palette/font saving, sidebar/navigation saving, restoration after reload, and logout. Source/file fingerprints were checked before and after every journey; synthetic accounts and correlated mail were cleaned up.

These theme/layout values are saved on this browser. **API777 cloud preference synchronization remains off.** This is an owned physio/clinic pilot, not proof for all roles, every portal workflow, native devices, complete reference parity or all 13 packages.

Additional accepted repairs:

- [Cached-worker migration](https://github.com/shaikhrais/primecare-platform/actions/runs/41470438175): a real isolated browser replaced a cached legacy worker through its original URL, preserving the draft and unrelated cache; all nine deployments and three account journeys passed. Physical installed-device migration remains unverified.
- [Unreadable-theme recovery](https://github.com/shaikhrais/primecare-platform/actions/runs/41472788148): four model checks and EN/FR/ES browser recovery cases passed before publication. Unknown records cannot be silently overwritten.
- [Theme closure component suites](https://github.com/shaikhrais/primecare-platform/actions/runs/41474757358): all seven jobs passed, including catalogue, browser, PostgreSQL and Linux/Windows/macOS components. No batch completion was requested or inferred.
- [Shared-shell lifecycle](https://github.com/shaikhrais/primecare-platform/actions/runs/41473038636) passed after moving its unsupported browser runner to Ubuntu24.04.

R01 completion covers its original 192-row repair only. Broader quarantined catalogue review remains in R02. Native hosts, cloud/dashboard persistence, unfinished feature families, registered communications/files, localization/accessibility review, coordinated rollback and full release acceptance remain open in their original packages. Full acceptance criteria remain in the JSON tracker and assessment plan.
