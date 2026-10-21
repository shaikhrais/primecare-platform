import {test} from 'node:test';
import assert from 'node:assert/strict';
import {owner,validateCodeAdminOwner} from './code-admin-owner.mjs';
test('owner policy pins the approved identity and cannot choose another owner',()=>{
 assert.equal(owner.roleCode,'code_admin');
 assert.equal(owner.verificationStatus,'owner-bound-not-activated');
 for(const email of ['',null,'other@example.test','code_admin@example.test'])assert.throws(()=>validateCodeAdminOwner(email));
});
