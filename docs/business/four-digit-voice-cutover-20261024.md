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


## Verified runtime checkpoint

Runtime source `40a98c99d7fbe4f19817b120c3e87581cf9201aa` and corrected browser
fixture `cae1f27070334dde0f8fb9b500d39e4c416d4568` passed all ten communication
jobs in run `40050431745`: 191 voice/AI checks, 17 native HTTP checks with
PostgreSQL, the real migration test, 34 workerd assertions and 24 sales QA checks.
The initial browser failure used six-digit fixture values; the corrected fixture
proves legacy inputs are rejected before creating an SDK call and retains media
cleanup assertions. No application checks were removed.

Both jobs in full-stack run `40050245695` passed all 15 milestones through Flutter
UI -> API gateway -> Worker -> disposable PostgreSQL. Peers received [7,10] audio
packets and both closed. Three artifact ZIP digests were checked and both
screenshots visually reviewed. The final production registry artifact independently
matched all 21 four-digit API schemas; no provider writes or activation occurred.
Exact jobs, hashes, earlier failures and remaining release limits are recorded in
`evidence/communication-four-digit-menu-20261024.json`. The business migration has
not been applied to production; legacy records require explicit reconciliation.

The broader source-triggered suite also exposed two separate governance failures:
care browser setup reads a filename containing JSON import-attribute text, and
account-session registration finds differing own-session API links. Their native
tests passed; no existing API links/grants were overwritten to force green.
Communication acceptance does not imply repository-wide CI success.

## Agreed configuration and next AI bindings

The selected outgoing address is `shkh.rais@gmail.com`; it needs a securely
authorized Gmail account or a provider-approved sending identity before live
sending. Do not impersonate a Gmail From address through an unrelated provider.
Reception is a configurable published destination, not a guessed user. Sales
rubrics are versioned/configurable with per-point weights, mandatory misses,
evidence and uncertain-result review; a sample rubric is sufficient for tests.

The existing AI task implementations support callback, booking-request and
reschedule-request ports behind OTP/passkey and exact independent approval. The
expanded live metadata inventory contains legacy generic booking placeholders
and a separate sales/prospect-appointment status API. Those are not proof of a
client/clinic appointment cancellation-fee policy. Pending booking-request
cancellation, care-visit cancellation and sales-appointment cancellation must not
be substituted for a clinic appointment cancellation. Bind the correct current
API, ownership/version/availability rules and clinic policy before enabling that
task; disclose any policy/fee consequence in the exact confirmation. Missing
terms or permissions must hand off to reception rather than invent a free cancel.

Useful later tasks include availability checks, appointment status, reminders and
reception handoff when their registered APIs/knowledge and permissions are bound.
These are proposed additions, not activated tools or completion claims.
