# Shared work modules

B13 adds original, optional shared templates. These exports do not mount an application route, activate screen 2534, grant a role, or replace an existing scheduling or clinical screen.

| Template | Concrete existing workflow | Available operations | Needs specification or host integration |
|---|---|---|---|
| Calendar | Tenant workflow task due dates | Month grid, detail, date edit; web drop reschedules an editable task | Appointments, timed events, recurrence, reminders, timezone scheduling, native pointer drag |
| Contacts | Authorized tenant staff/client directory | Bounded search, details, read-only directory | Personal address book, contact creation/edit/deletion, groups and imports |
| Tasks | Existing accountable tenant tasks | Search, detail, instruction/title/date edit and server-authorized transitions | New template create/owner/workflow/priority controls; generic task deletion |
| Notes | Instructions attached to existing workflow tasks | Read and edit task instructions | Standalone note service, notebooks, rich text, tags, archive and note CRUD |
| Scrumboard | Existing task statuses and transitions | Status lanes; choose permitted action and enter evidence; web drop opens evidence entry | Manual card ranking, custom lanes, board CRUD, native pointer drag |

Creation remains available in the existing tenant task application. The new template's create control is disabled: the existing mutation response is a bounded list, and this adapter does not yet have an independently verifiable created-item identity receipt. Cancellation retains its existing operational meaning. It is not presented as deletion.

## Web integration

Import `PrimeWorkModule` from `packages/primecare_ui/web/work-modules.ts`, `WorkModuleSession` from `packages/shared/src/work-modules/session.ts`, and `TenantTaskModulePort` from `packages/shared/src/work-modules/tenant-task-adapter.ts`. The optional authenticated fetch transport is `tenantTaskModuleTransport` in `websites/typescript/src/tenant-dashboard/work-module-transport.ts`.

The host supplies its current authenticated tenant/user/role/dataset scope and gateway origin, loads the B06 theme variables, and creates one session and view per module. Pass locale (`en`, `fr`, `es`), calendar year/month and first weekday explicitly. Use an exclusive content root, not `body`. Dispose the view and session when changing actor, tenant, role, dataset or route. Do not share sessions between actors. No token is persisted by this module; the optional transport requires the existing `primecare_session` token before and after each request.

The adapter uses only registered GET/POST `/v1/governance/tenant-dashboard`, API IDs 16578 and 16579. The server derives tenant/actor authorization. No headers or caller-controlled tenant parameters expand authority. Server actions and the existing shared task transition policy determine allowed operations; UI controls do not grant permissions.

The task page is bounded to 100 records. Filtering is server-side for tasks and local within the authorized bounded directory for contacts. `partial` explicitly reports incomplete projections. Calendar dates are all-day task due dates. A calendar month view is not a complete appointment feed. The current common previous/next labels are month-specific; non-calendar pagination labels need a neutral registered variant before host release.

## Flutter integration

Import `package:flutter_core/work_modules.dart` or the `primecare_ui` forwarding export. Load `CatalogueLabels.fromMetadata` from `packages/primecare_ui/catalogs/work-modules.registration.json`. Supply the session, scope key, year/month, first weekday, theme spacing and board column width to `PrimeWorkModule`. Mount within the host's scroll/layout constraints.

`WorkPort` is an injected contract with read, mutate, independent item read and dispose. The Flutter session verifies exact actor/module scope, editor version, mutation receipt and fresh readback before success. A concrete native authenticated transport and live host mount remain pending. Widget tests use a deliberately isolated test port; they are not production API evidence. Native semantics use registered component IDs. Very long generic record IDs may exceed the inherited native catalogue suffix limit; tenant UUID/directory IDs fit that limit, and broader host adapters must validate their identifiers.

## Save, conflict and disposal

An edit captures the displayed version. Known validation/conflict/denial results do not show saved success. Failed edits retain input. An uncertain mutation retains the exact command and UUID; call `retryPending()` with that same command/key, or reload and reconcile with the server. A changed command cannot replace an uncertain pending mutation. Hosts still need a visible reconciliation/retry affordance before release. A successful POST is followed by a fresh independent item query and exact expected-field/version comparison. Renames are read back using the new title, including pagination. Failed requests are removed from the adapter's request cache so a corrected save cannot use a rejected title search.

Disposal and generation guards ignore late results. Denied reload/mutation clears protected snapshots. Hosts must dispose immediately on session changes. Native requests use epoch guards; native transport cancellation is the host's responsibility.

## Release gates

Common EN/FR/ES labels are registered drafts. Task action/status labels reuse the existing English task catalogue. Human translation, accessibility, keyboard/screen-reader, contrast and release review are open. Native date input, weekday headings, responsive calendar density, focus restoration, localized business labels, long-ID suffixes and generic pagination wording need host verification. Do not infer release approval from factory tests.

No synthetic data is seeded into production by this batch. The generic protocol supports separate live/demo scopes, but a host must provide a persistent, localized demo banner and verify workspace-version handling before exposing demo mode. The current templates do not supply that banner; demo host activation remains blocked.
