# Coordinator responsibility ScreenManager boundary

## Scope

The existing TypeScript /coordinator-charge renderer now enters its existing ScreenManager registration before reading or presenting responsibility data and before acting on retained controls. The manager remains a presentation contract; it does not authenticate, authorize, grant a role, or replace the server's tenant and permission checks.

This change uses the existing coordinator catalog, view and /v1/governance/care/additional-charge endpoint. No screen, route, API, permission, workflow or business-policy records are added.

## Behavior

- The current root, renderer invocation, document route and query, session and presentation registration must still be valid before requests or visible results are applied. Stale results cannot replace another root, redirect its session, or modify its coordinator marker.
- Assignment, entry and revocation keep their original request bodies and shared transport behavior, including retry keys, revocation versions and server-enforced permissions. Entry still verifies the assignment with the server before setting primecare_care_charge and navigating to the live care workspace. Revocation removes only a marker whose assignment ID matches the acknowledged revoke.
- Reads are ordered. A read started before a mutation, an edited assignment or an open dialog cannot overwrite that newer work.
- Refresh preserves an unsaved assignment without introducing confirmation text. Restored selections are limited to users still offered by the server. Server removal of management controls is authoritative.
- Closed, canceled, removed and previous-owner dialogs cannot submit retained handlers. A failed write preserves its draft and original retry identity. Repeated clicks cannot create concurrent writes.
- A persisted pagehide suspends work without discarding drafts. Deferred results wait for pageshow and then revalidate ownership. Nonpersisted departure, root replacement and repeated mounting clean up owned dialogs, listeners and observers.
- Navigation does not retire the current document on click alone. A canceled navigation or navigation exception leaves the page recoverable until pagehide or a route change actually occurs.
- A current 401 retains sign-out behavior and storage failures are contained. Superseded reads and writes cannot sign out a newer session. A dispatched write may still commit at the server after the page is retired; local cancellation does not claim to cancel server execution.

## Verification

scripts/test-coordinator-charge-manager.mjs bundles the actual renderer, ScreenManager, route resolution, coordinator catalog/view and shared session client. Only the surrounding shell is stubbed. It reuses the predecessor's independent minimal DOM fixture without changing that fixture or any existing test assertions. Four original regressions were reproduced on the predecessor before implementation.

The suite covers presentation configuration, ownership and session changes, stale reads and writes, 401 suppression, request payloads, marker behavior, retry identity, dialogs, drafts, repeated navigation and BFCache lifecycle. Both existing TypeScript release workflows invoke this suite in an isolated credential-free environment. Existing test invocations are retained unchanged.

## Release limits

This is bounded source and simulated-DOM evidence, not a browser acceptance result. Real-browser keyboard, focus, native dialog, history, BFCache, accessibility and visual checks remain necessary. Browser execution was unavailable in this environment before navigation. No live database, production API, governance registration, deployment or hosted release verification is claimed. Full release readiness also depends on the repository's existing governance, localization, accessibility, security, performance, strict-type and CI gates.
