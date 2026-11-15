# PrimeCare Fuse dependency and licence audit — 2026-11-15

## Verdict
**No direct Fuse package dependency identified in the inspected active root npm manifest or PrimeCare UI Flutter manifest.** Original PrimeCare theme implementations exist. **Full repository and transitive dependency licence clearance is NOT established.** Do not describe the project as licence-cleared or wholly Fuse-independent until the open gates below are closed.

## Scope and evidence
- Inspected current `package.json`, `packages/primecare_ui/pubspec.yaml`, `packages/primecare_ui/lib/primecare_ui.dart`, `packages/primecare_ui/lib/src/theme/prime_fuse_theme.dart`, `packages/domain/src/fuse_theme_adapter.ts`, `scripts/test-primecare-original-theme.mjs`, `docs/handover/original-primecare-skeleton.md`, `docs/handover/fuse-native-compatibility.md`, `docs/appearance/original-assets-provenance.json`, `docs/appearance/theme-adoption-batch-12.md`, and the theme CI workflow.
- Repository code search covered `Fuse`, `@fuse`, `prime_fuse_theme`, `fuse_presets`, `license`, and `third-party`. Search returns ranked/limited matches, not a complete recursive checkout or dependency graph.
- No package-lock-wide, pubspec.lock-wide, generated binary, bundled asset, private Fuse repository, installed dependency, or published artefact audit was performed; no legal advice or licence clearance is claimed.

## Findings and dispositions
| Finding | Evidence | Disposition |
| --- | --- | --- |
| Root npm package has no declared `@fuse` or Fuse-named direct package | `package.json` | No direct Fuse dependency observed in this manifest |
| PrimeCare Flutter UI package has no declared Fuse-named direct package | `packages/primecare_ui/pubspec.yaml` | No direct Fuse dependency observed in this manifest |
| Original shared appearance/theme exists | `packages/domain/src/primecare_appearance.ts`, `packages/primecare_ui/lib/src/theme/primecare_theme.dart`, `packages/primecare_ui/web/prime-skeleton.css` | Retain and prefer these owned implementations |
| Fuse-named TypeScript and Dart compatibility aliases still exist | `packages/domain/src/fuse_theme_adapter.ts`, `packages/primecare_ui/lib/src/theme/prime_fuse_theme.dart` | Source shows reexports/typedef to PrimeCare implementation, not vendor code; remove only after consumer migration |
| Public Flutter barrel still exports legacy alias | `packages/primecare_ui/lib/primecare_ui.dart` | Migration required; do not break downstream imports without checks |
| Historical vendor reference inventories and extraction artefacts still exist | `packages/primecare_ui/catalogs/fuse-skeleton.inventory.json`, `tools/governance-production/theme-adoption-contract.json`, `scripts/fuse_presets.json` | Quarantine/retire with consumer, provenance and evidence impact review; avoid asserting active runtime use |
| Old extraction script | `scripts/parse_themes.js` | Deleted on main in commit `98098002a52d8c475fc4b98ee6d09b35e98b184b` |
| Vendor-compatible CI naming and tests remain | `.github/workflows/fuse-appearance-contract.yml`, `scripts/test-fuse-theme-adapter.mjs` | Refactor only after preserving test coverage and historical evidence |
| Separate private Fuse integration direction documented | `docs/handover/fuse-native-compatibility.md` | Historical plan conflicts with later original-only decision; verify no private vendor bundle enters builds/deployments |
| Original asset collection | `docs/appearance/original-assets-provenance.json`, `docs/appearance/theme-adoption-batch-12.md` | Task-authored provenance recorded; not independent legal or similarity clearance |
| Retained Tabler, Lucide, Flutter icon/framework dependencies | `docs/appearance/original-assets-provenance.json`, `docs/appearance/TABLER_ICONS_LICENSE.txt`, `packages/primecare_ui/pubspec.yaml` | MIT/ISC notices documented; resolved-version and redistribution notices still require verification |

## Open release gates
1. Enumerate **every** npm workspace/package manifest and lockfile, every Flutter pubspec/lockfile, and platform-specific assets/bundles, including generated output. Resolve each installed direct/transitive version and licence.
2. Inspect complete current source import graphs and produced web/mobile build artefacts for actual `@fuse`, vendor source, copied artwork, fonts, stylesheet assets, proprietary marks and runtime fetches. Search hits alone are not proof.
3. Remove or replace Fuse-named aliases, old presets and historical scan/inventory artefacts only after confirming consumers, generated catalogues, pinned hashes, CI and rollback/evidence requirements. Historical evidence can be retained in an explicitly non-runtime archive if appropriate.
4. Produce and verify a third-party notices/SBOM bundle for the **resolved** npm and Flutter dependencies, including Tabler MIT and Lucide ISC/MIT notices where distributed. Check commercial redistribution obligations and any incompatible or unknown licences.
5. Verify original artwork/code provenance and similarity independently; obtain counsel or vendor clarification where needed. The repository's older Fuse Regular License notes are not a licence to redistribute its source.
6. Run web/Flutter tests and production artifact checks on the resulting commits, then obtain human licence/release approval.

## Current decision
Develop new features only with PrimeCare-owned theme, tokens, and shared UI components. Do not import vendor Fuse packages or assets. Keep the release licence gate **OPEN** until the complete dependency graph, built artefacts, notices, and legal review are evidenced.
