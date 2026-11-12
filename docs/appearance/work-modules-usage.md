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

The host supplies its current authenticated tenant/user/role/dataset scope and gateway origin, loads the B06 theme variables, and creates one session and view per module. Pass locale (`en`, `fr`, `es`), calendar year/month and first weekday explicitly. Use an exclusive content root, not `body`. Dispose the view and session when changing actor, tenant, role, dataset or route. Do not share sessions between actors. No token is persisted by this module; the optional transport requires the existing `primecare_session` token before dispatch, after headers, throughout body streaming and after asynchronous stream cleanup. The reply is bounded to 1 MiB, decoded as strict UTF-8 JSON and rejected on cancellation, malformed data or an account-token change. A rejected mutation reply remains an uncertain outcome for the shared receipt/retry lifecycle; the transport never replays a write itself.

The adapter uses only registered GET/POST `/v1/governance/tenant-dashboard`, API IDs 16578 and 16579. The server derives tenant/actor authorization. No headers or caller-controlled tenant parameters expand authority. Server actions and the existing shared task transition policy determine allowed operations; UI controls do not grant permissions.

The task page is bounded to 100 records. Filtering is server-side for tasks and local within the authorized bounded directory for contacts. `partial` explicitly reports incomplete projections. Calendar dates are all-day task due dates. A calendar month view is not a complete appointment feed. The current common previous/next labels are month-specific; non-calendar pagination labels need a neutral registered variant before host release.

## Flutter integration

Import `package:flutter_core/work_modules.dart` or the `primecare_ui` forwarding export. Load `CatalogueLabels.fromMetadata` from `packages/primecare_ui/catalogs/work-modules.registration.json`. Supply the session, scope key, year/month, first weekday, theme spacing and board column width to `PrimeWorkModule`. Mount within the host's scroll/layout constraints.

`WorkPort` is an injected contract with read, mutate, independent item read and dispose. The Flutter session verifies exact actor/module scope, editor version, mutation receipt and fresh readback before success. The native `TenantTaskModulePort.authenticated` now supplies the existing API16578/16579 transport and task-backed projection/command adapter. Live authenticated host mounting remains pending. Widget tests use a deliberately isolated test port; they are not production API evidence. Native semantics use registered component IDs. B14 expanded common record IDs to the existing communication service’s 200-character bound and semantics suffixes to 400; old deterministic IDs are unchanged. Broader host adapters must validate their identifiers.

## Save, conflict and disposal

An edit captures the displayed version. Known validation/conflict/denial results do not show saved success. Failed edits retain input. An uncertain mutation retains the exact command and UUID; `retryPending()` replays that original request. After a validated acknowledgement, retries perform only the independent readback and never invoke the mutation again. A changed command cannot replace an unresolved mutation, and `load()` rejects while it is pending. Shared web/native views disable filter/reload/pagination and editing until resolution, and expose the existing confirmation control (or B13 apply-action control) for the original request. Recreating a view preserves this recovery action without automatically loading over the pending context. Durable recovery after the session itself is lost and production host activation remain separate work. A successful POST is followed by a fresh independent item query and exact expected-field/version comparison. Renames are read back using the new title, including pagination. Failed requests are removed from the adapter's request cache so a corrected save cannot use a rejected title search.

Disposal and generation guards ignore late results. Denied reload/mutation clears protected snapshots. Hosts must dispose immediately on session changes. Native requests use epoch guards; native transport cancellation is the host's responsibility.

## Release gates

Common EN/FR/ES labels are registered drafts. Task action/status labels reuse the existing English task catalogue. Human translation, accessibility, keyboard/screen-reader, contrast and release review are open. Weekday headings and localized full-date accessible names are implemented in both shared renderers; native/browser acceptance remains pending. The native due-date editor now reuses the shared date input, including picker lifecycle ownership and pending-state disabling; calendar day density uses an owned horizontal viewport. Their fresh native/browser acceptance is tracked separately. Native editor focus entry and return-to-opener behavior is implemented with scope/session guards and pending fresh native CI acceptance. Localized business labels, neutral pagination wording, native drag behavior and actual host/device accessibility still need implementation or verification. Do not infer release approval from factory tests.

No synthetic data is seeded into production by this batch. The generic protocol supports separate live/demo scopes, but a host must provide a persistent, localized demo banner and verify workspace-version handling before exposing demo mode. The current templates do not supply that banner; demo host activation remains blocked.

Transport lifecycle acceptance: source `0633b548ee5f73b9c34e2f7c22bb6d7ee036af5b` passed all 12 targeted/combined jobs in runs 41326605698 and 41326605678. See `work-module-transport-evidence.json`. Production host, missing workflow, device and release gates remain open.


## Native task-backed API binding

Import `TenantTaskModulePort` through `package:primecare_ui/work_modules.dart`. Construct `TenantTaskModulePort.authenticated` with the gateway origin, captured token/scope, current-token/current-scope callbacks, a B13 module (`calendar`, `contacts`, `tasks`, `notes`, `board`) and registered localized task lane/action labels. The host creates `WorkModuleSession(scope, module, port: port, requestId: uuid)` and the existing `PrimeWorkModule`. Dispose the session immediately on logout, actor/tenant/role/dataset change or route teardown. The factory disposes its transport; a host-injected HTTP client remains owned by the host.

The native adapter preserves existing task command fields and original receipt keys. Contacts are the existing read-only authorized directory; notes/calendar/board remain task-backed, with no standalone contact/note/appointment/board CRUD implied. Demo writes preserve the server workspace version. Server-provided actions are restricted by the shared transition policy, and independent manager completion rules are retained. Mutations require exact item/version/action/field matching. Independent readback searches the updated title across bounded pages. Uncertain writes retain the original payload and receipt key in memory; an acknowledged save retries verification without issuing another mutation. This does not provide durable process-restart recovery.

HTTP requests use only GET/POST `/v1/governance/tenant-dashboard`, captured bearer context, no redirects, bounded strict UTF-8 JSON (at most 1 MiB) and abortable requests. Disposing requests aborts their request trigger; injected clients must support the HTTP abort contract for physical cancellation. Guards suppress late results even for clients that do not honor abort. No API, role grant, business workflow or production host is registered or activated by this binding.

`node scripts/work-modules-native-fixtures.mjs --check` reproduces 60 projections and 52 mutation/receipt/readback cases from the existing web adapter and transition policy. `flutter test test/work_modules/tenant_task_module_port_test.dart` adds 13 regression groups, including the complete native session GET/POST/independent-GET path with an isolated HTTP client. Production/device and human release evidence remain separate.


## Registered tenant pilot host

The existing `/tenant-dashboard` host now has an opt-in source binding: `?workModule=tasks#tasks`, `?workModule=calendar#tasks`, `?workModule=notes#tasks`, `?workModule=board#tasks`, or `?workModule=contacts#people`. These are parameters on the existing registered route, not new routes or grants. The host checks the server's existing `allowedViews`; directory views require `people`, all task-backed views require `tasks`. Existing explicit global-demo tenant context is preserved from the server-authorized parent response. Default rollout is unchanged.

The common renderer replaces the corresponding legacy collection only for an authorized opt-in. It shows exact registered control IDs. Local edits or unresolved writes lock host navigation/refresh until saved, retried or explicitly closed. Acknowledged writes are independently read before success; verified completion refreshes parent data. Captured-context denial clears protected host content. Root replacement, rerender and route teardown release listeners/owned dialogs and prevent late reads from overwriting a new host. Legacy button disabled states are preserved. Before-unload protection does not provide durable process-restart recovery.

`test-tenant-work-module-host.mjs` exercises the actual portal source and existing handler: five opt-in views, unchanged default, registered IDs, SQL readback, verification-only retry without duplicate writes, reload, unsaved-state guards, role-view denial, account invalidation, dialog teardown and late-response/root ownership. Fourteen actual-host browser checks and PostgreSQL acceptance passed run 41339668646; see `tenant-work-host-evidence.json`; production/deployed native host, device and human review remain separate gates.
