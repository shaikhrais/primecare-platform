# Personal care Screen Manager integration

## Purpose and source boundary

This change extends the existing `/psw` and `/care` dispatcher into the actual personal workspace and its existing clinical dialogs. It starts from the preserved 831-file care-manager source snapshot, not a current-main merge. The earlier screen-management chain starts at `fad8a62e1a32c642df26f50c7b45b2c521c62800`; the latest separately observed main reference is `df27a32822e6255709c48bfcf71be5f9bbccc6ac`. Neither reference makes this candidate integrated with current main.

No production database, credentials, governance records, routes, permission grants, clinical capabilities or endpoints are added or modified. The separate request-review queue and separate coordinator demo renderer retain their previous behavior. Personal synthetic mode uses the same personal view and is included in this lifetime change; it is not the separate coordinator demo renderer.

## Existing workflows and authority

`renderPSW` retains its Screen Manager route owner through the initial personal read and the real `renderPersonalView`. Personal snapshots and commands continue to use `PersonalClient` and `/v1/governance/care/personal`, with unchanged dataset, tenant, week, body version and action/value payloads. The specialized managed subclass removes transport-driven signout side effects so only a current owner can act on authorization errors. The queue continues to use its existing separate subclass.

The actual personal visit, concern, availability, leave and time controls open the existing `renderCare` in body-mounted dialogs. These dialogs now have an explicit owner and ordinary nested child owner. A route-scoped `LiveCareClient` is shared across clinical dialog close/reopen, preserving existing care endpoints, authorization, capability-filtered forms, case selection, body versions, audit/idempotency keys and additional-charge headers. The UI lifetime guard never grants clinical authority. Server rules still authorize every command.

## Ownership and navigation

- Initial/private reads, retained controls, submissions and asynchronous publication require the same connected root, session, exact route/query, Screen Manager registration and synchronous layout/theme/language/responsive services. Additional-charge context is unchanged throughout the owner lifetime.
- A dialog must remain connected and open. Ownership-acquisition or child-acquisition failure cleans up an already appended dialog, including synchronous presentation callbacks that replace the parent root. Close, Cancel/Escape, programmatic removal, parent disposal and view/hash departure retire its controls, nested renderer, normalization observer and completion callbacks. Disposed dialog cleanup callbacks are released from the parent.
- Old root, dialog and clinical form closures cannot submit after replacement, detach or case selection. Current 401 signs out; late responses cannot sign out a new session or a closed/replaced child. Current 403 retires the denied presentation without speculative write retry.
- Shared locks reject duplicates and conflicting personal/clinical actions while a mutation is pending. Personal editable modal fields are disabled during a save while Close remains available. Actual hash departure can retire a dialog during an in-flight command, with the new page usable after the lock releases. During a pending personal save, changed-hash rendering uses the last confirmed state rather than publishing the optimistic draft; the dispatched request body, version, retry key and receipt remain unchanged.
- BFCache suspension holds pending continuations and blocks retained actions until restoration and revalidation. Nonpersisted page destruction disposes observers/listeners. Canceled links do not destroy a draft merely because they were clicked.

These are client presentation semantics, not server cancellation. An already dispatched POST may complete after Close, navigation or session replacement.

## Receipts, uncertain outcomes and recovery

The existing base client retains an idempotency key for an identical uncertain write within the client lifetime. Changed request content receives a new key. The clinical client retains accepted-write receipts across failed or filtered reads and dialog remounts until an authorized rendered snapshot reflects the returned record identity and valid version. Existing schedule previews remain uncached POSTs; versionless commands receive fresh server authorization after actual reflection. Existing positive safe-integer version validation is preserved unchanged.

The personal managed client records a successful POST before checking its snapshot. Receipt reflection requires the same workspace, user, tenant and dataset, and a positive safe-integer response version greater than the submitted version. A successful render, rather than JSON acceptance alone, confirms reflection and retires the receipt. Retrying a still-acknowledged personal command performs a GET, not another POST; an unrelated or old snapshot cannot claim the write was reflected.

Ordinary failed personal saves retain connected dialog fields and allow an identical idempotent retry. A malformed nested personal response that cannot render is deliberately fail-closed: it closes dialogs, removes old controls and shows the existing unavailable text with the existing Refresh saved data control. That control recovers through GET on the same owner/client, preserving receipt protection. The malformed-response path loses the unsaved dialog draft; it does not pretend the draft was retained. Clinical malformed snapshot behavior remains the earlier fail-closed boundary.

Receipts are in-memory within the renderer/client lifetime. An explicit full `renderPSW` replacement, full page reload, session/route retirement or new browser process is not durable receipt recovery. This change does not add cross-owner or offline write persistence. A pending server result after destruction must be checked using a fresh authorized read, not assumed canceled.

## Tests and evidence

`scripts/test-personal-care-manager.mjs` bundles the actual dispatcher, personal view, nested clinical renderer, shell, views, Screen Manager and transports. Its deterministic DOM/network fixture models identity, form events, dialog state, removal and BFCache events; it does not establish real-browser focus, layout, accessibility or BFCache behavior. It tests current/stale authorization, retained controls, exact query/session/charge, clinical and personal writes, receipt reflection, uncertain retries, case selection, malformed snapshots, dialog dismissal, canceled links and personal synthetic mode. The existing selected suites are preserved byte-for-byte. Both existing TypeScript release workflows add only the new isolated suite invocation.

The final focused suite passes 211/211, repeated three times; the complete selected command passes 1,843/1,843. The exact same focused suite against the immutable predecessor reports 55 passes and 156 expected failures, with no canceled or skipped tests. The replay invokes existing actual route/view modules rather than missing new interfaces. Non-strict TypeScript passes; strict TypeScript has the same ten inherited diagnostics as the predecessor. The browser-target bundle has 252 inputs, no warnings and 2,393,536 bytes. Patch reconstruction, source preservation and independent review evidence is supplied separately with this candidate. A killed exploratory predecessor run is incomplete evidence, not a product test result.

## Release limitations

This is a bounded source integration, not release certification. It does not complete every remaining Screen Management consumer, the separate legacy coordinator demo lifecycle, governance production cutover, registered accessibility/localization review or production release gates. No branch, commit, push, pull request, deployment, production credentials or database write was used. Current-main reconciliation, required CI on the eventual commit, production-governance registration proof and authorized browser/end-to-end acceptance remain release requirements. The prior unavailable browser environment was not retried without a new reason. No rendered-browser claim is made.
