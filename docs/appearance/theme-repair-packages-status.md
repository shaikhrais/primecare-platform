# PrimeCare repair package status

The agreed plan has **13 repair packages (R00–R12)** covering 18 feature batches (B01–B18). Each package contains multiple tasks. Package counts are the primary progress measure.

**1 complete · 7 partial · 5 pending.** No whole feature batch is closed.

| Package | Scope | Status | Remaining / accepted scope |
|---|---|---|---|
| R00 | Reconcile scope and evidence | partial | Scope ledger exists; dynamic host-resolution evidence is incomplete. |
| R01 | Repair production identity safely | done | Original 192-row identity repair accepted. Broader quarantined catalog review belongs to R02; runtime activation belongs to R06/R09. |
| R02 | Map existing service contracts before building replacements | partial | 187 candidates indexed; action-level contract and authority review remains. |
| R03 | Make verified publication reliable | partial | Read-only source/provider preflight and deployed owned account smoke accepted; coordinated full API/UI publication and rollback acceptance remain. |
| R04 | Finish one real web shell before portal-wide rollout | partial | Tenant pilot and locale/recovery subsets work; shell migration and localization/RTL acceptance remain. |
| R05 | Mount native hosts progressively | pending | Real native host rollout and physical-device journeys are not accepted. |
| R06 | Complete preferences and durable recovery | partial | Tenant draft and pending-request recovery are implemented; global API777 hosts, dashboard persistence and broader native recovery remain. |
| R07 | Complete data controls and configurable widgets | partial | Editor and dashboard-remount subsets pass; full control/widget adoption and persistence remain. |
| R08 | Complete the work applications | pending | Remaining work-app domain behavior and complete owned journeys are not accepted. |
| R09 | Complete communications and files | pending | Messaging role policy is staged; host, provider, member/tenant denial and file-lifecycle acceptance remain. |
| R10 | Complete application and financial families | pending | Application/finance business journeys and replacement of unavailable placeholders remain. |
| R11 | Finish reference/asset adoption and review | pending | Remaining app/reference/icon adoption and licensing/localization/accessibility review remain. |
| R12 | Run full release acceptance and close batches | partial | Owned deployed account lifecycle accepted across EN/FR/ES at 320/768/1440 widths (49 checks each); other feature families, actual devices, human review and coordinated rollback remain open. |

Latest accepted evidence: [account lifecycle run](https://github.com/shaikhrais/primecare-platform/actions/runs/41448542072), all nine portal deployments and EN/FR/ES proofs passed; 49 checks per journey. Dedicated synthetic accounts and correlated inbox messages were removed. This does not establish whole-auth, physical-device or whole-release acceptance.

Tenant default-view durable-request recovery was published in [run 41440610076](https://github.com/shaikhrais/primecare-platform/actions/runs/41440610076), with 17 model checks and lost-acknowledgement SQL/audit verification. Global preference synchronization remains off; 14 messaging grants remain disabled.

R01 is complete only for its original 192-row repair scope. Broader quarantined catalogue review belongs to R02; preference and messaging activation remain in R06/R09. Full acceptance criteria and evidence are retained in `theme-repair-packages-status.json` and the original deep-assessment plan.

Latest recovery fix: TypeScript source `5bb049c0bbf9cdf5ad1b39a67598398f99d787a9` and matching Flutter source `7142dbf8d50530aa6f219042903494eb00a04f3e` stop preference dispatch after disposal while durable storage is pending. The TypeScript regression failed before the fix; 13 client tests, 16 protocol cases, registration checks, 14 isolated service checks and client type checking passed locally. [TypeScript CI](https://github.com/shaikhrais/primecare-platform/actions/runs/41451471237) has passed protocol, PostgreSQL/browser and Linux jobs; Windows/macOS remain pending. [Flutter CI](https://github.com/shaikhrais/primecare-platform/actions/runs/41451711345) is pending. No production activation is claimed for these source fixes.
