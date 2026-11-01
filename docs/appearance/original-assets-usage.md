# B12 original icon and visual asset APIs

The central pack contains 105 icons and 16 brand/background/empty/onboarding/placeholder assets. Canonical files live in `packages/primecare_ui/assets/original/`. `scripts/build-original-assets.py` regenerates the registry, sprite, web icon paths, native drawing data and package-key constants; `--check` rejects drift. Author SVGs in the compiler's strict supported subset, never edit generated mirrors or copy assets per app. Optional `--seed-missing` scaffolds absent original additions only; it never overwrites existing canonical SVG edits.

## Scope and provenance

The 56 original v1 icons and seven asset paths remain available. B12 adds 49 icons and nine scenes for actual shell, navigation and B09–B11 component semantics. The 25 known shared ShellIcon keys now map to original geometry while preserving CSS classes and destination fallback behavior. Native shared navigation defaults and B10 date/time/expand controls use the same catalogue. Other app-specific Material/Lucide uses remain inventoried migration work; dependencies are retained.

The task-authored paths use basic geometry; no Fuse or third-party icon paths were imported into this pack. Retained third-party notices and primary license references are in `original-assets-provenance.json`. This is not trademark clearance, an exclusive-copyright claim or a complete transitive-license audit. The brand mark is still a concept.

Production run 41262137235 registered five optional presentation controls, 15 resources, 45 draft EN/FR/ES translations and `prime_asset` primitive ID 21 on existing screen 2534. Native/other-host activation and human review are not implied. The optional select binding remains reserved for a future authorized catalogue host; the static preview is documentation. Meaningful asset names must come from each registered host's localized resources; key names are inventory metadata, not default user-facing labels.

## Web

Compatibility: `primeCareIcon(name)` / `primeCareIconPaths` in `packages/primecare_ui/web/original-assets.ts` retain their decorative string API. `shellIcon(name)` / `navigationIcon(destination)` retain the existing shared shell API. Unknown shell/asset keys fail; unknown navigation destinations keep the existing dashboard fallback. The old direct Tabler path table is removed from the shared renderer, with its notice retained.

`originalAssetElement(key, options)` from `original-asset-view.ts` creates a safe namespaced SVG element from trusted compiled geometry. It does not parse arbitrary SVG, HTML or external URLs. Options:

- Required finite positive `width`, `height` (maximum 10,000 each) and explicit boolean `decorative`.
- Meaningful assets (`decorative:false`) require a nonempty localized `label` (maximum 500 characters); the label is literal text, including angle brackets. Decorative assets are hidden from accessibility; name the containing icon-only control.
- `rtl` mirrors only glyphs whose catalogue metadata declares directional behavior. Other geometry is unchanged. Legacy string helpers remain decorative and are not auto-mirrored.
- Optional lowercase `suffix` distinguishes repeated instances. Stable `data-cy` derives from the verified production binding, canonical key and suffix. Give repeated instances unique suffixes within a host.
- Optional `strokeScale`, a finite positive multiplier, and a restricted palette of CSS colour values (`currentColor`, standard hex lengths or simple CSS custom-property references). Arbitrary URLs/styles fail.
- Optional `document` for a caller-owned document/iframe. No global DOM work occurs at import time.

Palette roles are foreground, primary, surface, accent, border, background and onPrimary. Defaults resolve B06 CSS tokens; set the host's token/direction context first. Web accent maps to the warning/accent token. `originalAssetNames`, `resolveOriginalAsset`, `originalAssetInfo` and copied `originalAssetDrawing` expose catalogue metadata without allowing shared-record mutation.

Inline SVG can inherit CSS tint. External `<img>` SVGs cannot inherit page `currentColor`; their standalone source palette and intrinsic sizing remain separate. The generated sprite uses `pc-KEY` symbols. Assets never fetch images, fonts or scripts.

## Flutter

Import `package:flutter_core/original_assets.dart` or `package:primecare_ui/original_assets.dart`. `PrimeOriginalAsset(name, ...)` uses the generated data with a shared CustomPainter. It needs no SVG package, network fetch or app-specific bundle copy. The core renderer works even when only flutter_core is installed.

- Icons use explicit `size`/`width`/`height` or the host `IconTheme.size`. Non-icon assets require explicit finite positive width and height, at most 10,000 each.
- Decorative defaults to true and excludes inner semantics. Meaningful instances require `decorative:false` and `semanticLabel`; the default semantics identifier comes from the verified registration and canonical key. `dataCy` supplies a stable registered host identifier for repeated meaningful instances; give each a unique binding and do not generate random identifiers.
- `direction` overrides host Directionality. Mirroring is limited to declared directional glyphs. `color`, theme-backed `palette` and `strokeScale` control tint/stroke. Alpha is preserved and multiplied by source opacity. Native accent uses the host tertiary colour unless overridden to match the web accent token.
- Drawing preserves view-box aspect ratio, centers inside the requested bounds and clips to the widget bounds. Paths support compiled move/line/cubic/quadratic/arc/close commands. The runtime never accepts untrusted SVG/path text.

`originalAssetNames`, `resolveOriginalAsset` and immutable `originalAssetInfo` provide the same semantic catalogue. The older `PrimeCareAssets` constants and `icon(name)` bundle paths remain in `primecare_ui/lib/src/theme/primecare_assets.dart` and are exported by the new optional primecare_ui entry. Using those *file* keys requires the host to depend on primecare_ui, whose pubspec registers the canonical directories. Do not add a second package prefix. The core painter does not use file bundle keys or rootBundle loading.

## Authoring, access and rollout

Run `python3 scripts/build-original-assets.py`, then `--check`, `python3 scripts/test-original-asset-compiler.py`, and the web/native tests. The compiler accepts bounded basic shapes, supported numeric transforms and a small mapped palette. It rejects scripts, events, image/external resources, CSS, unknown namespaces/attributes, malformed paths and nonfinite geometry. It is an asset compiler, not a general-purpose SVG importer.

`audit-original-asset-usage.py` records mapped shared uses and remaining framework tokens, with paged source-path/digest inventories. Its counts include existing generated screens; they are not broken-asset or license-violation counts. No obsolete app-specific code is removed until its usage and migration are verified. Existing framework dependencies/notices stay in place.

Use accompanying text for meaning, maintain accessible icon-only control labels and theme contrast, and respect the host's minimum touch target. Healthcare symbols never replace clinical text. Automated geometry, raster, tint and semantics tests do not replace human visual/contrast/screen-reader review or actual-device checks.

Remaining scope: native/app-wide key migration, host-specific metadata/source bindings, deployment/device verification, resolved-version third-party license bundle review and human localization/accessibility/release approval. Rollback can revert the controlled shared glyph mappings while keeping canonical files and metadata; there is no business-data or destructive registration rollback.
