# Shared work-view construction cleanup

Batch summary before implementation: failed shared work-view construction must release its own root marker, subscription and event scope, restore the host's original nodes/attributes/styles, and permit a subsequent valid mount. Preserve caller-owned WorkModuleSession lifetime, metadata rejection, task data/actions and all authority rules. Reuse the existing shared renderer for the supported work/application slots; do not add parallel factories.

Base main432255cde4f54ff9265d8be707346fca3cf6589c passed Theme Center, component catalogue, boundary, contract and cross-batch closure. Eight new public API Node regressions fail on the unchanged source (leaked subscription/root ownership). They vary early/late control rejection, pre-existing marker and existing stylesheet. Native and real-browser evidence remain separate from these Node checks.

## Implementation and validation

Failed construction now aborts the failed instance's render/control scopes, unsubscribes its session listener, releases its own root ownership and restores original child node identities, the prior marker value and pre-existing stylesheet. A stylesheet created only by the failed constructor is removed. The original typed rejection is rethrown. A caller-owned session is not disposed; a valid remount can reuse it. Early rejection of a duplicate owner remains outside this cleanup path, so a rejected second constructor cannot release the first owner.

Eight new lifecycle cases fail before the implementation and pass afterward. A ninth invariant case confirms duplicate-owner rejection preserves the live owner. Together with the existing 21 calendar checks, all 30 public-renderer Node checks pass locally. TypeScript and browser-script syntax checks pass; strict findings remain0. The real browser fixture now asserts rejected construction retains the exact host node, leaves no marker/style, and allows the original subsequent authenticated task scenario to mount. It must execute in GitHub Actions; no local real-browser/native acceptance is claimed.

Counts remain source previous0/current0/new removals0;72/72 source mappings,0unreconciled;0fully accepted/72pending;readiness0/344screens and0/147workflows. No grant, API, business workflow, palette, registration or historical hash changes.
