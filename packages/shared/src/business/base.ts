/** Shared domain rules only. Callers enforce permissions and supply verified, scoped evidence. */
export type FlagStatus = 'green' | 'amber' | 'red' | 'unknown';
export type BusinessFlag = Readonly<{status: FlagStatus; reason: string}>;

export abstract class BusinessFlagRule<T> {
 abstract evaluate(input: T): BusinessFlag;

 /** Keep evidence coverage separate: a critical incident cannot be averaged away. */
 static summarize(flags: readonly BusinessFlag[]) {
  const unknown = flags.filter(flag => flag.status === 'unknown').length;
  const status: FlagStatus = flags.some(flag => flag.status === 'red') ? 'red'
   : unknown || !flags.length ? 'unknown'
   : flags.some(flag => flag.status === 'amber') ? 'amber' : 'green';
  return {status, unknown, total: flags.length};
 }
}

export type TargetEvidence = Readonly<{
 actual: number | null;
 target: number | null;
 approved: boolean;
 complete: boolean;
 current: boolean;
 periodClosed: boolean;
 /** Approved cumulative milestone; never inferred from elapsed calendar time. */
 milestone: number | null;
}>;

export class SalesTargetRule extends BusinessFlagRule<TargetEvidence> {
 evaluate(input: TargetEvidence): BusinessFlag {
  if (!input.approved || !input.complete || !input.current ||
      !Number.isSafeInteger(input.actual) || input.actual! < 0 ||
      !Number.isSafeInteger(input.target) || input.target! < 0) {
   return {status: 'unknown', reason: 'evidence_incomplete'};
  }
  if (input.target === 0) return {status: 'unknown', reason: 'no_target'};
  if (input.periodClosed) return input.actual! >= input.target!
   ? {status: 'green', reason: 'target_met'} : {status: 'red', reason: 'target_missed'};
  if (!Number.isSafeInteger(input.milestone) || input.milestone! < 0 || input.milestone! > input.target!) {
   return {status: 'unknown', reason: 'milestone_missing'};
  }
  return input.actual! >= input.milestone!
   ? {status: 'green', reason: 'milestone_met_provisional'}
   : {status: 'amber', reason: 'milestone_missed'};
 }
}

/** A restricted HR adapter can supply these booleans without exposing case details. */
export type IncidentEvidence = Readonly<{
 criticalVerified: boolean;
 resolutionVerified: boolean;
 complete: boolean;
 current: boolean;
 attentionRequired: boolean;
}>;

export class IncidentFlagRule extends BusinessFlagRule<IncidentEvidence> {
 evaluate(input: IncidentEvidence): BusinessFlag {
  if (input.criticalVerified && !input.resolutionVerified) return {status: 'red', reason: 'critical_open'};
  if (!input.complete || !input.current) return {status: 'unknown', reason: 'evidence_incomplete'};
  return input.attentionRequired ? {status: 'amber', reason: 'action_required'} : {status: 'green', reason: 'no_open_breach'};
 }
}

/** Existing planning arithmetic, independent of evidence-based business flags. */
export class BusinessMetricsBase {
 static campaign(budget: number, spend: number, leads: number) {
  return {cplCents: leads > 0 ? spend / leads : null, budgetGapCents: Math.max(0, spend - budget)};
 }
}
