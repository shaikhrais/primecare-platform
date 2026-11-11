# Platform documents and reporting session boundaries

Status: isolated local candidate; not published, deployed, or release-approved.

## Scope

The existing platform document downloader and report PDF exporter captured a bearer token but did not consistently compare it with the current browser session. A download could finish after account replacement or logout. Their surrounding asynchronous handlers could also redraw cached old-account data, and the platform attention navigation callback could hand an old-account tenant/item to its parent.

Platform BundleClient now guards asynchronous digest, fetch, JSON and blob reads before and after completion, including rejection. No object URL or download click is produced for a stale actor. Existing endpoint, bearer, cache, filename and object-URL cleanup behavior is retained. Matching 401 responses still revoke immediately, and a replacement login during their pending body cannot be cleared or consumed as the old response. Same-account errors and idempotency retry identities remain unchanged. Immediate consumer-side session checks after awaited helper results also close the extra microtask window before JSON consumption and object-URL creation. BundleController discards cached data, drafts and history when identity changes instead of redrawing them, and guards attention navigation before passing an item to its parent.

The reporting panel checks the captured session before actions and after asynchronous fetch/body reads for its existing load, generate, PDF and email controls. The first detected mismatch or storage-read failure permanently clears this panel's data/drafts and unsubscribes it. A connected invalidated panel reloads once through the existing host; a detached old panel never reloads the newer route. Retained handlers and live-label callbacks cannot revive the invalidated panel. Email still requires existing consent, keeps its idempotency key, suppresses duplicate sends, and preserves the uncertain pending marker when an old request finishes after an account switch. No external mail was sent by tests.

No new API, route, role, permission, screen, or governance record is added. Existing backend authorization remains authoritative.

## Verification

- Current main df27a32822e6255709c48bfcf71be5f9bbccc6ac was checked. All three original runtime files match that main and PR222 head fad8a62e1a32c642df26f50c7b45b2c521c62800.
- The original code fails 36 of the 42 new targeted tests; the six healthy-session controls pass.
- The fixed code passes all 44 targeted tests: 27 platform client/controller cases and 17 report panel cases. Report tests execute the actual module with a deterministic DOM fixture; platform controller tests stub presentation adapters only.
- The combined preserved manager, tenant presentation, authentication and export candidate passes 200 Node unit/fixture tests.
- Two additional queued-session regressions fail on the initial export candidate and pass after the immediate-consumer checks.
- Independent review reproduced the original attention-navigation bypass; its fix now passes that independent probe as well as all targeted tests.
- Strict TypeScript for the three changed runtime modules passes.
- Full main.ts bundling succeeds with zero warnings and 247 inputs. Full-entry strict TypeScript still reports the same ten baseline diagnostics.

The new read-only Export Session Boundaries workflow runs only these tests, without production credentials. Existing release, approval and publishing workflows are unchanged by this patch.

Run in an empty environment except PATH, temporary HOME/TMPDIR and LANG:

    node --test scripts/test-platform-bundle-session.mjs scripts/test-report-panel-session.mjs

## Limits

These checks do not replace real-browser interaction/accessibility testing, live PostgreSQL and production-governance verification, complete repository CI, release review, or deployment. Tests use fake fetch and synthetic data. Already-dispatched authorized writes cannot be cancelled by a later account switch; uncertain delivery markers remain unresolved rather than reporting success or retrying automatically. Other application clients and image-review paths are outside this batch.
