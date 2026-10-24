# Vapi activation checkpoint, 24 October 2026

Payment is cleared. API workflow run 40122697994, provider job 120970419890,
succeeded with all saved-field checks and four synthetic text responses reviewed:
AI identity disclosed; booking and extension transfer limitations stated; identity
bypass refused. This is text behavior evidence, not live voice acceptance.

The selected number is +1 289 799 4277, Vapi phone ID
`3e9cee92-b463-47c8-9e1a-cdbf179cb675`. Its preserved original Inbound assistant
is `da0cd4c3-3c4c-404d-946c-1001f0ecd0fe`. The tested PrimeCare Reception assistant
is `5ae2ab0c-fad0-454c-8cf7-64b81c91c850`, published v3. API readback verifies
prompt, greeting, audio recording disabled, no tools/webhook and 600-second maximum.

Activation succeeded in run 40127778842, provider job 120972859943:
numberRoutingChanged=true, routing=primecare_reception. Four fresh text responses
were reviewed. LiveCallVerified=false and businessActionsVerified=false.

## Controlled activation

The verification workflow has an explicit `activate_reception` dispatch input.
Push runs do not change routing. Activation runs four synthetic text checks, then
re-reads the exact assistant/phone/org/configuration and only replaces assistantId.
It accepts the expected original route or an already assigned PrimeCare route;
unexpected routing, squads, workflows, servers or changed assistant fields block it.
Independent readback must confirm the saved assignment. Ambiguous writes are never
retried automatically. Vapi has no assumed compare-and-swap: avoid concurrent
Console edits during activation. The old assistant is retained for recovery.

The workflow artifact records whether routing changed, final route, provider
checks and text responses. A route assignment does not prove an inbound call.
The 2223 temporary unavailable route is outside this activation and is unchanged.

## Remaining business integration

No booking, cancellation, rescheduling, reception/extension transfer, voicemail,
email, account lookup or OTP tool is attached. The prompt prohibits invented
success or collection of personal information for unsupported actions. The current
booking lifecycle API creates pending requests; it does not establish confirmed
provider availability or appointment creation. Before adding Vapi tools, bind the
registered authenticated APIs, real tenant/session context, app OTP pairing and
independent approval, cancellation policies, idempotency and persisted readback.
Do not expose OTP checking or approval as an AI-callable tool. No live call or
business action has been verified through Vapi.

## Implementation and official sources

`VapiManagementClient` inherits BoundedBinaryAdapterBase, uses a fixed API origin,
20-second timeout and bounded projections. Private provider objects may contain
Twilio credentials and never escape. Secret `VAPI_PRIVATE_API_KEY` remains in the
GitHub production environment. Ten local tests verify scope, credential redaction,
no call transport, guarded assignment, idempotent readback and ambiguous failures.

- https://docs.vapi.ai/api-reference/assistants/get
- https://docs.vapi.ai/api-reference/assistants/update
- https://docs.vapi.ai/api-reference/phone-numbers/update
- https://docs.vapi.ai/chat/non-streaming
- https://docs.vapi.ai/server-url/server-authentication
