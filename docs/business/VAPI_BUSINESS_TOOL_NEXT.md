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
