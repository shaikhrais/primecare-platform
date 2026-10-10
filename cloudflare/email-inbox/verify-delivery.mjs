import {readFile} from 'node:fs/promises';
import {randomUUID} from 'node:crypto';
const account=process.env.CLOUDFLARE_ACCOUNT_ID, token=process.env.CLOUDFLARE_API_TOKEN;
async function api(path,method='GET',body) {
 const response=await fetch(`https://api.cloudflare.com/client/v4/accounts/${account}${path}`,{method,headers:{Authorization:`Bearer ${token}`,'Content-Type':'application/json'},...(body?{body:JSON.stringify(body)}:{}),signal:AbortSignal.timeout(30000)});
 const payload=await response.json();
 if(!response.ok||!payload.success)throw new Error(`Cloudflare HTTP ${response.status}; codes ${(payload.errors||[]).map(x=>x.code).join(',')}`);
 return payload;
}
const namespaces=(await api('/storage/kv/namespaces?per_page=100')).result;
const namespace=namespaces.find(x=>x.title==='primecare-email-inbox');
if(!namespace)throw new Error('Inbox namespace missing');
const templates=JSON.parse(await readFile('cloudflare/workers/src/email-templates.json','utf8'));
const nonce=randomUUID(), pending=new Map();
for(const [id,template]of Object.entries(templates)){
 const subject=`${template.subject} [QA ${nonce} ${id}]`;
 const address=id==='password_reset'?'auth-test@15minutes-email.com':'temp@15minutes-email.com';
 const text=template.body.replace(/\{\{(\w+)\}\}/g,(_,key)=>({code:'QA0000000000',name:'Synthetic QA',support:'auth-test@15minutes-email.com',date:'Synthetic date',location:'Synthetic location',amount:'CAD 0.00',reference:nonce,message:'Synthetic security notice'}[key]||'Synthetic QA'));
 const result=(await api('/email/sending/send','POST',{from:'noreply@15minutes-email.com',to:address,subject,text})).result;
 if(result?.permanent_bounces?.length)throw new Error(`Synthetic ${id} bounced`);
 pending.set(subject,{id,address}); console.log(`Provider accepted: ${id}`);
}
const deadline=Date.now()+180000;
while(pending.size&&Date.now()<deadline){
 let cursor;
 do{
  const payload=await api(`/storage/kv/namespaces/${namespace.id}/keys?prefix=inbox%2F&limit=1000${cursor?'&cursor='+encodeURIComponent(cursor):''}`);
  for(const key of payload.result){
   const response=await fetch(`https://api.cloudflare.com/client/v4/accounts/${account}/storage/kv/namespaces/${namespace.id}/values/${encodeURIComponent(key.name)}`,{headers:{Authorization:`Bearer ${token}`},signal:AbortSignal.timeout(30000)});
   if(!response.ok)continue;
   const mail=await response.json(), expected=pending.get(mail.subject);
   if(expected){
    if(mail.to!==expected.address||!mail.rawBase64||mail.size<1)throw new Error('Stored envelope or MIME invalid');
    if(expected.address.startsWith('temp@')&&!key.expiration)throw new Error('Temporary message lacks expiration');
    if(expected.address.startsWith('auth-test@')&&key.expiration)throw new Error('Permanent message unexpectedly expires');
    console.log(`Private storage receipt verified: ${expected.id}`);pending.delete(mail.subject);
   }
  }
  cursor=payload.result_info?.cursor;
 }while(cursor);
 if(pending.size)await new Promise(resolve=>setTimeout(resolve,10000));
}
if(pending.size)throw new Error(`Missing receipts: ${[...pending.values()].map(x=>x.id).join(',')}`);
console.log('PASS: All eight synthetic template messages received and stored; both retention policies verified. Application workflow triggers require separate tests.');
