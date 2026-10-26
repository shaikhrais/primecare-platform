# Private screenshot vision reviewer

The repository now supplies `primecare-look-ai`, a private Cloudflare Worker behind governance's existing `LOOK_AI` binding. It uses the OpenAI Responses API to send the actual redacted PNG and request a strict structured visual assessment. It does not grant human approval. The production activation workflow deploys this private service with the encrypted production OpenAI credential and configurable `LOOK_AI_MODEL` (default `gpt-5.4-mini`). Credentials are never written to source or browser assets. Deployment and successful provider assessment are reported separately.

## Execution and authority

The administrator submits evidence through the authenticated governance API. That API validates tenant/role/page permissions, claims the review, and calls the private reviewer with an exact digest and stable review key. The reviewer verifies the PNG header/end markers, bounded payload, digest, context and current criteria/thresholds. Its fixed instructions treat screenshot text and context labels as untrusted data. It sends the image with high detail and requests scores, a summary and actionable findings in the context language.

The reviewer accepts only a completed Responses result with one assistant text message and the required JSON fields. Refusals, incomplete output, missing/extra criteria, invalid values and malformed findings fail closed. The model's reported identity and the server-computed digest accompany the validated report. Governance applies its existing score/finding rubric and records `ready_human`, `changes_requested` or `ai_failed`. Human approval remains an explicit separate API action.

The service uses `BaseWorker`; replay state lives in a server-side `VisionReviewJob` Durable Object. The generated configuration disables public `workers.dev` routing, preview URLs and custom routes. Only a service binding should expose it inside the account. Do not add public routes to this Worker. Its secret never appears in UI code or generated configuration. The UI still reads and writes solely through the governance API; Durable Object storage is server-side infrastructure.

The private request/response contract is documented in `look-provider.openapi.json`. Bump the registered provider policy version whenever assessment instructions or parsing semantics change; changed policy requires a new review ID rather than reusing an old report.

## Replay and failures

A transaction persists a job fingerprint and pending marker before provider I/O. A completed result or terminal failure is persisted and replayed. A changed context, policy or configured model conflicts with the same job key. A still-pending/unknown result never starts another outbound call. The provider deadline is 20 seconds, inside governance's 25-second deadline; refusals, cancellation and oversized output cannot become approval.

This design chooses at-most-one outbound initiation per persistent job key. It does not promise that an external provider finishes processing or avoids charging after an interrupted request. After a terminal failure or unknown outcome, submit fresh evidence to obtain a new review ID before deliberately trying again. Retrying the old API job repeats its recorded result; it does not reissue a provider request. Missing credentials/model are rejected before the durable claim and can be configured without consuming that job.

Durable receipts store only the fingerprint, claim time, status and validated report, not PNG bytes or credentials. They have no automatic purge in this version. Deleting replay receipts would allow the same key to start a fresh external call; set an operational retention policy before production use. Screenshots remain subject to the existing governance evidence retention policy. `store:false` is sent to Responses; this is not a claim of zero provider retention.

## Activation

Choose a model available to your OpenAI project that supports PNG image input and strict structured outputs, and verify that it completes this rubric within the deadline. The activation workflow explicitly defaults to `gpt-5.4-mini`; set the production `LOOK_AI_MODEL` variable to change it. There is no fallback model.

From the repository root, generate configuration with the chosen model:

```bash
VISION_MODEL='your-compatible-vision-model'
LOOK_AI_SERVICE=primecare-look-ai LOOK_AI_MODEL="$VISION_MODEL" node scripts/generate-cloudflare-worker-config.mjs
```

Provision `OPENAI_API_KEY` as a secret on `primecare-look-ai` using Cloudflare's secret mechanism. Do not put it in the browser, a checked-in configuration or chat. Deployment requires the provider's `VisionReviewJob` SQLite Durable Object migration. Deploy the private provider, then governance with its generated `LOOK_AI` binding. The generator emits `look-ai.jsonc` with the verified runtime compatibility date from the registered provider policy.

Activation is not complete until a redacted staging screenshot receives a real assessment, failed/provider-unavailable cases are checked, and an authorized administrator inspects and decides on the same evidence. Governance's `providerReady` currently means that a service binding exists, not that credentials, account access or model compatibility have been verified.

## Tests and remaining work

Provider contract tests use explicitly synthetic responses and keys. They verify image transport, fixed instructions, strict schema, refusal/incomplete/error paths, bounded input/output, timeout handling, durable replay, changed-job conflicts, concurrent pending claims, storage failure and private generated configuration. They do not evaluate real model quality or real account access. The local runtime test uses workerd/Miniflare with all external networking mocked; it checks actual Durable Object storage and replay after a runtime restart.

Local validation passed: 8 provider-contract tests, 1 workerd runtime/restart test and 11 related auth/configuration regressions (20 total), plus TypeScript checking. Miniflare is pinned to `4.20260730.0`; the provider's compatibility date is `2026-08-06`. Runtime verification caught and corrected an unsupported redirect mode: outbound fetch uses manual redirects and rejects non-success responses. No real provider call occurred.

Production deployment and encrypted key/model configuration are now automated. Remaining acceptance includes successful live provider assessment/calibration, retention decisions and native-device acceptance. No production screen approval or legacy API-completion credit is created by this adapter.

Sources consulted 2026-10-14:

- [OpenAI image inputs](https://developers.openai.com/api/docs/guides/images-vision)
- [OpenAI structured outputs](https://developers.openai.com/api/docs/guides/structured-outputs?api-mode=responses)
- [Cloudflare Worker configuration and service bindings](https://developers.cloudflare.com/workers/wrangler/configuration/)
- [Cloudflare SQLite Durable Object storage](https://developers.cloudflare.com/durable-objects/api/sqlite-storage-api/)
