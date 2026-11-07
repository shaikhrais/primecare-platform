# Workspace calls restoration lifecycle

Status: isolated, unpublished candidate. No production readiness claim.
Date: 2026-11-07.
Predecessor: the verified admin-auth-edges extension on fad8a62e1a32c642df26f50c7b45b2c521c62800 plus its twelve unpublished patches.

## Reproduced defect

The workspace calls branch returned before the generic workspace's persisted-pageshow listener was installed. InternalCallsPanel correctly released its media, polling and push owner on pagehide, including entry into the browser's back/forward cache. Restoring that document therefore displayed a closed calls panel indefinitely, without a fresh workspace authorization read.

The proof uses the existing customer_support grant and communication screen at /staff/communication from the actual workspace registry and handler. It does not create a screen, route, grant or database row.

A second lifecycle race occurred when an older pending call-panel start failed after root replacement: its catch could overwrite the new root's status. An independently found transport race also required checking ownership on rejected startup, not just successful responses. A changed or unreadable session can cause the real session client to reject before the panel's post-await check.

## Bounded repair

- Install a per-root workspace lifecycle before the first workspace read, including before lazy calls import and panel startup.
- Revoke the old presentation snapshot and suspend pending work on pagehide. Dispose calls through the existing idempotent CommunicationResourceBase.close implementation. Remove lifecycle bindings on nonpersisted departure.
- On persisted return, verify the captured session and request a fresh server-filtered workspace snapshot. Create a new call panel only if the existing communication route is still allowed and the current query still requests calls. Never reopen the closed media owner.
- Coalesce duplicate pageshow events during a pending restore. Older generations, detached roots and late responses cannot take ownership of a replacement.
- Reconcile same-document traversal into or away from the calls view without changing routes, grants or server policies.
- Claim a newly constructed panel synchronously, before awaiting startup. Close it immediately if its workspace owner has retired.
- Recheck ownership after startup rejection and immediately before starting push events. Closed owners cannot repaint status or schedule another poll. Session replacement/removal clears the workspace snapshot and content before reload. Blocked session storage produces the existing configuration error.
- Retain the existing three-argument renderInternalCalls API. A current, same-session transient startup error still displays unavailable and retains its existing retry behavior.

Only workspace.ts and internal-calls.ts change at runtime. ScreenManager, portal presentation bridge, workspace server authorization, call payloads/endpoints, shared communication base classes and media policy remain unchanged.

## Regression evidence

scripts/test-workspace-calls-resume.mjs has 31 passing isolated Node tests. It executes the actual workspace server handler, client module, ScreenManager and InternalCallsPanel, with synthetic database, DOM, call transport and push-event peripherals. The lazy-import test pauses actual module initialization through test-only instrumentation. This is not a browser or production acceptance test.

Coverage includes repeated and duplicate restoration, same/replaced/missing/unreadable sessions, revoked grants and HTTP 401/403/503, changed route/query, same-document traversal, pending workspace reads, lazy import, pending panel startup, remount, obsolete callbacks, nonpersisted departure, closed-start microtasks, generic workspace compatibility, the three-argument API, and current versus retired startup failures.

The identical new suite against the exact predecessor yields 3 passes and 28 failures, with no cancellations. The 3 passing cases cover behavior intentionally retained. All prior tests and fixtures are byte-for-byte unchanged, as is every other predecessor file under scripts/. The final combined suite passes 641 tests, including all 610 predecessor tests and 31 new tests. The focused suite also passes three repeated runs and the credential-environment isolation check. Independent review passes 34 additional probes using the actual InternalCallClient, BaseSessionClient and BrowserCallEvents with synthetic service/browser peripherals.

The complete main entry bundle succeeds with 247 inputs and zero warnings. Non-strict main-entry typechecking succeeds. Strict main-entry typechecking still reports the same ten diagnostics as the exact predecessor, with no new diagnostics. These existing type errors remain a release limitation.

Both existing TypeScript deployment and release verification workflows invoke the new suite with an empty environment plus PATH, HOME and TMPDIR. No workflow was run remotely.

Separate real Chromium launch attempts, including the approved standard-invocation retry, could not launch before opening any page: process-singleton socket creation failed with EPERM, followed by ptrace denial. The browser executable exists; no restriction was bypassed. Consequently real BFCache behavior, media permissions, keyboard/accessibility, responsive layout and screenshots remain unverified.

## Remaining release gates

This change does not finish the complete Screen Management inventory or production integration. It needs the existing authenticated browser, live PostgreSQL/tenant, governance registration, complete repository CI and release review gates. No credentials, live database, production mutation, dependency installation, commit, push, publication or deployment was used.

Deferred findings are separate work: the presentation bridge resets the non-scrolling app root instead of the document scroll position, and specialized administrator in-page account navigation does not re-enter ScreenManager. Neither is silently included in this lifecycle patch.
