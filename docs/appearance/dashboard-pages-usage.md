# Dashboard and supporting-page factories

These are optional original shared factories. They do not mount themselves, grant roles, provide billing/authentication workflows, or enable production features. Read `theme-adoption-batch-16.md` for evidence and remaining gates.

## Web host

Use `DashboardPageSession` from `packages/shared/src/dashboard-pages/session.mjs`, `dashboardPageTransport` from `websites/typescript/src/tenant-dashboard/dashboard-page-transport.ts`, and `bindDashboardPage` from `packages/primecare_ui/web/dashboard-pages.ts`.

The authenticated host supplies a captured user/tenant/role/dataset, the gateway origin and token, a current-token callback, and a current-scope callback. A scope callback must reflect the current host context rather than echoing the captured context. Mount only an independently registered slot. Retain the binding's cleanup function and call it before navigation/logout or replacing the slot. Call session invalidation immediately when token, role or tenant changes. Refresh uses `session.load()`; it clears old values before starting. A transport guard surrounds both the network response and asynchronous JSON decoding. No write endpoint or automatic retry is used.

`bindDashboardPage` needs title, demo/live, denied, unavailable, loading, error, idle and disposed strings plus a metric-key label map. The host resolves locale and reviewed resource IDs. Labels are rendered as text. Operational counts require the server's `operations` view. Project task counts require `tasks`. Finance/crypto are unavailable without approved bindings. Counts overlap and are not additive.

`renderSupportingPage` from `packages/primecare_ui/web/supporting-pages.ts` supports invoice, pricing, authentication, coming-soon, maintenance and error. Supply the kind's title and the relevant status text: `unavailable`, `static-coming-soon`, `static-maintenance` or `static-error`. Existing resource `dashboardPages.static-coming` supplies the message for the internal `static-coming-soon` status. No route, login form, price, payment or retry action is invented.

## Flutter host

Import `package:primecare_ui/dashboard_pages.dart` or `package:flutter_core/dashboard_pages.dart`. Construct `DashboardPageProjection.fromResponse(family, response, scope)` using `PreferenceScope` from `package:flutter_core/preference_sync/preference_protocol.dart`.

Pass the validated projection to `PrimeDashboardPage` and host-resolved labels keyed by family, ready dataset (`live`/`demo`), non-ready status (`denied`/`unavailable`) and metric keys. `PrimeSupportingPage` uses the same supporting-page kind/status label keys described above. Missing labels fail explicitly. Renderers are stateless and contain no credentials or network code.

The native host must supply its authenticated read adapter and scope lifecycle. Clear the old projection on refresh, logout and role/tenant changes; reject late responses from an earlier context before rendering. This batch does not claim a native session/HTTP adapter or production host mount. Retain the existing authentication and business modules.

## Checks and rollback

Run `node --test scripts/test-dashboard-pages-projection.mjs scripts/test-dashboard-pages-session.mjs`, `node scripts/test-dashboard-pages-parity.mjs`, integration/browser scripts and the scoped TypeScript check in `dashboard-pages-projection.yml`. The optional fixture generator accepts `--write`; regenerated fixtures must be reviewed. Flutter tests consume those fixtures and run on Linux/Windows/macOS CI. Desktop widget checks do not establish Android/iOS device acceptance.

Rollback removes the optional imports/bindings and disposes active sessions. No production business schema, role grant or service-availability change is introduced by these factories. Registered metadata remains inactive until separately approved activation and readback.

## Activity and bounded search

`projectRecordPage(kind, response, scope, query)` from `packages/shared/src/dashboard-pages/record-pages.mjs` handles `activity` and `search`. The query is a maximum of 100 characters and filters the loaded response only. Pass it as the fifth projector argument to `DashboardPageSession`, optionally through a closure capturing the chosen query. Recreate/refresh the host context when changing query; old read completions remain subject to the same epoch and context checks. `bindRecordPage` from `packages/primecare_ui/web/record-pages.ts` uses the same read-page binding as metric pages.

Supply localized activity/search, ready/empty/denied, demo/live, bounded, loading/idle/disposed/error/unavailable labels. `dashboardPages.partial` is the existing resource for the bounded-results notice. There is no global-search, record-navigation or mutation action. A denied page renders no records. Activity omits actor identity and event detail payloads; it displays action and timestamp. Search projects only task/workflow titles and identifiers from independently allowed source views, up to 100 per source.

Flutter exports `RecordPageProjection.fromResponse(kind, response, scope, query: query)` and `PrimeRecordPage` through the existing dashboard-pages barrels. Supply the same labels. Records/metrics are immutable. The native host must still discard old data on authenticated context change. The accessibility fix retains separate semantic nodes for each metric so the card does not merge counts into one label.

## Authenticated Flutter read session

`DashboardPageTransport` and `DashboardReadSession<P>` are exported by `dashboard_pages.dart`. The host supplies the existing gateway origin/token, captured `PreferenceScope`, current-token and current-scope callbacks, a byte limit (1 to 1,048,576) and optionally its HTTP client. The adapter calls existing API16578 with GET only and the dataset query. It rejects unsafe origins/credentials/paths, disables redirects, requests no-store, bounds the streamed response and checks context before/after the request, through body chunks, after JSON decoding and again before publication.

For metrics, use `DashboardReadSession<DashboardPageProjection>` with projector `DashboardPageProjection.fromResponse(family, raw, scope)` and status callback `(projection) => projection.status`. For activity/search, use the same generic session with `RecordPageProjection.fromResponse(kind, raw, scope, query: query)`. Render the corresponding stateless view when a projection is present; otherwise show the host's localized status. The session clears old data before reload and suppresses older completions. A new query uses a new captured projector/session.

Hosts must call `invalidate()` immediately on logout/token/tenant/role changes, and dispose the session on teardown. The transport closes its own HTTP client; an injected shared client remains host-owned. Invalidation suppresses late results; it does not promise physical cancellation of an in-flight request on a shared client. There is no persistence, login, grant change or automatic retry. Mock HTTP acceptance establishes client behavior; deployed authenticated native UI/API/database/device verification remains separate.

The recovered `dashboard-pages-registration-receipt.json` is historical evidence from production job 124766476200 in run 41278838480. The writer committed metadata and independently read it back. This turn retrieved its receipt from the saved job log; it did not perform a fresh production read. Controls retain registered-unimplemented status, review approval false and runtime activation false. Current host/device activation must not be inferred from this receipt.
