# B11 chart and dashboard widget APIs

These are optional shared packages. The verified export `packages/primecare_ui/catalogs/dashboard-widgets.registration.json` supplies production control IDs and draft EN/FR/ES labels on existing Tenant Admin screen 2534. `prime_chart` registry ID 20 is registered. This does not register business widgets or authorize native/other-host activation.

## Data, registry and layout contracts

`ChartData` has exactly `kind`, `title`, `categories` and `series`; each series has `id`, `label`, `values`. Kinds are `line`, `area`, `bar`, `donut`; limits are 200 categories, 1–6 unique series, labels up to 500 characters, finite values with absolute magnitude at most 1e12, or null gaps. Series lengths must match category length. Donut accepts one nonnegative series and reports zero-total input as empty. Geometry normalizes across zero, preserves null gaps and supports singleton points. Charts never evaluate labels or fabricate missing values.

The host supplies authorized `WidgetSpec` records: lowercase ID, localized label, positive registration/source/workflow IDs, kind (chart kind or `metric`), permitted view IDs and min/max column/row spans. Positive IDs are references, not permission proof; the server must independently enforce current tenant/user/role/workflow/source access. No production widget instances or fake metrics are created by this batch.

`ViewportSpec` contains ID, localized label, minimum width and column count. Supply 1–8 unique breakpoints, first minimum 0, 1–12 columns. Widget registry limit is 60; dimensions are bounded to 12 columns and 20 row units. IDs use `[a-z][a-z0-9-]{0,63}` with reserved prototype names excluded.

`DashboardLayout` is exactly `{version:1,views:{viewId:[{id,span,rows},...]}}`, with every declared view present. Only current permitted widget IDs, unique per view and supported by that view, are accepted. JSON import is at most 65,536 UTF-8 bytes. Array order determines placement; deterministic packing uses row/column spans without overlaps. This grid is separate from B02/B03 floating panel coordinates.

`validateRegistry`, `validateDashboard`, `parseDashboard`, `editDashboard`, `activeViewport`, `packDashboard`, `validateChart` and `chartGeometry` are pure shared model helpers. Add/remove/earlier/later/wider/narrower/taller/shorter affect only the chosen view. Host-provided tenant/role defaults use the same validator, with no hardcoded role decisions.

## Web

Import `PrimeDashboardWidgets` from `packages/primecare_ui/web/dashboard-widgets.ts`; domain types/models are in `packages/domain/src/dashboard_widgets.ts`. Create `new PrimeDashboardWidgets(exclusiveSlot, actorScope, locale)` under the B06 token/direction context. One owner per non-body/document slot is allowed. Dispose on actor, grants, source binding or route changes and create a new session/factory with freshly authorized registry records.

- `chart(data, {width,height,stroke}, suffix?)` returns a chart figure, named series controls and always-available data table. All dimensions are finite positive host/theme values. Different standalone charts need unique lowercase suffixes.
- `metric(label,value,unit,suffix?)` formats an explicitly supplied finite value for the locale.
- `dashboard(session,{rowHeight,gap,chart},source?)` mounts the grid into the exclusive slot. It returns `refresh(id)`, `useAutomaticViewport()` and `dispose()`. Grid row height/gap and chart geometry come from the host. Choose enough space for supported text scaling, localized actions and accessible data; cards scroll their content.
- `source(id,sourceId,workflowId,signal)` returns a validated chart or `{value,unit}` projection. Removed widgets and older/aborted requests cannot repaint. Missing source shows unavailable; failures expose retry. The host owns authorization, service validation and refresh scheduling.
- Explicit viewport selection overrides automatic `ResizeObserver` selection until `useAutomaticViewport()` is called. Reorder and resize use keyboard accessible buttons. Free coordinate dragging is not implemented.
- `dispose()` aborts owned listeners/data loads, unsubscribes and clears only the owned slot. It does not dispose an externally owned session; dispose that separately with the actor lifecycle.

IDs and `data-cy` values derive from the production export plus stable widget/series suffixes. The mounted grid replaces its own children on state updates and restores the active governed control where present. Keep unrelated content outside its slot.

## Flutter

Import `package:flutter_core/dashboard_widgets.dart` or the optional `package:primecare_ui/dashboard_widgets.dart`. Package/load the verified metadata in the host and create B09 `CatalogueLabels.fromMetadata(decoded, locale)`.

`PrimeChart` takes labels, validated `ChartData`, actor scope, chart height/stroke, host theme colours, optional suffix and locale. It uses original `CustomPainter` geometry with a semantic `DataTable`. Colour is not the only data alternative. The host supplies a nonempty palette of at most 12 colours from its theme, and Material localization/direction context.

`PrimeDashboardGrid` takes labels/session/scope, finite row height/gap/chart height/stroke, theme colours and optional `WidgetDataSource`. The native source receives widget/source/workflow IDs and returns `ChartWidgetData` or `MetricWidgetData`. Native requests have epoch guards; actual transport cancellation belongs to the host adapter. A widget dropdown adds its selected item; editing buttons handle remove/reorder/span/height. `LayoutBuilder` selects the automatic viewport, with a manual dropdown override. Native imports/exports use an editable JSON field; callers own any file picker/download workflow.

`DashboardLayout.fromJson`, `WidgetSpec.fromJson`, `ViewportSpec.fromJson` and `ChartData.fromJson` enforce the shared schema. Native session requires an injected UUID v4 request-ID function before save; no transport is auto-installed. Flutter 3.41.5 is the verification baseline. The host owns session disposal; the grid only removes its listeners and invalidates its data completions.

## Persistence and release boundary

`DashboardSession` binds immutable B07 `PreferenceScope` (tenant/user/role/live-or-demo), a dashboard resource, permitted registry and validated defaults. It offers `load`, `edit`, `save`, current document/revision/status and disposal. Web has `subscribe`; native extends `ChangeNotifier`.

`DashboardPreferencePort.read` returns matching scope/resource/revision/document. Revision 0 requires null document. `write` receives expected revision, snapshot document and UUID v4 request ID. A valid acknowledgement must advance revision exactly once and match the submitted document. A fresh readback must then agree before clean status. Edits made during a save remain dirty. Conflicts/errors retain the draft. An uncertain save retains its original document/revision/request ID; call `retryPending()` to reuse that request. Once acknowledgement is validated, retries only repeat independent readback. New saves and reload reject while pending; the shared save control routes to the explicit retry, while layout mutations and reload remain disabled. Recreating a view does not auto-load over pending recovery. A changed readback becomes an explicit conflict; a subsequent user-selected reload adopts current server state. No automatic mutation retry or silent overwrite is performed. This recovery is in-memory only: durable offline recovery remains open. The server must enforce atomic revisions and request idempotency.

There is deliberately no default HTTP adapter. Existing API 777 supports theme/workspace/shortcuts, not dashboard-grid documents; its role restrictions and empty panel policy are unchanged. Do not serialize grids into workspace panel payloads or introduce local storage as a production substitute. Register the dashboard preference kind, widget/workflow/source mappings and host access first, then verify UI → API → database → reload. Current isolated in-memory port tests prove component behavior only.

Full project/analytics/finance/crypto business dashboards remain B16. Advanced chart families, every reference visual variant, drag-and-drop placement, offline dashboard cache, physical-device/screen-reader verification and human localization/accessibility/release review remain pending. See the support matrix and reference audit for explicit limits. No vendor source/assets or new third-party runtime dependency were added.

Rollback: dispose/unmount the optional factory/grid and remove its host import. Additive production metadata remains registered-unimplemented; no destructive metadata rollback is supplied.
