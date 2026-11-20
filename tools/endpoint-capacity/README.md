# Endpoint capacity measurement

This harness measures an authenticated **read-only staging workload**. It does not establish production maximum capacity or exercise write workflows, outbound messaging, billing, or provider quotas. Use a representative staging deployment and synthetic fixtures. Keep its session token in the test environment; do not put it in the profile or commit it.

1. Copy `profile.example.json` to a local profile outside source control. Set the staging origin, independently verified release ID, workload name and evidence URL. Choose operations, weights, expected HTTP status and required JSON object keys. Use a session with only the permissions needed by those reads.
2. Review request rates, test duration and VU limits against the staging environment. The script requires an origin containing the selected environment as a hostname component and an exact match to `CAPACITY_TEST_ORIGIN`. Production hosts and write methods are rejected.
3. Configure `CAPACITY_PROFILE` (absolute path), `CAPACITY_TEST_ORIGIN`, and `CAPACITY_TEST_TOKEN` in the staging test environment. From this directory, run:

   ```sh
   k6 run load-test.js
   ```

   The tested tool version is k6 v2.4.0. The harness warms up for 60 seconds, runs increasing constant-arrival-rate stages with 30-second draining gaps, and checks each operation's status and configured JSON keys. A deterministic distribution preserves the declared operation mix. Redirects are disabled. Raw URLs and credentials are excluded from metric tags; do not enable HTTP debug output for an authenticated run.

4. Evaluate the normalized report from the repository root:

   ```sh
   node scripts/evaluate-endpoint-capacity.mjs /absolute/path/capacity-run.json /absolute/path/assessment.json
   ```

   The evaluator writes the assessment and, only when a contiguous set of stages passes, `assessment.benchmark.json`. It rejects truncated, future, expired or inconsistent results. It requires sustained duration, achieved request rate, zero dropped iterations, enough requests per operation, representative operation mix, and both aggregate and per-operation latency/error targets. It stops raising the supported rate after the first failing stage. A failed run clears a previously generated benchmark at the same output path.

5. Review the raw run, deployment identity, test generator saturation and server resources. Import the benchmark file through **Open capacity benchmark** on API Health Dashboard. The dashboard labels the staging read scope explicitly. Do not compare it with a different environment or workload as if it were measured production headroom.

## Measure the bottleneck before scaling

Collect Worker CPU per successful operation, database query time and connection waits, queue age, external provider limits, and transfer coverage during the same stages. The load harness does not infer these server-side measurements from HTTP latency.

| Observed bottleneck | First change to evaluate | Verify using the same profile |
| --- | --- | --- |
| Database waits or slow queries | Reviewed indexes, narrower queries and connection pooling | Query time, wait time, P95 and passing throughput |
| Large responses | Pagination, field projection and safe compression | Response bytes, transfer coverage and latency |
| Worker CPU | Remove repeated work; cache only appropriately scoped, safe responses | CPU per successful operation and passing throughput |
| Downstream saturation | Respect quotas; bound concurrency; queue work where the business contract allows | Queue age, errors, latency and successful operations |
| Unknown | Add resource observations before changing capacity | A repeatable bottleneck and comparable evidence |

Record the before/after release IDs and bottleneck evidence, then repeat the profile. The highest passing tested rate is a measured lower bound for that workload, not a discovered system maximum. Full-system capacity additionally requires controlled write/workflow tests with persistence, audit, authorization and tenant-isolation checks.

Validation performed for this harness: k6 v2.4.0 inspected the real scenario options and ran a full warmup plus sustained stage against an isolated local HTTPS fixture. The local server received 603 requests; the measured stage completed 301 requests with zero failed checks and zero dropped iterations. The offline evaluator accepted the resulting fixture-only evidence. Those counts validate the measurement pipeline and are not PrimeCare performance figures.
