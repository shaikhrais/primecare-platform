import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
const bundle=await build({entryPoints:['websites/typescript/src/auth-client.ts'],bundle:true,write:false,format:'esm',platform:'node'});
const {authenticate,verifyMfa}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
const challenge='a'.repeat(43),token='b'.repeat(43);
test('MFA challenge carries no session; valid factor then me confirmation completes authentication',async()=>{
 const calls=[];const send=async(url,input)=>{calls.push({url,input});if(url.endsWith('/login'))return Response.json({status:'mfa_required',challenge,purpose:'enroll',setupKey:'A'.repeat(32)});if(url.endsWith('/mfa')){assert.deepEqual(JSON.parse(input.body),{challenge,code:'123456'});return Response.json({status:'authenticated',token});}return Response.json({userId:'user-a',roles:'code_admin',status:'authenticated'});};
 let prompted=false;const result=await authenticate('https://synthetic.test','test@example.test','synthetic-password',send,async c=>{prompted=true;assert.equal(c.challenge,challenge);assert.equal(c.token,undefined);assert.equal(calls.length,1);return verifyMfa('https://synthetic.test',c.challenge,'123456',send);});assert.equal(prompted,true);assert.equal(result.token,token);assert.equal(calls.length,3);
});
test('unsupported or malformed MFA responses cannot continue to session confirmation',async()=>{
 for(const data of [{status:'mfa_required',challenge:'bad',purpose:'enroll',setupKey:'A'.repeat(32)},{status:'mfa_required',challenge,purpose:'unknown'},{status:'mfa_required',challenge,purpose:'enroll'}]){
  let calls=0,prompted=false;await assert.rejects(authenticate('https://synthetic.test','e','p',async()=>{calls++;return Response.json(data);},async()=>{prompted=true;return token;}));assert.equal(calls,1);assert.equal(prompted,false);
 }
});
test('failed final identity confirmation revokes MFA-created provisional token',async()=>{
 const calls=[];await assert.rejects(authenticate('https://synthetic.test','e','p',async(url)=>{calls.push(url);if(url.endsWith('/login'))return Response.json({status:'mfa_required',challenge,purpose:'verify'});if(url.endsWith('/me'))return Response.json({error:'denied'},{status:401});return Response.json({status:'signed_out'});},async()=>token));assert.equal(calls.at(-1),'https://synthetic.test/v1/auth/logout');
});
