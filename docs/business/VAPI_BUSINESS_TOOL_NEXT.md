# PrimeCare public-to-client voice flow and remaining activation

Updated 2026-10-27. All changes are on main. The owner explicitly included
authentication in the latest request.

## Current verified state

- Eight v4 saved agents and the active 4277 receptionist have native call ending,
  silent voicemail and public-information Query. Sixteen synthetic live chats
  verified public retrieval and honest unavailable-action responses.
- Current-call OTP backend support is deployed for the original receptionist and
  the exact eight saved IDs. The existing verification tool and exact instructions
  are attached and independently read back. Unknown calls and anonymous requests
  are denied. Call mapping is stable across two provider reads; identity grants
  no native administrator session or business-action approval.
- Native first-time account-phone enrollment was redeployed through its three
  registered gateway routes. Fresh source/CORS/no-store checks passed. A temporary
  authorized QA session read status; permission removal and session revocation
  denied access. QA account/session/tenant cleanup passed. No real SMS was sent.
- The owner-only client-information function is deployed and attached to all
  eight saved agents plus the original receptionist. After current-call OTP it
  reads bounded appointments, visit statuses or onboarding facts from the verified
  caller's own client profile/tenant. No native session is created.
- Sixteen native business handlers and the generic result-returning server
  composition are implemented and tested. Four registered request tools remain
  unattached. The separate private business-write responder is not yet mounted.
- Zero real account phones were enrolled at the production audit. A real account
  phone must be enrolled before a real caller can complete OTP acceptance.

## Requested service journey

1. Public callers can ask approved company/service questions without signing in.
   Hours, prices and slots must come from approved current sources. The current
   public source establishes PSW/home-care enquiry categories, not availability.
2. New-client registration must use an approved client account/profile service,
   contact verification and consent, checking for duplicates. A CRM enquiry is
   not an active client account. The current `/register` implementation is a
   privileged account-management operation requiring a password; do not expose
   it as public voice registration or ask callers to speak passwords.
3. Existing clients can request a dedicated verification text after consent. The
   backend matches the unique registered account phone against the canonical
   live caller. It never accepts a model-selected replacement destination. The
   check tool validates only the six digits from that call's verification text.
4. Successful OTP resolves a current call-scoped subject. Every appointment or
   support action must still enforce current client/tenant ownership and policy.
   Expired proofs, changed contacts, ambiguous accounts and uncertain checks fail.
5. Booking needs authoritative service/eligibility/slot data, current versions,
   exact-detail confirmation and saved-result readback. A pending request or CRM
   coordination appointment is not a confirmed service appointment.
6. Client-requested notes and questions to health professionals need approved
   scoped records/conversations and recipients. A submitted question is not an
   expert reply or clinician-authored assessment. Do not invent a recipient.
7. On missing tools or failed verification, explain the limitation and offer the
   approved contact/app path. Never claim an account, appointment or reply exists
   without its saved result.

## Remaining real dependencies

- First real account-phone enrollment and real caller OTP acceptance.
- Deploy the private business responder with current verified subject/native
  context, per-tool authorization and durable execution journal; do not borrow
  an administrator session or create a permissive policy.
- Authoritative availability and approved new-client registration bindings.
- Client-note and expert-question routing bindings to actual authorized records.
- Approved client proposal source and human-transfer directory destination.

The alternative native pre-AI app-pairing path still has its own dependencies;
it is reported separately and is not treated as a prerequisite for the deployed
spoken-SMS path. Neither configuration readback nor an anonymous denial proves a
real code was accepted or an appointment was saved.

## Evidence

- [Eight-agent conversations](evidence/vapi-agent-conversations-20261027.json):
  workflow 40537934027; 16 live synthetic chats; private actions not live.
- [OTP deployment](evidence/vapi-agent-authentication-20261027.json): workflow
  40546849680; source `f873b360fd8ab41b5a8e6ebce2ee990c6c11d125`; 53 local
  auth checks and durable runtime tests passed; real caller acceptance pending.
- [Enrollment recovery](evidence/voice-contact-native-deployment-20261027.json):
  workflow 40547521771; source `f31a704087d76a897aa9fd8bff9833da3f7eea8b`;
  fresh gateway boundary, authorized status, role denial, revocation and cleanup.
- [Business tool pack](VAPI_AGENT_TOOL_PACK.md): saved tool IDs, owner API
  registrations, handler coverage and actual attachment states.

Fresh production readback at workflow 40548592246 independently confirmed all
eight saved OTP configurations, original receptionist, phone routing and recovered
enrollment boundary. The direct spoken-SMS path has only two remaining identity
acceptance blockers: zero enrolled account phones and no real caller OTP test.
The native pairing path remains separate. Private business writes remain closed; the protected client-information read
function is now deployed.
Receipt: [vapi-authentication-readiness-20261027.json](evidence/vapi-authentication-readiness-20261027.json).

## Protected client-information release

Contract API 16569 was independently registered/read back before runtime release.
Source `5243abd88bfd308714bb8cf401f3a714e4078dbe`, workflow 40551796137,
passed the 61 focused checks, durable Worker checks, real disposable PostgreSQL
owner/tenant tests and production schema preflight. The live endpoint denied an
unverified caller. Tool `6a74a2af-7950-4a6d-b0eb-3082c6ad10a8` was created/read
back and attached to all nine target assistants. No phone routing, real SMS or
customer records were changed. Real caller OTP/client-read acceptance remains
pending because no account phone is enrolled.

Receipt: [vapi-client-information-20261027.json](evidence/vapi-client-information-20261027.json).
The native-write host must never substitute its administrator session for a
verified caller. Account creation, booking changes, notes and expert messages are
not implemented by this read-only function.

Post-release review 40553600445 re-read all 16 synthetic live chats and all eight
saved configurations successfully. The checker was corrected for a negated
sentence about an unsaved do-not-contact preference; no assistant prompt was
weakened and no new chat, call, SMS or business write was created for the review.
Receipt: [verified conversation review](evidence/vapi-client-information-conversations-verified-20261027.json).

## Optional support write tools built

Two additional native business functions are implemented:
`primecare_client_support_question` and `primecare_client_service_note`.
They reuse registered conversation API 710, require host-bound account/tenant/
conversation/approved recipient and independent confirmation, and verify the
saved message. Role selections are in `vapi-client-support-tools.json`.
Eight focused scenarios cover saved readback/replay, denied/cross-tenant scope,
model overrides, version races, lost responses and complete Vapi protocol replay.
These two handlers are not yet attached to phone agents: the native write host
and actual recipient/conversation binding are still required. They create no
clinical chart note or expert reply.

## Native request tools built

`primecare_client_booking_request_create`,
`primecare_client_booking_request_status` and
`primecare_client_booking_request_cancel` now reuse the existing client-owned
request lifecycle. The host binds the approved service/clinic time zone, current
native account and optional target request; writes require independent
confirmation. Saved create/cancel receipts are independently read back, and an
uncertain send never retries automatically. A pending request is not an actual
confirmed appointment, and cancelling it does not cancel a service booking.

Together with the two support-message functions, five new native tools are built
and composed into the shared server runner. The phone write host remains
unmounted; these five tools are not attached to phone assistants yet. Actual
account registration, bookable availability, service appointment changes and
approved expert/transfer routing remain separate unfinished dependencies.

The five-handler batch passed 47 local checks and CI run 40557983956. Booking
request contracts 16570 (create), 16571 (item status) and 16572 (pending cancel)
were independently registered/read back in run 40556734285 with no role grants,
schema changes, authentication changes or customer writes. Receipt:
[client action tools](evidence/vapi-client-action-tools-20261027.json).

## Durable business execution journal built

The shared runtime now accepts private transactional Durable Object storage via
`durableStorage`, or an existing explicit `journal` port, never both.
`DurableVapiBusinessJournal` commits a pending claim before business execution,
keeps unknown outcomes pending across restarts and replays only a bounded,
immutable completed result with a matching argument digest. Keys isolate the
canonical call, native business scope and provider tool-call ID. No automatic
lease expiry or retry can repeat an uncertain write. The host must preserve
receipts for the full period in which it accepts a call or replay.

A real local workerd Durable Object test passed twenty concurrent storage claims,
pending/completed restart survival, conflicting arguments, immutable completion,
size/input limits and call/scope/tool isolation. A complete Vapi server-protocol
fixture then processed twenty concurrent duplicate requests with exactly one
synthetic mutation, and replayed the same saved result after Worker restart.
The existing 47 business-handler checks also passed locally and in CI run
40561936690 (job 122392980675), together with the durable runtime checks.
The initial dependency pin was corrected to the exact locally verified version
before the successful run. Receipt: [durable journal](evidence/vapi-business-journal-20261027.json).

This implements the durable journal dependency, not the remaining private phone
write host or its current authorization and independent confirmation bindings.
No new phone tool was attached, no production storage was created and no real
call, SMS or customer write was performed by this batch.


## Concrete callback tool host

`createPostgresVapiCallbackHost` now composes the existing registered API Request
transport with dedicated provider authentication, exact API 16534/manifest checks,
canonical Vapi/Twilio call lookup, private current-call OTP identity, current
PostgreSQL callback role/screen policy, durable request claims, independent native
app confirmation, real callback persistence and independent saved readback.
Only `reception.callback.request` is allowed; booking/rescheduling are rejected.
The host creates no native session and accepts no model-selected actor, phone,
tenant or approval. It does not mount the endpoint or attach tools by construction.

The PostgreSQL acceptance suite now exercises the complete provider request →
proposal → native app preview/approval → callback save/readback flow, host
reconstruction with durable claims, duplicate execution, denied metadata/current
permissions and missing proof. Production activation still needs this host wired
to its private call/proof/storage bindings and the registered app approval routes.
No production deployment, provider attachment, customer write, call or SMS was
performed by this implementation batch.

Final callback host source `131be2d51355bda481c6e6c4f7d995b46a64aef9` passed CI run 40564830816 (job 122403197479): 23 focused checks, 21 real PostgreSQL scenario groups and strict TypeScript. Receipt: [callback host](evidence/vapi-callback-host-20261027.json). The broader gateway review and password-browser dependency failures remain separate; this is not a claim that all repository checks pass.


## Callback activation batch in progress

The production Worker, private proof consumer, durable call journal, exact native
approval gateway mounts and configuration-preserving callback attachments are
implemented. Local focused/Worker checks passed. Activation requires successful
CI, production schema/metadata preflight, private binding readback and HTTP denial
checks. No deployment or attachment is claimed until its receipt is verified.
Pending booking requests and support-message tools still require their own phone
write bindings and independent confirmation; this callback host never borrows a
native administrator session to run them. These remain separate acceptance items.
