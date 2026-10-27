# PrimeCare independent call and tool audit

PrimeCare keeps metadata in its own private PostgreSQL `communication_call_audit`
table. Call snapshots independently match the Vapi organization, phone/assistant
allowlist and Twilio account/direction/numbers before caller details are stored.
The caller number is evidence of routing, never proof of identity or a tenant.
Unmatched or unauthenticated attempts have separate unbound streams.

The inherited `CallAuditedWorker` wraps the existing verification/client-information
and callback tool hosts. It appends a start before delegation and a completion,
denial or unknown outcome afterward. If start cannot be persisted, no business
handler runs. Failure after delegation returns an unknown outcome and must never
cause automatic execution retries. PostgreSQL failures can leave a durable start
without completion; reconciliation records this as a gap.

No conversation text, arbitrary arguments/results, OTPs, credentials, recording
URLs or clinical records enter this table. Projection rejects unknown fields.
The verification layer can log `no_verified_account_phone` while the caller still
receives a generic safe error. A receipt ID links responses to audit attempts.
Account access and business approval remain in existing services.

Assistant lifecycle webhooks copy status/end events into PrimeCare. Conversation
updates are inspected transiently only for tool IDs/names and result presence;
all speech, arguments and result contents are discarded. Provider-native query,
end-call and voicemail observations are labelled `provider_observed_only`, not
independently executed or verified business actions. Backend receipts are direct
observations. Missing provider events cannot be reconstructed from disabled
transcripts; historical backfill copies call metadata only.

Every five minutes, the separate Worker reconciles provider calls since its last successful heartbeat, with a five-minute overlap, with bounded pagination. Release acceptance backfills 24 hours.
Provider call snapshots join canonical Vapi IDs and Twilio SIDs, caller/destination,
status and timing. Failed collection fails the scheduled invocation; it never
silently advances a cursor. A full 20-page window is a reported saturation error.
The scheduler writes a heartbeat, and identifies incomplete tool attempts. The watermark advances only after the whole window succeeds; long outages remain
visible and retry their uncollected window. Initial backfill covers 24 hours.

Each stream has serialized sequence numbers and a hash chain. Event-key retries
are idempotent; changed retries conflict. The application exposes no update/delete
operation. The database owner can modify this table: the chain detects accidental
or unrecomputed changes, not a malicious owner who rewrites all hashes. External
signed checkpoints or WORM storage would be required for that stronger guarantee.
Private ACL checks reject pre-existing public/nonowner access. No customer-facing
or public audit-reading endpoint is added. Operators with production workflow
access can run `verify-call-audit.mjs`; logs show aggregate counts and safe reasons,
not caller numbers or account details. Full timelines can be read only with a
separately authorized production reader and `PostgresCallAudit.timeline(callId)`.

Deployment preserves existing Worker bindings/secrets and assistant model,
recording policy and phone routing. It creates a dedicated audit webhook credential,
registers the exact provider-only API and adds lifecycle subscriptions to all nine
assistants. Configuration hashes and tool coverage inventories are persisted.
It makes no calls, sends no SMS, enrolls no phone and grants no native permissions.
Real incoming webhook/tool acceptance still requires a real caller test; a passing
fixture or historical snapshot is not evidence of that test.
