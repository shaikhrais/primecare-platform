/** Verify a candidate release against the last accepted cumulative activation register. */
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';

const [before,after,project,...rest]=process.argv.slice(2);
if(!before||!after||!project||rest.length)throw Error('Usage: verify-dashboard-activation-delta.mjs <prior-registry> <candidate-registry> <exact-project>');
const read=async path=>JSON.parse(await readFile(path,'utf8'));
const [prior,candidate]=await Promise.all([read(before),read(after)]);
assert.equal(prior.version,1);
assert.equal(candidate.version,1);
assert.deepEqual(candidate.retained,prior.retained);
assert.equal(candidate.cohorts.length,prior.cohorts.length+1);
assert.deepEqual(candidate.cohorts.slice(0,-1),prior.cohorts);
const fresh=candidate.cohorts.at(-1);
assert.ok(fresh.dashboards.length>=1&&fresh.dashboards.length<=10,'expected one new batch of 1–10');
assert.ok(fresh.dashboards.every(row=>row.project===project),'every new dashboard must match the selected project');
const rows=[...candidate.retained,...candidate.cohorts.flatMap(c=>c.dashboards)];
assert.equal(new Set(candidate.cohorts.map(c=>c.id)).size,candidate.cohorts.length);
assert.equal(new Set(rows.map(row=>JSON.stringify([row.project,row.appCode,row.code,row.route]))).size,rows.length);
console.log(JSON.stringify({project,cohort:fresh.id,activated:fresh.dashboards.map(row=>({code:row.code,route:row.route}))}));
