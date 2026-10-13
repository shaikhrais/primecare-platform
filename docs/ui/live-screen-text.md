# Downloaded screen text on this device

Screen text is downloaded as JSON and stored in persistent local app storage,
scoped to the API gateway. Flutter uses platform preferences in the app data
area; websites use browser local storage. A valid saved copy loads on restart
without API calls. First use can download a copy; there is no periodic polling
or refresh on resume. Explicit download updates the local copy. Bundled governed
text remains the fallback when no valid download is available.

The administration text editor saves English, French and Spanish changes on
this device. Save, reload, JSON import/export, history and restore operate
locally and do not publish changes or read server audit history. The latest
50 local edits are retained, and restore creates a new local version. The
separate Download from API action asks before replacing local text. Conflicting
local edits preserve the unsaved draft. Local saves report storage failures
instead of claiming a durable save.

Flutter provides `LiveScreenTextStore.saveLocal` and `localHistory` for device
text changes. Cached text updates rebuild dependent widgets while retaining
typed drafts. The shared API remains available for explicitly authorized
server updates; the local editor does not call its write/history endpoints.
Only plain interface text, catalog versions and local text history are stored,
never passwords, recovery codes, session tokens or business records. This cache
covers screen text; business/authentication operations keep their existing
network requirements.

The supported catalogs are Reality Check, Role Carousel, Theme Center, workspace,
reports, platform administration, the text editor, shared Flutter authentication
and password recovery. TypeScript authentication still needs migration.

Bundled defaults are governed by `register-live-screen-text.py`. Changes in
production are versioned in PostgreSQL, not written back automatically into
the repository's SQLite file. API routing is `/v1/governance/screen-text` through
the gateway. Apply `20261013_screen_text.sql` before deploying the Worker.
The binary governance database is excluded from the code PR.

The catalog repair fills 35 workspace resources in Spanish/French and repairs
nine malformed serialized English labels in each of the ten app/shared
catalogs. Catalog audit parity is separate from translation quality review;
identical strings elsewhere still require review.

## Historical screenshot references

`export-screenshot-screen-json.py` exports the maintained old HTML previews
and matches candidate screenshot filenames. It produces 965 screen references,
64 role files and 64 reusable shell definitions. The 1,617 image files have
293 unique hashes. Filename matches do not prove image identity; some images
show galleries, placeholders or login walls. Reference JSON records this
uncertainty and does not infer permissions, APIs or implemented workflows.
English text comes from preview HTML; French/Spanish reference maps remain
empty pending verified translation. These are historical migration inputs,
not additional live runtime catalogs.

## Validation

The dedicated CI workflow checks API schemas, PostgreSQL authority/concurrency/
history/restore, browser editing/conflict/JSON transfer and Flutter refresh
without losing user drafts. Shared workspace, reports and admin localization
regressions are included. Production readiness still requires applying the
migration, deploying API/UI and verifying an authenticated production workflow.

## Contract evidence review

The governance handler gains only a `screenText` import and an early dispatch
after its existing governance-service check. Existing registry reads, authority
checks, route bindings and transaction logic are unchanged. The contract-review
source hash and dependent generated evidence are refreshed for that additive
change. The baseline remains 1,415 operations, including 1,063 unresolved
operations; this refresh earns zero implementation or retirement credits and
does not activate any unresolved workflow.

The workspace renderer audit pin is also refreshed after reviewing its only
changes: a live-text import and label lookup. Its authorized route selection,
returned section loop, visible cards and stable semantics remain unchanged.
The audit still rejects unrendered/dead section loops and does not promote
production readiness.

## Shared authentication catalogs

`auth` reuses the 62 registered authentication resources for the shared Flutter
login, provisioning information, recovery shell, language selection, session
summary and unavailable-capability pages. `password_recovery` adds 18 governed
labels and validation/status messages in English, French and Spanish. Recovery
status stores resource keys so language changes and remote text edits update
messages while retaining email, code and password drafts. Server failures use
a localized generic status; authentication requests and validation rules are
unchanged. The TypeScript authentication pages still require their own resolver
migration. This brings the live catalog count to nine; historical reference
files are not counted as additional runtime migrations.

The TypeScript login page uses the governed `auth` catalog in the document/browser language (English, French or Spanish). Downloaded and device-edited labels update in place; email/password fields and active requests are preserved. Authentication still uses its existing online endpoint. Failed sign-in displays the localized catalog message rather than raw server text.
