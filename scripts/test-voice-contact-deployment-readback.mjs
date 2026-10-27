import {test} from 'node:test';import assert from 'node:assert/strict';
import {verifyNativeContactDeployment} from './voice-contact-deployment-readback.mjs';
const receipt={scope:'native-own-phone-enrollment-only',deployed:true,gatewayConnected:true,unknownSessionDenied:true,unauthenticatedDenied:true,foreignOriginDenied:true,corsVerified:true,sourceCommit:'a'.repeat(40),nativeOrigin:'https://primecare-voice-contact-api.owner.workers.dev',gatewayOrigin:'https://primecare-api-gateway.owner.workers.dev'};
const headers={'x-primecare-voice-contact-source':receipt.sourceCommit,'cache-control':'private, no-store','access-control-allow-origin':'https://primecare-clinic.pages.dev'};
test('fresh nonexistent session check verifies source, CORS and API boundary without SMS or user authentication',async()=>{
 let requests=0;const checked=await verifyNativeContactDeployment(receipt,async(url,options)=>{requests++;assert.equal(url,receipt.gatewayOrigin+'/v1/voice/contact/status');assert.match(options.headers.authorization,/^Bearer [A-Za-z0-9_-]{43}$/);assert.equal(options.body,'{}');assert.equal(options.redirect,'error');return new Response('{}',{status:401,headers});});
 assert.equal(requests,1);assert.equal(checked.boundaryVerified,true);assert.equal(checked.smsSent,false);assert.equal(checked.authenticatedUserVerified,false);
});
test('missing or conflicting receipts and arbitrary callback origins cannot cause a request',async()=>{
 for(const altered of [null,{...receipt,deployed:false},{...receipt,sourceCommit:'bad'},{...receipt,gatewayOrigin:'https://foreign.invalid'},{...receipt,nativeOrigin:receipt.nativeOrigin+'/changed'},{...receipt,gatewayOrigin:'https://primecare-api-gateway.other.workers.dev'}]){const checked=await verifyNativeContactDeployment(altered,()=>assert.fail('Unapproved destination'));assert.equal(checked.boundaryVerified,false);assert.equal(checked.deploymentRecorded,false);}
});
test('changed source, missing CORS or cache policy and unexpected status are not accepted as live proof',async()=>{
 for(const changed of [{status:200,headers},{status:401,headers:{...headers,'x-primecare-voice-contact-source':'b'.repeat(40)}},{status:401,headers:{...headers,'access-control-allow-origin':'*'}},{status:401,headers:{...headers,'cache-control':'public'}}]){const checked=await verifyNativeContactDeployment(receipt,async()=>new Response('{}',changed));assert.equal(checked.deploymentRecorded,true);assert.equal(checked.boundaryVerified,false);}
});
test('transport outages remain unverified without a retry or private provider details',async()=>{
 let requests=0;const checked=await verifyNativeContactDeployment(receipt,async()=>{requests++;throw Error('private');});assert.equal(requests,1);assert.equal(checked.boundaryVerified,false);assert.equal(JSON.stringify(checked).includes('private'),false);
});

test('readback explains source drift without blessing a different deployment',async()=>{
 const checked=await verifyNativeContactDeployment(receipt,async()=>new Response('{}',{status:401,headers:{...headers,'x-primecare-voice-contact-source':'b'.repeat(40)}}));
 assert.equal(checked.boundaryVerified,false);assert.equal(checked.httpStatus,401);assert.equal(checked.sourceMatchesReceipt,false);assert.equal(checked.observedSourceCommit,'b'.repeat(40));assert.equal(checked.corsMatches,true);assert.equal(checked.noStore,true);
});
