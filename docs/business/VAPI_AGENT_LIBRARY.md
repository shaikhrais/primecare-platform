# PrimeCare Vapi agent library

Created and independently read back from Vapi on 2026-10-26. These are independent saved assistants, not a Squad. No call campaign or automatic handoff has been configured.

Open Code Admin → Voice AI · Vapi inside platform administration. The screen shows the live assistant/tool inventory, eight workflow templates, default scripts and missing business capabilities. “Use default script” fills the agent creation form; saving is explicit. Existing assistant names disable the corresponding template creation action. Reusable tools can only be created/attached from the server-approved capability catalogue; the catalogue currently has no enabled business capabilities.

| Agent | Stage | Saved assistant ID | Required business capabilities |
|---|---|---|---|
| PrimeCare Reception Desk | Reception | 9ba3014c-cfaa-4607-997c-b5347212be54 | Service catalogue; Extension / reception transfer; Callback request |
| PrimeCare New Enquiry | New enquiry | 8d9123e9-ac5b-4b2c-abbf-0447b3fbc5ff | Lead lookup; Consent / suppression check; Lead creation; Callback request |
| PrimeCare Lead Qualification | Qualification | 07b2e8c6-d4a9-4284-bb2b-ffae589183b3 | Lead lookup; Consent / suppression check; Service catalogue; Qualification update |
| PrimeCare Consultation Followup | Consultation follow-up | 16fc27f3-2c96-49b4-aa76-be6ee099c0ec | Lead lookup; Consent / suppression check; Consultation status; Callback request |
| PrimeCare Proposal Followup | Proposal follow-up | 322ff7af-f657-424e-91fc-47b7dfd66074 | Lead lookup; Consent / suppression check; Proposal lookup; Follow-up outcome |
| PrimeCare Booking Followup | Booking follow-up | 01231dfe-d02a-45a3-9faf-9eb2ebe14e75 | Consent / suppression check; Identity verification; Availability lookup; Booking proposal; Independent confirmation; Booking readback |
| PrimeCare Client Onboarding | Onboarding | 469ed456-4e68-4d2f-b09e-6658bae5bfdd | Identity verification; Onboarding status; Secure instructions; Callback request |
| PrimeCare Client Followup | Existing-client follow-up | d1985ae7-8e35-4a7e-8f08-6a6dace03632 | Consent / suppression check; Identity verification; Service history; Callback request; Follow-up outcome |

Each agent has a complete default greeting and system prompt in `packages/shared/src/vapi-agent-templates.json`, native `endCall`, disabled audio recording and a bounded duration. The creation job reuses an exact existing configuration and refuses ambiguous names or mismatching scripts. It never overwrites the existing receptionist or changes phone routing. Recording being disabled is not a claim that provider transcripts or other artifacts are disabled.

## Verification

- [Provider creation/readback](https://github.com/shaikhrais/primecare-platform/actions/runs/40403323731): eight saved assistants, all scripts and greetings verified.
- [Native activation/readback](https://github.com/shaikhrais/primecare-platform/actions/runs/40405876518): pinned PostgreSQL screen 1269; API IDs 16561–16564; Code Admin-only explicit grants. Encrypted Vapi configuration deployed to the governance Worker, preserving its database, email, Look and rate-limit bindings.
- Native inventory HTTP 200; all eight library agents found; one existing reusable tool listed; zero approved business capabilities. Anonymous access HTTP 401 and current Tenant Admin role HTTP 403.
- Temporary native-session test account and tenant removed. This verifies a seeded native session, not credential login or MFA enrollment.
- Browser fixture checks cover default-script selection, explicit save/readback, narrow-screen overflow, permission-denied form removal and TypeScript checking. Mobile/desktop visual evidence is retained by the Vapi UI test workflow. These fixtures do not prove live phone behavior.
- Fixed Worker transport compatibility: manual redirects with rejection of redirects, and provider transport invoked without binding the client instance as its receiver. Live inventory passed after these corrections.

## Remaining business integration

The capability names above are requirements, not invented callable tool identifiers. They need real registered backend contracts, approved tool configuration, appropriate current-role/tenant/identity checks, provider attachment verification and end-to-end tests. In particular, lead permission/suppression checks must precede outbound dialing, and booking requires authorized availability plus independent confirmation and saved-record readback. No campaign was launched; no phone routing changed; no business-action completion is claimed. Native call-ending configuration is not a live call acceptance test.
