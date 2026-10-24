# Four-digit voice extension cutover

The user selected globally unique extensions 1000–9999, 0 for reception and 1
for the AI assistant. Appointment changes must use existing registered business
APIs, current cancellation/rescheduling policy and exact independent confirmation.
The sales script remains configurable. Browser business operations use the API;
PostgreSQL connections are server-owned. Database assertions are separate test
runner operations.

## Metadata first

`four_digit_voice_revision.py` compares every existing policy/API field against
the immutable previously verified six-digit baseline or its exact four-digit
revision. It preserves IDs, grants, screen links, implementation flags, provider
configuration and user assignments. It updates only extension schema limits and
the registered policy definition/requirement in one transaction. A differing human
edit, missing/duplicate identity or mismatched pin aborts; no general overwrite is
allowed. Dry-run rollback, idempotence and independent readback are mandatory.

The dedicated CI workflow runs native rollback/grant-preservation fixtures before
the exact production metadata revision. Its receipt is required before switching
the active source contracts and runtime validators. No operational SQLite fallback,
business schema application, number purchase or provider activation is included.

## Runtime and business schema cutover

After metadata readback succeeds, switch active source definitions, compiled API
validators, directory/token/connect/device checks and the IVR gather to four
digits. Keep SMS OTPs at six digits and private pairing codes at eight digits.
The business migration must reject existing six-digit destination or voicemail
records instead of truncating or silently renumbering them. Existing historical
migrations remain immutable; the follow-up migration handles the new range.

Menu 0 goes to configured reception. Menu 1 enters the verified AI pairing flow,
with missing configuration falling back to reception/unavailable. Four-digit
extensions beginning with 1 remain distinct from menu 1 (entered with pound or
after the gather timeout). No caller speech, caller ID or voice match authorizes
an account action. AI booking/rescheduling/cancellation remains subject to actual
registered APIs, live policy and exact user confirmation; missing policy/bindings
must be reported rather than inferred as permission.

Production release still requires host bindings, current grants, mailbox/provider
configuration, selected reception, explicit extension publication and live/device
acceptance. This plan is not a claim that those steps have completed.

## Verified metadata revision and runtime candidate

Run `40049674028` passed isolated rollback/grant-preservation tests and production
job `120739520564` independently read back the four-digit policy and all 21
contracts. The receipt proves policy version 2, `extensionDigits:4`, no grant or
assignment changes, no provider writes and no activation. The earlier fixture
failure in run `40049540796` was an unordered identity comparison; adding `ORDER
BY id` preserved exact field equality. That failed run skipped production.

The runtime now uses four-digit validators across IVR, native API schemas, token
issuance, directory assignment and SDK connect. Its optional same-origin
`aiPairingUrl` sends menu 1 to the existing verified pairing handler. Menu 0 and
unknown input use configured reception; missing AI configuration uses reception
or unavailable. Four-digit values beginning with 1 remain ordinary extensions.
No user-selected URL or actor is forwarded to an AI agent. Local voice/AI tests
pass 207 cases with one native-only skip; 34 actual workerd checks, eight schema
definition checks and strict integration types pass. Source-specific native and
full browser CI remain required for this candidate.

`20261024_four_digit_voice_extensions.sql` is an explicit candidate business
migration, not an automatic production operation. It changes only known legacy
constraints/sequence on an empty directory, preserves an already four-digit
sequence without reset, rejects six-digit directory or voicemail records, and
refuses unexpected edited constraints/ranges. It performs no truncation, deletion
or reassignment. Its disposable PostgreSQL test checks legacy preservation,
rollback, bounds, global uniqueness, exhaustion and idempotent sequence state.
The historical migrations remain unchanged.

The read-only communication inventory also includes appointment, booking,
cancellation and rescheduling metadata so AI task bindings can be reviewed
against the current production API/workflow definitions. This adds no business
record reads, policy defaults or grants. In code, the existing client cancellation
handler cancels pending booking requests only; it is not evidence of a confirmed
appointment cancellation or fee policy. The AI must not treat these as equivalent.
