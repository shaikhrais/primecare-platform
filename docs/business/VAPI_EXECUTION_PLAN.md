# Vapi business tool execution plan

Work directly on main. No new branches, campaigns, test calls or SMS are needed
for this engineering checkpoint.

| Order | Task | Current result |
|---|---|---|
| 1 | Review current agents, registrations and authorization | Reviewed against main 63b5a6f9 and production API audit |
| 2 | Connect call possession to a reusable server identity | Identity component and private durable proof implemented; task-core compatibility tested; business authorization still separate |
| 3 | Connect the first real agent business workflow | Pending: approved runtime policy, independent confirmation and actual request-service composition |
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
window, but its `ReceptionAppointmentPorts.requestCallback` is an injected port,
not a live persisted callback service. The host must connect a real registered
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
