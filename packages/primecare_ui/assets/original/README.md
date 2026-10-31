# PrimeCare original SVG assets v1.0

56 icons, one logo concept, two backgrounds and four empty-state illustrations.
Open preview.html locally to inspect the complete pack. No build is needed.

## Web usage
Inline an SVG and set CSS color; icons use currentColor. For external img elements, currentColor does not inherit from the host page; inline the SVG or use the sprite.
Sprite example: <svg width="24" height="24" aria-hidden="true"><use href="primecare-sprite.svg#pc-calendar"/></svg>.
For meaningful standalone icons add role="img" and an accessible name. For icon-only buttons give the button aria-label and hide its decorative SVG. Use at least a 44px touch target.

## Shared package access

Web: import { primeCareIcon } from the primecare_ui/web entry point and call primeCareIcon("calendar"). Size the SVG with CSS. The typed helper embeds the canonical SVG geometry without a public asset URL or runtime fetch.

Flutter: import package:primecare_ui/primecare_ui.dart and use PrimeCareAssets.icon("calendar") with rootBundle.loadString or a compatible renderer. Keys already include packages/primecare_ui; do not add a second package prefix. All SVG directories are registered in the package pubspec. Apps must depend on primecare_ui.

Other runtimes can consume assets/original directly during their build. Do not duplicate assets per app.

## Flutter integration
SVGs can be loaded through the application's existing SVG renderer. Map color through its tint/color-filter interface. The pack does not install or bundle a renderer. The assets are registered in this package’s pubspec.yaml.

## Theme
theme-tokens.json supplies a light palette and geometry tokens. Treat these as source values to map into your existing theme manager; they are not wired to a running application.

## Provenance and usage
All vector paths in this pack were authored in this task from basic geometry. No Fuse files, third-party icon sets, fonts, photographs or brand marks were used. No third-party attribution is required by this pack. The PrimeCare mark is a design concept, not a trademark clearance. This provenance statement is not a claim of exclusive copyright or a legal clearance.

## Status
Stored centrally in the shared primecare_ui package with web exports and Flutter bundle keys. Existing screens retain their current icon choices; apps can adopt this collection through the shared exports. Includes SVG sprite and JSON path registry. Never use decorative healthcare symbols as a substitute for text labels.
