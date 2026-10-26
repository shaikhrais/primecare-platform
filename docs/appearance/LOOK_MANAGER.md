# Base Look Review Manager

The manager reviews uploaded visual evidence in two stages: trusted AI assessment, then an explicit decision by an authenticated human administrator. All evidence, scores, decisions, versions and audit records are stored through the governance API. The UI and native adapter contain no SQL or database connection.

## Workflow

1. Administrator selects a registered page, platform, viewport, pixel ratio, language, build, theme and layout revision.
2. Administrator uploads a PNG after removing personal, clinical and payment information. The API checks size, PNG header/end markers and declared pixel dimensions, then computes the exact image digest. Context labels are supplied by the submitter; they do not independently prove native capture provenance.
3. The API creates `pending_ai`. A trusted, server-side AI service evaluates the actual image. Client-supplied AI scores are not accepted.
4. AI scores eight criteria: layout, spacing, typography, contrast, consistency, imagery, responsive fit and clarity. Average must reach 80, every criterion must reach 70, and major/critical findings block an AI pass.
5. An AI pass produces `ready_human`, never final approval. Failed or malformed AI results produce `ai_failed`; visual defects produce `changes_requested` with actionable findings.
6. An authorized administrator inspects the screenshot, confirms that inspection and supplies decision evidence. Only a current AI pass can be approved. Rejection and requested changes retain the evidence and identity of the decision maker.
7. A replacement screenshot supersedes the previous screenshot for that exact context/viewport. Version checks, image-digest checks and current-role scope checks prevent stale decisions and unauthorized retry replays.

The same administrator may submit and perform the human review in the one-person model. AI and human stages remain separate. The API authenticates the administrator account and records its inspection attestation; it cannot independently prove that an API caller is physically a person.

## Review usability

Language changes and successful refreshes preserve the unfinished submission, including the browser-selected PNG and redaction checkbox. Human decision drafts are keyed to review ID, version and image digest; a changed version cannot inherit the earlier inspection attestation. Drafts live only in the current page's memory, are not written to browser storage or a database, and disappear on page close/reload. A successful screenshot submission clears its upload draft.

Each screenshot has translated loading, ready and error messages and a retry action. Before enabling the human decision controls, the browser checks that the downloaded PNG's SHA-256 digest matches the API record and that the image actually decodes. Failed HTTP requests, mismatched bytes and decode errors leave those controls disabled. This usability guard complements the API's authorization/version/digest checks; it cannot prove that a person inspected the screen or prevent a separate API client from submitting an attestation.

Local browser tests exercise draft preservation, a simulated failed screenshot request, mismatched image bytes, retry recovery and the subsequent human approval in EN/FR/ES at 320/1440 pixels. These use synthetic evidence and a mock vision provider.

## Review coverage

Approvals are per page, tenant, build, theme, layout, language and screenshot. Rubric configuration is fingerprinted; changing criteria, thresholds or the required matrix invalidates current coverage and decision eligibility for the earlier rubric.

| Platform | Required reference viewport |
|---|---|
| Web mobile | 320 × 800 |
| Web tablet | 768 × 1024 |
| Web desktop | 1440 × 900 |
| Web 4K | 3840 × 2160 |
| Android | 360 × 800 |
| iOS | 390 × 844 |
| Windows | 1440 × 900 |
| macOS | 1440 × 900 |
| Linux | 1440 × 900 |

A web pass never approves a native platform. `coverage.complete` is true only when all nine required variants in that exact context have a current human approval. This is a reference matrix, not a claim to cover every device, orientation, assistive technology or interactive state. Beauty scores are judgments, not WCAG certification, functional test results or release-readiness tags.

## Authority and privacy

- Code/central/platform administrators can review global visual evidence. CEO/tenant administrators are restricted to their tenant and eligible registered pages.
- Screenshots are authenticated resources, not public URLs. Session changes prevent the browser from displaying a former session's returned image.
- Human decisions require a current version, exact image digest, inspection confirmation and a reason. The server resolves administrator identity; the request cannot choose an actor or tenant.
- Audit failure rolls back submissions/decisions. Actor mutation limit is 30/minute; AI limit is 10/hour. Uploads are capped at 1 MiB, 64 million pixels and a bounded JSON body.
- AI execution occurs after the claim transaction commits. Stable provider idempotency keys and compare-and-set completion prevent duplicate claims and late results overwriting newer evidence. A claim older than two minutes can be retried; providers must honor the supplied idempotency key.
- The UI lists at most 100 recent records. No retention/deletion workflow has been added; production needs a retention policy for uploaded visual evidence.

## AI connection

Production now has the private `primecare-look-ai` Worker, encrypted OpenAI credential and governance service binding. Provider failures fail closed: no new AI pass and therefore no new human approval. An already valid recorded AI pass can still be reviewed by a human if the provider subsequently becomes unavailable.

Configure governance Worker `LOOK_AI_SERVICE` when generating Worker configuration. This creates a private `LOOK_AI` service binding. It must implement:

- POST `/review` with review ID, base64 PNG, exact image digest, context and rubric.
- Idempotency key `reviewId-imageDigest`.
- JSON response containing exactly `imageDigest`, `model`, `summary`, `scores` for all eight criteria and `findings` with `criterion`, `severity` and `fix`.
- The response digest must match. Missing criteria, invalid scores or malformed findings cannot pass. The API imposes a 25-second provider deadline.
- Treat screenshot text as untrusted evidence, never instructions. Do not expose provider credentials in UI code. Implement a real vision model in the bound service; returning fixed or heuristic scores is not an AI review.

This repository now supplies an OpenAI Responses vision adapter and private Worker/Durable Object configuration in `vision-provider.ts`. See `VISION_PROVIDER.md` for activation, replay semantics and failure handling. It is deployed through `Verify and activate Look Manager` on `main`. The workflow registers pinned PostgreSQL metadata, applies the business-table migration, publishes the private provider and governance Worker, and publishes the governance portal. Live acceptance results are recorded separately in the workflow artifacts; a deployed binding alone does not prove a successful model assessment.

## Implemented surfaces and evidence

- Shared API-side policy: `packages/shared/src/look/manager.ts`.
- Database migration: `20261014_look_reviews.sql`; four dedicated tables.
- API manager: `cloudflare/workers/src/look/service.ts`; five governed operations and OpenAPI.
- Website screen: `/appearance-review`, linked from platform administration and eligible growth dashboards. EN/FR/ES, mobile and desktop layouts.
- Native API base/adapter: `BaseLookManager` and `ApiLookManager`. Approval endpoints bypass synthetic/cache fallback in the shared Dart API client. No native review widget or physical device acceptance is claimed; Flutter/Dart is unavailable here.
- Local tests: rubric checks, real handler transactions with PGlite text/UUID identities, ordering/digest/role/tenant controls, stale evidence, failure and rollback, retry recovery, and six browser approval workflows. Vision results and administrator actions in tests are explicitly synthetic fixtures.
- PostgreSQL CI and browser/provider tests run in the activation workflow (11 tests). Production metadata grants are checked against the pinned PostgreSQL authority. Native SDK/device tests and full accessibility acceptance remain pending.

The earlier audit found legacy Flutter SQLite/Drift access elsewhere in the project. This API-only manager does not silently remove those separate modules.
