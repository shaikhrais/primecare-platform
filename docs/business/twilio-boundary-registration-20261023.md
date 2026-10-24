# Twilio boundary contract registration

The user requested one shared number with globally unique six-digit extensions,
reception fallback, app answering, private voicemail/email notification and an AI
agent limited to defined tasks after verified identity and independent approval.
The reusable implementations already exist. Their production HTTP/upgrade
contracts were still missing; this package registers that metadata before mounting.
It does not assert that the handlers or phone experience are live.

The authoritative input is
`tools/governance-production/twilio-contracts-registration.json`. Registration uses
the pinned production PostgreSQL authority and its `govt_api_endpoints` relation.
The application identity comes from existing API 710, never an invented app.
All rows are `registered-unimplemented`, require authentication and have unknown
health. There are no role/API/screen grants and no screen-link writes.

| Contract group | Exact paths | Authentication |
| --- | --- | --- |
| SDK token | `/v1/voice/token` | Current native session, endpoint permission, CSRF; session hash is server context |
| Extension administration | `/v1/voice/extensions/assign`, `/v1/voice/extensions/publish` | Current native session, scoped assignment/publication policy, CSRF |
| Private voicemail | `/v1/voice/voicemail/read`, `/v1/voice/voicemail/audio` | Current native owner/tenant and policy, CSRF |
| App-linked OTP | `/v1/voice/otp/start`, `/v1/voice/otp/check` | Current native session, current verified account contact, call pairing, CSRF |
| Exact task review | `/v1/voice/tasks/preview`, `/v1/voice/tasks/approve` | Current native session/owner, call-bound identity, exact displayed digest, CSRF |
| Shared-number entry | `/v1/twilio/voice/incoming`, `/v1/twilio/voice/gather` | Official SDK signature on the exact configured URL and all form parameters; canonical account/shared number checks |
| SDK outgoing connection | `/v1/twilio/voice/connect` | Signed provider form, canonical client/call verification and scoped extension policy |
| Missed-call recording | `/v1/twilio/voice/dial-complete`, `/v1/twilio/voice/record-action`, `/v1/twilio/voice/recording-status` | Signed provider form, reserved owner route and canonical recording verification |
| Agent entry | `/v1/twilio/voice/pair`, `/v1/twilio/voice/wait`, `/v1/twilio/voice/agent`, `/v1/twilio/voice/agent-complete` | Signed form plus the existing canonical call and app identity gates |
| Agent socket | `GET /v1/twilio/voice/relay` | Exact signed upgrade, then canonical setup, live identity, authorization and durable one-use claim |
| SMS delivery | `/v1/twilio/sms/status` | Signed provider form and canonical sender/account/receipt association |

All paths except Relay use POST. Provider form schemas retain future string
parameters: the official signature validator must receive every parameter, not a
schema-filtered subset. Metadata validation never replaces the SDK validator.
Native request schemas reject actor, tenant, raw session, contact or arbitrary
URL overrides. Extension administration accepts a target user ID, not an actor.
The OTP receipts match the current service (`verificationRequested`, then a
boolean `verified`). A false OTP result creates no authenticated identity.

The response contract distinguishes JSON, TwiML, no-content callbacks, private WAV
and a WebSocket upgrade; the last three must not be wrapped as ordinary JSON.
A host must enforce request bounds, current endpoint/resource permissions, CSRF,
rate/abuse policy, audit and transport-specific response headers before mounting.
These deployment policies are not silently invented by metadata registration.
There is no public task-propose, task-execute, voice-approval or arbitrary API tool
endpoint. The model still receives only call-bound, server-owned tools. Spoken
consent, caller ID and voice similarity cannot approve a business action.

`TwilioContractRegistrationStore` inherits the pinned native production store.
Its additional opt-in and definition hash are pinned in `production-pin.json`.
It locks only API metadata for registration, inserts the exact allowlisted rows,
and compares every existing row field. It refuses duplicates, human edits,
missing anchors, foreign routes and activation-status changes. It never rewrites
an existing differing contract. A transaction failure rolls back all inserts.
Only explicit transaction concurrency failures may retry with a fresh connection;
there are no provider requests to retry.

The workflow `twilio-contracts-registration.yml` first validates eight definition/readback
checks and eight native PostgreSQL cases in a named disposable loopback database.
The native cases cover idempotence and concurrent registration across connections, rollback after partial
insertion, preserved grants/links, edited contracts, duplicate routes/API IDs, missing
anchors and scope/opt-in denial. Production registration is dependent on that
job. It performs a rollback-only dry run, commits the same idempotent registration,
then uses an independent read-only connection to verify every complete row.
The receipt reports metadata IDs and zero provider writes, purchased numbers,
assigned extensions and activation. It contains no credentials, messages or audio.

Local validation: eight definition/schema/readback checks and the existing 15 contract-plan
checks pass. A local PostgreSQL server is unavailable; the CI native job must
supply the transactional evidence before its production job can run. These are
registration tests, not live Twilio, SMTP or telephone acceptance.

The selected existing number +1 647 930 2223 and its IVR are unchanged. Live work
still requires registered human/service policies and access decisions, approved
business schema application, exact route mounting, secret/provider/model/media
bindings, a chosen reception destination, explicit per-user extension publication,
provider onboarding and actual device/phone/email acceptance. Recording is only
for missed-call voicemail. Notification email contains an authenticated app link,
not a public recording URL or unprotected audio attachment.

Sources reviewed: the `twilio-webhook-architecture` skill, the official
[webhook overview](https://www.twilio.com/docs/usage/webhooks), and official [secure webhook documentation](https://www.twilio.com/docs/usage/webhooks/webhooks-security).


The independent reader requires Node and the pinned `pg` package as well as the
Python writer dependencies. The workflow installs both. `--verify` opens only the
independent read-only adapter and checks the full set without entering a writer
transaction. A failed readback after registration does not prove rollback; always
reconcile using read-only verification. The first run reached that stage without
its Node dependency, so it was treated as potentially committed and unverified.
The corrected workflow reruns idempotently and performs an additional read-only
verification; no differing row is overwritten during recovery.


## Production blocker and recovery

The corrected native CI run passed eight definition/readback tests and 28 native
PostgreSQL tests (including eight new registration cases and the inherited native
store suite). The production connection was then rejected by Prisma with
`planLimitReached`. No independent production readback can be credited from that
run. The earlier apply reached its post-commit readback before the missing-reader
dependency failure, so its 21 metadata rows must be treated as potentially
committed, not assumed rolled back. No differing records are overwritten.

Pushes now run the isolated checks only; production reconciliation is an explicit
workflow operation so new commits do not repeatedly attempt the restricted account.
Restore access to the existing pinned production Prisma database account first.
Then run the `Register Twilio boundary contracts without activation` workflow on
`main`, choosing `verify`. That mode provides no writer opt-in variables and runs
only the independent read-only check. It must verify every complete row and API
ID before registration is credited. If metadata is missing, use the separately
selected `register` mode to perform the tested dry-run/idempotent transaction and
readback. An existing edited or colliding row requires reconciliation; do not
reset or replace it. There is no alternate-database or SQLite fallback.

Evidence: [native checks and restricted production attempt](https://github.com/shaikhrais/primecare-platform/actions/runs/40018192032).
This blocker concerns production database access, not Twilio number provisioning.
It does not establish live routes, grants, extension publication, phone ringing,
SMTP delivery or model/task acceptance.


## Independent production reconciliation after Prisma upgrade

At source `bf359a818ae53c1097f86abc941c5be191e4fae3`, communication CI run
`40046406409`, inventory job `120729028781`, passed the existing independent
`--verify` reader. All 21 complete rows matched their pinned definitions, with
unique API IDs 16513–16533 and definition SHA256
`803ee241af0c61f5117578bc0e52f9413c10bea6e631c21acc584005ceea3bd7`.
The receipt states `independentReadback:true`, `writesAttempted:false`, zero
grants/extensions/provider writes and `activation:false`. This supersedes the
earlier plan-limit/readback blocker; no registration retry or grant change was
needed. The pinned production database remains the sole live authority.

Live mounting, current permissions and screen bindings, verified mailbox/provider
routing, selected reception destination, explicit extension publication, model
and transcription setup, mobile background ringing and real phone/email/device
acceptance remain open. The generic inventory still reports these release gaps;
recognizing XML/audio/no-content schemas does not remove access requirements.
