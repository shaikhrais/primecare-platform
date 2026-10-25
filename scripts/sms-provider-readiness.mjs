import {mkdir,writeFile} from 'node:fs/promises';
import {pathToFileURL} from 'node:url';
export async function smsProviderReadiness(env,{fetch:request=globalThis.fetch}={}){
 const report={readbackVerified:false,smsCapable:false,inboundWebhookConfigured:false,messagingServiceLinked:false,routingChanged:false,messagesSent:0,receiveReplyVerified:false};
 const account=env.TWILIO_ACCOUNT_SID,key=env.TWILIO_API_KEY_SID,secret=env.TWILIO_API_KEY_SECRET;
 if(!/^AC[a-f0-9]{32}$/i.test(account??'')||!/^SK[a-f0-9]{32}$/i.test(key??'')||typeof secret!=='string'||secret.length<16)return {...report,status:'credentials_missing'};
 try{
  const response=await request(`https://api.twilio.com/2010-04-01/Accounts/${account}/IncomingPhoneNumbers/PN14d5f063ed5b5412c444922d3a4b4fd1.json`,{method:'GET',redirect:'error',headers:{authorization:'Basic '+Buffer.from(key+':'+secret).toString('base64')},signal:AbortSignal.timeout(15000)});
  if(!response.ok){await response.body?.cancel();return {...report,status:'provider_read_denied'};}
  const reader=response.body?.getReader();if(!reader)throw Error();let total=0;const chunks=[];
  try{for(;;){const item=await reader.read();if(item.done)break;total+=item.value.length;if(total>524288)throw Error();chunks.push(item.value);}}finally{await reader.cancel();reader.releaseLock();}
  const row=JSON.parse(Buffer.concat(chunks).toString('utf8'));
  if(row.account_sid!==account||row.sid!=='PN14d5f063ed5b5412c444922d3a4b4fd1'||row.phone_number!=='+16479302223')return {...report,status:'resource_mismatch'};
  report.readbackVerified=true;report.smsCapable=row.capabilities?.sms===true;
  report.inboundWebhookConfigured=typeof row.sms_url==='string'&&row.sms_url.length>0;
  report.messagingServiceLinked=/^MG[a-f0-9]{32}$/i.test(row.messaging_service_sid??'');
  return {...report,status:'configuration_read_only'};
 }catch{return {...report,status:'provider_read_unavailable'};}
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href){
 const report=await smsProviderReadiness(process.env);await mkdir('test-results/sms',{recursive:true});await writeFile('test-results/sms/readiness.json',JSON.stringify(report,null,2)+'\n');console.log('SMS_PROVIDER_READINESS '+JSON.stringify(report));if(!report.readbackVerified)process.exitCode=1;
}
