import {test} from 'node:test';import assert from 'node:assert/strict';import {normalizePhoneNumber} from '../packages/shared/src/communications/phone-number.mjs';
import {NativeVoiceContactHttpAdapter} from '../packages/shared/src/communications/voice-native-http.mjs';
test('Canadian variants normalize to the same exact country-code number',()=>{for(const value of ['289-887-3200','2898873200','12898873200','1-289-887-3200','+1 289-887-3200','(289) 887-3200','+1 (289) 887-3200','289.887.3200',' +12898873200 '])assert.equal(normalizePhoneNumber(value),'+12898873200');});
test('canonical international E.164 is preserved, without guessing another country',()=>{assert.equal(normalizePhoneNumber('+919876543210'),'+919876543210');assert.equal(normalizePhoneNumber('+15550001001'),'+15550001001');});
test('ambiguous input, extensions, controls and malformed prefixes are rejected',()=>{for(const value of [null,2898873200,'2898873200\n','2898873200 ext 4','2898873200/4165550101','++12898873200','0012898873200','+91 98765 43210','289  887 3200','(2898873200','1-1-289-887-3200']){assert.throws(()=>normalizePhoneNumber(value));}});
test('native enrollment adapter validates and dispatches canonical input without overriding identity',async()=>{
 const seen=[],session={actor:{id:'user',tenantId:'tenant'},sessionHash:'a'.repeat(64),expiresAt:Date.now()+60000};
 const adapter=new NativeVoiceContactHttpAdapter({origin:'https://fixture.invalid',appOrigins:[],maxRequestBytes:2048,maxAudioBytes:12,authenticate:async()=>session,authorize:async()=>{},service:{status:async()=>({verified:false,enrollmentAllowed:true}),start:async(hash,phone)=>{seen.push({hash,phone});return {challengeId:'11111111-1111-4111-8111-111111111111',verificationRequested:true,expiresAt:Date.now()+60000};},check:async()=>({verified:false})}});
 const post=body=>adapter.respond(new Request('https://fixture.invalid/v1/voice/contact/start',{method:'POST',headers:{authorization:'Bearer fixture','content-type':'application/json'},body:JSON.stringify(body)}));
 const input={phone:'289-887-3200',requestId:'11111111-1111-4111-8111-111111111111'};
 assert.equal((await post(input)).status,200);assert.deepEqual(seen,[{hash:session.sessionHash,phone:'+12898873200'}]);assert.equal((await post({...input,tenantId:'foreign'})).status,400);assert.equal(seen.length,1);
});
