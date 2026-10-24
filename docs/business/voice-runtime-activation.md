# Voice runtime activation

The user saved the Twilio AI/ML agreement on 24 October 2026. The screenshot
shows the agreement checked and the Console's Settings Updated acknowledgement.
This clears that prerequisite, not the remaining deployment or acceptance gates.
2223 currently uses the temporary unavailable TwiML Bin; the previous Studio IVR
was disconnected. Do not describe the temporary message as an AI agent.

`CommunicationVoiceWorker` inherits the Worker lifecycle and routes the 21 existing
registered operations to separate native-session, signed provider and relay
adapters. It preserves the original request and signing URL, rejects unexpected
origins, paths, methods and query parameters, and returns the original WebSocket
upgrade response. Failed upgrades close the session and both sockets. It does
not provide substitute identities, grants, a model, or business-task adapters.

The host must supply all native, extension, connect, voicemail, OTP pairing,
verified-agent, SMS-status and relay adapters. Existing PostgreSQL compositions
are in `twilio-integration.ts`; their native API permissions and task-write ports
must be connected to current governed implementations. Construction fails if any
adapter is missing. No new route, permission or screen is registered by this code.

Production inventory from Actions run 40106094722 confirms all 21 contracts in
the pinned governance database. It also reports no linked screens or active API
grants for those contracts. Governance Worker settings contain no Twilio/OpenAI
bindings. Registration and isolated tests do not establish deployment readiness.

The voice-runtime-readiness workflow checks these exact deployment input names:

| Storage | Names |
| --- | --- |
| Production secrets | PRODUCTION_DATABASE_URL, CLOUDFLARE_API_TOKEN, CLOUDFLARE_ACCOUNT_ID |
| Provider secrets | TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN, TWILIO_API_KEY_SID, TWILIO_API_KEY_SECRET, TWILIO_VERIFY_SERVICE_SID, TWILIO_APPLICATION_SID, TWILIO_MESSAGING_SERVICE_SID |
| Model secret | OPENAI_API_KEY |
| Production variables | VOICE_MODEL, VOICE_ORIGIN |

The report contains presence only. A missing input means that exact input is not
available to this workflow; it does not prove the account has no equivalent key
under another name. Never copy credentials to logs, artifacts or chat. This
workflow makes no provider or number changes. Complete input presence still does
not certify values, a mounted runtime or live acceptance.

Remaining activation work: validate provider inputs, connect current native API
and task permissions, bind real appointment/policy APIs, prepare approved contacts
and reception, supply production WebSocketPair/101 response ports, deploy the
complete host, test provider signatures and verified sessions through that host,
then connect 2223 and test real calling, reception and voicemail. A successful
request-task result is not a confirmed clinical booking.

`createPostgresTwilioVoiceWorker` now composes that router with the existing
PostgreSQL token/directory, private voicemail, signed OTP pairing, independently
confirmed reception tasks and OpenAI relay factories. Signing URLs must equal
the registered host paths. Host policies and task APIs remain mandatory. No
production mount or key provisioning is performed by this composition.

Local validation: 48 tests passed with no skips across voice runtime, complete
composition, configuration redaction, agent start, OpenAI relay and relay session
suites. Strict TypeScript checking passed. GitHub CI and live phone verification
are separate evidence.

The first configuration check (run 40110468098) found only the production database
and Cloudflare inputs present. Twilio credentials, OpenAI key, model and origin
were unavailable under the expected names. Do not claim endpoint readiness or
replace the temporary message based on the passing runtime test job.
