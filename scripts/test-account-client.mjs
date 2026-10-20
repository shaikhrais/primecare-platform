import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
const bundle=await build({entryPoints:['websites/typescript/src/account-client.ts'],bundle:true,write:false,platform:'node',format:'esm'});
const {AccountClient}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
let current='original';globalThis.sessionStorage={getItem:()=>current};
await test('password change requires a confirmed contract and matching session',async()=>{
 const prior=globalThis.fetch;
 try{
  const client=new AccountClient('https://fixture/','original');
  for(const value of [null,[],{}, {status:'password_changed'},{status:'password_changed',reauthenticationRequired:false}]){
   globalThis.fetch=async()=>Response.json(value);await assert.rejects(client.changePassword('old-password','new-password-2026'));
  }
  globalThis.fetch=async(url,init)=>{assert.equal(url,'https://fixture/v1/user/change-password');assert.equal(init.headers.authorization,'Bearer original');assert.equal(init.cache,'no-store');assert.deepEqual(JSON.parse(init.body),{currentPassword:'old-password',newPassword:'new-password-2026'});return Response.json({status:'password_changed',reauthenticationRequired:true});};
  await client.changePassword('old-password','new-password-2026');
  for(const status of [400,401,429,503]){globalThis.fetch=async()=>Response.json({error:'private diagnostic'},{status});await assert.rejects(client.changePassword('old-password','new-password-2026'),e=>e.status===status&&e.message==='account_request_failed');}
  globalThis.fetch=async()=>{current='replacement';return Response.json({status:'password_changed',reauthenticationRequired:true});};
  await assert.rejects(client.changePassword('old-password','new-password-2026'),e=>e.status===409);
  globalThis.fetch=async()=>{throw Error('must not send with replaced session');};await assert.rejects(client.changePassword('old-password','new-password-2026'),e=>e.status===409);
 }finally{current='original';globalThis.fetch=prior;}
});
