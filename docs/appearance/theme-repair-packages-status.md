# PrimeCare repair package status

The agreed plan has **13 repair packages (R00–R12)** covering 18 feature batches (B01–B18). A package contains several tasks. Counts refer to packages throughout.

**1 complete · 7 partial · 5 pending.** No whole feature batch is closed.

| Package | Scope | Status | Accepted scope / remaining work |
|---|---|---|---|
| R00 | Reconcile scope and evidence | partial | Scope ledger exists; dynamic host-resolution evidence is incomplete. |
| R01 | Repair production identity safely | done | Original 192-row identity repair accepted. Broader quarantined catalog review belongs to R02; runtime activation belongs to R06/R09. |
| R02 | Map existing service contracts before building replacements | partial | 187 candidates indexed; action-level contract and authority review remains. |
| R03 | Make verified publication reliable | partial | Competing Flutter/TypeScript publishers identified; nine-portal TypeScript selection and source/hash gates implemented. All nine Flutter web builds archived without publication. Stamped production acceptance and coordinated rollback remain. |
| R04 | Finish one real web shell before portal-wide rollout | partial | Tenant pilot and locale/recovery subsets work; shell migration and localization/RTL acceptance remain. |
| R05 | Mount native hosts progressively | pending | Real native host rollout and physical-device journeys are not accepted. |
| R06 | Complete preferences and durable recovery | partial | Published tenant request recovery; TypeScript/Flutter disposal and late-storage fixes passed all five CI jobs (16 client tests per language). API777 hosts, dashboard contract and broader native recovery remain. |
| R07 | Complete data controls and configurable widgets | partial | Editor and dashboard-remount subsets pass; full control/widget adoption and persistence remain. |
| R08 | Complete the work applications | pending | Remaining work-app domain behavior and complete owned journeys are not accepted. |
| R09 | Complete communications and files | pending | Messaging role policy is staged; host, provider, member/tenant denial and file-lifecycle acceptance remain. |
| R10 | Complete application and financial families | pending | Application/finance business journeys and replacement of unavailable placeholders remain. |
| R11 | Finish reference/asset adoption and review | pending | Remaining app/reference/icon adoption and licensing/localization/accessibility review remain. |
| R12 | Run full release acceptance and close batches | partial | Owned deployed account lifecycle accepted across EN/FR/ES at 320/768/1440 widths (49 checks each); other feature families, actual devices, human review and coordinated rollback remain open. |

Latest verified progress:

- Preference lifecycle fixes passed [all five CI jobs](https://github.com/shaikhrais/primecare-platform/actions/runs/41452987783), including 16 client tests per language, PostgreSQL/browser and Linux/Windows/macOS checks.
- All nine Flutter web builds compiled and archived artifacts while skipping production publication under the explicit TypeScript portal policy. [Stamped production acceptance](https://github.com/shaikhrais/primecare-platform/actions/runs/41455071276) remains pending.
- The exact current renderer received a static structural review; [isolated reconciliation passed](https://github.com/shaikhrais/primecare-platform/actions/runs/41456376437). This is not live inventory or business acceptance. The [main governance/POM suite also passed](https://github.com/shaikhrais/primecare-platform/actions/runs/41456376480).
- The earlier [complete three-locale owned account lifecycle](https://github.com/shaikhrais/primecare-platform/actions/runs/41448542072) remains historical evidence (49 checks each). A later Spanish run exposed competing runtime publications. Its failure and retry are retained; no assertion was weakened. The [diagnostic release](https://github.com/shaikhrais/primecare-platform/actions/runs/41453304412) then passed all three locales; the newer fingerprinted release remains pending.

R01 completion covers only its original 192-row repair. Broader quarantined catalogue review remains in R02; preference/messaging activation remains in R06/R09. Global preference synchronization and messaging activation are not enabled by these changes. Full package acceptance criteria and evidence remain in the JSON tracker and original assessment plan.
