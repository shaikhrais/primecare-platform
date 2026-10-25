# Native SMS link runtime — 25 October 2026

The three registered owner API contracts now have an internal runtime boundary:
`NativeSmsLinkService` extends `ScopedServiceBase`, and the request-scoped
`NativeSmsLinkChannel` extends `CommunicationChannelBase`. The bounded HTTP
adapter invokes this channel and uses build-time compiled validators from the
exact registered request/response schemas. It does not mount a route.

Status and bind require current scoped conversation access and membership. The
PostgreSQL repository independently checks current session, active user/tenant,
conversation membership and mandatory policy in its transaction. Status accepts
an older but valid native session; bind and revoke still require a session
created within five minutes. Only an authorized absence becomes `linked:false`;
a database or permission failure remains an error. STOP/revoked/stale verified
contact links cannot appear as active status.

HTTP requires bearer credentials and exact approved origins. Cookie-only calls
cannot authorize mutations. Bodies are streamed into a bounded allocation,
validated against schemas with additional properties disabled, and cannot
select actor, tenant, phone, provider or session. The host must supply real
current-session and exact registered API permission checks; no default grants
are installed. The same native actor/session and API permission are rechecked
before body parsing, immediately before invocation, and before releasing output.
A failed final check never retries a mutation that may already have committed.

Responses project only link ID, version, conversation ID and channel. Internal
phone/account/session data is omitted, and repository output from another owner,
tenant, conversation or provider fails closed. Revoke uses persisted conversation
scope inside the repository transaction rather than client-selected scope.

Local verification: 37 focused inbound/link/AI/native-boundary tests passed,
strict TypeScript checking passed, and the generated three-contract validators
reproduced exactly. CI includes these tests plus native PostgreSQL status cases:
authorized absence, cross-owner/session/policy denial, linked readback, valid
older-session status, and absence after committed STOP. PostgreSQL results must
be read from the actual CI run before being reported as passing.

Remaining: native host composition, registered endpoint policy/action bindings,
owner access verification, worker deployment, durable inbound dispatcher and
original-link-bound outbox composition, then live SMS receive/reply/delivery
readback. No runtime/API mount, role grant, provider write, phone routing change
or live messaging activation was performed by this checkpoint.
