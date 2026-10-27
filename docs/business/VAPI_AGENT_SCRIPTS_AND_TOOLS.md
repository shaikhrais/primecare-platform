# PrimeCare saved agent scripts and API dependencies

Eight independent saved assistants cover reception, new enquiry, qualification,
consultation follow-up, proposal follow-up, booking recovery, onboarding and
existing-client follow-up. Each script has a distinct ordered workflow and three
dialogue examples. `scripts/build-vapi-agent-scripts.py` regenerates the catalogue.
No Squad, automatic stage movement, campaign or number rerouting is installed.

Native end-call and a reusable silent voicemail tool are reconciled by pinned
assistant IDs. The adapter inherits the shared bounded transport base. It preserves
the fetched model, inline tools, voice and unrelated settings; refuses unknown
prompts/capabilities and checks readback. Recording, transcript artifact, logging
and packet capture storage are disabled on these assistants. This is not a claim
about retention by every upstream AI provider.

| Agent | Required business capabilities |
|---|---|
| Reception | Service catalogue, verified extension transfer, callback request |
| New enquiry | Lead lookup/create, consent/suppression, callback request |
| Qualification | Lead lookup, service catalogue, qualification update, consent/suppression |
| Consultation | Consultation status, lead lookup, callback request, consent/suppression |
| Proposal | Authorized proposal lookup, follow-up outcome, consent/suppression |
| Booking recovery | Identity, service/availability lookup, exact proposal, independent confirmation, saved status |
| Onboarding | Identity, onboarding status, approved instructions, callback request |
| Retention | Identity, authorized service history, callback/outcome, consent/suppression |

## Existing API connections and limitations

- `POST /v1/vapi/voice/verification` is the deployed dedicated current-call SMS
  function endpoint, registered as API 16565. Its canonical call reader currently
  allows the active original reception assistant only. The eight saved library
  agents must not receive this tool until backend assistant scope is explicitly
  extended and tested. OTP possession alone grants no business-task authority.
- `POST /v1/vapi/voice/tasks` is registered but its deployed boundary returns 503
  for authenticated requests. Do not attach a booking or callback tool to it yet.
  Registered request schemas exist for callback, booking and rescheduling;
  those are request tasks, not confirmed appointments.
- Native client booking routes require an actual authenticated app session.
  Passing Vapi's service credential or fabricating an app session is invalid.
- Existing domain lead schemas do not prove a live, authorized voice lead API.
  No lead write, suppression, proposal, availability or onboarding capability is
  represented as operational just because a schema or metadata row exists.

The production workflow reads candidate registrations from the pinned PostgreSQL
`govt_api_endpoints` table and saves `api-bindings.json`. This is a read-only
inventory, not API activation or runtime proof. A valid connection additionally
requires current call/account binding, endpoint permission checks, tenant scoping,
stable write idempotency, explicit approval and saved-result readback. Missing
bindings stay unavailable in scripts and reports; no placeholder API is published.

## Verification

Run `node --test scripts/test-vapi-agent-library.mjs scripts/test-vapi-admin.mjs`.
The release workflow checks reproducible generation, tests preservation and denied
mutations, updates the eight pinned assistants and independently reads them back.
It creates no calls or messages. Existing number routing is compared before and
after. Readback of configuration is not a successful voice or business-action test.

Live acceptance cases for every role: caller interrupts; unclear speech; wrong
recipient; voicemail; refusal; missing/denied tool; ambiguous lookup; write timeout.
Booking also requires stale-slot, expired approval and duplicate-command checks.
Lead follow-up also requires current consent, suppressed number and stage mismatch
checks before any outbound call. All remain necessary before operational activation.

## Research

- https://docs.vapi.ai/tools/api-request-vs-function
- https://docs.vapi.ai/tools/custom-tools
- https://docs.vapi.ai/tools/default-tools
- https://docs.vapi.ai/tools/voicemail-tool/configure
- https://docs.vapi.ai/api-reference/assistants/update

Function callbacks must return a string result or a flat string error per
`toolCallId`. Use API Request tools only for a real directly compatible endpoint.
Native call controls use native Vapi tools. Update attachments by merging the
complete fetched model, never a hand-written partial replacement.
