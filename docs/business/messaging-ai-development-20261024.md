# Messaging AI development checkpoint — 24 October 2026

Continue on current `main`. Preserve the old dirty checkout; do not use it as the
release source. This work starts from `8dcf4100`, including the saved SMS/WhatsApp/
Telegram integration design and read-only SMS provider readiness workflow.

## Implemented internally

- Signed, bounded Twilio SMS receiver, inheriting the existing Twilio form adapter.
- Durable PostgreSQL inbox keyed by provider account + MessageSid. Identical
  retries increment a counter; a changed payload never replaces the original.
- Control-message exclusion and MMS quarantine without fetching media URLs.
- Shared `MessagingAiReplyChannel` and `MessagingAiReplyService`, inheriting the
  existing channel/service bases. Mandatory current-link, access-policy, model and
  durable-outbox ports; no default account mapping or permissive policy.
- Durable model/outbox claims, deterministic event/turn and reply IDs, policy and
  link-version rechecks, bounded generation and no blind retry after uncertainty.
- Bounded, cancellable text Responses API resource with server-configured service
  information, no tools, no provider storage and independent concurrent messages.
- Native inbox/turn migrations and tests wired into existing communications CI.

The reply lane answers general service questions only. It does not book an
appointment or execute account tasks. Vapi's existing verified task service is
unchanged. Model text cannot provide authentication or confirmation authority.

## Validation at implementation checkpoint

60 focused local tests passed, zero failed/skipped, including existing SMS service,
transport and voice model regression checks. Strict types for the new service,
declarations, repository and shared store passed. Native PostgreSQL acceptance is
pending CI at this checkpoint: the local runtime has no PostgreSQL server. The
native script requires an explicitly named disposable loopback fixture, never
production credentials. It tests real multi-connection deduplication, independent
database readback, inherited turn storage, real SMS outbox persistence, concurrent
generation/queue/delivery claims and synthetic provider acceptance.

## Activation still pending

No route was mounted, migration applied to production, permission granted, live
message sent or phone routing changed. New internal service actions are not
automatically registered APIs. Production governance remains the only live
authority; no SQLite fallback or historical-count substitution is allowed.

Before activation, inventory current production contracts, then register the exact
inbound webhook, link/consent and reply processing/storage contracts. Bind inbox
consumers to a uniquely verified account/conversation and canonical event-derived
turn ID. Persist and enforce opt-out against pending outbox items. Implement
atomic current-link/consent outbox checks and explicit uncertain-outcome recovery.
Serialize conversations and keep enrollment/OTP messages outside model input.

Then wire the worker/queue dispatcher and registered sender configuration, run
forged/replay/cross-user/cross-tenant and revoked-link acceptance, deploy and prove
real incoming SMS → AI → reply → delivery callback → independent DB readback.
WhatsApp requires its approved sender/window/template adapter; Telegram requires
its authenticated bot/private-chat adapter. Shared service tests are not live
WhatsApp/Telegram verification. Vapi task activation remains separately gated by
its verified caller, permissions, proposal/confirmation and saved result checks.
