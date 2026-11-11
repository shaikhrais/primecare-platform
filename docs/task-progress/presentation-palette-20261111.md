# Presentation palette batch

115 fixed colors in the shared core finance presentation library. Migrate the shell and all 17 finance content builders together. Six shared helper functions receive BuildContext explicitly. Surfaces, table headers, borders, shadows, labels, selected navigation, avatars, badges, actions and chart categories resolve from the active Material theme.

The shared PrimeSemanticPalette adapter reads primary/secondary/error/neutral roles from Material. Success and warning use PrimeSemanticStatusColors supplied by PrimeThemeData from its existing status tokens; standalone Material hosts fall back to their tertiary/secondary roles. No core dependency on UI widgets. The existing materialTheme override identity remains unchanged. Existing personal-theme application preserves this extension.

Pair badge foregrounds with their actual containers, avatar initials with composited tints, action text with the corresponding accent, and KPI trend text with the actual surface. Keep datasets, routing selection, labels and action callbacks unchanged. Presentation data remains demonstration data; this migration does not establish production acceptance.

Publish shared theme support, utility, source/native validation first, then the consumer library, on current main with a lease. No branch or boundary exemptions. Native tests must render actual shell/content and byte-matched helper fixtures; Python checks alone are not native acceptance.

Validation: 263 migration tests and 24 boundary tests pass. Source receipts prove the exact 115-diagnostic reduction and a zero-change second pass; every helper and all 17 finance content bodies have byte-matched native fixtures. Native selectors, bright/dark content renders, all-preset helper rendering, 1x/2x text, shared status bridge and custom status contrast are added to CI. Native execution is still queued, not accepted. Strict source scan339->224.

Concurrent integration: preserve main8c79cb56 card/snack-bar migrations, their compile fixtures, workflow additions and receipt composition. Combined validation passes 271 migration tests and 26 boundary tests. This batch removes115 colors; the concurrent batch removes29 direct controls. No native acceptance inferred.
