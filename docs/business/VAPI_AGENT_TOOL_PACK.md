# PrimeCare agents and business tools

Authentication is now included by the owner. All eight saved agents and the active 4277
receptionist have version-four scripts, native end-call, silent voicemail and the
public-information Query tool. They now also have the existing current-call OTP
verification tool and exact instructions. Saved configuration and a real public-only Vapi
chat/query/result/readback test passed. No phone calls, SMS or customer-record
writes were performed for this release.

| Capability | Verified state |
|---|---|
| Eight role scripts and active receptionist | Version 4 saved and independently read back |
| Current-call OTP | Backend deployed for the original receptionist and eight saved IDs; tool/instructions attached and read back; real caller/code acceptance pending |
| Account phone enrollment | Native API/gateway redeployed; fresh CORS/session/permission/revocation checks passed; no real enrollment SMS sent |
| Public service enquiry information | Native Query attached; source file bytes/hash and actual retrieval verified |
| Callback, booking, rescheduling, execution | Four API Request tools saved/read back; not attached or activated |
| Native Growth tools | Nine business API adapters implemented and tested |
| Client history and onboarding facts | Two owner-only read adapters; existing API contracts registered in production |
| Result-returning function protocol | Server adapter/runner implemented and tested; private host not mounted |
| Proposals | Needs an approved current proposal source |
| Human transfer | Needs an approved directory/transfer destination |

The business/call tool pack covers 20 capabilities and all ten existing CRM
stages. Current-call OTP is managed separately. Stage
selection is a plan, not automatic dialing or a stage update. Lost, suppressed,
duplicated and unrequested-contact leads are excluded. CRM milestones and
coordination appointments do not certify clinical care.

## Agent tool selections

| Agent | Main capabilities |
|---|---|
| Reception | Public information, approved directory transfer, callback request |
| New enquiry / marketing | Lead lookup/create, contact preferences, follow-up, opt-out, callback |
| Qualification | Lead lookup, next-stage update, contact correction, follow-up, opt-out |
| Consultation | CRM consultation scheduling/outcome, follow-up, opt-out, callback |
| Proposal | Approved proposal lookup, follow-up, opt-out, callback |
| Booking recovery | Exact request/rescheduling, approved execution, follow-up |
| Onboarding | Owned profile, consent and service-authorization facts, callback |
| Retention | Owned visit status records, follow-up, opt-out, callback |

Every agent also has public enquiry information and call controls. Private
capabilities in this table remain conditional on their verified host and actual
attachments; the scripts never claim that an absent or failed action succeeded.

## Actual Vapi resources

The public Query tool is `3c5ee8ee-8f7c-4adf-a90f-cba2809ed43b`; its managed source
file is `40b4d2df-67a4-402c-814b-4cc67592942c`. It covers the existing public
PSW/home-care enquiry categories. It contains no invented prices, availability,
service-area guarantees or clinical advice. Uploaded bytes are independently read
and hashed before the tool is accepted. Existing file/tool edits are preserved.

| Saved request tool | Vapi ID |
|---|---|
| Callback request | `789aa291-15de-4916-a875-6bda7825a169` |
| Booking request | `d99bca0b-17e1-4c58-b100-2989e548282f` |
| Rescheduling request | `0ef9c437-7c11-4ae3-9dcb-7515bd4c483d` |
| Execute approved request | `52c105a9-a0f9-4547-936a-7cfdbec3b7da` |

These four resources reference the existing credential without changing it.
Action/task fields and the provider call header are server-resolved. They target
the existing registered request endpoint, which remains closed for private
business activation. A saved resource is not a successful business action.

## Business implementation

`VapiGrowthToolClient` inherits the bounded transport base. It implements lead
lookup/contact preference, enquiry creation, current next-stage advancement,
actual call outcome, suppression, contact correction and CRM appointment
creation/update. Agent, lead, owner and appointment bindings stay in host context.
Every write uses current backend versions and a stable idempotency key, then
independently reads and matches the saved result. Uncertain writes never retry
blindly; a successful response alone is not saved-result evidence.

`VapiClientToolClient` reads only the existing owner APIs. It omits names,
addresses, signatures and clinical notes. Onboarding returns actual profile,
consent and service-authorization facts; overall completion is explicitly unknown.
Visit statuses are operational records, not a claim that care was delivered.

Production registrations now include owner-only API 16431 (profile), 16566
(visits), 16567 (consents) and 16568 (service authorizations). The three missing
contracts and client-profile links were restored additively, with no role grants,
authentication changes, persistent schema changes or patient data writes.

Vapi client-side tools cannot return results to the model. Consequently,
`VapiBusinessFunctionAdapter` provides the actual server protocol around
`createVapiBusinessToolRunner`: bounded batches/arguments/results, original
per-tool-call IDs, flat string results/errors, current host context/per-tool
policy, durable replay and stable operation IDs. It requires existing trusted
context and journal ports and mounts no unregistered URL. The private function
host remains unmounted while that boundary is deferred; native handlers are
not falsely presented as attached phone tools.

## Verification and evidence

Runtime source `838f8f6e1f8342589da1e2fcd7e1e7b63ba51e26`, workflow 40527152119:
56 targeted checks passed, eight agent and active receptionist readbacks passed,
and chat `81d70341-ac5e-4200-943e-2d80614acb22` invoked the Query tool, received
its result, returned the approved categories and invented no price.

Metadata source `2108e39958b9f0b37fc5bbde5f8302d48ecbd32b`, workflow 40529094325:
six native PostgreSQL metadata tests plus three read-adapter checks passed;
production dry run, apply and separate read-only verification passed.

Receipts: `evidence/vapi-business-runtime-20261027.json`. Complete per-capability
state, schemas, registrations, saved IDs and stage mappings:
`evidence/vapi-agent-tools-prepared-20261027.json`.

Current primary references:
- https://docs.vapi.ai/knowledge-base/using-query-tool
- https://docs.vapi.ai/api-reference/files/create
- https://docs.vapi.ai/tools/api-request/configuration
- https://docs.vapi.ai/tools/client-side-websdk
- https://docs.vapi.ai/tools/custom-tools

Authentication release: workflow 40546849680, source `f873b360fd8ab41b5a8e6ebce2ee990c6c11d125`.
Enrollment recovery: workflow 40547521771, source `f31a704087d76a897aa9fd8bff9833da3f7eea8b`.
Current evidence: `evidence/vapi-agent-authentication-20261027.json` and
`evidence/voice-contact-native-deployment-20261027.json`. Enrollment status checks
used a temporary QA account/session/tenant and verified cleanup. Zero account
phones were enrolled at the audit; caller-code acceptance remains pending.
