import test from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {BusinessTaskFlowBase} from '../src/business/task-flow.ts';

const catalog = JSON.parse(readFileSync(new URL('../src/business/task-flows.json', import.meta.url)));
test('catalog is explicitly a candidate, not a registry or permission source', () => {
 assert.equal(catalog.status, 'candidate_unregistered');
 assert.equal(catalog.responsibilitiesAreNotPermissionGrants, true);
 assert.equal(new Set(catalog.flows.map(flow => flow.id)).size, catalog.flows.length);
});
for (const definition of catalog.flows) {
 test(`${definition.id}: complete handoffs, missing evidence and corrections`, () => {
  const flow = new BusinessTaskFlowBase(definition);
  for (let index = 0; index < definition.steps.length; index++) {
   const step = definition.steps[index];
   const evidence = Object.fromEntries(step.requiredEvidence.map(key => [key, `synthetic-reference:${key}`]));
   assert.equal(flow.prepareSubmission(step.id, evidence).ready, true);
   const missing = {...evidence}; delete missing[step.requiredEvidence[0]];
   assert.equal(flow.prepareSubmission(step.id, missing).ready, false);
   assert.throws(() => flow.prepareSubmission(step.id, {...evidence, unregisteredDetail: 'private'}));
   const correction = flow.planCorrection(step.id, 'Missing verified reference');
   assert.equal(correction.recipientResponsibility, step.responsibility);
   assert.equal(correction.preserveOriginalSubmission, true);
   assert.throws(() => flow.planCorrection(step.id, ' '));
   assert.equal(flow.planAcceptance(step.id).nextStepId, definition.steps[index + 1]?.id ?? null);
  }
  const final = definition.steps.at(-1);
  assert.equal(flow.planAcceptance(final.id).requiresIndependentReview, true);
  assert.equal(flow.planAcceptance(final.id).completionReviewRequired, true);
  assert.throws(() => flow.step('foreign-step'));
 });
}
test('validated plan cannot be changed through its original input', () => {
 const input = structuredClone(catalog.flows[0]);
 const flow = new BusinessTaskFlowBase(input);
 input.steps[0].requiredEvidence.length = 0;
 assert.ok(flow.definition.steps[0].requiredEvidence.length > 0);
 assert.throws(() => new BusinessTaskFlowBase({...input, steps: []}));
});
