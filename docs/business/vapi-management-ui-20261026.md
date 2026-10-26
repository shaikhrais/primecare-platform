# PrimeCare Vapi management

Code Admin → Voice AI · Vapi adds a shared-shell management panel with English,
French and Spanish panel text, a narrow-screen layout, saved agent inventory,
agent creation, approved API tool creation/reuse, and tool attachment/detachment.
Configuration changes do not assign numbers, place calls or execute business tasks.

## Source status

Implemented source, not deployed or live verified. Production endpoint registration,
explicit API/screen grants, Worker secret/configuration binding, production build,
PostgreSQL acceptance and actual Vapi write/readback remain pending. No grants,
production policy, phone routing or provider resources were changed by this commit.
The existing receptionist verification workflow is unchanged.

The backend uses VapiAdminClient inheriting VapiManagementClient, and an injected
HTTP boundary. Every operation rechecks the current active native session, active
tenant, Code Admin role, pinned production manifest, exact API registration,
explicit API permission and linked screen grant. Unknown/missing grants deny.
Vapi management has a separate policy query; existing communication-policy source
and grants are preserved.
The four candidate operations are in vapi-admin-contract.json, linked to the existing
Code Admin screen 1269. The JSON file is not a production registration or grant.

Private management keys remain server-side. Inventory returns selected fields,
never full Vapi provider payloads. Tool URLs, body schemas and credential IDs come
from an approved server catalogue; the browser supplies only its capability key.
The catalogue must contain only independently verified runtime operations. No
OTP verification or independent approval API is an AI-callable capability.

## Activation dependencies

Bind VAPI_PRIVATE_API_KEY as an encrypted Worker secret, plus VAPI_ADMIN_ORG_ID,
VAPI_ADMIN_TEMPLATE_ID and optional VAPI_ADMIN_CATALOG as server settings. Do not
copy the secret into app manifests, browser storage or public environment fields.
The existing GitHub production secret does not automatically bind a Worker secret.
An empty catalogue permits no API tool creation or attachment.

Catalogue entries use key, callable name, enabled, description, HTTPS url, method,
Vapi credentialId and optional body JSON Schema. Bind only reviewed contracts to
this catalogue after registered backend authentication and task permissions pass.
The catalogue is never submitted by the browser or accepted from model arguments.

The verified template supplies only its model provider/model selection to a new
agent. New agents have an endCall tool, a maximum duration of 600 seconds and audio
recording disabled. They use Vapi defaults for voice/transcriber; existing template
voice IDs are not copied. Review current provider compatibility before live calls.
The operator supplies the system prompt and greeting. No clinical booking capability
is implied by a prompt or by successful configuration creation.

A durable pending receipt is committed to the existing platform administration
request store before each provider write, using a Vapi-prefixed idempotency key.
Pending receipts use the existing allowed status 200 and a reconciliation marker;
no schema change is needed. Provider timeouts or failed readback leave this marker
and prohibit automatic repeat writes. Resolve ambiguous results against provider
inventory before creating a new request. Browser request keys survive reload via
hashed session/path/body fingerprints; prompts and tokens are not stored in them.
Tool attachments preserve the full existing model and verify independent readback.
Concurrent Vapi Dashboard edits can still race; provider CAS is not assumed.

## Validation

Local: 22 management and existing provider tests passed. New cases cover projections,
organization denial, validation before transport, saved-field readback, approved
tool reuse, full-model preservation, authorization, durable receipt replay and
ambiguous-write denial. Node TypeScript syntax transformation passed for the panel
and Worker module. The local Playwright run was blocked by missing Chromium.

CI workflow vapi-admin-tests.yml installs Chromium and runs the narrow-screen
browser → native HTTP boundary → synthetic provider-port flow plus strict panel
type checking. Fixture tests do not establish live Vapi or PostgreSQL verification.

## Official documentation reviewed

- https://docs.vapi.ai/assistants/quickstart
- https://docs.vapi.ai/api-reference/assistants/create
- https://docs.vapi.ai/api-reference/assistants/update
- https://docs.vapi.ai/api-reference/tools/create
- https://docs.vapi.ai/tools/api-request/configuration
- https://docs.vapi.ai/tools/api-request-vs-function
- Vapi create-assistant/create-tool skills and attachment/API implementation references.

Current documentation requires API Request arguments in body JSON Schema and
reusable authentication through credentialId. Saved tools attach using model.toolIds;
creation, attachment, backend implementation and live acceptance are separate checks.
