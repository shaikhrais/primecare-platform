# PrimeCare class management

This module builds one source inventory with declared architecture managers and a master base-class index. It discovers real AST declarations in Dart, TypeScript/JavaScript and Python. It does not change Flutter inheritance, grant access, invent a business screen, or automatically merge similar classes.

## Ownership model

`master_registry.json` declares one root manager, parent managers, purpose and source-directory ownership scopes. Longest matching scope owns each observed declaration. The generated catalog is the master declaration index; IDs use language + SHA-256 of source path and qualified class name. Moving a file changes identity; moving a declaration within a file normally does not. Anonymous JavaScript closures can have unstable identities and are marked accordingly.

`MasterClassManager` validates the hierarchy. `MasterBaseClassManager` rejects duplicate base declarations. A class links to its source manager and parent manager. Base classes link only through explicit source bindings or declared external SDK targets. Ambiguous imports remain unresolved; this tool does not pretend an AST scan is type resolution. `implements`, mixin and secondary Python-base names are inventory metadata, not fully resolved manager links yet.

Human purpose/rationale proposals can be placed in `descriptions` under the class ID with the exact current `sourceSha256`. Stale descriptions fail validation. These are unapproved source proposals. Source comments remain separate from verified explanations. `baseBindings` maps class IDs to actual base declaration IDs; bindings need code review and currently do not prove import resolution.

## Database and review status

The additive SQL migration creates nine `govt_class_registry_*` relations inside the existing pinned production governance schema. The manifest and migration hash must match before DDL. The writer requires `CLASS_REGISTRY_WRITES=1`, a clean committed inventory and the existing `PRODUCTION_DATABASE_URL` GitHub Actions secret. It verifies the pinned Prisma PostgreSQL host with full TLS certificate checks. There is no SQLite or demo-data fallback.

| Status | Meaning |
|---|---|
| `unknown` | Source was scanned; no authenticated production read-back exists. |
| `present_current` | The production transaction read back this scan's class/source hash. |
| `needs_review` | Automated discovery has not approved class meaning or design. |
| `no_review` | Production has no human metadata review for the class. |
| `stale_review` | A human review exists for an older source hash. |
| `needs_resolution` | A base name still needs an explicit verified binding. |

Automated sync never inserts or approves human reviews. It preserves observations, events and reviews and never deletes declarations based on a missing or partial scan. No business rows, role grants or runtime app registration are changed. A class recorded in the database is not proof that its implementation works.

## Run locally

Use Dart 3.11 / Flutter 3.41.5, TypeScript 5.9.3 and Python 3.12. Install the Dart package and the existing `tools/governance-production/requirements.txt` for PostgreSQL tests/sync. Set `CLASS_REGISTRY_TYPESCRIPT` to the installed TypeScript compiler module.

```sh
dart pub get --directory tools/class_management
dart run tools/class_management/bin/scan.dart "$PWD" /tmp/classes-dart.json
node tools/class_management/scan-typescript.mjs "$PWD" /tmp/classes-typescript.json
python tools/class_management/catalog.py --dart /tmp/classes-dart.json --typescript /tmp/classes-typescript.json --output /tmp/classes-catalog.json
python tools/class_management/render_dashboard.py --catalog /tmp/classes-catalog.json --output /tmp/class-dashboard.html
```

The HTML is a downloadable, read-only engineering audit artifact. It supports search, manager/language/review filters, pagination, class details, overlap review and source-bound purpose proposal downloads. It is not a deployed PrimeCare Dart dashboard or a production-authorized app route. It has no authenticated API or database write button. Native app hosting, permission registration, localization and shared Dart component rendering remain separate work.

## CI and production execution

`.github/workflows/class-registry.yml` tests parsers and real PostgreSQL 16 transactions before scanning current source. Main pushes synchronize only the allowlisted class metadata extension after an exact current-main check. Manual `observe` runs do not write; manual `sync-production` requires an exact main SHA. Production receipts are emitted only after successful commit and include zero review approvals. Source and production-read-back dashboards are distinct artifacts. Main changing while the job prepares its source causes the write gate to fail and requires a current run.

Tests cover invalid hierarchies, scopes, real versus commented declarations, source identity, partial scans, spoofed status, pinned schema/manifest/migration checks, transaction idempotency, SQL cycle enforcement, human-review preservation, stale review status, dashboard script escaping and JavaScript syntax. Local PGlite is a PostgreSQL-compatible fixture, not evidence of a live production sync; native PostgreSQL CI and production receipts are reported separately.

## Known limits

Only the seven configured source roots and three supported languages are covered. Generated/vendor/test declarations are retained so that coverage is explicit. Invalid source is reported as partial coverage. Dynamic factories and external dependencies are not fully inventoried. Source-scope managers express architecture responsibility, not verified human ownership. Similarity groups are review candidates, including legitimate test and generated repetitions. There is no automatic class deletion, inheritance rewrite, component merge, review approval or app deployment.

## Class organization and table exports

Every new scan records separate `architecturalRole`, `appClass`, `isAppClass`, `appName`, `sourceContainer`, `usageScope`, `classificationEvidence`, `classificationStatus` and `runtimeReadiness` attributes. These deterministic, versioned labels are inferred and remain `inferred_needs_review`. They never change ownership, route registration, human reviews or runtime readiness. `appClass` identifies source placement; shared_package does not prove every application consumes that package. An app-specific screen and a shared-package screen can have the same role with different application scope. The writer rejects derived attributes that disagree with the recorded source rules.

Run `python tools/class_management/export_tables.py --catalog /tmp/classes-catalog.json --output /tmp/class-tables` for a complete class CSV, manager table, architecture-role table, application/container table, role-by-manager matrix, attribute dictionary and research-backed organization report. Both source and production CI artifacts include these exports. Manager counts are direct counts; parent rollups overlap and must not be summed. CSV text cells protect against spreadsheet formula execution. Role and appClass filters and detail attributes are available in the read-only HTML dashboard. Attribute metadata is not exhaustive Dart field/method introspection.

The organization follows Flutter's separation of views, view models, repositories and services (https://docs.flutter.dev/app-architecture/guide) and Backstage's separation of kind, type, ownership and lifecycle (https://backstage.io/docs/features/software-catalog/descriptor-format/). Screen/controller/model/section suffixes are deliberately distinguished; screen candidates are not accepted production routes.

## Primary types and HTML5 explorer

Organization version 3 adds `primaryType`, `primaryTypeLabel`, `primaryTypeEvidence`, `sourceOrigin` and `isGeneratedPathHint`. The detailed `architecturalRole` is the subtype. Priority is test scope, external ownership, non-test tooling, then data/API/UI/application/platform role evidence, backend fallback and unresolved. A test widget stays Test → Widget rather than increasing production UI totals. Source-location ownership remains independent.

The HTML5 dashboard uses the central default/defaultDark palette tokens, a primary-type distribution, nested type/subtype cards, source-volume explanations, review priorities, filtered paginated source rows, a class-evidence dialog, dark mode, filtered CSV and source-bound review proposals. It explains screen sections, supporting models/controllers/API clients, generated-path hints and overlap findings without asserting that every declaration is necessary. Only paths explicitly suggesting generation are marked as hints. Unmarked source can still be generated. Overlap affected-class counts are unique IDs, not a sum of overlapping findings. New table exports include `primary-types.csv` and `types-and-classifications.csv`.

Browser QA uses a recorded snapshot to exercise primary/subtype filters, subtype-card drill-down, search, class details, pagination and theme switching. Current production read-back is required before publishing a hosted snapshot as current. The HTML companion does not add a PrimeCare runtime route or business permissions.

## Four primary types and library inventory (version 4)

The only primary types are UI, API, Test and Packages. Tests take precedence. All other declarations under central/shared package libraries, including UI and core libraries, use Packages. Application presentation uses UI; backend/application API classes use API; models, tooling, modules, platform and unresolved support use Packages with their original detailed role. This is categorization, not a source move or inheritance rewrite.

Package-root and nested pubspec.yaml/package.json manifests declare library identity and source hashes. A source directory without a manifest is explicitly a source group, not a verified package. Nested libraries use the longest source-prefix match. Empty declared libraries remain visible. Manifest libraries and source-group counts are shown separately from class counts. Class metadata retains libraryId/name/path/status, including Test entries. Library inventories are preserved in metadata-sync event JSON; no new database relations or business writes are introduced. The dashboard and libraries.csv show per-library total, Packages and Test declarations and support library filtering. External dependencies outside configured source roots remain outside this inventory.
