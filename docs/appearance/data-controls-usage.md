# Shared B10 data controls

B10 is an optional shared factory catalogue, not an app-wide migration. Labels/control IDs come from `packages/primecare_ui/catalogs/data-controls.registration.json`, independently verified on production screen 2534. EN/FR/ES strings remain human-review pending. Native/other-host source and access bindings must be registered before activation.

## Web

Import `PrimeDataControls` from `packages/primecare_ui/web/data-controls.ts`. Create `new PrimeDataControls(exclusiveSlot, scope, locale)` inside the existing B06 themed host. Supply CSS token context, direction, authorized projected data and localized column/option labels. One slot has one owner; body/document roots are rejected. Scope must identify the actor and operation/session lifecycle. Dispose on navigation or actor change and recreate; do not reuse a slot for unrelated content.

| API | Inputs / result |
|---|---|
| `table(columns, rows, geometry, detail?)` | Returns `{element,model,replace}`. Geometry supplies finite token-derived row height, viewport height, column bounds, action width and optional page size. Detail is caller-created content. |
| `field(kind, constraint?, value?)` | Kinds `date`, `time`, `number`, `mask`; returns `{element,input,validate}`. Required/min/max/step and `#` mask constraints are presentation rules. |
| `form(fields, submit?)` | Responsive validated form; callback receives keyed values. Rejected acknowledgement retains input. Missing callback disables submit. |
| `autocomplete(load?, selected?)` | Abort-aware async query adapter returning up to 100 unique `{value,label}` options. Stale results and blurred requests cannot reopen old options. Arrows/Enter/Escape operate a labelled combobox/listbox. |
| `editor(document, save?, imageAllowed?)` | Returns `{element,document}`. Apply block bold/italic/bullet, HTTPS link, approved image, add paragraph and save. Missing save disables it. Image alternative text comes from the active block text. |
| `upload(policy, port?, retrySafe?)` | Returns `{element,task}`. Native browser file picker, metadata validation, progress, cancel and explicitly enabled idempotent retry. |
| `dispose()` | Aborts listeners/tasks, invalidates late results and empties only the owned slot. |

Append returned elements to the owned slot. Each primary catalogue key has one instance per factory; table row/column suffixes are deterministic derivatives of its registered IDs. Row/column IDs must be lowercase `[a-z0-9_-]`, 1–80 characters. Suffixes are bounded and duplicates fail. Repeat full catalogues in different hosts only after identity/source registration review; this is not an unlimited dynamic field-schema generator.

Table model limits: 100,000 supplied rows, 50 columns, 1–1,000 rows per page, 1,000 filter characters. Inputs are primitive projections (string/finite number/boolean/null) with stable unique IDs. Sorting is stable; filters reset paging; selection follows IDs and prunes on replacement. Expanded detail is outside the fixed-height virtual region. Native browser scroll and keyboard arrows/Home/End work with logical RTL navigation; column controls expose show/hide/order/pin/width. Pinned web columns remain sticky inside the scroll viewport. Choose an action width and row height large enough for localized controls and supported text scaling; do not squeeze accessible buttons into a narrow cell.

## Flutter

Import `package:flutter_core/data_controls.dart` or `package:primecare_ui/data_controls.dart`. Load/package the verified metadata in the host and create `CatalogueLabels.fromMetadata(decoded, locale)` from the B09 optional catalogue entry. `PrimeDataKit(labels, scope)` reuses B09 guarded action handling and existing Material theme context.

- `kit.field(kind, controller, required/min/max/step/pattern, firstDate/lastDate)` supports presentation constraints. Date picker access requires host-supplied first/last date; time picker access is built in. Values are ISO calendar date and 24-hour time strings; host display/localization and server time-zone conversion remain separate.
- `kit.form(key, fields, save)` validates and preserves host-owned controllers after rejection.
- `PrimeVirtualTable` accepts the shared column/row model and finite host-token geometry. `ListView.builder` bounds mounted rows; vertical arrows/PageUp/PageDown scroll; selection, expansion and controls remain keyboard reachable. Horizontal scroll synchronizes header/body. Pinning moves columns before unpinned columns; native sticky horizontal pinning remains a gap.
- `PrimeDataAutocomplete` accepts async query and selection callbacks. Material keyboard behavior is reused; scope changes invalidate old results. The host cancels its own transport if required (native adapter has no cancellation argument).
- `PrimeStructuredEditor` accepts document, save and optional image approval/rendering adapters. Native links are displayed as selectable validated addresses; activation/navigation requires a host adapter and is not implemented here.
- `PrimeUploadControl` accepts policy, async picker, upload port and retry-safety declaration. Binary handles are opaque; the injected picker owns platform permissions and actual binary selection. No picker package or transport is silently installed.

Flutter source is validated with 3.41.5. Keep EN/FR/ES Material localization delegates, direction, theme and permissions in the application host.

## Structured document and upload contracts

`validateDocument` accepts only `{version:1, blocks:[...]}`: 1–200 blocks, total text at most 32,768 characters, boolean bold/italic, paragraph/bullet kind, optional HTTPS link and image `{url,alt}`. Unknown fields, URL credentials, control characters, backslashes, JavaScript/data URLs and missing image alternatives fail. Every text node remains literal. This is block-level rich text, not arbitrary HTML import or character-range/embedded-provider editing. Previews never execute source strings. Browser images require host URL approval; native images additionally require a rendering adapter. Approval must enforce a trusted host/path policy and any privacy requirements before external fetching.

`UploadTask` receives scope, file policy, optional transport and retry flag. The transport receives scope, operation key, opaque selected files, cancellation and monotonic progress callback; completion requires a nonempty durable receipt ID. Type/name/size checks are advisory metadata checks, not malware scanning or server authorization. Server-side content inspection, quotas and access enforcement remain required.

Use a fresh host-issued operation/session scope for each upload-control lifetime; selection keys append an ordinal and retries retain the same key. Enable `retrySafe` only when the server's idempotency contract covers that key. Cancellation stops local waiting and signals the port; it does not prove remote deletion. A late acknowledgement after cancellation/disposal cannot show success. Invalid replacement clears old files. Progress reaching 100% alone is not a receipt.

## Explicit support limits and rollout

No new runtime dependency was added. Original TypeScript/Dart code uses existing DOM, Flutter and B09 helpers; third-party package licensing remains recorded in existing manifests. No vendor runtime/assets were copied.

Remaining feature gaps include native sticky pinning, native link activation, arbitrary HTML import, inline mark ranges, spreadsheet editing/server-side queries, upload removal/remote deletion UI, and specialized rating/slider/stepper/transfer-list variants. Their reference examples are not claimed adopted. Host-native picker policy, actual business adapters, governed real-data flows, actual-device/screen-reader testing and human localization/accessibility/release reviews remain required. Existing apps and legacy widgets are unchanged until controlled integration.

Rollback: dispose/unmount the optional factory/widget and remove its host import. Additive metadata remains registered-unimplemented; no destructive metadata rollback is provided.

Native `PrimeStructuredEditor.openLink` accepts a host-owned async HTTPS navigation callback. No system launcher or route is chosen by the factory. A missing callback retains selectable link text; a failure exposes the existing error label. Duplicate taps are disabled while pending, and late failures after scope replacement/disposal cannot overwrite the new context. Link/image draft fields also reset when the document/scope resets. Native table horizontal pinning and application-specific adapter/host gates remain open.
