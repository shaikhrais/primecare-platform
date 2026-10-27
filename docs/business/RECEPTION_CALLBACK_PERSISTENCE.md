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

The SQL migration is a candidate for reviewed production storage registration.
It is applied only to the named disposable PostgreSQL fixture by this release.
The business endpoint stays closed and no business tool is attached. Before
production activation: register/review storage and native task permissions, wire
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
