/** Shared action policy regression only; does not certify browser or database workflows. */
import assert from 'node:assert/strict';
import {test,after} from 'node:test';
import {build} from 'esbuild';
import {mkdtemp,rm} from 'node:fs/promises';
import {createRequire} from 'node:module';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
const directory=await mkdtemp(join(tmpdir(),'care-closed-appointment-'));
after(()=>rm(directory,{recursive:true,force:true}));
const target=join(directory,'contract.cjs');
await build({entryPoints:['packages/shared/src/care/contract.ts'],bundle:true,platform:'node',format:'cjs',outfile:target});
const {registry,allowedActions}=createRequire(import.meta.url)(target);
const record=(state,visit_status)=>({state,visit_status,nurse_id:'nurse',supervisor_id:'supervisor',worker_id:'worker',plan_author:'nurse'});
await test('closed source appointments never offer reassignment to operations',()=>{
 for(const role of registry.operationsRoles)for(const state of registry.states)for(const visit of ['cancelled','rejected','completed'])for(const eligible of [false,true]){
  assert.equal(allowedActions({id:'operator',roles:role,tenant_id:'tenant'},record(state,visit),eligible).includes('reassign'),false,role+':'+state+':'+visit);
 }
});
await test('assignment-only cancellation preserves the registered operations restart path',()=>{
 for(const role of registry.operationsRoles)for(const eligible of [false,true]){
  assert.ok(allowedActions({id:'operator',roles:role,tenant_id:'tenant'},record('cancelled','requested'),eligible).includes('reassign'),role);
 }
});
await test('active appointments do not grant reassignment to non-operations roles',()=>{
 for(const role of Object.keys(registry.roles).filter(role=>!registry.operationsRoles.includes(role)))for(const state of registry.states){
  assert.equal(allowedActions({id:'worker',roles:role,tenant_id:'tenant'},record(state,'requested'),true).includes('reassign'),false,role+':'+state);
 }
});
