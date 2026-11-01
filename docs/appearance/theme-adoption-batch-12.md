# B12 — Original icon and visual asset foundations

The expanded original assets and controlled shared adoption are on main. Final platform acceptance is pending. App-wide migration, production/device verification and human review remain separate gates.

The canonical collection now has 105 icons and 16 brand/background/empty/onboarding/placeholder assets: 49 added icons and nine added scenes, with the original 56 icons and seven asset paths preserved. The complete generated preview is `packages/primecare_ui/assets/original/preview.html`.

## Registration

[Production run 41262137235](https://github.com/shaikhrais/primecare-platform/actions/runs/41262137235), source `112891281b3175a3bcb38902ed57736cd526fb97`, passed validation job 124717385931 and production job 124717455483. Rollback-only dry-run, idempotent apply and independent readback completed before implementation.

Five optional presentation controls and five required-element records, 15 resources and 45 draft EN/FR/ES values were added on existing Tenant Admin screen 2534. New primitive `prime_asset` is registry ID 21. The pinned PostgreSQL manifest remains unchanged; no business API, grant, route, schema change or runtime activation occurred. Screen tags remain registered-unimplemented and human translation review remains unset.

## Shared implementation and adoption

The canonical SVGs compile into one registry, sprite, decorative web paths, native drawing data and compatible PrimeCareAssets bundle keys. The strict build-time compiler rejects scripts, external resources, unknown attributes/namespaces, malformed paths and unbounded geometry. The native runtime draws only trusted compiled commands, without a general SVG parser or new runtime dependency.

The 25 existing shared shell keys now resolve to original geometry. ShellIcon/navigationIcon signatures, CSS classes and unknown-destination fallback stay compatible. The former shared Tabler path table is removed; its MIT notice remains for history/other retained copies. Native B04 navigation defaults and B10 date/time/expand glyphs use the same registry. All 20 semantic aliases resolve centrally; map-location pin and panel thumbtack remain distinct.

Meaningful assets require localized host-provided labels, while decorative assets exclude inner semantics. Explicit RTL metadata mirrors directional glyphs only. Web helpers resolve B06 colour tokens; native uses the host IconTheme/ColorScheme or palette override. Native drawing clips to bounds and preserves aspect ratio/alpha. External file SVG images retain their standalone source palette rather than inheriting page CSS.

Usage: [original-assets-usage.md](original-assets-usage.md). Provenance and retained dependency terms: [original-assets-provenance.json](original-assets-provenance.json). Source migration inventory: [original-assets-usage-audit.json](original-assets-usage-audit.json), with paged path/token/digest details. Framework-token counts describe existing source, not broken assets or license violations. No existing app-specific implementation is removed without verified migration.

## Provenance and remaining migration

Paths in the original pack are task-authored basic geometry. No Fuse files, third-party vector paths, photos or proprietary marks were used for these additions. This is not an exclusive-copyright claim, trademark clearance or full transitive-license audit. The PrimeCare brand mark remains a concept.

Retained notices distinguish Tabler MIT terms, the Flutter Lucide wrapper's published MIT license and upstream Lucide ISC/Feather MIT notices, with primary references in the provenance file. App-specific framework dependencies remain installed; resolved-version license bundles and broader app migration still require review. No claim that all third-party icons were removed is made.

## Verification

Local checks passed: six compiler groups; four registry/shell/hash groups; rendering of all 121 assets in Chromium; meaningful/decorative naming; strict colour input validation; directional-only RTL; literal hostile labels; responsive sizing; keyboard shell controls; zero external asset requests. Canonical hashes and all 25 shared shell mappings were checked. Navigation browser regression passed and the existing 74-check tenant-dashboard suite passed against its isolated PostgreSQL fixture.

Native tests render all 121 assets, validate aliases/semantics, compare raster tint/RTL behavior and rerun B04 navigation/B10 form/table/picker tests. The raster fixture uses Flutter real-async capture. Initial web CI exposed missing PGlite test setup; the corrected workflow installs the existing pinned fixture dependencies. These are isolated source/component regressions, not production business-flow evidence.

Final exact-source CI evidence will be recorded after the corrected platform run completes. Actual deployment/device/screen-reader checks, host-specific source bindings, app-wide migration and human localization/accessibility/release reviews remain pending. Existing auth-reader review blockers remain unchanged; whole-repository CI success is not claimed.

Rollback can restore controlled shared glyph mappings and unmount optional asset views while preserving canonical files and additive metadata. No business-data rollback or destructive metadata removal is provided. B13 business-module foundations can proceed while these B12 migration/review gates remain explicit.
