/** Read-only capability checks using CI secrets. Never returns credentials or mail content. */
import {mkdir,writeFile} from 'node:fs/promises';
import {pathToFileURL} from 'node:url';
export async function inspectEmsSecretCapabilities(env,send=fetch,now=Date.now()){
 const account=env.CLOUDFLARE_ACCOUNT_ID,token=env.CLOUDFLARE_API_TOKEN;
 const report={source:env.GITHUB_SHA??null,observedAt:new Date(now).toISOString(),providerWrites:0,emailMessagesSent:0,mailContentRead:false,secrets:{deploymentConfigured:!!token,analyticsReaderConfigured:!!env.ENDPOINT_ANALYTICS_READ_TOKEN},analytics:[],workers:{}};
 if(!/^[a-f0-9]{32}$/i.test(account??''))return {...report,blocker:'Cloudflare account configuration unavailable'};
 const base='https://api.cloudflare.com/client/v4/accounts/'+account;
 async function request(path,credential,sql){
  if(!credential)return {status:'missing_secret'};
  try{
   const response=await send(base+path,{method:sql?'POST':'GET',headers:{authorization:'Bearer '+credential,...(sql?{'content-type':'text/plain'}:{})},...(sql?{body:sql}:{}),redirect:'error',signal:AbortSignal.timeout(15000)});
   const httpStatus=response.status;
   // Metadata and aggregate-only SQL; bound decoded input even without Content-Length.
   if(!response.body)return {status:'unavailable',httpStatus};
   const reader=response.body.getReader();const chunks=[];let length=0;
   try{while(true){const part=await reader.read();if(part.done)break;length+=part.value.length;if(length>1000000)throw Error('Bound exceeded');chunks.push(part.value);}}finally{await reader.cancel();}
   const bytes=new Uint8Array(length);let offset=0;for(const chunk of chunks){bytes.set(chunk,offset);offset+=chunk.length;}
   let data;try{data=JSON.parse(new TextDecoder().decode(bytes));}catch{return {status:'unavailable',httpStatus};}
   const errorCodes=Array.isArray(data.errors)?data.errors.map(e=>e?.code).filter(n=>typeof n==='number'&&Number.isSafeInteger(n)).slice(0,10):[];
   return {status:response.ok?'responded':'denied_or_unavailable',httpStatus,errorCodes,data};
  }catch{return {status:'unavailable'};}
 }
 // Use the already reviewed Analytics Engine SQL shape; never return queried totals.
 const end=Math.floor((now-120000)/300000)*300000,start=end-300000;
 const date=n=>new Date(n).toISOString().slice(0,19).replace('T',' ');
 const sql=`SELECT SUM(_sample_interval) AS requests FROM primecare_endpoint_traffic_v1 WHERE timestamp >= toDateTime('${date(start)}') AND timestamp < toDateTime('${date(end)}') FORMAT JSON`;
 for(const [credentialName,credential] of [['ENDPOINT_ANALYTICS_READ_TOKEN',env.ENDPOINT_ANALYTICS_READ_TOKEN],['CLOUDFLARE_API_TOKEN',token]]){
  const result=await request('/analytics_engine/sql',credential,sql);
  report.analytics.push({credentialName,status:result.status,httpStatus:result.httpStatus,errorCodes:result.errorCodes,querySucceeded:result.httpStatus===200&&Array.isArray(result.data?.data)&&result.data.rows===result.data.data.length});
 }
 for(const [name,worker] of [['auth','primecare-auth-api'],['inbox','primecare-email-inbox'],['governance','primecare-governance-api'],['gateway','primecare-api-gateway']]){
  const result=await request('/workers/scripts/'+worker+'/settings',token);
  const bindings=result.data?.success===true?result.data.result?.bindings:undefined;
  const available=result.httpStatus===200&&Array.isArray(bindings);
  report.workers[name]={metadataAvailable:available,httpStatus:result.httpStatus,errorCodes:result.errorCodes,...(available?{sendEmailBinding:bindings.some(b=>b.type==='send_email'),inboxStorageBinding:bindings.some(b=>b.name==='INBOX'&&b.type==='kv_namespace'),analyticsDatasetBinding:bindings.some(b=>b.name==='ENDPOINT_ANALYTICS'&&b.type==='analytics_engine'),analyticsReaderSecret:bindings.some(b=>b.name==='ENDPOINT_ANALYTICS_READ_TOKEN'&&b.type==='secret_text')}: {})};
 }
 return report;
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href){
 const report=await inspectEmsSecretCapabilities(process.env);
 await mkdir('test-results/endpoint-management',{recursive:true});
 await writeFile('test-results/endpoint-management/secret-capabilities.json',JSON.stringify(report,null,2)+'\n');
 console.log('EMS_SECRET_CAPABILITIES '+JSON.stringify(report));
}
