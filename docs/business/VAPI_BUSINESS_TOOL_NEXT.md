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
- Eleven native business handlers and the result-returning server composition are
  implemented and tested. Four registered request tools are saved in Vapi but
  remain unattached. The private business host is not yet deployed/mounted.
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
The native pairing path remains separate. Private business actions remain closed.
Receipt: [vapi-authentication-readiness-20261027.json](evidence/vapi-authentication-readiness-20261027.json).
