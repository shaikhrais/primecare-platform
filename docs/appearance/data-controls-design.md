# B10 design and integration boundary

This batch provides optional shared presentation factories on existing Tenant Admin metadata. It introduces no business routes or permission grants. Activation requires host source bindings and authorized adapters; component acceptance does not complete a production screen.

- Tables operate on an explicitly supplied authorized projection. Stable row identity, bounded columns/rows, filtering/sorting/paging/selection/expansion and column configuration live in a pure model. Fixed-height virtualization limits mounted rows. Expanded details occupy a separate region so variable detail heights cannot corrupt virtual offsets.
- Forms validate presentation constraints and preserve values after rejected saves. Business validation remains server-owned. Autocomplete adapters must return only authorized, localized options; stale completions are discarded.
- Rich documents use a bounded structured block format with explicit text marks, lists and validated HTTPS links/images. No HTML import, script execution or arbitrary DOM serialization. Images require host approval; no implicit remote fetch or upload.
- Upload ports own authorized binary transport and durable receipt validation. Client metadata screening is advisory; the server must inspect content, limits and permissions. Progress never means completion. Missing ports disable actions. Cancellation/disposal invalidates late results; retry keeps the selection's operation key so ports can implement idempotency.
- Web/native support is documented separately. No third-party editor/grid/picker package is introduced; existing platform dependencies remain governed by their existing manifests. Existing UI stays compatible until controlled host migration.

## Proposed shared contracts

Table rows use a stable, bounded string ID and a map of primitive projected values. Columns use a stable key, host-localized label, width and visible/pinned flags. The renderer accepts finite token-derived row height, viewport height and minimum/maximum widths. Filtering resets paging; selection is keyed by identity rather than array index. Data replacement prunes missing IDs. Scope replacement clears all actor-owned selection/expansion state. A client-projected table is unsuitable for fetching unrestricted data; a server query adapter remains separate.

The document schema is version 1, with bounded blocks. Each block has plain text, bold/italic flags, paragraph/bullet kind and optional HTTPS link or image URL/alternative text. Validation reconstructs only allowlisted fields, rejects unknown keys, caps total text and disallows credentials or control characters in URLs. The editor applies formatting to the active block. It does not claim character-range mark parity or arbitrary HTML compatibility.

Upload candidates expose a safe filename, finite byte size, media type and opaque platform handle. A caller policy defines allowed media types, maximum files and aggregate bytes. The port receives scope, stable operation key, candidates, cancellation signal and progress sink; it returns a nonempty durable receipt. Client cancellation can stop local waiting but cannot prove remote deletion. Retry requires a server idempotency contract; otherwise the host must leave retry disabled. Native picking and image rendering are injected, avoiding an unapproved plugin or implicit remote fetch.

Accessibility verification combines explicit control labels, stable governed identifiers, status/error live regions, keyboard navigation and focus checks. Automated interaction success is not human screen-reader or WCAG certification.

## Acceptance scenarios

1. Use a 50,000-row synthetic projection to verify only a bounded viewport mounts; scroll far into a page and move focus with arrow keys. Filter, sort numeric/null cells, change page, retain selection by ID, expand details, hide/reorder/pin/resize columns and reject invalid widths or identities.
2. Required/date/time/number/mask fields reject malformed values; localized labels and errors remain available. Failed submit retains typed input. Resolve an older autocomplete request after a newer one and confirm it cannot overwrite current options; exercise arrows/Enter/Escape.
3. Format plain text, list blocks and apply safe links. Reject malformed document shapes, oversized text, JavaScript/data URLs and credential-bearing links. Host-approved images require alternative text. Save rejection retains the document and does not report persistence.
4. Reject oversized/type-denied files before transport. Verify actual progress callbacks, rejected/denied transport, cancellation, late acknowledgement after cancellation, same-key retry and successful durable receipt. An absent transport disables send/retry with an explicit unavailable label.
5. Run corresponding pure-model fixtures in TypeScript and Dart, plus native interaction tests across Linux/Windows/macOS. Keep backend/device/human review scope separate from component tests.
