import {test} from 'node:test';
import assert from 'node:assert/strict';
import {requirements,schemaProblems,safeFailureReason} from './check-auth-schema.mjs';
const fixture=()=>Object.entries(requirements).flatMap(([table_name,fields])=>Object.entries(fields).map(([column_name,udt_name])=>({table_name,column_name,udt_name})));
test('preflight failure reports never serialize driver messages or unknown codes',()=>{
 assert.equal(safeFailureReason({code:'28P01',message:'private-password'}),'database authentication rejected');
 assert.equal(safeFailureReason({code:'private-password',message:'private-url'}),'database preflight unavailable (unclassified error)');
});
test('accepts required auth schema and varchar text columns',()=>{
 const rows=fixture();assert.deepEqual(schemaProblems(rows),[]);
 rows.find(r=>r.column_name==='email').udt_name='varchar';assert.deepEqual(schemaProblems(rows),[]);
});
test('blocks missing rate-limit migration',()=>{
 assert.equal(schemaProblems(fixture().filter(r=>r.table_name!=='auth_rate_limits')).length,3);
});
test('blocks incompatible user identity type',()=>{
 const rows=fixture();rows.find(r=>r.table_name==='users'&&r.column_name==='id').udt_name='int8';
 assert.deepEqual(schemaProblems(rows),['users.id: expected uuid, found int8']);
});
