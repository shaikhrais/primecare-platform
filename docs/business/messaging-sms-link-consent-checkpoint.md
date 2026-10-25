# SMS account links and consent checkpoint

Internal native adapters now bind the existing shared AI reply service and SMS
outbox to a durable verified account/conversation link. No new public route,
permission, production table, seeded contact or live message is introduced.

`PostgresSmsMessagingRepository.bind` receives native context from the host,
checks a session created within five minutes, active user/tenant, independent
verified contact and version, current conversation membership and mandatory
registered host policy. Only the link ID, conversation ID and explicit consent
are accepted as request data. Phone/provider/actor/tenant/role overrides are
rejected. Existing edited/stale/revoked links cannot be revived by retries.

The candidate schema makes an active provider account/shared-number/phone pair
globally unique, preventing silent tenant/user selection for a shared phone.
Reads recheck user, tenant, membership, contact revocation/version, consent and
the complete original link. No default permission policy exists.

The derived consent inbox repository atomically records signed control events
and applies consent/link changes. STOP revokes the active link; START does not
restore it. A fresh explicit native binding gets a new identity. Duplicate STOP
delivery after START does not replay an old opt-out or overwrite later state.

The recipient/transport adapters retain the original link from the persisted AI
turn and compose the existing SMS service rather than copying its queue/claim
logic. Current country/consent/quota policy remains mandatory. Provider submission
is serialized with committed STOP, native revoke and re-link. Already submitted
SMS cannot be recalled; ambiguous provider outcomes must not be retried blindly.
The official SMS client's 10-second timeout/no-retry configuration is required
for the guarded transport. Policy factories must query the owned native client
instead of acquiring the same pool recursively.

37 focused local checks passed, including the existing inbound inbox, SMS outbox
and shared AI reply service. Strict adapter types passed. Source `33a71b37`, run
`40158426495`, job `121064667937`, passed all ten new native PostgreSQL groups
plus the six existing native messaging groups. The checks cover concurrency,
rollback, queued replies blocked after STOP, no revival of old links/replies
after START, identity/membership/contact changes and single-slot pools.

A redundant START when already opted in preserves the current valid link; it
does not advance the consent generation unnecessarily. A START after STOP still
cannot revive the revoked link. The native suite asserts both behaviors.

The first implementation checkpoint `40523846` also passed all 12 communication
CI jobs in run `40158240711`; the updated source `33a71b37` passed all 12 in
run `40158426495`. These are scoped checks, not live/provider or full
release acceptance. Broader existing gateway/endpoint-policy review blockers
remain documented in `messaging-ai-development-20261024.md`.

Next activation work: register storage and native owner-only bind/revoke
contracts, apply approved migrations through the pinned writer, compose the
signed receiver with `PostgresSmsConsentInboxStore`, durably dispatch inbox work,
bind delivery to the original saved turn/link, and prove a real receive/AI/reply/
delivery sequence. Signed provider delivery is not independent account proof.
The inbound webhook metadata remains registered as API 16538, without activation.
