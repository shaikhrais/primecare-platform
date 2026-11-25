import test from 'node:test';
import assert from 'node:assert/strict';
import {tableSample,chartSample} from '../src/index.mjs';
test('samples compose real synthetic fixture package without business dependencies',()=>{
  const table=tableSample({name:'Name',status:'Status',demo:'Example',success:'Ready'});
  assert.equal(table.rows.length,12);assert.equal(table.options.pageSize,6);assert.equal(table.columns[0].pinned,true);
  const chart=chartSample('line',{title:'Title',demo:'Example',optionOne:'A',optionTwo:'B',status:'Status'});
  assert.equal(chart.data.series.length,6);assert.deepEqual(chart.data.categories,['A','B','Status']);
  assert.equal(chart.options.width,420);
});
