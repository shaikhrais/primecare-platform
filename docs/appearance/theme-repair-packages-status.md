# PrimeCare: 13 repair packages

The execution plan has **13 packages (R00–R12)**. They cover the **18 feature batches (B01–B18)**. Each package contains several tasks and its own acceptance checks.

**1 done · 6 partial · 6 pending.** This is a package count, not a completion percentage.

| Package | Work | Status | Remaining scope or completion boundary |
|---|---|---|---|
| R00 | Reconcile scope and evidence | partial | Scope ledger exists; dynamic host-resolution evidence is incomplete. |
| R01 | Repair production identity safely | done | Original 192-row identity repair accepted. Broader quarantined catalog review belongs to R02; runtime activation belongs to R06/R09. |
| R02 | Map existing service contracts before building replacements | partial | 187 candidates indexed; action-level contract and authority review remains. |
| R03 | Make verified publication reliable | partial | Immutable-source publication works; full authenticated smoke and rollback acceptance remain. |
| R04 | Finish one real web shell before portal-wide rollout | partial | Tenant pilot and locale/recovery subsets work; shell migration and localization/RTL acceptance remain. |
| R05 | Mount native hosts progressively | pending | Real native host rollout and physical-device journeys are not accepted. |
| R06 | Complete preferences and durable recovery | partial | Tenant draft and pending-request recovery are implemented; global API777 hosts, dashboard persistence and broader native recovery remain. |
| R07 | Complete data controls and configurable widgets | partial | Editor and dashboard-remount subsets pass; full control/widget adoption and persistence remain. |
| R08 | Complete the work applications | pending | Remaining work-app domain behavior and complete owned journeys are not accepted. |
| R09 | Complete communications and files | pending | Messaging role policy is staged; host, provider, member/tenant denial and file-lifecycle acceptance remain. |
| R10 | Complete application and financial families | pending | Application/finance business journeys and replacement of unavailable placeholders remain. |
| R11 | Finish reference/asset adoption and review | pending | Remaining app/reference/icon adoption and licensing/localization/accessibility review remain. |
| R12 | Run full release acceptance and close batches | pending | Full release acceptance depends on the open packages plus actual-device and human evidence. |

R01 is done only for the original 192 affected permission records: the bounded transactions, independent readbacks and unchanged identity gate passed. This does not establish authority for the broader 2,494 quarantined groups; that review remains in R02. Preference and messaging activation remain separate R06/R09 work.

“Pending” means package-level acceptance has not been established; foundational components may already exist. No whole feature batch is release-complete. The [original plan](deep-assessment-repair-plan-2026-11-01.json), [execution evidence](theme-plan-execution-status.json) and [machine-readable package tracker](theme-repair-packages-status.json) remain available.
