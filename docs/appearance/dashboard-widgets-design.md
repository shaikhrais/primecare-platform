# B11 design and activation boundaries

B11 provides optional original chart primitives and a dashboard grid separate from floating workspace panels. Production controls and a chart primitive are registered before runtime implementation. No business metric, widget grant, workflow, source endpoint or preference API kind is invented.

Charts accept bounded authorized projections: labelled categories and finite numeric/null series. Original line, area, grouped bar and donut geometry share numeric rules in TypeScript/Dart; metric cards display an explicit supplied value. Data alternatives remain available independent of graphics and colour. Theme tokens, localized series/category labels and number formatting come from the host. Missing values are gaps, not fabricated zeroes; empty/error/loading states are explicit.

The dashboard registry is supplied by an authorized host adapter and includes stable widget IDs, positive registration/source/workflow IDs, supported chart kind, allowed breakpoint IDs and size bounds. These proof references are transport inputs, not client-side permission grants. Real activation requires server validation of all of them. The generic source catalogue creates no production business-widget instances.

Layouts contain versioned per-breakpoint ordered placements with bounded column/row spans. Deterministic packing provides layout positions and keyboard/button reorder; no floating coordinates are mixed into this format. Imported, cached, saved and default layouts all pass the current permitted registry validator. Tenant/role defaults are host-provided authorized documents, never hardcoded role decisions. Scope or grant changes require disposal and recreation with fresh bindings.

Persistence uses an explicit dashboard preference port with scope, resource, revision and acknowledged snapshot validation. Save is followed by a fresh readback; exact document/revision agreement is required before clean status. Failed/conflicting writes retain edits. No HTTP adapter is auto-bound: existing API 777 accepts only theme/workspace/shortcuts and its current role/panel restrictions remain unchanged. Registration of a dashboard document kind, workflow/widget source bindings and actual production API/database/reload verification are blocked integration work. Isolated port tests do not count as production persistence.

No third-party chart/grid dependency is introduced. Existing packages and B09 actions/labels are reused. Proprietary reference code/assets are not copied. Native and browser support gaps, human review and real-device gates remain explicit.

## Acceptance scenarios

- Shared numeric fixtures cover mixed-sign bars, single-point lines, gaps, all-zero donut data, empty/malformed datasets and finite bounds. Web/native charts expose all original values through an accessible table/list; graphics never substitute synthetic values for missing data.
- Add/remove/reorder/resize and per-breakpoint edits preserve the other views, honor registered placement bounds and reject unknown/denied widgets in imports, defaults and readbacks.
- A late data result from a removed widget, changed actor or older refresh cannot repaint current content. Error/empty/loading states remain explicit; retry uses only the currently authorized source adapter.
- Persistence tests cover read/write/readback/reload, revision conflict, mismatched acknowledgement, denied saves, edits during a pending save and scope disposal. A pure isolated adapter success is labelled component evidence; no production database success is inferred.
- Browser tests use governed stable control selectors and native tests use registered semantics/labels. Actual device, screen-reader, localization and production integration approvals remain separate gates.
