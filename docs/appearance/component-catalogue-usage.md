# Shared component catalogue (B09)

These optional factories consume the verified `packages/primecare_ui/catalogs/component-catalogue.registration.json` export. They are shared source packages, with host integration still required. Their metadata targets existing Tenant Admin screen 2534; it does not authorize native or other app activation.

## Web API

Import `PrimeComponentFactory` and optional `catalogueRegistration`, `codeTokens`, `remainingSeconds`, `responsiveColumns`, `AsyncTask` from `packages/primecare_ui/web/component-catalogue.ts`.

Create `new PrimeComponentFactory(slot, scope, locale)` once for an exclusive, empty component slot inside a B06 themed host. `locale` is `en`, `fr` or `es`; `scope` identifies the current tenant/account/role presentation context. Body/document roots and simultaneous owners of one slot are rejected. Call `dispose()` on navigation or context change, then construct a fresh factory. Disposal aborts listeners and tasks, closes owned dialogs, clears timers and empties the owned slot. Do not put unrelated host content there.

The host supplies B06 CSS tokens (`--color-*`, spacing, radius, border and control-height tokens), direction and authorized content. No factory automatically mounts into an application.

| Method | Contract |
|---|---|
| `text(key)` | Resolve an existing registered label; unknown keys fail. |
| `button(key, action?, options?)` | Registered button with disabled/pressed/suffix options, single-flight promise handling, retained label and localized loading/success/error status. Missing action disables it. Optional success/error keys must exist. |
| `field('input' or 'multiline', options?)` | Returns `{element,input}`. Value, disabled and required options; labelled error status, invalid-state reset on input. |
| `select(key, options, onChange, disabled?)` | Up to 100 unique value/label entries. Host supplies localized option text. |
| `boolean('checkbox' or 'switch', checked, onChange, disabled?)` | Labelled native checkbox or switch semantics. |
| `radio(options, value, onChange, disabled?)` | Labelled fieldset, bounded unique options and browser radio keyboard behavior. |
| `card(key, children, role?)`, `badge(text)` | Governed card container or badge content. |
| `menu(items)` | Label/action/disabled entries; arrows, Home/End, Escape, outside click and focus departure handling. |
| `tabs(items)` | Registered button keys plus content and optional disabled state; roving selection, Home/End and directional RTL arrows. |
| `accordion(content)` | Toggle with expanded state and owned panel relationship. |
| `tooltip(message)` | Focus/hover/click visibility and Escape dismissal. |
| `modal('dialog' or 'drawer', content, confirm?)` | Owned modal with launcher focus return, cancel/close and optional async acknowledgement. A rejected confirmation remains open and reports failure. |
| `form(children, submit)` | Token-based responsive grid, required-field checks and `FormData` callback; rejection retains inputs. |
| `state('loading' or 'splash' or 'empty' or 'error', retry?)` | Truthful status/alert, progress and optional async retry. |
| `feedback(message, error?)` | Explicitly dismissible inline toast/snackbar presentation; host owns placement and delivery. |
| `code(source, copy?)` | Literal selectable code with bounded lexical emphasis and asynchronous copy status. Default copy uses Clipboard API. |
| `preview(content)` | Host-created, authorized element preview. |
| `asyncRegion(key, scope, load, render)` | Returns `{element,load,dispose}`; loading clears previous data, aborts older work and ignores late/disposed results. Keys are `card` or `preview`. |
| `countdown(deadline, options?)` | Absolute epoch-millisecond deadline; returns `{element,tick,dispose}`. Optional clock and once-only finish callback. |

Append returned elements to the owned slot. Each governed control key is single-instance per factory except documented button suffixes, which must match `-[a-z0-9_-]{1,100}`. Repeated catalogues and menu compositions need distinct host placement/identity review; this is not a dynamic unlimited form-field generator. IDs and `data-cy` values come from approved bindings; a mismatched primitive or duplicate ID fails.

## Flutter API

Import `package:flutter_core/component_catalogue.dart` or the optional `package:primecare_ui/component_catalogue.dart` entry. Load the same metadata JSON through the host asset/configuration mechanism and call `CatalogueLabels.fromMetadata(decoded, locale)`. The host must declare/package that asset and approve its own source bindings. Do not load the large legacy widget barrel just to use this catalogue.

Create `PrimeComponentKit(labels, scope)` under the existing B06 `ThemeData` and `Directionality`. The kit exposes `button`, `field`, `select`, `boolean`, `radio`, `card`, `badge`, `accordion`, `menu`, `tooltip`, `tabs`, `form`, `state`, `feedback` and `preview`. Required arguments are visible in the typed source; controllers, selection values and persistence belong to the host. `form` requires a `GlobalKey<FormState>`, fields, async submit, and finite token-derived `minColumnWidth`/`gap`. `tabs` requires registered tab keys, matching child widgets and finite positive height. Native menu/tab behavior follows Material widgets; this is functional equivalence, not identical web rendering or every web option.

Standalone widgets:

- `PrimeCatalogueAction`: labels/scope/control, optional action, disabled/busy/pressed state, suffix and operation key. Replacing scope/control/operation key invalidates pending status updates.
- `PrimeCatalogueRadio` / `PrimeCatalogueSwitch`: registered primitives 18/19, controlled selection and disabled state. Radio uses Flutter `RadioGroup` (CI Flutter 3.41.5).
- `PrimeResponsiveForm`: children and finite token-derived geometry; shared model bounds columns to 1–12.
- `PrimeAsyncBoundary<T>`: scope, future, labels and builder. Scope changes clear old data; failure and null results render registered error/empty states.
- `PrimeCodePreview`: labels/scope/code and optional async copy callback; code changes invalidate old copy status.
- `PrimeCountdown`: labels/scope/deadline, optional clock and finish callback; refreshes on resume and disposes timer/observer.
- `PrimeCatalogueModal`: labels/scope/control (`dialog` or `drawer`), child and optional async approve. Owns its route, preserves failed confirmation and removes only that route when a late acknowledgement arrives beneath a newer route. Focus returns only when the launcher route is current.

Do not reuse a scope across different actors. Native semantics identifiers use the registered test bindings; screen-reader review and device testing are still required. Flutter RadioGroup reference: https://api.flutter.dev/flutter/widgets/RadioGroup-class.html.

## Safety, lifecycle and integration limits

Code highlighting is a bounded, literal lexical helper (32,768 characters maximum), not a complete language grammar. Text is never evaluated, interpreted as HTML or dynamically executed. Preview content is separately created by the caller. Clipboard success is shown only after callback acknowledgement; rejection is localized.

Countdown is client display logic with a sticky zero and once-only expiry per deadline/scope lifecycle. It cannot authorize business deadlines. Server clocks and business enforcement remain the host/service responsibility.

Callbacks must enforce approved permissions, business validation and real server acknowledgement. Required-field UI validation does not replace service validation. Async presentation helpers do not introduce APIs, grants, delivery services or demo-data fallback. Feedback is an inline presentation, not a notification transport.

The old PrimeButton/Card/TextField implementations remain compatibility entries. Existing apps are not migrated automatically. Before activation, finish host/source registration, approved callback/API bindings, governed Cypress/device flows, human EN/FR/ES review, accessibility review and release approval. See the B09 audit for deferred families and intentionally consolidated framework examples.

Rollback: remove the optional host import/mount and dispose the owned slot/widgets. Additive production metadata remains registered-unimplemented; this batch provides no destructive metadata rollback or automatic app-wide cutover.
