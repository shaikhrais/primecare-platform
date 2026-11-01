# B16 dashboard presentation progress

The shared read-only projection now maps API 16578 task counts and operational counts to original presentation data. It rejects mismatched user, tenant, role, dataset and synthetic flags, invalid counts, and unavailable server views. Operational counts require the server's `operations` view; project counts require `tasks`. Finance and crypto return unavailable because this contract supplies no approved financial datasets. Overlapping task counts are never summed or converted to a composition chart.

`packages/shared/src/dashboard-pages/projection.mjs` consumes an already authenticated, authorized response. It is not an authorization boundary or HTTP adapter. Hosts must discard old responses when session identity changes and independently verify registration before mounting. `packages/primecare_ui/web/dashboard-pages.ts` renders supplied localized labels and counts through text nodes and a semantic description list. It is optional and not mounted in the live host. Its demo/live label is mandatory caller input; callers must use the validated projection.

Validation: five Node test groups cover exact projections, mutation isolation, identity/tenant/role/dataset changes, server-view denial, malformed counts, unavailable financial families and explicit demo flags. Eight existing synthetic registration tests pass. Node successfully loads the renderer after TypeScript stripping; this is not a typecheck or browser test.

Remaining B16: authenticated transport/session lifecycle, independently read-back registration receipt, host activation, browser and PostgreSQL/reload acceptance, Flutter renderer, supporting-page templates, human localization/accessibility and release review. Dashboard layout persistence remains unavailable under API 777. No production activation, production database write, full dashboard-family completion or B17 completion is claimed.

## Read-session continuation

The optional `DashboardPageSession` and `dashboardPageTransport` now use the existing tenant-dashboard GET contract. The transport rejects unsafe origins, checks captured tokens before fetching, after response and after JSON decoding, and disables caching/redirects. Sessions clear retained metrics before refresh, suppress stale responses, validate captured user/tenant/role/dataset and clear pending results on explicit invalidation/disposal. Hosts must invoke invalidation on account context changes; no background auth watcher is implied. `bindDashboardPage` connects a supplied session to a supplied registered slot and clears it on teardown. This does not activate the live tenant host.

Local checks: nine model/session groups, eight integration groups against the real tenant handler using PGlite PostgreSQL, and TypeScript checks pass. Integration checks compare counts through independent SQL and a new session, reject tenant mismatches and denied operational views, and test token changes during JSON decoding. No production database was accessed. Local Chromium installation failed because the downloaded archive was invalid. Browser and native PostgreSQL checks are supplied in `dashboard-pages-projection.yml`; their execution status must be read from CI before claiming acceptance.

The independent B16 registration receipt is absent from the repository, so production mounting remains gated. Supporting pages, native rendering, full family bindings, translation/accessibility review and production deployment acceptance remain outstanding.

## Native and supporting-page continuation

Prior source `de65f80a56dedb3ac934d7b3b58d53eb886018b7` passed workflow [41305965995](https://github.com/shaikhrais/primecare-platform/actions/runs/41305965995): web job 124846285300 and native PostgreSQL job 124846285472 both succeeded. These jobs executed the browser, API/SQL/reload and session checks. This proves isolated host acceptance, not production activation or whole-repository CI success.

Added optional Flutter dashboard projection/view, exported through both shared packages. The native projection uses the same checked-in web-generated fixtures for exact API16578 metric fields, server-view restrictions, scope/synthetic checks and unavailable finance/crypto families. Metrics are immutable, labels come from the host locale, and the widget exposes semantic headings/status/counts. The host owns the authenticated native adapter, refresh and disposal; no native production integration is implied.

Added six supporting-page presentations in web and Flutter: invoice, pricing, authentication, coming-soon, maintenance and error. Invoice/pricing/account actions remain unavailable without approved service bindings; static pages do not change service availability, start authentication, charge money or create navigation. Activity and search supporting pages remain outstanding. Web presentation reuses the shared supporting-status model. Native models are checked against its fixtures.

Local parity, model/session, PGlite integration and TypeScript checks pass. The current environment has no Flutter SDK, so native analysis/widget acceptance is delegated to the included Linux/Windows/macOS CI jobs and remains pending until those jobs succeed. New browser coverage checks six supporting presentations and absence of action controls. Production host activation remains gated on independent B16 registration readback, localized labels and release review.

Source `ea9ca5089ca040aaa2dff7ba365329198c20804a` passed the updated web and native PostgreSQL browser jobs in [41306313942](https://github.com/shaikhrais/primecare-platform/actions/runs/41306313942) (jobs 124847312375 and 124847312673). Flutter jobs were queued/in progress at evidence capture, and their success is not yet claimed. See `dashboard-pages-usage.md` for host imports, lifecycle, label mappings and rollback.

## Activity/search and accessibility continuation

Flutter analysis passed on the earlier source, but Linux/macOS widget acceptance failed at the exact `Open: 5` semantics lookup. Metric semantics were merging into the surrounding card. The fix gives headings, statuses and metrics explicit semantic containers; the exact accessibility assertion is retained. Native success is not inferred from analysis.

Added optional activity/search projections and web/Flutter views through existing API16578 fields. Activity requires the server `audit` view and projects action/timestamp only. Search includes tasks and/or workflows only for the corresponding server-authorized views, projects title/identifier only, and filters the loaded response locally. Each source is capped at the API's 100 rows; oversized or malformed projected values fail. All results are explicitly marked bounded and never presented as complete tenant-wide search. Denied sources are omitted before projection and do not reveal their fields. Shared scope validation is reused by metrics and records.

Record sessions reuse the existing stale-response/token/context lifecycle. Web record/metric mounts share one generic read-page binding. Native views remain stateless; the host owns authenticated transport and context invalidation. Added web-generated native fixtures, record model/widget checks and browser checks for record rendering and token-denial clearing. Local checks pass: 12 model/session groups, 10 real-handler/PGlite integration groups including independent SQL and fresh-session record reads, parity fixture and scoped TypeScript checks. New browser/native checks await CI.

Remaining: independent registration readback, approved production slot activation, native authenticated session/HTTP adapter, real financial workflow bindings and human locale/accessibility/device/release acceptance. No production mount or native acceptance is claimed while the verification run is pending.

Activity timestamps now require UTC ISO date-time text and roundtrip date components in both renderers; impossible normalized dates, local dates and leap-second strings are rejected. This retains the current API's JSON timestamp contract and avoids web/native disagreement. Local verification now passes 13 model/session groups and 10 integration groups. Source `25ba9f140a0e358ec974a67a9e74f9ddccb5a037` started verification run 41306819901; final-source CI must also include this timestamp follow-up before claiming acceptance.

## Main-only audit repair

The all-batch audit found two additional test-only issues: untyped empty authorization-view lists under strict Dart analysis, and a semantics handle disposed too late by generic teardown. The fixture now types those lists and disposes the handle in a test-body try/finally. Production accessibility assertions remain intact. Source `6d7ec963967f34270c51ef215a3178902df57132` passed Linux native analysis and all six widget/model tests in run 41307397565 (job 124850487046). Windows/macOS and other final-source jobs were pending at capture. See the complete `theme-batches-main-audit.md` for B01-B18 gaps and main-only evidence.

## Registration evidence recovered and native reader added

All five jobs in run 41307397565 passed for source `6d7ec963967f34270c51ef215a3178902df57132`: web, native PostgreSQL and Flutter Linux/Windows/macOS. Earlier native failures were corrected; the prior pending status is superseded for that exact source.

Recovered the B16 metadata receipt from successful production job 124766476200 / run 41278838480 at source `33d3566c5f120d7ebcb423fc7bd8fc8cb099196e`. The recorded writer transaction committed and independently read back 20 optional controls, 44 resources, 132 translations and API16578. This is historical readback, not a fresh production query. Controls remain registered-unimplemented, runtime off and review approval false. Recovery closes the missing-receipt evidence gap, not activation.

Added a generic actor-bound Flutter read session and existing-API HTTP transport for metric and record projections. It checks token/scope during network and stream processing, bounds bytes, disables redirects, clears stale projection state and ignores old/disposed results. Five new native test groups cover GET/bearer/no-cache behavior, reload, captured context changes, late completion, disposal, denied/redirect/malformed/oversized replies and unsafe configuration. The new source requires its own CI acceptance before readiness is promoted. Live host/device/database verification remains open.

Source `2b957d21e702819e628ac64bce200bcb74edd453` passed web, native PostgreSQL and Linux Flutter analysis/all 11 tests in run 41309237883 at capture. Windows/macOS remained running. The historical receipt consistency check matched the unchanged registered contract, all control/resource keys and existing API16578. No live activation or fresh production query was performed.
