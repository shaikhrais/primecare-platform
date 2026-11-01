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
