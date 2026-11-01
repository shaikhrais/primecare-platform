# B01–B18 repair and acceptance plan

Component tests cover the implemented subset. A complete batch also needs its intended features, registered host/API integration, deployed acceptance and review evidence. No entire batch is marked complete by this plan. Existing source acceptance is retained; missing business workflows are not represented by successful fixture data.

| Batch | Why incomplete | Repair needed | Evidence required to close |
| --- | --- | --- | --- |
| B01 | Remaining host registrations and reviewed translations | Match actual host source and existing API/workflow contracts; register missing controls/resources and review EN/FR/ES | Independent governance readback; host selector and translation review |
| B02 | Workspace rollout/footer slots incomplete | Bind supported layouts to registered hosts; connect footer only where the host supplies a real slot | Authenticated deployed layouts, persistence/reload and responsive acceptance |
| B03 | Native shell is not fully mounted/verified | Bind authenticated native shell and Theme Center with actor lifecycle | Full app builds and Android/iOS/device workflow evidence |
| B04 | Navigation runtime adoption unfinished | Bind server-authorized destinations and teardown across actor/route changes | Allowed/denied role routes, deep links and device acceptance |
| B05 | Page host and business overlay lifecycle incomplete | Bind page routes and owner-controlled overlay teardown before hiding chrome | Back/forward, focus restoration, chrome and overlay acceptance |
| B06 | Some component states and host integration incomplete | Integrate focus/caret/selection/hover/disabled/error theme tokens across consumers | Authenticated screens, contrast/accessibility and locale review |
| B07 | Preference controls, revoked-reference recovery and role decisions open | Bind existing preference resources; implement explicit draft/conflict/revoked-reference recovery; obtain access decisions for ungranted roles | Owned save/read/reload, scope denial, recovery and reviewed activation |
| B08 | Utilities lack complete real resource adapters | Bind approved notifications/events/notes/settings contracts and read/unread acknowledgements | Real records, independent readback, actor teardown and RTL acceptance |
| B09 | Real-screen migration and variant dispositions unfinished | Bind actual callbacks and migrate controls; review the 106 unadopted reference examples | App-by-app control/action acceptance and reviewed dispositions |
| B10 | Remaining editor/table/specialized controls and storage integration missing | Complete range marks/import requirements, spreadsheet/query adapters, specialized variants and approved binary storage/picker policies | Real persistence/removal readback, native parity and accessibility review |
| B11 | Business widgets, registered persistence and chart/placement scope incomplete | Confirm widget grants/data mappings and dashboard document policy; finish required chart families, placement and durable recovery | API/database/reload, offline recovery, native and device acceptance |
| B12 | Icon migration and dependency review incomplete | Replace remaining actual usages and review resolved licence bundle | Per-app verified usages, licence/contrast/screen-reader review |
| B13 | Task-backed subset does not implement all requested work apps | Complete approved calendar recurrence/reminders, personal contact/notes CRUD, board ordering; mount and accept the native task adapter; add durable reconciliation | Real workflow mutations, created-item receipts, independent readback/reload and denial |
| B14 | Full mail/messenger/files/notifications workflows unbound | Confirm registered contracts for compose/drafts/folders/history/realtime/attachments/storage; implement their authorized adapters | Provider/service receipts, owned records, reload and denied/cross-tenant acceptance |
| B15 | Read-only identity and shortcut settings do not implement full academy/commerce/profile/settings/help | Mount native identity and shortcut-settings ports with explicit recovery UI; bind confirmed learning/commerce/help/provider contracts and preference recovery; preserve existing sensitive account flows | Real host/API flows and provider authorization/quota/persistence acceptance |
| B16 | Finance/supporting pages have unavailable placeholders | Confirm real financial data and invoice/pricing/account workflows; mount authorized dashboards | Real data projections and complete deployed UI/API/database/reload flows |
| B17 | Full migration and owner dispositions unreviewed | Finish actual app migration; remove duplicate paths after compatibility acceptance | App-by-app adoption evidence and reviewed reference/owner decisions |
| B18 | Deployed, device and human release evidence incomplete | Run full login/action/API/database/reload paths, denied/cross-tenant cases and actual-device/review checks | Recorded evidence for each earlier batch; human release decisions |

## Repairs completed during follow-up

- B13: concrete native task API transport/projection/mutation/receipt/readback binding for all five task-backed views, verified by 60 projection cases, 52 mutation cases and 13 regression groups across 12 targeted/combined jobs. Source `d0d2ea41c13be48fd7ed6b613d2d14573fdf5cb6`; see `native-task-binding-evidence.json`. Host activation and standalone workflow/device/review gaps remain open.

- B13/B15/B16: shared web response reader with streamed byte limits, strict JSON and captured actor/cancellation/disposal checks through cleanup. Source `e1e0a786e5515f57e92df3289cd6d382babc0551` passed all 22 targeted/combined CI jobs; see `guarded-response-evidence.json`. This is response integration/parity acceptance, not completion of the missing business workflows.

- B02/B06: account-bound appearance teardown and out-of-order/stale import protection; 13 browser checks passed (run 41321528275).
- B07: local-discard serialization, retained drafts on storage failure and disposed-state protection; all five targeted jobs passed (run 41320644480).
- B15: native read-only self-profile API16402 adapter; web, PostgreSQL/browser and Flutter Linux/Windows/macOS passed (run 41323515743).
- B13: task API16578/16579 response lifecycle guard, bounded streamed JSON, cancellation and original receipt preservation. Nine new transport regressions and 30 existing real-handler/database checks pass locally. Targeted and combined CI source: 0633b548ee5f73b9c34e2f7c22bb6d7ee036af5b; all five targeted jobs (run 41326605698) and seven combined jobs (run 41326605678) passed. Evidence: `work-module-transport-evidence.json`.
- B18: application/combined/work-module verification concurrency uses immutable source identity; older push events cannot cancel a newer source through a shared branch-only group.

These repairs do not supply missing business contracts, grant privileges, activate unreviewed hosts or substitute for actual-device and human release checks. Detailed scope remains in `theme-gap-register.md`.

- B14/B15: native communication collections and shortcut-settings adapters passed all 17 targeted/combined jobs. Strict registered routing, independent receipts/readback and wrong-account denial are covered; see `native-communication-settings-evidence.json`.
- B13: actual registered tenant portal now composes the five task-backed views through explicit URL opt-in. Fourteen browser checks and native PostgreSQL acceptance passed run 41339668646; see `tenant-work-host-evidence.json`. Default rollout, standalone workflows, native host and deployed/device/human gates remain open.
- B18: preflight preserves original proposal hashes and separately pins current source revisions. Unrecorded source drift and approval inflation still fail; production registration receipts are unchanged.

## Current production release blocker

Release run 41339668667 job 124948188609 rejects existing API710/API857 grant keys targeting different operations and dangling runtime-artifact references in 64 grants each for APIs710,857,777. This is separate from source verification. Repair requires exact pinned PostgreSQL identity/authority reconciliation and independent readback; adding grants, replacing the quarantine baseline or bypassing the guard would not repair it. See `current-release-blocker-evidence.json`. The tenant workspace publication path is tracked separately and does not establish acceptance of this blocked release.

## Follow-up: draft preservation and exact production readback

Source `4c23805263bd41250786d31ead5523bc86de9f79` prevents internal work-module navigation from silently discarding edited drafts in web and native renderers. PostgreSQL CI run 41346938280 job 124968680553 passed 21 browser checks, 30 work-module checks and 14 actual-host checks. Flutter acceptance is pending. See `theme-draft-preservation-evidence.json`; this does not close any entire batch.

Read-only production run 41346724602 job 124968025068 confirms 64 grants each on APIs710,857,777 and missing runtime artifact 1. API710 is POST /v1/messages but its grant labels name premium-concierge-workflow; API857 is GET /v1/messages/inbox but its grant labels name document-expiry. Registry references point to APIs4957/5104, which were not present in the endpoint readback. API777 has its canonical preference key but the same missing artifact. No grant is retargeted, enabled, removed or assigned a fabricated artifact by this follow-up. Exact evidence is `theme-release-identity-readback.json`. Intended operation/role authority must be reconciled before a mutation is safe; changing labels solely to pass the guard could turn unrelated legacy permissions into message permissions.
