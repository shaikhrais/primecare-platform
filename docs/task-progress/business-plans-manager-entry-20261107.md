# Business plans ScreenManager boundary

## Scope and authority

The existing TypeScript `/business-plans` renderer in `websites/typescript/src/business-plans/dashboard.ts` now owns its reads, plan and tenant selections, existing actions, and dialogs through the existing ScreenManager ID and route contract. Compatible registration metadata remains accepted. This presentation boundary grants no authentication, tenant membership, management, publication, or clinical authority.

The existing `/v1/governance/growth/cycles` endpoint, scoped query, actions, numeric plan versions, authorization header, idempotency behavior, template families, visible markup, form helpers and text remain in use. The existing server repository and policies remain authoritative. No screen, route, API, permission, label, localization key or governance record is introduced. The already-visible learning-review control on the initial list now binds the same existing tenant-level review action before the plan-specific early return.

## Lifecycle and action ownership

- Entry, retained controls and asynchronous continuations revalidate the installed manager, all four synchronous presentation connections, connected root and owned nodes, renderer invocation, document path/query and captured session.
- Replacement, detachment, repeated rendering, account or query change and nonpersisted departure retire the old owner, dialogs, observer and lifecycle listeners. Obsolete fetch, JSON, error and 401 results cannot redraw or sign out a replacement.
- Reads are sequenced. A later tenant or plan selection supersedes an earlier read. Visible actions cannot write while a new selection is pending; mutations use accepted tenant data rather than a newly requested scope. A denied current read removes old visible authority.
- Dialogs and pending writes block refresh, scope changes, new dialogs and same-tab navigation. Closing, canceling, removing or retiring a dialog invalidates its retained form. A canceled navigation click does not retire the page.
- Pending submissions freeze fields and prevent duplicate writes. Failed or uncertain writes retain the draft and the existing same-payload retry identity; changed payloads retain their separate retry identity.
- A successful POST is recorded separately from its follow-up GET. Failed, malformed or not-yet-updated refreshes preserve the accepted values and retry only GET, including after dialog dismissal and reopening. A current forbidden follow-up read revokes the old visible authority even if the dialog was dismissed; obsolete-owner reads remain inert.
- Receipts follow the actual tenant/action identity. Tenant-wide learning review and global creation do not borrow an unrelated selected plan's identity. Versioned command receipts retire only after a safe integer version strictly advances. Creation retires its receipt when the created ID is observed; notices and reviewed learning use their returned state.
- Submitting learning does not advance the existing server cycle version. Its receipt retires only when a newly observed lesson for that cycle matches the submitted evidence and the existing shared patch normalization. JSONB key ordering is irrelevant. Previously visible or unrelated learning does not prove reflection.
- Complete presentation strings are staged before accepting response data, pruning receipts or advancing the visible generation. Malformed nested refresh data therefore leaves an accepted dialog's values and read-only retry available.
- Persisted page suspension preserves pending results, drafts and receipts until resume revalidates ownership. Nonpersisted departure cleans up. Authentication effects are owned by the planning renderer; the shared session client, PersonalClient and PSW queue behavior are unchanged.

An already-dispatched write can still commit on the server after local retirement. Receipts are local to the owning renderer, not persistent storage. Existing server versions and idempotency remain the protection across full navigation or reload; this change does not claim server-side cancellation.

## Verification

`scripts/test-business-plans-manager.mjs` bundles the actual planning renderer, template data and normalization, shared session transport, ScreenManager and route resolver. It reuses the existing minimal DOM fixture without modification and replaces only peripheral shell presentation. A second shell mode retains existing navigation and refresh nodes to exercise in-place shell updates. These are simulated-DOM lifecycle tests, not browser acceptance.

The focused suite passes 191 cases in three consecutive final runs. The same final suite against the unchanged predecessor completes with 47 passes and 144 expected failures, with no cancellations or skips. Six actual-module regressions were reproduced before implementation. The tests cover presentation gating, all existing action families and payloads, ownership and permission revocation, tenant/plan races, fetch and JSON failures, dialog closure, draft and retry identity, accepted-write reflection, repeated rendering and persisted/nonpersisted lifecycle transitions.

All existing tests and fixtures are unchanged. Both existing TypeScript workflows retain their prior commands and add only the isolated credential-free focused suite invocation. Aggregate tests, type checking, production bundling and exact patch reconstruction must be verified against the final packaged source separately.

## Remaining scope and release limits

The broader `/care` and `/psw` dispatcher routes still select personal, live and demo renderers and nested clinical forms, with their own reads, writes and observers. The growth dashboard likewise delegates multiple action and export children. Those deeper routes are deliberately unchanged by this bounded batch; an initial manager gate alone would not establish ownership of their actions.

Real-browser dialog behavior, focus, keyboard handling, history, BFCache, accessibility, layout and visual review remain required. Browser execution was blocked before navigation in this environment, and no browser success or bypass is claimed. No production database, credentials, live API, governance mutation, published commit, deployment or hosted release verification is included. Full release readiness still requires the existing governance, localization, accessibility, security, performance, strict-type and CI gates.
