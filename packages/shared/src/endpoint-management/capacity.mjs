/** Shared browser/Worker capacity validation; no I/O or inferred production capacity. */
const positive = (v) => typeof v === "number" && Number.isFinite(v) && v > 0;
const nonNegative = (v) => typeof v === "number" && Number.isFinite(v) && v >= 0;
const rate = (v) => typeof v === "number" && Number.isFinite(v) && v >= 0 && v <= 1;
function readCapacityEvidence(raw, now = Date.now()) {
  const value = raw;
  if (!value || ![value.releaseId, value.environment, value.workload].every((text) => typeof text === "string" && text.trim().length > 0 && text.length <= 200) || !positive(value.sustainableRequestsPerSecond) || !nonNegative(value.p95LatencyMs) || !positive(value.targetP95LatencyMs) || !rate(value.errorRate) || !rate(value.targetErrorRate) || !["database", "transfer", "downstream", "worker", "unknown"].includes(value.bottleneck)) throw Error("Invalid capacity evidence");
  if (value.measurementScope !== void 0 && value.measurementScope !== "staging_http_read_mix") throw Error("Invalid capacity scope");
  const measured = Date.parse(value.measuredAt), expires = Date.parse(value.expiresAt);
  if (!Number.isFinite(measured) || !Number.isFinite(expires) || measured > now || expires <= now || expires <= measured) throw Error("Expired or invalid capacity evidence");
  const url = new URL(value.evidenceUrl);
  if (url.protocol !== "https:" || url.username || url.password) throw Error("Invalid evidence URL");
  if (value.p95LatencyMs > value.targetP95LatencyMs || value.errorRate > value.targetErrorRate) throw Error("Benchmark does not meet targets");
  return value;
}
function assessCapacity(evidence, observedRps) {
  if (!Number.isFinite(observedRps) || observedRps < 0) throw Error("Invalid observed rate");
  return {
    // Interval averages are not peaks; sampled traffic cannot establish spare capacity.
    observedAverageUtilization: observedRps / evidence.sustainableRequestsPerSecond,
    averageRateMargin: evidence.sustainableRequestsPerSecond - observedRps,
    successfulBenchmarkRps: evidence.sustainableRequestsPerSecond * (1 - evidence.errorRate),
    recommendation: capacityRecommendation(evidence.bottleneck)
  };
}
function capacityRecommendation(bottleneck) {
  return {
    database: "Inspect slow queries and connection waits; verify indexes and pooling, then repeat the same load test.",
    transfer: "Reduce response fields, paginate and measure compression, then repeat the same load test.",
    downstream: "Check provider quotas; use bounded concurrency and queues where permitted, then repeat the same load test.",
    worker: "Measure CPU per operation; remove repeated work and cache safe responses, then repeat the same load test.",
    unknown: "Measure Worker CPU, database waits, queue age and provider quotas before choosing a scaling change."
  }[bottleneck];
}
export {
  assessCapacity,
  capacityRecommendation,
  readCapacityEvidence
};
