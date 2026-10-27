# Remaining Vapi business activation

Updated 2026-10-27. Work is saved on main; authentication is unchanged and excluded
from this work. The previous authentication-first implementation target is
superseded by the user's instruction to prepare business tools and agents.

Eight v4 saved agents and their public Query attachment have verified provider
readbacks and a successful public-only Vapi chat probe. Four registered task
request tools are saved but unattached. Eleven native business handlers are
implemented; client owner read contracts are registered in production. See
[VAPI_AGENT_TOOL_PACK.md](VAPI_AGENT_TOOL_PACK.md) for IDs and receipts.

The result-returning server protocol now has an executable composition root,
`createVapiBusinessRuntime`, combining the existing Growth and client adapters.
It consumes existing authenticated transport, current context, access policy and
durable journal ports. It changes no authentication code and mounts no new route.
Its integration suite exercises actual native adapters behind the Vapi protocol,
including saved readback/replay, uncertain responses, denied access, context
rebinding, role isolation and private-field omission.

Remaining production connections:

- A registered host must supply those existing ports and mount the composed
  responder. Until then, private business tools remain unattached and cannot be
  reported as working by phone. Do not substitute an administrator session.
- Proposal lookup needs the approved client proposal source. A tenant marketing
  contribution proposal is not a client quote.
- Human transfer needs an approved directory destination. The owner's personal
  test number is not an approved transfer destination.

No call, campaign, SMS, phone routing or authentication change is part of this
checkpoint. Automated tests use isolated in-memory API/journal fixtures only;
production journal durability and deployed private execution remain unverified.

## Requested public-to-client service flow

The owner clarified the desired journey on 2026-10-27:

1. Public callers can ask approved company/service questions without signing in.
   Opening hours and appointment slots must come from their authoritative sources;
   the public enquiry-category document does not establish either.
2. A new client can request registration and an appointment. Registration needs
   the actual approved account/profile service, contact verification and consent;
   creating a CRM enquiry is not creating a usable client account. Booking needs
   authoritative service, eligibility, live slots, current versions, exact-detail
   confirmation and saved-result readback. A request is not a confirmed booking.
3. An existing client can request a dedicated current-call verification code.
   The existing backend resolves the unique registered contact and sends to that
   contact; caller/model input cannot replace the destination. The check tool
   validates the code without exposing a stored code, hash or login secret.
4. After successful verification, resolve the current client/tenant permissions.
   Phone possession does not grant an administrator session or authorize every
   action. Read/change only that client's permitted appointments and records.
5. Client service can include appointment changes, client-requested notes and
   questions for a qualified health professional. A client-requested note is not a
   clinician-authored assessment. Routing a question is not providing diagnosis
   or proving that an expert has answered. Save/send only through the approved
   scoped communications and client APIs, with readback and status tracking.
6. On unavailable tools or failed verification, explain the limitation and offer
   the approved contact/app path; never invent an account, appointment or reply.

This is the target flow, not a statement that all steps are currently deployed.
Existing authentication/verification implementation is preserved. Availability,
new-client registration, client-note and expert-routing tool bindings must be
verified separately; the previous 20-capability pack does not include complete
implementations of these newly clarified steps.

## Verified saved-agent conversations

Workflow 40537934027 at source `dbb9df30c5ae0bb66f7dea9817397e55e3714f60`
passed all 16 live synthetic chats: eight actual public Query invocations/results
and eight clear unavailable-action responses. Each saved role script and allowed
tool configuration was read before and after its checks. No private business
action, phone call, SMS or authentication change occurred. Evidence:
[evidence/vapi-agent-conversations-20261027.json](evidence/vapi-agent-conversations-20261027.json).
The focused local suite also passed 63 checks. These checks verify the currently
connected agent behavior, not the unimplemented service-flow steps above.
