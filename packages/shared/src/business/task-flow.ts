/** Candidate workflow planner. It does not authorize, persist, approve or send tasks. */
export type TaskStep = Readonly<{
 id: string;
 responsibility: string;
 requiredEvidence: readonly string[];
 recipientResponsibility: string;
 independentReview: boolean;
}>;
export type TaskFlow = Readonly<{
 id: string;
 title: string;
 registrationStatus: 'candidate_unregistered';
 steps: readonly TaskStep[];
}>;

export class BusinessTaskFlowBase {
 readonly definition: TaskFlow;
 constructor(definition: TaskFlow) {
  if (!definition.id || !definition.title || !definition.steps.length ||
      definition.registrationStatus !== 'candidate_unregistered') throw Error('Invalid candidate flow');
  const ids = new Set<string>();
  for (const step of definition.steps) {
   if (!step.id || ids.has(step.id) || !step.responsibility || !step.recipientResponsibility ||
       !step.requiredEvidence.length || new Set(step.requiredEvidence).size !== step.requiredEvidence.length ||
       step.requiredEvidence.some(key => !key.trim()) || typeof step.independentReview !== 'boolean') throw Error('Invalid candidate step');
   ids.add(step.id);
  }
  // Do not let a caller's later mutation silently alter an already validated plan.
  this.definition = Object.freeze({...definition, steps: Object.freeze(definition.steps.map(step =>
   Object.freeze({...step, requiredEvidence: Object.freeze([...step.requiredEvidence])})))});
 }

 step(id: string): TaskStep {
  const step = this.definition.steps.find(candidate => candidate.id === id);
  if (!step) throw Error('Unknown flow step');
  return step;
 }

 prepareSubmission(stepId: string, evidence: Readonly<Record<string, string>>) {
  const step = this.step(stepId);
  const unknown = Object.keys(evidence).filter(key => !step.requiredEvidence.includes(key));
  if (unknown.length) throw Error('Unexpected evidence fields');
  const missing = step.requiredEvidence.filter(key => typeof evidence[key] !== 'string' || !evidence[key].trim());
  if (missing.length) return {ready: false as const, missing};
  return {ready: true as const, stepId, recipientResponsibility: step.recipientResponsibility,
   evidence: Object.fromEntries(step.requiredEvidence.map(key => [key, evidence[key].trim()])),
   requiresAuthorizedAssignment: true as const};
 }

 /** Acceptance is a proposed next step, never proof that business work is complete. */
 planAcceptance(stepId: string) {
  const current = this.step(stepId);
  const index = this.definition.steps.findIndex(step => step.id === stepId);
  const next = this.definition.steps[index + 1];
  return {requiresIndependentReview: current.independentReview,
   nextStepId: next?.id ?? null,
   nextResponsibility: next?.responsibility ?? current.recipientResponsibility,
   completionReviewRequired: !next};
 }

 planCorrection(stepId: string, reason: string) {
  const step = this.step(stepId);
  if (typeof reason !== 'string' || !reason.trim()) throw Error('Correction reason required');
  return {stepId, recipientResponsibility: step.responsibility, reason: reason.trim(),
   preserveOriginalSubmission: true as const, requiresAuthorizedAssignment: true as const};
 }
}
