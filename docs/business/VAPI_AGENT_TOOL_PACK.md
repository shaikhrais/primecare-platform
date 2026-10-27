# PrimeCare agent and tool pack

Authentication is left unchanged. The eight existing saved assistants receive
version-three role scripts and explicit per-role tool workflows. No duplicate
assistants, campaigns, calls or phone-routing changes are created.

The machine-readable pack is `packages/shared/src/vapi-agent-tool-pack.json`.
It contains 20 capabilities and maps all ten existing Growth CRM stages to a
specialist. This is stage planning; no automatic handoff or dialing is configured.
Lost, suppressed, duplicated and unrequested-contact leads are excluded.

| Agent | Main tools |
|---|---|
| Reception | Approved service information, directory transfer, callback request |
| New enquiry / marketing | Lead lookup/create, contact preferences, follow-up, opt-out, callback |
| Qualification | Lead lookup, next-stage update, contact correction, follow-up, opt-out |
| Consultation | CRM consultation scheduling/outcome, follow-up, opt-out, callback |
| Proposal | Current proposal lookup, follow-up outcome, opt-out, callback |
| Booking recovery | Service/slot-based request, rescheduling request, approved execution, follow-up |
| Onboarding | Client onboarding status, callback request |
| Retention | Authorized service history, follow-up, opt-out, callback |

All agents retain native end-call and silent voicemail tools. Their prompts ask
one question at a time, handle interruptions and missing tools, and distinguish
saved requests/CRM milestones from confirmed clinical bookings or delivered care.

## Implemented native business API adapter

`VapiGrowthToolClient` connects nine tool capabilities to the existing native
Growth APIs: lead lookup, contact preferences, lead creation, stage advancement,
follow-up outcome, do-not-contact, contact correction, and CRM appointment
creation/update. It inherits the bounded transport base. Existing authentication
is supplied by the host; no token, tenant, URL, lead or owner can be selected by
model arguments. Actual Growth service policy and idempotency stay authoritative.
Writes require an independently read saved result, not just an HTTP success.
Readback mismatch/network ambiguity is an uncertain outcome with no blind retry.

Nine model-facing function parameter schemas and per-agent native function
definitions are included. They omit owner/lead/version/operation identifiers,
credentials and destinations; the host binds those independently. These are
client-side/native-host definitions, not saved phone webhook tools.

The adapter requires a host-pinned saved-agent role and native scope. It is not
permission to expose staff endpoints to an anonymous phone caller. The production
workflow reads current registrations and produces an exact per-agent readiness
artifact without changing permissions or creating business records.

## Configuration and operational limits

These are separate states: script saved, tool contract prepared, backend adapter
implemented, tool created in Vapi, assistant attachment, and live acceptance.
The readiness artifact records them honestly. Native call controls are configured.
The native staff adapter and callback/booking request schemas are prepared in
code. The general phone business endpoint is still closed. Service catalogue,
proposal lookup, client onboarding/history and verified transfer destinations
still need their corresponding compatible runtime; partner onboarding is not
client onboarding. Missing capabilities remain unavailable in the scripts.

The release preserves all fetched model fields, inline tools, tuning, voice and
unrelated settings. It upgrades only exact reviewed version-two role scripts;
unexpected edits stop reconciliation. The active 4277 receptionist retains its
current SMS verification instructions and tool. No authentication work is part
of this release.

Sources: https://docs.vapi.ai/tools/api-request-vs-function and
https://docs.vapi.ai/knowledge-base/using-query-tool (complete-model attachment
updates). Tests cover role/stage mappings, registered schemas, private-field
projection, current versions, saved readback, suppression, denial, scope changes,
uncertain writes, native coordination appointments and Vapi preservation.
