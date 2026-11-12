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
| `editor(document, save?, imageAllowed?, options?)` | Returns `{element,document}`. Apply block bold/italic/bullet, HTTPS link, approved image, add paragraph and save. Missing save disables it. Image alternative text comes from the active block text. |
| `upload(policy, port?, retrySafe?)` | Returns `{element,task}`. Native browser file picker, metadata validation, progress, cancel and explicitly enabled idempotent retry. |
| `dispose()` | Aborts listeners/tasks, invalidates late results and empties only the owned slot. |

Append returned elements to the owned slot. Each primary catalogue key has one instance per factory; table row/column suffixes are deterministic derivatives of its registered IDs. Row/column IDs must be lowercase `[a-z0-9_-]`, 1–80 characters. Suffixes are bounded and duplicates fail. Repeat full catalogues in different hosts only after identity/source registration review; this is not an unlimited dynamic field-schema generator.

Table model limits: 100,000 supplied rows, 50 columns, 1–1,000 rows per page, 1,000 filter characters. Inputs are primitive projections (string/finite number/boolean/null) with stable unique IDs. Sorting is stable; filters reset paging; selection follows IDs and prunes on replacement. Expanded detail is outside the fixed-height virtual region. Native browser scroll and keyboard arrows/Home/End work with logical RTL navigation; column controls expose show/hide/order/pin/width. Pinned web columns remain sticky inside the scroll viewport. Choose an action width and row height large enough for localized controls and supported text scaling; do not squeeze accessible buttons into a narrow cell.

## Flutter

Import `package:flutter_core/data_controls.dart` or `package:primecare_ui/data_controls.dart`. Load/package the verified metadata in the host and create `CatalogueLabels.fromMetadata(decoded, locale)` from the B09 optional catalogue entry. `PrimeDataKit(labels, scope)` reuses B09 guarded action handling and existing Material theme context.

- `kit.field(kind, controller, enabled/required/min/max/step/pattern, firstDate/lastDate)` supports presentation constraints. Date picker access requires host-supplied first/last date; time picker access is built in. Values are ISO calendar date and 24-hour time strings; host display/localization and server time-zone conversion remain separate. The optional enabled flag defaults to true. The shared field owns only its picker route; changing its scope/controller/kind/bounds/enabled state or disposing it closes that route and ignores its late result. A newer controller text edit also wins over an outstanding picker. Controllers remain caller-owned.
- `kit.form(key, fields, save)` validates and preserves host-owned controllers after rejection.
- `PrimeVirtualTable` accepts the shared column/row model and finite host-token geometry. `ListView.builder` bounds mounted rows; vertical arrows/PageUp/PageDown scroll; selection, expansion and controls remain keyboard reachable. Horizontal scroll synchronizes header/body. Pinned columns and selection actions stay at the logical leading edge while the remaining columns scroll. Header and body share the horizontal offset; LTR and RTL use the same model. Source acceptance passed web/browser and native Linux/Windows/macOS CI in run 41311492044; registered-host/device acceptance remains open.
- `PrimeDataAutocomplete` accepts async query and selection callbacks. Material keyboard behavior is reused; scope changes invalidate old results. The host cancels its own transport if required (native adapter has no cancellation argument).
- `PrimeStructuredEditor` accepts document, save and optional image approval/rendering adapters. `inlineRanges: true` opts into version-2 range documents; the default remains the strict version-1 block format. Native links are displayed as selectable validated addresses; activation/navigation requires a host adapter and is not implemented here.
- `PrimeUploadControl` accepts policy, async picker, upload port and retry-safety declaration. Binary handles are opaque; the injected picker owns platform permissions and actual binary selection. No picker package or transport is silently installed.

Flutter source is validated with 3.41.5. Keep EN/FR/ES Material localization delegates, direction, theme and permissions in the application host.

## Structured document and upload contracts

`validateDocument` accepts only `{version:1, blocks:[...]}`: 1–200 blocks, total text at most 32,768 characters, boolean bold/italic, paragraph/bullet kind, optional HTTPS link and image `{url,alt}`. Unknown fields, URL credentials, control characters, backslashes, JavaScript/data URLs and missing image alternatives fail. Every text node remains literal. This remains the default block-level format. Optional character ranges use the explicit version-2 format described below. Arbitrary HTML import and embedded-provider editing remain outside this implementation. Previews never execute source strings. Browser images require host URL approval; native images additionally require a rendering adapter. Approval must enforce a trusted host/path policy and any privacy requirements before external fetching.

`UploadTask` receives scope, file policy, optional transport and retry flag. The transport receives scope, operation key, opaque selected files, cancellation and monotonic progress callback; completion requires a nonempty durable receipt ID. Type/name/size checks are advisory metadata checks, not malware scanning or server authorization. Server-side content inspection, quotas and access enforcement remain required.

Use a fresh host-issued operation/session scope for each upload-control lifetime; selection keys append an ordinal and retries retain the same key. Enable `retrySafe` only when the server's idempotency contract covers that key. Cancellation stops local waiting and signals the port; it does not prove remote deletion. A late acknowledgement after cancellation/disposal cannot show success. Invalid replacement clears old files. Progress reaching 100% alone is not a receipt.

## Explicit support limits and rollout

No new runtime dependency was added. Original TypeScript/Dart code uses existing DOM, Flutter and B09 helpers; third-party package licensing remains recorded in existing manifests. No vendor runtime/assets were copied.

Remaining feature gaps include arbitrary HTML import, inline mark ranges, spreadsheet editing/server-side queries, upload removal/remote deletion UI, and specialized rating/slider/stepper/transfer-list variants. Their reference examples are not claimed adopted. Host-native picker policy, actual business adapters, governed real-data flows, actual-device/screen-reader testing and human localization/accessibility/release reviews remain required. Existing apps and legacy widgets are unchanged until controlled integration.

Rollback: dispose/unmount the optional factory/widget and remove its host import. Additive metadata remains registered-unimplemented; no destructive metadata rollback is provided.

Native `PrimeStructuredEditor.openLink` accepts a host-owned async HTTPS navigation callback. No system launcher or route is chosen by the factory. A missing callback retains selectable link text; a failure exposes the existing error label. Duplicate taps are disabled while pending, and late failures after scope replacement/disposal cannot overwrite the new context. Link/image draft fields also reset when the document/scope resets. Native table horizontal pinning is implemented in the shared renderer; application-specific adapter/host gates and device acceptance remain open.


## Upload selection and receipt removal

Web: `upload(policy, uploadPort, retrySafe, {remove, readReceipt, retrySafe: removalRetrySafe})` adds the optional removal binding. Flutter: pass `removalPort`, `receiptPort` and `removalRetrySafe` to `PrimeUploadControl`. All types are exported through the existing data-control entry points; no app-specific implementation is required.

Before upload, each selected file can be removed. This edits the local selection and invalidates its upload key; it never deletes remote data. After successful upload, the receipt-level Remove file action deletes the entire upload represented by that receipt. Per-file remote deletion is not inferred from a multi-file upload receipt.

The host must bind both a deletion port and a fresh authoritative receipt reader. The write acknowledgement must match the captured receipt and confirm deletion; the separate read must match scope/receipt and report absent. Only then are local files and the receipt cleared. Missing adapters keep remote removal disabled. Denied, malformed or failed operations retain the receipt and selection with an error.

An acknowledged write followed by failed verification retries only the read. A lost acknowledgement first reconciles absence. Reissuing an unresolved deletion requires explicitly declared server idempotency and reuses the exact original operation key. No automatic retry, new endpoint, permission grant or provider operation is introduced. Scope replacement/disposal suppresses late completions. The pending state is in-memory; durable reload reconciliation is a host/storage integration requirement.

Source `7409001beae3d7ff714f2f2a9bb98f296535443f`, run 41315000584: web/browser and Flutter Linux/Windows/macOS analysis/widget/model checks passed. This closes the shared removal-control/lifecycle source gap; approved storage bindings and deployed business acceptance remain pending.

## Optional character ranges (version 2)

Web hosts opt in with `editor(document, save, imageAllowed, {inlineRanges: true})`; Flutter hosts use `PrimeStructuredEditor(inlineRanges: true, ...)`. This is a capability declaration by the host, not a role grant or automatic rollout. The host must have approved version-2 read/write and persistence bindings before mounting it. No current host is opted in by this repair. Existing callbacks without the option continue receiving version-1 documents and marked/version-2 input is rejected rather than silently stripped.

The opted-in editor writes `{version: 2, blocks: [...]}`. A block can include `marks: [{start, end, bold, italic}]`. Offsets are UTF-16 on both web and Dart. Ranges must be ordered, non-overlapping, nonempty and cannot split a surrogate pair. Every mark supplies both effective style booleans, allowing a range to turn off a block-level style. Adjacent identical marks merge; marks equal to the block defaults disappear. Limits are 1,024 marks per block and 4,096 per document, in addition to existing text/block limits. Version-1 documents still reject the `marks` field.

Select text and use the existing Bold/Italic controls to apply or remove that style for the selection. With a collapsed selection the existing whole-block action remains. Previews use literal styled text, never executable HTML. Insertion/replacement/deletion rebases surviving spans around one contiguous edit; inserted text inherits the neighbouring style. Rejected saves retain the text and marks. Scope replacement resets the editor to the new supplied document. Link and image approval remain with the existing host adapters.

Pure model helpers are `richRuns`, `toggleRichRange`, `inferRichEdit` and `replaceRichText` on web and Dart. The Node suite compares overlapping operations with an independent per-character reference; 254 shared fixture operations verify web/Dart parity, including emoji and combining text. Browser and native widget suites additionally cover selection, preview, edits, failed saves and the legacy capability gate. Source acceptance, registered persistence, actual-host/device use and human release review remain distinct.

When the old selection and new caret are known, `inferRichEdit(oldText, newText, start, end, afterStart)` supplies an exact edit range to `replaceRichText`. The web editor captures `beforeinput`; Flutter tracks controller editing values. This prevents identical-character insertions/deletions from shifting marks at the wrong repeated substring. Without edit context, the pure replacement helper uses a contiguous common-prefix/suffix replacement.
