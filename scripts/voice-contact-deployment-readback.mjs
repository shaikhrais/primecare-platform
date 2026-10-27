import {randomBytes} from 'node:crypto';
import config from '../cloudflare/workers/src/business-tasks/voice-contact-deployment.json' with {type:'json'};
/** Read-only fresh boundary check. A synthetic nonexistent bearer is never an
 * authenticated user and cannot send/check SMS. Historical receipt alone is not
 * accepted as live proof. No request or response body is logged. */
export async function verifyNativeContactDeployment(receipt,transport=globalThis.fetch){
 const result={deploymentRecorded:false,boundaryVerified:false,smsSent:false,authenticatedUserVerified:false};
 if(!receipt||receipt.scope!=='native-own-phone-enrollment-only'||receipt.deployed!==true||receipt.gatewayConnected!==true||receipt.unknownSessionDenied!==true||receipt.unauthenticatedDenied!==true||receipt.foreignOriginDenied!==true||receipt.corsVerified!==true||! /^[a-f0-9]{40}$/.test(receipt.sourceCommit??''))return result;
 try{
  const native=new URL(receipt.nativeOrigin),gateway=new URL(receipt.gatewayOrigin),prefix=config.workerName+'.',suffix='.workers.dev';
  const subdomain=native.hostname.startsWith(prefix)&&native.hostname.endsWith(suffix)?native.hostname.slice(prefix.length,-suffix.length):'';
  if(!/^[a-z0-9][a-z0-9-]{0,62}$/.test(subdomain)||[native,gateway].some(u=>u.protocol!=='https:'||u.username||u.password||u.port)||native.origin!==receipt.nativeOrigin||gateway.origin!==receipt.gatewayOrigin||gateway.hostname!==config.gatewayName+'.'+subdomain+suffix)return result;
  result.deploymentRecorded=true;result.sourceCommit=receipt.sourceCommit;
  const response=await transport(gateway.origin+'/v1/voice/contact/status',{method:'POST',redirect:'error',signal:AbortSignal.timeout(15000),headers:{authorization:'Bearer '+randomBytes(32).toString('base64url'),'content-type':'application/json','user-agent':'PrimeCare-Native-Contact-Readiness/1.0','cache-control':'no-cache',origin:config.appOrigins[0]},body:'{}'});
  try{
   result.httpStatus=response.status;
   const source=response.headers.get('x-primecare-voice-contact-source');
   result.sourceMatchesReceipt=source===receipt.sourceCommit;
   if(/^[a-f0-9]{40}$/.test(source??''))result.observedSourceCommit=source;
   result.noStore=response.headers.get('cache-control')?.includes('no-store')===true;
   result.corsMatches=response.headers.get('access-control-allow-origin')===config.appOrigins[0];
   result.boundaryVerified=response.status===401&&result.sourceMatchesReceipt&&result.noStore&&result.corsMatches;
  }finally{await response.body?.cancel();}
 }catch{}
 return result;
}
