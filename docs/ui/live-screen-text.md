# Live screen text

The platform administrator's administration interface contains a Screen text
section. Select a registered screen, search its keys and edit English, French
and Spanish side by side. Save publishes all three locale maps as one version.
The API checks key parity, named parameters, nonempty values and text limits.
Import loads a JSON draft for review; export downloads a screen JSON document.

The editor reads the latest 50 history records, including actor and timestamp.
Restore publishes a selected historical catalog as a new version, retaining
the earlier history. Concurrent saves require the version originally read;
stale edits receive 409 and their unsaved draft remains visible.

Only an active, authenticated `platform_admin` can save or read history.
Ordinary roles cannot edit global text. Public reads contain plain registered
interface text only, without actor history, user records or business data.
Writes recheck session authority under transaction locks, apply a per-actor
limit of 30 attempts/minute, and commit catalog/history together.

The supported live surfaces are Reality Check, Role Carousel, Theme Center,
workspace, reports, platform administration and the text editor. Flutter uses
the inherited shared app scope; websites use the shared live catalog store.
They check versions every 30 seconds while active and retain fallback/last
valid text on refresh failures. Browser refresh avoids overwriting active
drafts. Editing a supported resource needs no rebuild after the initial feature
and additive database migration are deployed. Generated/legacy screens that
have not adopted this resolver still require migration.

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
