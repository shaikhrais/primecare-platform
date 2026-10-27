# Approved reception callback persistence

Implements the existing `reception.callback.request` business port. No new public
route, phone routing, role grant, agent attachment or provider traffic is created.

`ReceptionCallbackRequestService` inherits `ScopedServiceBase`, reuses the exact
callback validator used by the voice task, and accepts only the stable
`voice-task:<intent UUID>` execution key. Actor and tenant belong to trusted host
context. Input contains reason and a future UTC window; it cannot contain a
destination phone, assignee, actor or tenant.

The native repository requires an existing callback intent in executing state,
matching actor/tenant/arguments, a consumed matching app confirmation, an active
user/tenant and a current enrolled contact. It locks those rows while persisting,
calls the host's current task policy before and after the write, and retains one
request per intent. Concurrent same-command retries return that request; changed
arguments fail. The saved request refers to the contact version, not a copied
phone number or model-selected recipient.

The service independently reads the row after commit and verifies the exact
request/status before the outer voice task may finish. Write or readback failure
is an uncertain outcome to reconcile, never permission to create another request.
The task core separately consumes approval once, claims execution once and tracks
unknown outcomes. A saved status of `requested` does not promise staff assignment,
a completed call, a scheduled callback or an appointment.

## Production boundary

Callback storage was registered and migrated in production; see
`CALLBACK_STORAGE_PRODUCTION.md` and its independently verified receipts.
The business endpoint stays closed and no business tool is attached. Before
production activation: verify current native task permissions, wire
the actual identity/approval host, deploy the callback service, add operational
staff pickup/read access, then verify the real call/app/API/database path. Never
replace app approval with a transcript or a model-provided consent flag.

No live callback request or verified user phone is claimed by fixture acceptance.

## Tests

`node --test scripts/test-reception-callback.mjs scripts/test-communication-voice-tasks.mjs`
checks the typed port, schema restrictions, permission denial, independent
readback, one-use task approval and duplicate execution.

`scripts/test-reception-callback-postgres.mjs` uses PostgreSQL 16 and the real task,
confirmation, callback service and repository. It verifies no write before app
approval, saved result and independent database readback, replay, cross-user and
cross-tenant denial, permission/contact revocation, concurrent execution, rejection
of a claimed task without consumed approval and transaction rollback on storage
failure. It refuses production credentials and nonlocal/nonfixture databases.

The fixture's policy and identity are explicit synthetic host ports. Passing it
does not verify a live app session, provider call, production policy registration
or staff callback fulfilment.

`createPostgresReceptionCallbackServices` connects the real task service, app
confirmation service and callback repository as one callback-only composition.
Its host must supply current identity and policy; it mounts no route. Native
acceptance uses this composition. The repository rehashes the complete approved
intent before accepting a write, so modified details cannot reuse an old digest.

## Vapi proof to native app approval

The previous `vapi-proof:<proof UUID>` reference was rejected by the native
confirmation service's bounded reference validator. New proposals bind the
canonical Vapi call and original SMS proof in an opaque underscore-delimited
reference. Existing intents are never mutated to bypass their approved digest.

`VapiAppTaskIdentityBroker` accepts only a host-authenticated actor and a stored
intent ID. It checks owned callback v1 intent, current proposed state, expiry and
full digest before reading any provider proof. It then checks the original live
call/proof/current contact through `VapiVerifiedCallIdentityService`, rereads the
intent and rechecks identity. No app/model-supplied call ID, phone, proof or
native-session override is accepted. A replaced or expired proof requires a fresh
proposal. `VapiCallbackAppApprovalService` and
`createPostgresVapiCallbackApprovalHttpAdapter` compose these checks with the real
PostgreSQL app confirmation service and the inherited native HTTP boundary.

Disposable PostgreSQL acceptance now also exercises the Vapi-bound proposal,
native HTTP preview and explicit approval, approval consumption, exactly one
saved callback, independent SQL readback, invalid digest, foreign owner,
unauthenticated/denied endpoint, revoked proof and modified intent. Provider
calls/proofs/native sessions are explicit fixture ports, not live login evidence.
The production identity readiness report separately inspects the existing task
preview/approve registration and linked-screen grant counts without modifying
permissions or user data. Live host mounting and staff fulfilment remain pending.

## Verified approval permissions

Source `3bd1e93ffbb208cb71212b05fa88431c8e4bf320` passed 18 native callback
scenario groups, nine native metadata tests, three focused callback policy tests
and strict TypeScript. Workflow 40511738975 then dry-ran, applied and independently
verified the exact approval metadata. Four already eligible own-contact roles
have eight API grants across eight screen links; each existing preview/approve
endpoint independently reports four usable grants. Role-screen rights, business
records and provider resources were untouched. Evidence is in
`evidence/callback-approval-access-20261027.json`.

The concrete native approval host now uses PostgreSQL `auth_sessions`, active
user/tenant membership, exact endpoint/screen grants and callback-only business
policy. Its routes still require operational mounting and acceptance. The
readiness snapshot still finds zero verified voice contacts. No live app
approval, callback staff fulfilment or Vapi business-tool activation is claimed.
