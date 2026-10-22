import {test} from 'node:test';
import assert from 'node:assert/strict';
import {verifyMfaKeyRotation} from '../cloudflare/workers/src/security/mfa-key-rotation.mjs';
const env={MFA_ENCRYPTION_KEY:'a1'.repeat(32),MFA_ENCRYPTION_KEY_V2:'b2'.repeat(32)};
test('actual fixed bindings support forward and reverse synthetic configuration drill without returning proof material',async()=>{
 assert.deepEqual(await verifyMfaKeyRotation(env,'mfa-v1','mfa-v2'),{fromKeyId:'mfa-v1',toKeyId:'mfa-v2',verified:true});
 assert.deepEqual(await verifyMfaKeyRotation(env,'mfa-v2','mfa-v1'),{fromKeyId:'mfa-v2',toKeyId:'mfa-v1',verified:true});
});
test('missing key and invalid drill scopes fail closed',async()=>{
 await assert.rejects(verifyMfaKeyRotation({MFA_ENCRYPTION_KEY:env.MFA_ENCRYPTION_KEY},'mfa-v1','mfa-v2'));
 await assert.rejects(verifyMfaKeyRotation({...env,MFA_ENCRYPTION_KEY_V2:env.MFA_ENCRYPTION_KEY},'mfa-v1','mfa-v2'));
 for(const scope of [['mfa-v1','mfa-v1'],['unknown','mfa-v2'],['mfa-v1','MFA_ENCRYPTION_KEY']])await assert.rejects(verifyMfaKeyRotation(env,...scope));
});
