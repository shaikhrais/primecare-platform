# Shared application module foundations

B15 adds original optional academy, commerce, AI-image, profile, settings and help-centre collection templates. They reuse the B13/B14 actor-bound view, detail editor, receipt/readback and failure lifecycle. Source readiness is separate from an activated product screen.

| Template | Supported source integration | Explicit dependency or missing scope |
|---|---|---|
| Academy | Registered optional presentation, unavailable without an approved port | Own training read candidate is absent from production metadata; course/catalogue/enrolment/progress/certificate workflows remain unbound |
| Commerce | Registered optional presentation, unavailable without an approved port | Inventory/purchase-order/ledger candidates are absent from production metadata; cart, checkout, payment, tax, refund and entitlement workflows remain unbound |
| AI images | Registered optional presentation, unavailable without an approved port | Provider adapter, authorization, entitlement, quotas, persistence and asset access are not registered for this product workflow; no generation call or pretend image result |
| Profile | Existing self-session identity GET, read-only and strictly compared to the captured actor/tenant/role | Full personal profile, contact editing, avatar, sensitive updates and host integration remain outside this adapter |
| Settings | Existing API 777, B07 sync client and navigation-shortcut resource | Other account settings/security changes, rich shortcut picker, host defaults/reconciliation UX remain pending; native shortcut settings port is verified |
| Help centre | Registered optional presentation, unavailable without an approved port | No approved article/knowledge candidate was found in this discovery; knowledge content, search and support escalation require a confirmed workflow/API binding |

Creation controls remain disabled. No purchase, payment, image-provider, course completion, support message or sensitive account operation is implied by a collection view.

## Registration and authority

Run `41276699858`, attempt 2, independently verified API 777 POST `/v1/user/preferences` with existing `authenticated_self_preferences` permission, and committed 20 optional controls, 20 optional required-element records and 96 draft EN/FR/ES translations across 32 resources. The initial attempt stopped at a database lock timeout before writes; the same failed job was retried without loosening locks. No new API, route, screen link, grant, business record, schema or runtime activation was introduced.

The same transaction and independent readback discovered existing API 16402 GET `/v1/auth/me`, auth-required with `authenticated_self_session`. Its legacy `service_name` is null. This batch preserves that metadata; the fixture verifies the existing gateway/auth-handler route and self-session scope. Source/host routing review and production activation remain separate gates. The new adapter exposes only the four existing identity fields, with no administrative or profile mutation.

Discovery returned no rows for the queried own-training, inventory, purchase-order, authored-post, ledger, help-article and knowledge-article candidates. Candidate queries are not API registrations and do not prove that no alternate governed workflow exists. Do not bind source-only services or guessed paths to these templates. The readback is in `application-modules-registration-receipt.json`.

API 777's existing runtime flag, metadata status and host grants remain required. B07 did not authorize the Tenant Admin pilot to bypass its missing host grant; B15 does not change that. Preference hints cannot grant access to a route. Existing authentication, password, MFA, session and contact-management flows remain unchanged.

## Web composition

Import `PrimeApplicationModule`, `WorkModuleSession`, `ApplicationSettingsPort`, `ApplicationProfilePort` and `applicationPreferenceTransport` from `packages/primecare_ui/web/application-modules.ts`. Load `packages/primecare_ui/catalogs/application-modules.registration.json` and pass the selected locale's registered labels to the adapter. Supply B06 theme tokens, an exclusive content root, locale and the shared renderer's year/month/first-weekday inputs. Do not use `body` as the owned root. Mount one B15 family view per document; its shared action IDs are not allocated for simultaneous duplicate family mounts.

The profile port accepts the real gateway origin, captured token and authenticated scope, a current-session accessor, registered labels and an optional fetch adapter. Every read checks the current token/scope before fetch, after response and after decoding, then compares returned userId, tenantId, roles and authenticated status exactly. No caller-selected owner, role or tenant is sent. Denial clears the displayed result. The API remains read-only in this template.

For settings, create `applicationPreferenceTransport` with the authenticated origin/token/scope and a current-session accessor. It delegates to the bounded B07 HTTP transport. Pass a B07 binding `{scope,kind:'shortcuts',resource:'navigation',policy}` and a durable `PreferenceCache` to `ApplicationSettingsPort`. Supply a map from currently allowed registered screen IDs to unique, localized display names, plus optional registered default IDs. The host obtains these hints from current approved resources; the server still verifies every permission and ID.

The editor contains one shortcut display name per line. It does not expose role strings, API URLs, JSON or internal screen IDs as editable product settings. The port maps only unambiguous names back to IDs and delegates validation to the existing preference protocol. Defaults supplied by the host are display defaults when no document is saved; they are not claimed as a persisted user selection. A production host should provide an accessible registered picker rather than relying only on free text.

Settings use an owned B07 `PreferenceSyncClient` with a distinct `application-modules.settings:` local draft namespace, retaining B07's full account/tenant/role/dataset key. This does not create a second business authority. The host-supplied cache must be durable and must not store tokens. Client drafts, optimistic revisions, UUID receipts, quotas, scope and registered screen restrictions remain the existing B07 protocol.

Use module `profile` or `settings` with the corresponding approved port. Omit the port for `academy`, `commerce`, `ai-images` and `help`; unavailable is an intentional dependency state, not an empty successful API result. New adapters accept only live scopes; no demo/provider success fallback exists.

## Saves, replay and reconciliation

The shared editor captures a positive collection version; settings map it to the existing preference revision without manufacturing a server version. A valid selection is persisted in the B07 local draft before the POST. The work-session UUID is also the B07 request UUID. Lost acknowledgements retain that exact command/key; the confirmation button replays the existing durable receipt, not another write. If acknowledgement was already verified and only the independent read failed, confirmation reuses that verified acknowledgement and retries the read without another write.

After the B07 client verifies acknowledgement scope/revision/document, a fresh server read independently verifies the document and expected revision before the collection shows saved success. The tests independently query PostgreSQL and reload a fresh UI. Unregistered shortcut names are rejected before a request; server conflicts and denials remain failures. A shared-engine fix makes unavailable mutation outcomes reject too, retaining the visible editor draft.

Cached dirty/pending drafts or a revision conflict after reload require the B07 explicit reconciliation flow. This new collection does not yet mount that full conflict-recovery UI. `ApplicationSettingsPort.recovery` exposes its state for host integration; it does not automatically discard, replace or replay a recovered draft. Before enabling this collection, the host must wire B07’s explicit reconciliation actions to this same draft namespace. No automatic retry, implicit remote/local resolution or silent overwrite is added.

Dispose view, session/port and its owned client when actor, tenant, role, dataset or route changes. Late results are ignored; a request already accepted by the server cannot be recalled by disposing a widget. A host must still immediately invalidate all related UI when its authenticated context changes.

## Flutter and platform scope

Import `package:flutter_core/application_modules.dart` or the `primecare_ui` forwarding export. B15 reuses `PrimeWorkModule`, `WorkModuleSession` and B07's native preference protocol/client. Load `CatalogueLabels.fromMetadata` with the B15 export and supply host spacing/width tokens and a UUID-v4 provider for mutations.

The new collection has no concrete native live profile/settings `WorkPort` or host mount yet. Existing native B07 clients remain available rather than being copied. Native tests prove the optional presentation/protocol, unavailable states and retained failed draft using isolated ports. They are not deployed native transport evidence. Physical-device and full-app acceptance remain open.

## Release gates

All new labels are registered EN/FR/ES drafts. Human language, keyboard/focus, screen-reader, contrast, responsive layout, localization and release review remain open. Host bindings, API 777 activation/current grants, profile routing metadata review, default/picker presentation and complete reconciliation UX are required before exposure. B14's unrelated notification/API and file-operation gaps remain unchanged. Full reference-family adoption is not claimed.


## Native self-profile binding

`package:primecare_ui/application_modules.dart` now exports `ApplicationProfilePort` for the existing API 16402 `GET /v1/auth/me`. Construct it with the real gateway origin, the captured bearer token, immutable `PreferenceScope`, current-token/current-scope callbacks and the registered localized identity label. Pass it to `WorkModuleSession(scope, 'profile', port: port)` and the existing `PrimeWorkModule`. Dispose the session on logout or actor/tenant/role change.

The native adapter exposes only the existing authenticated identity fields and no mutation actions. It denies demo scope, owner-selected queries and redirects; bounds streamed JSON to at most 64 KiB; checks captured context before dispatch, after headers, throughout streaming and before publication; and compares all returned identity fields exactly. Closing the port does not close a host-injected HTTP client. Its source tests use isolated fixtures; authenticated native host activation, actual-device checks and production acceptance remain open.

Native source acceptance: `2b0cb0d27da5f88d7b7b25b189866a5ed85a607f`, run 41323515743, passed web, native PostgreSQL/browser and Flutter Linux/Windows/macOS jobs. The native suite passed 43 tests including seven self-profile regression groups. See `native-profile-binding-evidence.json`; host activation and release approval remain separate.

Web/native response parity: the web self-profile port now uses the same 64 KiB maximum as native. Its shared guarded reader validates the captured actor, cancellation and disposal throughout streaming and after cleanup. Invalid/oversized JSON fails without publishing identity or adding any mutation operation. `scripts/test-application-modules-transport.mjs` covers these cases and the dashboard reader's 1 MiB bound.


## Native shortcut settings binding

`ApplicationSettingsPort.authenticated` composes the existing API777/B07 client with the common `WorkPort`. Supply the existing grant-bearing session, immutable shortcut binding/allowlist, scoped cache, registered destination names/labels and explicit host defaults. It projects the same names/version as the web adapter and preserves API revision, original request UUID, durable cached draft and independent readback. Injected HTTP clients remain owned by the host. Dispose the session/port on actor, role, tenant, dataset or route changes.

Default, empty and selected preferences plus writes/readback are compared against the existing web adapter by `application-settings-native-fixtures.mjs --check`. Native tests cover cache-denied/no-write behavior, original-key replay, verification-only retry, strict names/fields/version, changed sessions and disposal. Restarted dirty/pending preferences remain explicitly blocked with the owned recovery snapshot exposed; the B07 governed reconciliation UI must be mounted before host rollout. This adapter does not enable API777, add roles/grants, alter account security, or create academy/commerce/help/image-provider bindings. Native/source acceptance passed targeted run 41336612262 and combined run 41336612512; see `native-communication-settings-evidence.json`.
