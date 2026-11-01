# B11 — Shared chart and configurable widget foundations

The original shared chart/grid source is on main; final platform acceptance is pending. Registry/data bindings, common preference-service integration, real business flows and human review remain pending. This is factory acceptance, not production dashboard completion.

The catalogue adds line, area, grouped bar, donut and metric presentations with accessible data alternatives. A separate dashboard-grid model provides permitted widget add/remove/order/column-span/row-span changes, per-breakpoint layouts, registered defaults and strict JSON import/export. It does not mix dashboard grids with floating workspace panels.

## Database-first metadata

[Production run 41260408035](https://github.com/shaikhrais/primecare-platform/actions/runs/41260408035), source `acac55e3b68dacbecf2330ce89889fccf303f379`, passed validation job 124712308550 and production job 124712384496. Rollback-only dry-run, idempotent apply and independent readback completed before runtime implementation began.

It registered 22 optional controls and 22 required-element records on existing Tenant Admin screen 2534, plus 34 resources and 102 draft EN/FR/ES translations. The new primitive `prime_chart` has registry ID 20. The pinned PostgreSQL manifest is unchanged. Only the five approved metadata tables are writable; no business metric rows, widget grants, APIs, routes, schema changes or runtime activation were added. Production screen tags remain `registered-unimplemented`; human translation review remains unset.

The verified receipt and metadata export are committed with the source. Usage and integration contracts: [dashboard-widgets-usage.md](dashboard-widgets-usage.md). Machine-readable limitations: [dashboard-widgets-support.json](dashboard-widgets-support.json).

## Source behavior

Shared TypeScript/Dart models validate finite/null chart data, bounded registries, current permitted IDs, viewport widths, layout imports and placement dimensions. Gaps stay gaps; a zero-total donut is empty. Every graphic has an original-value table alternative. Browser SVG and native CustomPainter use original geometry and host theme context, with no new chart/grid dependency or proprietary runtime/assets.

Registered host-provided widget definitions reference source/workflow/registration IDs. These inputs do not grant access; the eventual server must enforce current scope and registry policy. Defaults, imports, edits and readbacks pass the same allowlist validator, including stale/denied widget rejection. Both renderers invalidate late data results after removal/scope changes; failures show retry. Missing adapters show unavailable and disable operational save/reload.

The dashboard session reuses B07 identity/canonicalization contracts, retaining immutable tenant/user/role/dataset/resource binding. Saves require exact next revision/document acknowledgement followed by fresh port readback. Edits made during a save stay dirty. Errors/conflicts retain draft; explicit reload resolves by discarding the draft. No automatic mutation retry or local-storage production substitute is supplied.

## Persistence and business integration gate

Existing API 777 accepts only themes, workspaces and shortcuts. No approved dashboard-grid document kind or business widget/workflow/source map was established in this batch. Its role restrictions and empty panel policy remain unchanged. There is no default HTTP binding, no dashboard payload hidden inside a workspace panel record and no claimed production persistence.

The persistence test adapter is isolated and in memory. It proves write/readback/reload behavior, revision checks, mismatch/conflict errors, edits during save and disposal. It is not API/database evidence. Actual common-service document registration and server policy, host/source/access bindings and UI → API → database → reload verification remain blockers before live activation.

## Reference disposition

The scoped audit records 189 TS/TSX files from both licensed v17 demos: dashboard directories or chart-named files. It stores filenames/content digests, not vendor implementation. [Audit](dashboard-widgets-reference-audit.json) preserves the query scope, source hash and full file dispositions. Reproduce with `python3 scripts/audit-dashboard-reference.py PATH_TO_LICENSED_ARCHIVE --check`; the archive is not redistributed.

Project, analytics, finance and crypto business dashboards stay in B16. Advanced chart families, every vendor visual/property/animation variant, free-coordinate/drag-and-drop placement and offline dashboard cache are not claimed. The native add flow uses the widget selector; native transport cancellation remains a host concern. Web/native data alternatives and validated geometry are shared behavior, not pixel-identical rendering.

## Verification and remaining rollout

Local checks passed: six model/session groups, five browser scenes, TypeScript, seven registrar tests, three metadata-store tests and reference digest recomputation. The shared oracle has six chart cases, four breakpoint cases and one packed-layout case across TypeScript/Dart.

Browser coverage includes literal hostile titles, missing data, all four graphic families, series controls, widget add/remove/reorder/resize, isolated save/readback/reload, denied imports, conflicts, mobile RTL/breakpoint changes, removed stale data, retry and unbound adapters. Native tests cover matching model/session behavior, chart data alternatives, grid edits, source failure/retry and removed late results.

Final CI evidence will be recorded after the exact corrected source run completes. Human localization/accessibility/release approval, actual-device/screen-reader verification, real registered business data, service policy and host rollout remain pending. Six historical auth-reader review blockers are unchanged; whole-repository CI success is not claimed.

Rollback: dispose/unmount the optional factory/grid and remove its host import. Additive metadata remains registered-unimplemented; no destructive registration rollback is provided. B12 original icons/assets can proceed while these explicit B11 activation gates remain tracked.
