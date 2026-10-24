import {mkdir,writeFile} from 'node:fs/promises';
import {pathToFileURL} from 'node:url';

// Read-only checks against fixed provider hosts. No calls, messages, number
// changes, model prompts, credential values or response bodies enter reports.
const phoneSid='PN14d5f063ed5b5412c444922d3a4b4fd1';
const sharedNumber='+16479302223';
const sid=(value,prefix)=>typeof value==='string'&&new RegExp('^'+prefix+'[a-fA-F0-9]{32}$').test(value);
const secret=value=>typeof value==='string'&&value.length>=16&&value.length<=512&&!/\s/.test(value);
export async function voiceProviderPreflight(env,{fetch:request=globalThis.fetch}={}){
 const checks=[];
 async function check(name,ready,url,authorization,valid){
  if(!ready){checks.push({name,status:'missing_or_invalid_configuration'});return;}
  let status='unavailable';
  try{
   const response=await request(url,{method:'GET',redirect:'error',headers:{authorization,accept:'application/json'},signal:AbortSignal.timeout(15000)});
   if(!response.ok){status=response.status===401||response.status===403?'authentication_denied':response.status===404?'resource_not_found':'provider_unavailable';await response.body?.cancel();}
   else {
    const reader=response.body?.getReader();if(!reader)throw Error();
    let length=0;const chunks=[];
    try{for(;;){const chunk=await reader.read();if(chunk.done)break;length+=chunk.value.byteLength;if(length>524288)throw Error();chunks.push(chunk.value);}}
    finally{await reader.cancel();reader.releaseLock();}
    const bytes=new Uint8Array(length);let offset=0;for(const chunk of chunks){bytes.set(chunk,offset);offset+=chunk.length;}
    status=valid(JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(bytes)))?'passed':'resource_mismatch';
   }
  }catch{status='unavailable';}
  checks.push({name,status});
 }
 const account=env.TWILIO_ACCOUNT_SID,base=`https://api.twilio.com/2010-04-01/Accounts/${sid(account,'AC')?account:'invalid'}`;
 const basic=(user,password)=>'Basic '+Buffer.from(user+':'+password).toString('base64');
 const accountReady=sid(account,'AC'),keyReady=accountReady&&sid(env.TWILIO_API_KEY_SID,'SK')&&secret(env.TWILIO_API_KEY_SECRET);
 const authReady=accountReady&&secret(env.TWILIO_AUTH_TOKEN);
 const numberValid=row=>row.account_sid===account&&row.sid===phoneSid&&row.phone_number===sharedNumber&&row.capabilities?.voice===true;
 await check('twilio_account_token',authReady,base+'/IncomingPhoneNumbers/'+phoneSid+'.json',authReady?basic(account,env.TWILIO_AUTH_TOKEN):'',numberValid);
 await check('twilio_api_key',keyReady,base+'/IncomingPhoneNumbers/'+phoneSid+'.json',keyReady?basic(env.TWILIO_API_KEY_SID,env.TWILIO_API_KEY_SECRET):'',numberValid);
 const verifyReady=keyReady&&sid(env.TWILIO_VERIFY_SERVICE_SID,'VA');
 await check('twilio_verify_service',verifyReady,'https://verify.twilio.com/v2/Services/'+(verifyReady?env.TWILIO_VERIFY_SERVICE_SID:'invalid'),keyReady?basic(env.TWILIO_API_KEY_SID,env.TWILIO_API_KEY_SECRET):'',row=>row.account_sid===account&&row.sid===env.TWILIO_VERIFY_SERVICE_SID);
 await check('openai_api_key',secret(env.OPENAI_API_KEY),'https://api.openai.com/v1/models',secret(env.OPENAI_API_KEY)?'Bearer '+env.OPENAI_API_KEY:'',row=>row.object==='list'&&Array.isArray(row.data)&&row.data.length>0);
 return {purpose:'Read-only provider credential and owned resource checks; no model generation or traffic.',checks,providersValidated:checks.every(row=>row.status==='passed'),runtimeMounted:false,liveCallVerified:false,numberRoutingChanged:false};
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href){
 const report=await voiceProviderPreflight(process.env);
 await mkdir('test-results/voice-runtime',{recursive:true});
 await writeFile('test-results/voice-runtime/provider-preflight.json',JSON.stringify(report,null,2)+'\n');
 console.log('VOICE_PROVIDER_PREFLIGHT '+JSON.stringify(report));
 if(!report.providersValidated)process.exitCode=1;
}
