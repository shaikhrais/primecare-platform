# PrimeCare original vector assets v2

105 icons and 16 brand, background, empty-state, onboarding and placeholder assets.
Canonical SVGs are the single authoring source. Generated registry, sprite, TypeScript and Dart mirrors are checked by `python3 scripts/build-original-assets.py --check`.

See `docs/appearance/original-assets-usage.md` for APIs, naming, RTL, tint, sizing and package access. Web optional entry: `original-asset-view.ts`; native optional entry: `package:flutter_core/original_assets.dart` or `package:primecare_ui/original_assets.dart`. Legacy decorative web helpers and PrimeCareAssets package keys remain compatible.

Open preview.html for the complete v2 catalogue. registry.json is the machine-readable inventory; automated browser/native render checks cover all 121 assets. No bitmap, vendor code or third-party runtime renderer was added. The mark is a concept, not trademark clearance. Retained third-party dependencies/notices and remaining app-specific migration are recorded in the B12 provenance and usage audits.
