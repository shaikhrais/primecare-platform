# B01-B18 main-branch functionality audit

Captured: 2026-11-01T13:03:44.246980+00:00. Audited source: `4c29795d4fe2e36dd1c978d0e4c16a2f0226e3b2`.

**All 18 batches are not fully functional or production verified.** B01-B15 have historical passing checks for registered subsets/factories; B16 has corrected native checks and remaining integration gaps; B17 has an audit but unfinished catalogue/app migration; B18 remains unfinished. No batch is promoted to full functionality from a green build, metadata registration or file presence.

GitHub branch read: main. Main-only confirmed: True. No branch was created or deleted by this audit.

Current local checks: 18/19 scripts passed. The workspace browser script could not launch because local Chromium is unavailable; this is an environment limitation, not a passing browser result. Historical and new CI results are listed separately. Local PostgreSQL tests here use PGlite; native PostgreSQL/browser acceptance comes from CI.

| Batch | Source saved on main | Historical verification | Full functionality | Main remaining work |
|---|---|---|---|---|
| B01 | Subset/foundation and evidence | [success](https://github.com/shaikhrais/primecare-platform/actions/runs/41226841005) | Not confirmed | Translation review before release approval; Non-pilot host registration and feature-specific workflow/API contracts remain required before their later-batch activation |
| B02 | Subset/foundation and evidence | [success](https://github.com/shaikhrais/primecare-platform/actions/runs/41230046732) | Not confirmed | Footer controls remain disabled without an existing footer slot; Other-host registration and rollout |
| B03 | Subset/foundation and evidence | [success](https://github.com/shaikhrais/primecare-platform/actions/runs/41232017741) | Not confirmed | Native host registration and explicit shell/Theme Center binding; Android/iOS and physical-device workflow verification |
| B04 | Subset/foundation and evidence | [success](https://github.com/shaikhrais/primecare-platform/actions/runs/41239616377) | Not confirmed | Registered host activation and authenticated runtime checks; Android/iOS device, accessibility, translation and release review |
| B05 | Subset/foundation and evidence | [success](https://github.com/shaikhrais/primecare-platform/actions/runs/41242747737) | Not confirmed | Registered host binding and authenticated route/runtime checks; Owner-controlled navigation/business overlay teardown before hiding chrome |
| B06 | Subset/foundation and evidence | [success](https://github.com/shaikhrais/primecare-platform/actions/runs/41245395058) | Not confirmed | Registered host integration and authenticated runtime checks; Device, accessibility, translation and release review |
| B07 | Subset/foundation and evidence | [success](https://github.com/shaikhrais/primecare-platform/actions/runs/41249952025) | Not confirmed | Registered authenticated host controls/resources and panel bindings; Reviewed access decisions for roles without existing API 777 grants |
| B08 | Subset/foundation and evidence | [success](https://github.com/shaikhrais/primecare-platform/actions/runs/41253722290) | Not confirmed | Approved resource adapter and notification read/unread API bindings with real business-data verification; Actual web/native host/source bindings and reviewed API 777 role access decision |
| B09 | Subset/foundation and evidence | [success](https://github.com/shaikhrais/primecare-platform/actions/runs/41257279489) | Not confirmed | Host source/role/API bindings and real application flows; Advanced inputs/collections B10 and assets B12 |
| B10 | Subset/foundation and evidence | [success](https://github.com/shaikhrais/primecare-platform/actions/runs/41259596812) | Not confirmed | Native sticky horizontal pinning; Native link activation adapter |
| B11 | Subset/foundation and evidence | [success](https://github.com/shaikhrais/primecare-platform/actions/runs/41261294950) | Not confirmed | registered business widget/workflow/source mappings and authoritative server grants; dashboard document kind and policy in the common preference service |
| B12 | Subset/foundation and evidence | [success](https://github.com/shaikhrais/primecare-platform/actions/runs/41263870497) | Not confirmed | App-specific framework icon migration with individual verified usage; Host-specific metadata/source bindings and production deployment/device checks |
| B13 | Subset/foundation and evidence | [success](https://github.com/shaikhrais/primecare-platform/actions/runs/41267690894) | Not confirmed | Standalone notes and personal contact CRUD require approved workflow/API bindings; Timed appointment scheduling, recurrence and calendar reminders require approved workflow/API bindings |
| B14 | Subset/foundation and evidence | [success](https://github.com/shaikhrais/primecare-platform/actions/runs/41269984530) | Not confirmed | Own-notification API is absent from pinned production metadata: read transport, mutations and navigation remain unbound; General file/folder storage, binary picture open/upload, rename/move/delete/sharing/quota need approved adapter/workflow bindings |
| B15 | Subset/foundation and evidence | [success](https://github.com/shaikhrais/primecare-platform/actions/runs/41277937362) | Not confirmed | Academy course/catalogue/enrolment/progress/certificate workflows require confirmed registered learning APIs; Commerce inventory/order/payment/cart/checkout/tax/refund/entitlement workflows require confirmed APIs and providers |
| B16 | Subset/foundation and evidence | [success](https://github.com/shaikhrais/primecare-platform/actions/runs/41310167833) | Not confirmed | Obtain fresh production activation/readback; the recovered metadata receipt does not activate runtime; Integrate the verified native authenticated reader into registered app hosts |
| B17 | Audit partial | Not established | Not confirmed | Publish an original developer catalogue with component APIs, layout recipes, examples, configuration schemas and asset mappings.; Track every reference feature as verified-equivalent, intentionally-replaced, not-applicable-with-reason, blocked or missing; no silent omissions. |
| B18 | Plan only | Not established | Not confirmed | Run governed Cypress/browser and Flutter/native verification across registered roles, tenants, supported apps, layout families and breakpoints.; Cover LTR/RTL, EN/FR/ES, keyboard/touch/screen-reader behaviours, contrast, state retention and preference migrations. |

New native reader source `2b957d21e702819e628ac64bce200bcb74edd453`: [run 41309237883](https://github.com/shaikhrais/primecare-platform/actions/runs/41309237883); status completed. Earlier green checks do not establish this new adapter's acceptance.

Latest B16 repairs: [run 41310167833](https://github.com/shaikhrais/primecare-platform/actions/runs/41310167833) at `4c29795d4fe2e36dd1c978d0e4c16a2f0226e3b2`. web: success; postgres: success; native Linux: success; native Windows: success; native macOS: success. Pending jobs are not counted as accepted.

## Exact limits and next actions

The 72 proposal-feature records are a bounded catalogue, not an authoritative claim of complete reference parity. B09 and B10 historical source digests differ for later-edited native renderer files; their older receipts remain historical. Full details, missing references, digests and remaining work are in the JSON audit.

Keep all remaining work on main. Verify the B16 native test repairs first. Then close registered host/access/preference bindings and real workflows in earlier batches before claiming app-wide adoption. B17 must finish catalogue and app migration; B18 must verify deployed UI/API/database/reload and denied/cross-tenant/device/review paths.

Reproduce: `python scripts/audit-theme-batches.py --check`. The snapshot records GitHub reads and local test summaries; it does not fetch new evidence or change production state.
