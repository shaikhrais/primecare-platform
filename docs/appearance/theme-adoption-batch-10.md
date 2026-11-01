# B10 — Shared tables, forms, structured editor and uploads

Shared source implementation is on main. Web and Flutter Linux/Windows/macOS factory acceptance passed; host activation and remaining feature gaps are separate gates. This batch does not complete application screens or claim every reference variant.

The original web/Flutter packages reuse verified B09 action/label handling, B06 theme context and registered PrimeCare primitives. They add bounded table models and virtual renderers, typed form constraints and autocomplete, a safe block document editor, and a receipt-based upload lifecycle. Usage/API details and platform limits are in [data-controls-usage.md](data-controls-usage.md); [support matrix](data-controls-support.json) preserves explicit dispositions.

## Database-first registration

[Production run 41258198250](https://github.com/shaikhrais/primecare-platform/actions/runs/41258198250) used source `ba504522165ea5a61f59faab568af7a30b446cc9`. Validation job 124705758506 and production job 124705829773 passed. The workflow performed a rollback-only dry-run, exact idempotent apply and independent read-only verification before implementation began.

It registered 38 optional controls, 38 required-element records, 46 resources and 138 draft EN/FR/ES translations on existing Tenant Admin screen 2534. Existing primitives, including `prime_table_web`, were reused; no primitive additions were needed. The manifest remains pinned to the same PostgreSQL schema. The metadata writer permits only the five existing metadata tables and introduces no business data, grants, routes, schema changes or runtime activation. Screen implementation tags remain `registered-unimplemented`; translations remain unreviewed/unapproved. The optional `remove` binding is reserved and not exposed as a working remote-file deletion action.

## Implemented behavior

- Tables: 100,000-row bounded model, stable sorting/filtering/paging, identity-based selection/pruning, external expanded detail, column visibility/order/width and pin configuration. Web mounts a fixed-height virtual window; native uses `ListView.builder`. The large-data test uses 50,000 rows, with bounded mounted elements rather than a hidden full table.
- Forms: required and ISO calendar/time checks, finite number/range/step checks, digit masks, retained failed submit values and stale-safe asynchronous autocomplete. Web uses browser date/time controls; Flutter exposes date/time dialogs, with host-supplied calendar bounds.
- Editor: original versioned block schema with bold/italic/bullet, safe HTTPS links and approved images. Unknown fields and unsafe URLs fail. Literal source is never HTML-interpreted or evaluated. Saves require callback acknowledgement and retain the document on failure.
- Upload: real platform handles via browser picker or injected native picker, advisory metadata policy, monotonic progress, cancellation, explicit idempotent retry and durable receipt validation. Late cancelled/disposed results cannot report success. Missing adapters disable operational actions and show localized unavailable status.

No external grid/editor/picker dependency or vendor source/assets were added. Existing app hosts and legacy widgets remain compatible and unmigrated.

## Reference and platform limits

The B09 physical inventory has 205 advanced-input/collection examples. Core family behavior maps to the 59 autocomplete, 11 number-field, 24 pagination and 27 table examples; this is family consolidation, not a claim to all 121 visual/property variants. The 17 rating, 39 slider, 21 stepper and 7 transfer-list examples remain specialized variants pending. Source details remain in the unmodified B09 reference inventory and the B10 support matrix.

Native pinning currently prioritizes column order without sticky horizontal rendering. Native editor links are selectable addresses; host link activation is pending. Block-level marks do not provide character-range mark editing or arbitrary HTML import. Spreadsheet cell editing, server-side queries, remote upload removal/deletion and specialized variants remain gaps. The support matrix makes these limits machine-readable.

## Validation and remaining rollout

Local checks passed: six model/state-machine groups, 19 shared TS/Dart oracle cases, five Chromium scenes, TypeScript, seven registration tests and three metadata-store tests. Browser scenes cover keyboard table navigation, 50,000-row virtualization, column configuration, mobile RTL form input retention, stale/denied autocomplete, unsafe editor links and literal text, failed saves, cancellation/late receipts/retry/denial, and disabled missing adapters. These use isolated synthetic projections and transport callbacks, not production business transactions.

Source `8022da343ef678ab1fa63d80f13a0fdeba276cf3` passed [run 41259596812](https://github.com/shaikhrais/primecare-platform/actions/runs/41259596812). Flutter analysis was clean and all 12 native tests passed per platform.

| Job | ID | Result |
|---|---:|---|
| native (windows-latest) | 124709977319 | Passed |
| native (macos-latest) | 124709977504 | Passed |
| native (ubuntu-24.04) | 124709977514 | Passed |
| web | 124709977609 | Passed |

The initial native run caught a missing semantics import; after correction, a test finder matched both the filter text and the selected cell. The assertion now targets the cell widget. Final acceptance uses the corrected exact commit. Production APIs, native binary permissions/picker policy, trusted image hosts, idempotency service contracts, host/source/access registration and actual business-data flows remain integration work. Device/screen-reader verification and human localization/accessibility/release review remain pending. Six historical auth-reader review blockers are unchanged; whole-repository CI success is not claimed.

Rollback: unmount/dispose an optional factory or widget and remove its host import. Additive metadata stays registered-unimplemented; this batch provides no destructive registration rollback.
