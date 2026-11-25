import test from 'node:test';
import assert from 'node:assert/strict';
import {demoTableRows,demoChartSeries} from '../src/index.mjs';
test('synthetic data reproduces independent fixture rows and chart series',()=>{
  const rows=demoTableRows('Example','Ready');
  assert.equal(rows.length,12);assert.deepEqual(rows[0],{id:'row-0',values:{name:'Example 1',status:'Ready'}});
  rows[0].values.name='changed';assert.equal(demoTableRows('Example','Ready')[0].values.name,'Example 1');
  assert.equal(demoChartSeries('line','Example').length,6);
  assert.deepEqual(demoChartSeries('donut','Example')[0].values,[12,18,9,14,7,11]);
  assert.throws(()=>demoChartSeries('unknown','Example'),RangeError);
});
