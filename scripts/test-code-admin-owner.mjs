import {test} from 'node:test';
import assert from 'node:assert/strict';
import {owner,validateCodeAdminOwner,requireCodeAdminActivationReady} from './code-admin-owner.mjs';
test('owner policy pins the approved identity and cannot choose another owner',()=>{
 assert.equal(owner.roleCode,'code_admin');
 assert.equal(owner.verificationStatus,'owner-bound-not-activated');
 for(const email of ['',null,'other@example.test','code_admin@example.test'])assert.throws(()=>validateCodeAdminOwner(email));
});
test('a bound owner cannot activate before the registered MFA readiness gate',()=>{
 assert.throws(()=>requireCodeAdminActivationReady(),/disabled pending verified MFA setup/);
});
