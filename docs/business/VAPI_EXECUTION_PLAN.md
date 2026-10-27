# Vapi business tool execution plan

Work directly on main. No new branches, campaigns, test calls or SMS are needed
for this engineering checkpoint.

| Order | Task | Current result |
|---|---|---|
| 1 | Review current agents, registrations and authorization | Reviewed against main 63b5a6f9 and production API audit |
| 2 | Connect call possession to a reusable server identity | Identity component and private durable proof implemented; task-core compatibility tested; business authorization still separate |
| 3 | Connect the first real agent business workflow | Callback composition verified; callback storage registered and migrated in production; live approval/API host and staff handling pending |
| 4 | Test denial, expiry, races and duplicates | Identity/unit and real durable-runtime checks pass locally; release workflow verifies native PostgreSQL and deployment |
| 5 | Extend the proven business pattern to remaining roles | Pending first complete operational workflow |
| 6 | Deploy and preserve evidence | Private proof support releases through the existing verification workflow; no claim of live business-task activation |

## Identity component

`VapiVerifiedCallIdentityService` inherits `ScopedServiceBase`. Its host must supply
the canonical Vapi/Twilio call and current unique enrolled contact, plus the actual
verification access policy. It never accepts actor, tenant or proof claims from
tool arguments. It rechecks canonical contact/call, current policy and durable
proof around resolution, then returns a minimal internal subject.

Only an approved Verify check creates a random proof ID in the existing private
phone-keyed Durable Object. The proof expires with the original two-minute
challenge; reads never extend it. Private `possession()` RPC requires the complete
candidate to match and exposes no phone, code, provider verification SID or native
session. Pending, unknown, locked, expired and legacy proof-less rows return null.
The public request/check schema, output and tool attachments remain unchanged.

`DurableVapiCallProofRepository` derives the same SHA-256 phone storage key as the
verification writer. Its namespace is a server-owned binding, never a URL or ID
chosen by the model. `VapiCallTaskIdentityBroker` binds one canonical Vapi call to
one Twilio call and adapts the proof to the existing task-core identity interface.
Its internal authentication-event reference is not an `auth_sessions` token.

No user roles, app sessions, native login tokens or task approvals are created.
No business permission is granted by possession. The current business endpoint
remains closed: its registered contract requires current OTP/passkey app identity
and independent app approval. The new phone-proof compatibility port must not be
mounted there as a substitute without an explicit compatible registration and
approved runtime composition.

## First business workflow dependencies

The registered callback task already specifies reason and a future callback
window, and its `ReceptionAppointmentPorts.requestCallback` now has a concrete candidate
persistence service and callback-only composition. Native PostgreSQL acceptance
passes; this component is not yet a published production callback service. The host must connect a real registered
request service and current authorization, not write arbitrary database rows or
substitute a staff session. A callback result also needs authoritative readback.

Growth APIs are real staff operations. Their session/role and ownership checks
cannot be replaced with a shared Code Admin credential for customer calls.
Proposal, consent/suppression, availability and onboarding tools remain dependent
on their own exact business policies and role-scoped runtime bindings. A partner
onboarding endpoint is not client onboarding. A Growth appointment is not a
confirmed clinical booking.

The first live task must include: trusted call/account binding, current registered
permission, exact summary, independent approval, durable once-only execution,
underlying ownership/version rechecks and saved-result readback. Do not attach
business tools before those checks pass.

## Validation

- Eight identity/broker cases: current subject; malformed/expired/future proofs;
  missing permission; ended/changed call/contact/user/tenant/version; concurrent
  revocation; no positive cache; private storage key; no task approval bypass.
- Real Miniflare/SQLite Durable Object: approved-only proof, private RPC, restart
  persistence, foreign/version denial, expiry, send/check quota and idempotency.
- Strict TypeScript checks include Cloudflare Worker runtime types. The broad
  communications workflow previously omitted them. Its host socket response port
  now omits the platform-specific webSocket property before declaring its own
  unknown boundary, preserving the original abstract host contract.
- Existing runtime and composition tests cover socket cleanup and signed/native
  adapter separation. Full operational business acceptance remains pending.

Sources reviewed: Cloudflare Durable Object rules and RPC guidance at
https://developers.cloudflare.com/durable-objects/best-practices/rules-of-durable-objects/
and Vapi server authentication at
https://docs.vapi.ai/server-url/server-authentication.

## Deployed checkpoint

Source `5666ccc6127345f6955d4fd20f87db27e0b1683c` passed the verification
release (run 40491531919). The private proof support is deployed; anonymous and
unknown-call denial probes passed. The owner-call job was skipped. No real SMS
or call was sent. Eligible verified contacts remain zero, so no live caller proof
or business action is claimed. The component and adapter tests cover 36 cases,
plus the real durable-runtime check. All 12 communications CI jobs passed (run
40491531928), including the repaired strict service type check.

The older general voice deployment configuration check remains incomplete:
TWILIO_APPLICATION_SID, VOICE_MODEL and VOICE_ORIGIN are absent from that workflow's
configuration. This is separate from the successful dedicated Vapi verification
Worker release. The existing reviewed gateway amendment gate also remains failed.
See the evidence receipt for the full CI snapshot; this checkpoint does not claim
all repository checks pass.

## Callback checkpoint

Callback source `96ddebb67120602160cd2a06377393a8bd8d2847` passed run
40496531391: 9 unit/task cases, 11 native PostgreSQL scenario groups and strict
service types. The actual callback-only composition verifies app approval,
claimed execution, the exact approved digest, once-only save and independent
readback. Expiry is rechecked across awaited permissions and before commit.

Candidate migration and implementation are saved on main. No production schema
migration, public callback host, staff fulfilment route or Vapi business-tool
attachment was performed. No live caller/app session or human callback is claimed.
See [callback persistence](RECEPTION_CALLBACK_PERSISTENCE.md) and its evidence.

## Production callback storage checkpoint

Source `781ba55e0aa6c3f12cb694a003477baaf0bba0e8` passed workflow
40505751914: five metadata registration tests, four native schema tests, nine
unit/task checks and eleven callback PostgreSQL scenario groups. Production
registration independently read back table metadata ID 1365 and nine columns.
The direct database dry run rolled back, the migration created the private empty
callback table, and a separate pooled read-only connection verified the full
schema and owner-only access. Existing task/approval/contact structures matched
the tested reference and were preserved. No grants, content, calls or SMS were
created. This checkpoint enables storage only; public callback tools remain off.

Next: live API/approval host composition, current native permission enforcement,
staff pickup/fulfilment and complete caller/app acceptance. See
[production storage](CALLBACK_STORAGE_PRODUCTION.md) and its evidence receipt.


### Callback approval HTTP composition — October 27, 2026

Implemented `NativeVoiceTaskHttpAdapter` and
`createPostgresReceptionCallbackHttpServices`: the real callback confirmation
service can now serve the two existing registered app approval contracts without
installing unrelated placeholder services. The inherited transport checks retain
native bearer identity, exact endpoint permission, bounded registered schemas,
approved origins and identity/grant rechecks before invocation and response.

Local verification: 22 native HTTP tests passed, one disposable PostgreSQL test
skipped because no test database was supplied; declaration and callback source
strict TypeScript checks passed. This is source composition evidence, not a live
app approval acceptance result. Gateway mounting, production current grants,
call-to-app identity linkage and staff handling are still pending. The business
Vapi tool remains disabled.
