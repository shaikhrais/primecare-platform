import {test} from 'node:test';
import assert from 'node:assert/strict';
import {paginationState,movePagination} from '../src/index.mjs';

test('empty results display no range and disable both controls', () => {
  const state=paginationState({page:7,pageSize:10,totalItems:0});
  assert.deepEqual(state,{page:1,pageSize:10,totalItems:0,totalPages:0,firstItem:0,lastItem:0,hasPrevious:false,hasNext:false});
  assert.deepEqual(movePagination(state,'next'),state);
});

test('partial final page, shrinking result count and boundary moves', () => {
  const initial=paginationState({page:2,pageSize:10,totalItems:23});
  assert.deepEqual([initial.firstItem,initial.lastItem,initial.hasPrevious,initial.hasNext],[11,20,true,true]);
  const last=movePagination(initial,'next');
  assert.deepEqual([last.page,last.firstItem,last.lastItem,last.hasNext],[3,21,23,false]);
  assert.deepEqual(movePagination(last,'next'),last);
  assert.deepEqual(movePagination(last,'previous'),initial);
  assert.equal(paginationState({...last,totalItems:5}).page,1);
  assert.equal(movePagination({...initial,page:1},'previous').page,1);
  assert.ok(Object.isFrozen(last));
});

test('invalid and imprecise inputs are rejected', () => {
  for(const input of [{page:0,pageSize:10,totalItems:1},{page:1,pageSize:0,totalItems:1},{page:1,pageSize:10,totalItems:-1},{page:1.5,pageSize:10,totalItems:1},{page:1,pageSize:10,totalItems:Infinity}]) {
    assert.throws(()=>paginationState(input),RangeError);
  }
  assert.throws(()=>movePagination({page:1,pageSize:10,totalItems:1},'last'),RangeError);
});

test('safe integer upper bound remains an exact range', () => {
  const total=Number.MAX_SAFE_INTEGER;
  const state=paginationState({page:total,pageSize:10,totalItems:total});
  assert.equal(state.lastItem,total);
  assert.equal(state.hasNext,false);
});
