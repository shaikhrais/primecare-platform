# B09 — Shared component and feedback catalogue

Accepted as shared source factories on main. Application host bindings, production runtime verification and human reviews remain pending. Source acceptance does not mark production screen controls implemented.

The original web and Flutter catalogue covers buttons, fields, multiline text, selection controls, radio/switch, menus, tabs, accordions, cards/badges, tooltips, dialogs/drawers, responsive forms, loading/splash/empty/error/retry, inline toast/snackbar feedback, confirmation, countdown, literal code emphasis/copy and caller-created previews. It reuses B06 theme tokens and existing primitive registrations. No Fuse runtime, proprietary visual assets, business endpoints or per-app copies were introduced.

Usage and lifecycle contracts: [component-catalogue-usage.md](component-catalogue-usage.md). Web entry: `packages/primecare_ui/web/component-catalogue.ts`. Native entries: `packages/flutter_core/lib/component_catalogue.dart` and `packages/primecare_ui/lib/component_catalogue.dart`. Existing legacy widgets remain compatible; app migration is later work.

## Registration

Production run [41255604301](https://github.com/shaikhrais/primecare-platform/actions/runs/41255604301), source `517d66b0201ea773a6bb5b45a2389de6c3ef42ba`, passed validation job 124697993743 and production job 124698079577. Dry-run rollback, idempotent apply and independent readback verified:

- 34 optional controls and 34 required-element records on existing Tenant Admin screen 2534.
- 42 language resources and 126 EN/FR/ES values, still unreviewed/unapproved.
- Primitive registry additions `prime_radio` (18) and `prime_switch` (19).

The pinned PostgreSQL manifest remains unchanged. Only the five approved metadata tables are writable. No business-data writes, grants, routes, schema changes or runtime activation occurred. Control implementation tags remain `registered-unimplemented`.

Initial attempts encountered an unrelated workflow-tracking table lock before apply. The correction introduced a metadata-only store that locks just the five allowlisted tables, rather than using the tracking writer. The exact pin, scope and dry-run safeguards remain enforced. Tests reject SQLite fallback and workflow mutations through the read interface. The final successful receipt and verified metadata export are committed alongside the source.

## Reference disposition

The licensed v17 Vite/Next.js demo inventory records filenames and content digests without copying implementation into the runtime. [Full audit](component-catalogue-reference-audit.json) accounts for all 1,187 physical examples across 55 families:

| Disposition | Examples |
|---|---:|
| Consolidated into original foundation factories | 652 |
| Deferred advanced inputs/collections, B10 | 205 |
| Deferred assets, B12 | 50 |
| Existing B04/B05 navigation and composition | 65 |
| Framework-only examples, no separate factory | 109 |
| Not adopted in B09; specification/disposition required | 106 |

There are 565 logical cross-bundle duplicate names and zero byte-identical duplicates. Consolidation is a family mapping, not a claim to every MUI property, animation or visual variant. Lists, masonry, speed dial, timeline and floating action button examples include explicit unadopted dispositions. Fuse loading/suspense consolidate into scoped async boundaries; splash is a loading variant. Highlight/example/countdown/dialog map to original safe helpers.

Reproduce the inventory with `python3 scripts/audit-component-reference.py PATH_TO_LICENSED_ARCHIVE --check`, then `node scripts/check-component-reference-audit.mjs`. The archive is not redistributed.

## Verification

Source `f5bf3d21ebda8fade161b680d91129c8da8f5a63` passed [run 41257279489](https://github.com/shaikhrais/primecare-platform/actions/runs/41257279489):

| Job | ID | Result |
|---|---:|---|
| Web | 124703051777 | Passed |
| Flutter macOS | 124703051792 | Analyze clean; 11 tests passed |
| Flutter Windows | 124703051894 | Analyze clean; 11 tests passed |
| Flutter Linux | 124703051911 | Analyze clean; 11 tests passed |

Web verification includes TypeScript, four model groups, five browser scenes, seven registrar tests and three metadata-store tests. Twenty-one shared model cases compare literal code tokenization, absolute countdown and responsive geometry across TypeScript and Dart. Flutter 3.41.5 runs two model and nine widget tests on each platform.

Interaction coverage includes busy/disabled/error states, retained form input, required validation and Enter submission, controlled selection, keyboard navigation, mobile/RTL presentation, modal rejection/acknowledgement and focus, literal hostile text and clipboard rejection, stale async results, once-only expiry and disposal. A regression also confirms that a late native confirmation removes only its own dialog while a newer route remains open. Synthetic callbacks verify component behavior; they are not business transactions or production end-to-end evidence.

## Remaining integration and release work

Actual hosts must register source bindings, package metadata, supply approved business callbacks and consume theme/direction context. Native and other app metadata/access decisions are not implied by this Tenant Admin pilot. Full rollout requires governed Cypress flows, actual-device/screen-reader checks, human localization/accessibility/release approval and later app migration. B10 advanced fields/collections, B12 assets and the explicitly unadopted examples remain tracked. Six historical auth-reader review blockers are unchanged; whole-repository CI success is not claimed.

Rollback is removal of an optional host import/mount and disposal of its owned lifecycle. Additive registrations stay unimplemented; there is no destructive metadata rollback. B10 can proceed while these activation gates remain explicit.
