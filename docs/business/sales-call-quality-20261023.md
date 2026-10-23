# Sales script coverage candidate

User requirement: evaluate a sales call against the supplied script, identify covered/missed points and report coverage such as 60% or 90%. This is script coverage, not conversion rate or a guarantee of factual correctness.

Status: internal, unmounted candidate. No new API, permission, screen, navigation, localization or theme records are invented. No live recording/transcription/configuration is enabled. The pinned production governance connection currently rejects access with `planLimitReached`; registration, storage application, business workflow/review records, UI and production activation remain blocked. Earlier Twilio boundary metadata registration is not evidence that sales QA is registered. Runtime policy actions and call/script ownership ports must resolve approved records after access is restored. Owner: platform communications; business owner must supply the real script and criteria.

## Architecture and workflow

`SalesCallQualityService` inherits `ScopedServiceBase`. It receives authenticated server identity, a mandatory current policy, canonical call/consent scope, a versioned script, a provider source and the existing atomic store protocol. There are no role defaults. Permissions are host-supplied registered actions, never selected by a model. Current owner/tenant/capture/script authorization is checked before provider access and inside the audit transaction; read access checks current call access too. Scope or rubric changes while awaiting the provider reject persistence.

The read-only Twilio SDK adapter fetches a configured classic Intelligence custom operator, completed dual-channel recording, completed transcript, all bounded sentences and the configured JSON operator result. It verifies account, call/recording/transcript/service/operator relationships and the approved operator configuration digest. Completed transcript and recording durations must both be present, positive and no longer than eight hours, and agree within one second (the candidate policy allowance for second-based rounding). A mismatch fails before sentence/operator-result reads. This catches contradictory duration metadata; it does not prove every spoken word was transcribed or that capture covered the entire sales interaction. Only supported two-party recording sources (`DialVerb`, `OutboundAPI`, `StartCallRecordingAPI`) are accepted. Conference recordings are rejected: their second channel can mix multiple participants and cannot safely stand in for one agent/customer. Voicemail/unsupported sources are rejected as well. The canonical call scope must use the parent-leg Call SID returned by recording metadata. Only canonical agent-channel sentences count; choose that channel from the trusted recording leg mapping, never assume that channel 1 is always the sales agent. Canonical scope must establish the recording belongs to an approved sales call, with the required recording and processing consent. Voicemail recording is a separate workflow and does not enable full-call recording.

`salesOperatorDefinition(rubric)` generates a reproducible GenerativeJSON prompt/schema and rubric/config SHA-256 digests. It honors the documented 4,000-character classic custom prompt limit. Transcript instructions are untrusted. Output supplies every criterion once, one of `covered`, `missed`, `unknown`, and exact full agent-sentence quotes for covered criteria. The adapter maps each unique quote to the canonical GX sentence ID; repeated/ambiguous, customer-only or fabricated quotes are rejected. This does not assume Twilio exposes GX IDs to its model. The pure scorer validates those IDs, complete quotes, timestamps, confidence and optional literal phrases. Evidence validation proves provenance, not semantic accuracy; results remain reviewable.

Use a new, immutable operator SID per approved rubric version; do not edit/reuse an operator for a different script. Pin account, service, operator, rubric digest and operator config digest in server configuration. Preview on representative approved calls and verify the actual output shape before activation. Classic Generative Custom Operators are documented as Public Beta. This adapter does not consume v3 authored Script Adherence output: that is a separate categories/Succeeded/Failed schema without this evidence contract. No unsupported v2/v3 translation or fallback is attempted.

## Score contract

Each point has a unique ID, clear transcript-observable criterion, positive integer weight (1–1,000), critical flag and optional exact required phrase. The host versions and authorizes the script; model output cannot alter the denominator, weights or exclude criteria as N/A. All configured criteria apply. Conditional rubrics need explicit business design before use.

`coverage = 100 × covered weight / total weight`, rounded to two decimal places. Ten equal-weight criteria with six covered produce 60%; nine produce 90%. A critical miss remains listed even with a high percentage. There is no automatic pass/fail threshold or business action.

Unknown criteria, incomplete transcripts, or any sentence with unknown/confidence below 0.8 prevent a definitive percentage. A low-confidence covered point earns no confirmed weight; an absence claim is unknown when transcript reliability is inadequate. Reports show `coveragePercent: null`, `review_required`, confirmed lower bound and upper bound including unknown weights. Missing timestamps or unmappable speakers reject the source rather than fabricate evidence. Confidence is transcription confidence, not calibrated semantic accuracy. The 0.8 gate is conservative policy for this candidate and requires business validation before release.

The audit snapshot includes the versioned rubric, digests, provider operator ID, account/service/recording SIDs, exact operator configuration digest, agent channel, per-point status, full evidence quote and time offsets. Provenance is validated and included in the idempotency fingerprint, so a changed operator configuration cannot silently overwrite an earlier score. Scope projection prevents extra database/adapter fields from replacing policy identity, aggregate kind or version. It does not store the entire transcript. Quotes can contain personal information: register retention/access/deletion requirements before enabling storage. Candidate DDL uses separate `business_sales_quality_*` tables through `PostgresAtomicStore(pool, 'business_sales_quality')`; default communication storage behavior is preserved. Exact report retries are idempotent; changed source/model output conflicts rather than rewriting history. Events carry no transcript content.

## Composition after registration

1. Business owner supplies the sales script; turn each requirement into a yes/no observable point and approve weights, critical points and literal phrases.
2. Register workflow, storage/retention, actions, route/screen contracts, translations and reviews in the pinned authority. Apply candidate DDL only after registration. No grants are included here.
3. Configure approved sales-call capture/transcription and dual-channel mapping. Create/preview the generated custom JSON operator in the appropriate Twilio service; pin its SID/config digests and restrict API key reads to the required resources. The code does not create or modify Twilio resources.
4. Compose the source as `source: source.read.bind(source)` in the inherited service with native policy/call/script ports and the explicitly selected storage family. Dispatch work only from the independently authenticated/canonical completion path; a webhook body alone is not call ownership or trusted analysis.
5. Mount only registered report/read workflows. Display script version, all criteria, quotes/timestamps, critical misses and uncertain bounds; avoid presenting uncertain coverage as a final score. Require independent OTP/passkey and exact task confirmation for any action; QA never executes tasks.

## Validation and limitations

`node --test scripts/test-communication-sales-quality.mjs` covers 60/90/100%, weighted arithmetic, critical misses, uncertainty, exact phrases, duplicate/missing criteria, fake/customer/ambiguous evidence, malformed timing/speakers, bounds, tenant/owner isolation, revocation during provider reads, configuration pinning, idempotency and actual Twilio SDK GET serialization using a synthetic HTTP transport. It makes no paid call and does not prove live semantic model accuracy.

The same suite has a native PostgreSQL test gated by `TWILIO_SMS_TEST_DATABASE_URL`, restricted to the disposable local `twilio_sms_test` database. CI applies the candidate migration only to a fresh private schema, runs concurrent independent stores, verifies one audit event, readback, cross-tenant denial and rollback/replay authorization. It skips locally without that database; a skip is not a native acceptance pass. No new browser/Dart contract exists in this candidate, so there is no new UI or browser completion claim. Existing communications CI remains the regression gate.

The provenance hardening adds tests for missing/mismatched duration metadata, malformed source provenance, extra scope fields, configuration-digest replay conflicts and strict secret/digest lengths. The PostgreSQL acceptance test reads back provenance as well as score evidence. Earlier reports without this candidate provenance contract are not automatically rewritten or backfilled. No production sales QA storage is activated.

## Official documentation reviewed 2026-10-23

- [Transcript resource and recording input](https://www.twilio.com/docs/conversation-intelligence-classic/api/transcript-resource)
- [Sentence fields, speaker channels and pagination](https://www.twilio.com/docs/conversation-intelligence-classic/api/transcript-sentence-subresource)
- [Classic custom JSON operator configuration, preview and prompt bound](https://www.twilio.com/docs/conversation-intelligence-classic/generative-custom-operators)
- [Operator result retrieval](https://www.twilio.com/docs/conversation-intelligence-classic/api/transcript-operator-results-subresource)
- [v3 authored Script Adherence schema](https://www.twilio.com/docs/conversations/intelligence/use-twilio-authored-language-operators)
- [Writing unambiguous criteria](https://www.twilio.com/docs/conversations/intelligence/script-adherence-best-practices)

Confirm product eligibility, processing settings and provider agreements for the actual call data before activation; classic and v3 are different products. No medical/payment call analysis is activated by this candidate.

- [Recording status, channels and duration in seconds](https://www.twilio.com/docs/voice/api/recording)
