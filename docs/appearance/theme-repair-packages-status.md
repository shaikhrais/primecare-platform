# PrimeCare repair package status

The agreed plan contains **13 repair packages (R00–R12)** covering 18 feature batches (B01–B18). Counts refer to packages; each package contains several tasks.

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

Confirmed results:

- Preference shutdown and late-storage recovery: [all five CI jobs passed](https://github.com/shaikhrais/primecare-platform/actions/runs/41452987783), including 16 client tests per language, PostgreSQL/browser and Linux/Windows/macOS checks.
- All nine Flutter web builds compiled and archived artifacts; production publishing was skipped under the explicit TypeScript portal policy.
- [Main governance/POM suite passed](https://github.com/shaikhrais/primecare-platform/actions/runs/41456376480). [Isolated reconciliation passed](https://github.com/shaikhrais/primecare-platform/actions/runs/41456376437) after exact source review and fixture repair. This establishes static structure only, not live inventory or business readiness.
- [Diagnostic publication and all three account journeys passed](https://github.com/shaikhrais/primecare-platform/actions/runs/41453304412). Earlier competing-runtime failures remain recorded; no assertion was weakened.

Pending release acceptance:

The first fingerprinted attempt was blocked by HTTP308 at the noncanonical `/index.html` URL. The corrected verifier reads canonical `/`, compares exact bytes with the built `index.html`, and still refuses redirects. All 19 local deployment tests pass. [Corrected stamped release verification](https://github.com/shaikhrais/primecare-platform/actions/runs/41457664954) is queued; it is not counted as production acceptance. Coordinated API/UI rollback and the other package acceptance criteria remain open.

R01 completion covers only the original 192-row repair. Broader quarantined catalogue review remains in R02; preference/messaging activation remains in R06/R09. These changes do not activate global preference synchronization or messaging grants. The JSON tracker retains full original package acceptance criteria and evidence.
