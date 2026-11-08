// Test evidence identity only; no application or API behavior is changed.
export function smokeOutput(runId) {
  if (runId === undefined) return 'test-results/growth/loading';
  if (typeof runId !== 'string' || !/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/.test(runId)) {
    throw Error('QA smoke run identity must be a generated UUID v4');
  }
  return 'test-results/growth/loading/runs/' + runId;
}
