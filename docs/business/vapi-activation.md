# Vapi activation checkpoint, 24 October 2026

The user selected existing Twilio number +1 289 799 4277 for Vapi instead of
2223. Its Vapi number ID is `3e9cee92-b463-47c8-9e1a-cdbf179cb675`.
The existing assigned assistant remains `Inbound`, ID
`da0cd4c3-3c4c-404d-946c-1001f0ecd0fe`. No phone routing was changed.

Created a separate assistant by duplicating Inbound, preserving the original:
`PrimeCare Reception - 4277`, ID `5ae2ab0c-fad0-454c-8cf7-64b81c91c850`.
Published version v3, named `PrimeCare general reception`, with 100% assistant
version traffic. This version split does not assign a phone number. Dashboard
readback still shows a draft indicator after reload; v3 and its traffic exist,
but full published-field readback is still required before phone assignment.

The new first message identifies the assistant as PrimeCare's automated AI
receptionist. The prompt is preserved in `primecare-vapi-reception-prompt.txt`.
No tools or webhook URL are attached. Booking, cancellation, rescheduling,
reception/extension transfer, voicemail/email delivery, account lookup and OTP
actions are not operational through Vapi. The prompt explicitly prohibits
invented success, availability, clinic details, identity or approval. It does
not collect personal information for unsupported tasks.

Audio recording is disabled in the new configuration; logging and transcripts
remain enabled. Inherited Mary's Dental voicemail/end-call messages were
replaced with PrimeCare wording. No calls were placed.

The actual Vapi Chat test is blocked: `Payment method required`. The dashboard
says pay-as-you-go organizations need a card on file to use chat, even though
7.08 credits are displayed. Only the configured greeting appeared; no model
response was tested. The user must complete any billing entry in Vapi's own
secure form. Do not claim live voice, chat, transfer or booking acceptance.

Next: resolve the provider billing blocker, verify the published configuration,
test greeting and unsupported-action behavior using synthetic data, assign 4277
to the tested assistant, and verify an actual inbound call. Business tools need
registered authenticated PrimeCare API adapters and server-side authorization
before attachment. Keep the existing direct Twilio runtime code for later.
