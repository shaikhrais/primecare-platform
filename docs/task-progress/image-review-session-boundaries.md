# Image review session and ownership boundaries

Status: isolated local candidate; not published, deployed, or release-approved.

The appearance-review route now retains its captured account and renderer ownership across JSON, image and mutation operations. Transport checks run before and after asynchronous digest/fetch/body reads, including failures, and immediately after awaited helper results before consuming data or applying 401 effects. Requests explicitly use no-store. Existing endpoints, retry identities, PNG content checks, image digests, server permissions and human-evidence readiness remain unchanged.

Each root has one active renderer. Replacing that renderer disposes its drafts, image URLs, readiness state and observers. Ownership tracks the actual review panel, so replacing contents inside a reused application shell cannot leave the old renderer active. Older refresh results and failures cannot overwrite newer refreshes, mutations or routes. Retained handlers from a previous draw are inert. Image fetch, byte conversion, digest and decode completions all recheck ownership/session; stale image URLs are revoked.

Account mismatch or blocked session storage clears only the owned old content. Connected owners reload once; detached/replaced routes are not navigated or overwritten. MutationObserver and pagehide/pageshow handling clean up idle evidence and retained roots. Normal same-session401 handling preserves the existing single login redirect.

## Verification

- Original runtime matches main df27a32822e6255709c48bfcf71be5f9bbccc6ac and PR222 head fad8a62e1a32c642df26f50c7b45b2c521c62800.
- All 88 targeted tests pass: 30 client and 58 actual-renderer fixture cases. The unchanged original fails 74 of the final test cases; 14 controls pass.
- Independent review exposed and then verified fixes for the awaited-helper timing window and reused-shell ownership. Additional independent pagehide/pageshow probes pass.
- The combined manager, tenant presentation and authentication/export candidates pass 288 Node unit/fixture tests.
- Strict typing passes for the image-review runtime and corrected platform/report runtime modules.
- The full main.ts browser bundle succeeds. Full-entry strict TypeScript retains ten baseline diagnostics.

Run without production credentials:

    node --test scripts/test-look-review-client-session.mjs scripts/test-look-review-session.mjs

A separate read-only workflow runs these tests. Existing Look Manager activation, production environment, approval and publishing controls are unchanged.

## Companion correction and limits

The export-session-boundaries patch was revised separately to apply immediate caller-side checks after awaited JSON/blob helpers in platform-bundle/client.ts. Its two queued replacement regressions now pass. Use the corrected export patch in a combined candidate.

Tests use synthetic data, fake fetch and deterministic DOM fixtures, including reused-shell and asynchronous observer behavior. No real-browser acceptance, production governance export, live PostgreSQL, complete monorepo CI, publishing or deployment ran. This is not release approval or proof that every production screen is complete.
