# PrimeCare original theme implementation batches

Created: 2026-10-31. Baseline: `f563f5447c4d1cf8a9622975f475dd704931d1d1`.

**Status: B01 source preparation validated; GitHub production connection verified and registration gaps confirmed. B02–B18 remain planned.**

Implement original PrimeCare equivalents for the audited Fuse v17 features. Reuse shared core packages across web and Flutter. Work on current `main`, retain concurrent work and use expected-head checks. Do not copy proprietary vendor implementation or replace existing authentication without an approved requirement.

## Current starting point

Shared shell, base Theme Center, personal themes, existing native layout options and account-scoped local settings.

Shared optional docking engine exists and passed isolated tests; no production shell mount.

**Production execution:** the local pinned reader returned `MISSING_DATABASE_URL`. Existing GitHub workflows reference the `production` environment’s `PRODUCTION_DATABASE_URL` secret. The dedicated `theme-adoption-preflight.yml` workflow uses that secret in place for read-only reconciliation. Run 41225732414 connected and validated the pin on commit 119b0094, then identified unresolved registrations. Exact metadata bindings must be resolved before registration or new UI exposure. No SQLite fallback.

## Ordered batches

| Batch | Deliverable | Depends on |
|---|---|---|
| B01 | Governance, feature contracts and localization | — |
| B02 | Integrate the advanced web layout engine | B01 |
| B03 | Flutter layout parity | B01, B02 |
| B04 | Complete navigation and three layout families | B01, B02, B03 |
| B05 | Page templates and route-specific layouts | B01, B02, B03, B04 |
| B06 | Complete Theme Center and palette tools | B01, B02, B03 |
| B07 | Account preferences and cross-device sync | B01, B02, B03, B06 |
| B08 | Shared shell utilities | B01, B04, B05, B07 |
| B09 | Base component and feedback catalogue | B01, B05, B06 |
| B10 | Tables, forms, editors and upload controls | B01, B06, B09 |
| B11 | Charts and configurable dashboard widgets | B01, B05, B06, B09, B10 |
| B12 | Original icon and visual asset completion | B01, B06, B09 |
| B13 | Calendar, contacts, tasks, notes and scrumboard | B01, B05, B07, B08, B10, B11, B12 |
| B14 | Mailbox, messenger, notifications and file manager | B01, B05, B07, B08, B10, B12 |
| B15 | Academy, commerce, AI images, profile, settings and help centre | B01, B05, B07, B09, B10, B12 |
| B16 | Four dashboard families and supporting pages | B01, B05, B06, B09, B10, B11, B12 |
| B17 | Catalogue, documentation and app-wide adoption | B04, B05, B06, B08, B09, B10, B11, B12, B13, B14, B15, B16 |
| B18 | Full verification and release closure | B02, B03, B04, B05, B06, B07, B08, B09, B10, B11, B12, B13, B14, B15, B16, B17 |

## Batch contracts

### B01 — Governance, feature contracts and localization

Status: in progress; source preparation validated and GitHub production reconciliation completed with registration gaps. See `docs/appearance/theme-adoption-batch-01.md`. Dependencies: none.

Scope:

- Reconcile every audited Fuse capability against existing production registrations and PrimeCare implementations; retain missing, partial, implemented-unverified and verified distinctions.
- Register approved controls, resources, tokens, template requirements and implementation tags in the pinned production PostgreSQL authority before exposing new UI.
- Map every template to an existing authorized business workflow; record unmatched workflows as needs-specification instead of inventing routes, permissions or endpoints.
- Export reviewed identifiers and EN/FR/ES resources; define RTL behaviour, owner, API bindings and evidence requirements.

Completion checks:

- Exact pinned manifest validates; registrations are idempotent and independently read back.
- Every later batch has approved dependencies and traceable requirement IDs.
- No operational SQLite fallback; no fabricated registration or completed tags.

Shared targets: `tools/governance-production/`, `packages/primecare_ui/catalogs/`, `packages/domain/src/`.

### B02 — Integrate the advanced web layout engine

Status: planned. Dependencies: B01.

Scope:

- Mount the existing WorkspaceLayoutManager through the shared web shell and existing Theme Center using governed controls.
- Expose navigation placement and width, boxed/full-width/content modes, panel docking/floating/hiding, resize handles and keyboard alternatives.
- Connect toolbar top/bottom and sticky/static, footer sticky/static/hidden, page/content scrolling, undo/redo/reset and workspace JSON import/export.
- Preserve existing theme XML compatibility and unsaved screen state; define focus and lifecycle handling on navigation, logout and tenant/role changes.

Completion checks:

- Real shell actions change the layout without losing input, handlers or authorized content.
- Denied or removed panels cannot be restored by imported preferences.
- Desktop/mobile browser tests cover storage failures, gestures, focus, import rejection and rollback.

Shared targets: `packages/primecare_ui/web/`, `packages/domain/src/workspace_layout.ts`, `websites/typescript/src/`.

### B03 — Flutter layout parity

Status: planned. Dependencies: B01, B02.

Scope:

- Implement a Flutter renderer for the same validated workspace contract and approved panel registry.
- Support matching container, toolbar/footer, panel docking, floating/resizing and scroll settings through shared layout factories.
- Add touch and keyboard interaction, semantics, safe-area handling and small-screen stacking.
- Use one account/tenant/role-scoped preference adapter; preserve current native layout choices and migrate existing preferences safely.

Completion checks:

- Shared web/native contract fixtures roundtrip without silent setting loss.
- Flutter widget and interaction tests verify focus, retained state and panel authorization.
- Supported Android, iOS and desktop builds pass relevant checks; unsupported platforms remain explicitly blocked.

Shared targets: `packages/flutter_core/lib/theme/`, `packages/flutter_core/lib/registry/widgets/`, `packages/primecare_ui/lib/src/components/layouts/`.

### B04 — Complete navigation and three layout families

Status: planned. Dependencies: B01, B02, B03.

Scope:

- Create three original preset compositions corresponding to the functional vertical and two horizontal layout families.
- Implement genuine horizontal dropdown navigation, grouped/nested menus, tabbed icon rail and submenu panel.
- Complete folded/expanded, hover expansion and pin/unpin behaviour across web and native.
- Support registered icons, badges, subtitles, disabled items, active-route matching and permission-filtered navigation with responsive drawer fallbacks.

Completion checks:

- All three compositions work through the same navigation model and existing authorization.
- Keyboard navigation and menu focus work in LTR/RTL and mobile layouts.
- Changing layout never changes permitted destinations or exposes denied menu entries.

Shared targets: `packages/primecare_ui/web/navigation.ts`, `packages/primecare_ui/web/sidebar.ts`, `packages/flutter_core/lib/models/`, `packages/flutter_core/lib/registry/widgets/`.

### B05 — Page templates and route-specific layouts

Status: planned. Dependencies: B01, B02, B03, B04.

Scope:

- Build original simple and carded page factories with header/action/content slots and independently controlled left/right page sidebars.
- Support permanent, temporary and responsive page drawers plus normal/page/content scrolling and route scroll resets.
- Bind registered route-specific layout overrides with independent chrome visibility; public/auth/error pages reuse the shared shell safely.
- Add consistent page titles and breadcrumbs from authorized route metadata.

Completion checks:

- Every template supports both renderers without duplicating screen business logic.
- Navigation restores route defaults without leaking another page or role profile.
- Header, sidebars, content and focus remain usable at tested breakpoints.

Shared targets: `packages/primecare_ui/web/`, `packages/primecare_ui/lib/src/components/layouts/`, `packages/domain/src/`.

### B06 — Complete Theme Center and palette tools

Status: planned. Dependencies: B01, B02, B03.

Scope:

- Expose independent main/navigation/toolbar/footer palettes with light/dark mode, contrast-safe foregrounds and editable semantic colours.
- Add palette previews, derived light/dark shades and a common typography, spacing, border/radius and density token model.
- Generate conditional layout controls from approved configuration schemas rather than duplicating forms per layout.
- Provide theme/settings preview, formatted configuration viewer, copy, import/export, reset, named theme CRUD and reviewed translations.

Completion checks:

- Theme combinations satisfy agreed contrast checks without overriding business content.
- Web/native controls produce compatible validated data and reject scripts, CSS injection and unknown fields.
- Existing saved themes and version-1 XML imports remain supported or explicitly migrated.

Shared targets: `packages/domain/src/theme_center.ts`, `packages/primecare_ui/web/theme-center.ts`, `packages/primecare_ui/web/theme-manager.ts`, `packages/flutter_core/lib/theme/`.

### B07 — Account preferences and cross-device sync

Status: planned. Dependencies: B01, B02, B03, B06.

Scope:

- Register and implement account/tenant/role-scoped theme, workspace and shortcut preference persistence using existing authorized service conventions.
- Define optimistic concurrency, versioned migrations, local cache precedence, default/reset semantics and deletion behaviour.
- Sync settings across sessions/devices with explicit error and offline states; never present failed saves as success.
- Document API contracts, rate limits, audit records and server-side allowlists.

Completion checks:

- Save on one client and read back on another through API, independent database read and reload.
- Cross-account and cross-tenant attempts fail; stale updates cannot silently overwrite changes.
- Offline recovery, storage denial, invalid imports and schema migrations are tested.

Shared targets: `packages/domain/src/`, `packages/shared/src/`, `cloudflare/workers/src/`, `packages/contracts/`, `packages/flutter_core/lib/theme/`.

### B08 — Shared shell utilities

Status: planned. Dependencies: B01, B04, B05, B07.

Scope:

- Implement the quick side panel for authorized events, notes and quick settings using existing business data adapters.
- Add consistent notification drawer, read/unread actions and authorized delivery/status views.
- Add account-saved favourite navigation shortcuts and searchable shortcut management alongside existing native keyboard shortcuts.
- Add fullscreen controls, complete RTL shell behaviour and real custom-scrollbar/route-reset support with native fallbacks.

Completion checks:

- Utility actions operate on real authorized resources where required and fail honestly when unavailable.
- Favourites and settings survive account-scoped reload and cross-device sync.
- Focus restoration, keyboard operation, fullscreen rejection, mobile and RTL interactions pass.

Shared targets: `packages/primecare_ui/web/`, `packages/flutter_core/lib/registry/widgets/`, `packages/flutter_core/lib/security/shortcuts/`, `packages/shared/src/`.

### B09 — Base component and feedback catalogue

Status: planned. Dependencies: B01, B05, B06.

Scope:

- Audit bundled component demonstrations and map them to original PrimeCare factories; classify duplicates and framework-only examples explicitly.
- Complete controls, menus, tabs, accordions, badges, cards, dialogs/drawers, tooltips and responsive form layouts.
- Unify loading/suspense, splash, empty/error states, toast/snackbar, confirmations and countdown utilities.
- Add reusable accessible code-highlight/copy and component-preview helpers where registered requirements call for them.

Completion checks:

- Each adopted component has a documented API, governed identifier, localization and meaningful interaction tests.
- Disabled, loading, error, focus and screen-reader states are covered.
- No vendored Fuse runtime, copied proprietary assets or duplicate per-app factories are introduced.

Shared targets: `packages/primecare_ui/web/`, `packages/primecare_ui/lib/src/components/`, `packages/flutter_core/lib/`.

### B10 — Tables, forms, editors and upload controls

Status: planned. Dependencies: B01, B06, B09.

Scope:

- Complete shared table/grid filtering, sorting, pagination, row selection/expansion, column visibility/order/pinning, resizing and virtualization as required by the reference inventory.
- Implement equivalent validated forms, autocomplete, date/time pickers, masks, numeric fields and file upload states.
- Add a shared rich-text editor with registered formatting, links, images, lists and sanitization rules.
- Map supported features per web/native renderer and document any platform gaps; reuse approved open-source dependencies only with recorded provenance.

Completion checks:

- Representative large-data cases validate actual virtualization and accessible keyboard operation.
- Form, upload and editor failures are tested, including untrusted content and denied operations.
- Existing APIs provide real data; unsupported actions remain disabled with clear status.

Shared targets: `packages/primecare_ui/web/`, `packages/primecare_ui/lib/src/components/`, `packages/shared/src/`, `packages/domain/src/`.

### B11 — Charts and configurable dashboard widgets

Status: planned. Dependencies: B01, B05, B06, B09, B10.

Scope:

- Build a reusable original chart and metric/widget catalogue from the reference examples.
- Implement widget add/remove/reorder/resize, permitted placement, per-breakpoint layouts and role/tenant defaults.
- Connect dashboard definitions and real data sources through approved widget and workflow registries.
- Persist dashboard layouts through the common preference service; keep floating panel layout distinct from dashboard grid layout.

Completion checks:

- User edits survive API/database readback and reload across breakpoints.
- A denied widget cannot be added through layout import or stale cache.
- Charts expose accessible data alternatives; empty, error, loading and data-update states pass.

Shared targets: `packages/domain/src/`, `packages/shared/src/`, `packages/primecare_ui/web/`, `packages/primecare_ui/lib/src/components/`.

### B12 — Original icon and visual asset completion

Status: planned. Dependencies: B01, B06, B09.

Scope:

- Build a semantic inventory of actual icon/illustration needs across the approved theme/component catalogue.
- Expand the current original 56-icon SVG collection and add needed brand, empty-state, onboarding and placeholder assets.
- Map existing app icon keys to the central asset registry, replace usage systematically and remove obsolete references after verification.
- Document provenance, accessible naming, contrast/tint behaviour, sizing and package access for all supported apps.

Completion checks:

- No missing asset keys, broken references or duplicate per-app copies in adopted screens.
- Representative web/native renders verify scaling, tinting and meaning.
- Every retained third-party dependency/asset has recorded terms; original replacements are not presented as trademark clearance.

Shared targets: `packages/primecare_ui/assets/original/`, `packages/primecare_ui/web/original-assets.ts`, `packages/primecare_ui/lib/src/theme/primecare_assets.dart`, `packages/shared/src/media/`.

### B13 — Calendar, contacts, tasks, notes and scrumboard

Status: planned. Dependencies: B01, B05, B07, B08, B10, B11, B12.

Scope:

- Create original reusable templates for calendar, contacts, tasks, notes and scrumboard.
- Map scheduling, filtering, details, editing and drag operations to existing governed PrimeCare workflows.
- Add proper loading, empty, invalid, conflict and denied states without mock-success business adapters.
- Keep synthetic demonstration data isolated and explicitly labelled; activate only registered real workflows.

Completion checks:

- For each approved module: authorized UI action → API → independent database readback → reload.
- Meaningful create/update/delete or reorder actions include validation, denied roles and tenant-isolation cases.
- Unmapped reference features are listed as needs-specification rather than marked adopted.

Shared targets: `packages/shared/src/`, `packages/primecare_ui/web/`, `packages/primecare_ui/lib/`, `websites/typescript/src/`.

### B14 — Mailbox, messenger, notifications and file manager

Status: planned. Dependencies: B01, B05, B07, B08, B10, B12.

Scope:

- Create original shared application templates for mailbox, messenger, notifications and file management.
- Reuse the existing communications inheritance core and authorized conversation/mail/file services.
- Implement required threads, search, attachments, delivery/read states, folders and file operations through registered adapters.
- Preserve privacy, sender/recipient verification, file access and honest send/upload failure states; no unrequested external messages.

Completion checks:

- Permission-scoped message/file flows pass API/database/reload validation.
- Denied conversation/mailbox/file access, cross-tenant access and attachment failures are covered.
- Existing call and communication behaviour does not regress.

Shared targets: `packages/shared/src/communications/`, `packages/shared/src/`, `packages/primecare_ui/lib/src/communications/`, `packages/primecare_ui/web/`.

### B15 — Academy, commerce, AI images, profile, settings and help centre

Status: planned. Dependencies: B01, B05, B07, B09, B10, B12.

Scope:

- Create original template counterparts for academy, e-commerce, AI image generation, profile, settings and help centre.
- Reuse existing identity/account settings and approved learning/product/support workflows; do not replace working authentication.
- Register any required external provider adapter and entitlement before enabling AI/image or commerce operations.
- Document real-service dependencies, missing workflow specifications and platform support separately from presentation readiness.

Completion checks:

- Each template has approved scope and a verified real flow, or an explicit blocked dependency.
- Profile/settings permissions and sensitive updates are validated.
- No demo billing, generated image, purchase or provider success is reported as a production transaction.

Shared targets: `packages/shared/src/`, `packages/domain/src/`, `packages/primecare_ui/web/`, `packages/primecare_ui/lib/`.

### B16 — Four dashboard families and supporting pages

Status: planned. Dependencies: B01, B05, B06, B09, B10, B11, B12.

Scope:

- Create original project, analytics, finance and crypto dashboard presentation templates driven by approved registered datasets.
- Map relevant PrimeCare metrics and currencies to approved requirements; crypto examples remain isolated unless a real workflow is registered.
- Add invoice, pricing, activity, search, authentication presentation, coming-soon, maintenance and error-page templates.
- Reuse current auth/permission providers. Inventory Fuse JWT/Firebase/AWS adapters as architectural references; register an adapter only where an approved requirement needs it.

Completion checks:

- Each dashboard tile/chart is permission filtered and source mapped; no invented production metrics.
- Supporting pages use shared route templates, navigation and localized resources.
- Synthetic reference-only examples are separated from operational business screens and cannot be mistaken for live data.

Shared targets: `packages/shared/src/`, `packages/primecare_ui/web/`, `packages/primecare_ui/lib/src/components/layouts/`, `websites/typescript/src/`.

### B17 — Catalogue, documentation and app-wide adoption

Status: planned. Dependencies: B04, B05, B06, B08, B09, B10, B11, B12, B13, B14, B15, B16.

Scope:

- Publish an original developer catalogue with component APIs, layout recipes, examples, configuration schemas and asset mappings.
- Track every reference feature as verified-equivalent, intentionally-replaced, not-applicable-with-reason, blocked or missing; no silent omissions.
- Replace old app-specific shell/theme/widget implementations with shared factories in controlled app groups.
- Remove obsolete implementations only after references, compatibility and migration checks pass; maintain main-only commits.

Completion checks:

- Every reference feature has a reviewed disposition, integration owner and evidence link.
- All supported apps consume the shared packages without duplicate implementations.
- Migration/rollback documentation matches the shipped configuration and supported platforms.

Shared targets: `docs/appearance/`, `packages/primecare_ui/catalogs/`, `apps/`, `websites/`, `scripts/`.

### B18 — Full verification and release closure

Status: planned. Dependencies: B02, B03, B04, B05, B06, B07, B08, B09, B10, B11, B12, B13, B14, B15, B16, B17.

Scope:

- Run governed Cypress/browser and Flutter/native verification across registered roles, tenants, supported apps, layout families and breakpoints.
- Cover LTR/RTL, EN/FR/ES, keyboard/touch/screen-reader behaviours, contrast, state retention and preference migrations.
- Verify UI → API → database → reload, denial cases, cross-tenant isolation, large-data performance and production error paths.
- Update implementation/test/review tags honestly, record required CI and deployment/readback evidence, and resolve every remaining gap or mark it blocked.

Completion checks:

- No feature is called complete from file presence, inventory, compilation or screenshot alone.
- All required checks pass against the exact shipped commit; material exceptions stay explicit.
- Final matrix distinguishes source implementation, production integration, runtime verification and human review.

Shared targets: `scripts/`, `.github/workflows/`, `docs/appearance/`, `tools/governance-production/`.

## Completion tracking

The companion JSON is the machine-readable checklist. Advance one batch only with evidence. Each batch record retains status, dependencies, acceptance checks, evidence and blockers. Use separate implementation, production-integration and runtime-verification evidence; one does not imply another.

A reference demo does not automatically authorize a new production business workflow. Unmapped features require a registered specification or a reviewed not-applicable disposition, never silent omission or fake data presented as live success. Native and web equivalents may use different rendering technology while sharing validated contracts, semantic tokens and access boundaries.

Deliver each batch as a reviewable commit on main with relevant tests, known gaps and migration/rollback notes. Do not estimate an adoption percentage from source-file counts. No execution schedule or automatic background task is created by this plan.
