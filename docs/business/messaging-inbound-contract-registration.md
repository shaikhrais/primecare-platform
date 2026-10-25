# Inbound SMS contract registration

The next production boundary is `POST /v1/twilio/sms/incoming`, authenticated by
Twilio's signature over the exact configured public URL and complete form. This
signature authenticates the delivery provider, not a PrimeCare user or tenant.

The definition is pinned in `tools/governance-production/production-pin.json`.
Its writer can only insert one exact endpoint in `govt_api_endpoints`, anchored
to the existing communication application (API 710). It cannot grant a role,
modify a screen, assign a user/tenant, create a database table, change a provider
configuration, mount a handler or activate messaging. Existing edited or
duplicate contracts are preserved and cause a failure requiring reconciliation.

The protected workflow first tests schema behavior, concurrent registration,
idempotency, rollback, duplicate identities, changed contracts and opt-in/pin
denial against disposable PostgreSQL. It then rolls back a production dry run,
applies exact metadata and reads it back through an independent read-only
adapter with writer opt-ins removed. Production remains the only live authority.

Successful input produces empty `<Response/>` XML only after durable inbox
acceptance. Future provider fields may be signed and ignored; identity-related
custom fields do not select a PrimeCare account. Critical duplicate parameters
are invalid. Body, SID, phone, media-count and opt-out values are bounded. Media
messages and STOP/START/HELP controls do not enter the ordinary AI reply queue.

Registration status and API ID must be recorded from the completed protected
workflow, never inferred from this definition. Handler deployment and all live
traffic remain pending verified account linking, persistent consent/opt-out
suppression, the inbox dispatcher and bound outbox/current-policy composition.
