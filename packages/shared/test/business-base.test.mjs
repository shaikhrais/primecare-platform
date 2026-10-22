import test from 'node:test';
import assert from 'node:assert/strict';
import {BusinessFlagRule, SalesTargetRule, IncidentFlagRule, BusinessMetricsBase} from '../src/business/base.ts';

const sales = new SalesTargetRule();
const target = {actual: 100, target: 100, approved: true, complete: true, current: true, periodClosed: true, milestone: null};
test('only complete, current, approved final attainment is green', () => {
 assert.equal(sales.evaluate(target).status, 'green');
 assert.equal(sales.evaluate({...target, actual: 99}).status, 'red');
 for (const key of ['approved', 'complete', 'current']) {
  assert.equal(sales.evaluate({...target, [key]: false}).status, 'unknown');
 }
});
test('missing, negative, nonfinite and unsafe amounts cannot appear healthy', () => {
 for (const value of [null, -1, NaN, Infinity, 1.2, Number.MAX_SAFE_INTEGER + 1]) {
  for (const key of ['actual', 'target']) assert.equal(sales.evaluate({...target, [key]: value}).status, 'unknown');
 }
 assert.equal(sales.evaluate({...target, target: 0}).reason, 'no_target');
});
test('interim evaluation needs an explicit milestone and remains provisional', () => {
 const interim = {...target, periodClosed: false};
 assert.equal(sales.evaluate(interim).status, 'unknown');
 assert.equal(sales.evaluate({...interim, milestone: 40, actual: 39}).status, 'amber');
 assert.equal(sales.evaluate({...interim, milestone: 40, actual: 40}).reason, 'milestone_met_provisional');
 assert.equal(sales.evaluate({...interim, milestone: 101}).status, 'unknown');
});
test('critical incidents survive unavailable feeds and require verified resolution', () => {
 const rule = new IncidentFlagRule();
 const incident = {criticalVerified: true, resolutionVerified: false, complete: false, current: false, attentionRequired: true};
 assert.equal(rule.evaluate(incident).status, 'red');
 assert.equal(rule.evaluate({...incident, resolutionVerified: true}).status, 'unknown');
 assert.equal(rule.evaluate({...incident, resolutionVerified: true, complete: true, current: true}).status, 'amber');
 assert.equal(rule.evaluate({...incident, resolutionVerified: true, complete: true, current: true, attentionRequired: false}).status, 'green');
});
test('summary preserves red and separately reports unknown evidence coverage', () => {
 const flags = [{status: 'green', reason: 'target_met'}, {status: 'red', reason: 'critical_open'}, {status: 'unknown', reason: 'stale'}];
 assert.deepEqual(BusinessFlagRule.summarize(flags), {status: 'red', unknown: 1, total: 3});
 assert.equal(BusinessFlagRule.summarize(flags.filter(f => f.status !== 'red')).status, 'unknown');
 assert.equal(BusinessFlagRule.summarize([]).status, 'unknown');
 assert.equal(BusinessFlagRule.summarize([{status: 'amber', reason: 'action'}]).status, 'amber');
});
test('existing campaign metrics retain zero-lead and budget behavior through inheritance', () => {
 class ExistingAnalytics extends BusinessMetricsBase {}
 assert.deepEqual(ExistingAnalytics.campaign(100, 120, 3), {cplCents: 40, budgetGapCents: 20});
 assert.deepEqual(ExistingAnalytics.campaign(100, 0, 0), {cplCents: null, budgetGapCents: 0});
});
