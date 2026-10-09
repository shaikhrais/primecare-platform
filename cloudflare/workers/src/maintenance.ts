import {requiredRow} from './database-results';
import {accountId} from './account-read-projection';
import {singleConfiguration,configuredMailFields,configurationRevision,configurationUpdatedAt,configurationAudit} from './maintenance-projection';
import type {Client} from 'pg';
import templates from './email-templates.json';
import {sendEmail,mailReady,emailSender,type MailEnv} from './email';
export interface MaintenanceEnv extends MailEnv {CONFIG_ENCRYPTION_KEY?:string}
export const maintenanceRoles=['ceo','maintenance'];
type Template=typeof templates.password_reset;
export function validateSettings(v:Record<string,unknown>) {
 if(Object.keys(v).some(k=>!['sender','templates','revision'].includes(k)) || !Number.isSafeInteger(v.revision) || Number(v.revision)<0 || Number(v.revision)>2147483646)return null;
 const sender=typeof v.sender==='string'?v.sender.trim():'';
 if(sender.length>254 || /[\r\n]/.test(sender) || !/^[^\s<>@]+@[^\s<>@]+\.[^\s<>@]+$/.test(sender))return null;
 if(!v.templates || typeof v.templates!=='object' || Array.isArray(v.templates))return null;
 const overrides:Record<string,Template>={};
 for(const [id,value] of Object.entries(v.templates)) {
  if(!Object.hasOwn(templates,id) || !value || typeof value!=='object' || Array.isArray(value))return null;
  const fields=value as Record<string,unknown>,base=templates[id as keyof typeof templates];
  if(Object.keys(fields).some(k=>!['subject','title','body'].includes(k)))return null;
  for(const key of ['subject','title','body'])if(typeof fields[key]!=='string' || !(fields[key] as string).trim() || (fields[key] as string).length>(key==='body'?4000:200))return null;
  if(/[\r\n]/.test(fields.subject as string))return null;
  const combined=[fields.subject,fields.title,fields.body].join(' ');
  const variables=[...combined.matchAll(/\{\{([a-zA-Z]+)\}\}/g)].map(m=>m[1]);
  if(variables.some(k=>!base.required.includes(k)) || base.required.some(k=>!variables.includes(k)))return null;
  if(combined.replace(/\{\{[a-zA-Z]+\}\}/g,'').includes('{{'))return null;
  overrides[id]={subject:fields.subject as string,title:fields.title as string,body:fields.body as string,required:base.required};
 }
 return {sender,templates:overrides,revision:Number(v.revision)};
}
async function encryptionKey(env:MaintenanceEnv) {
 if(!/^[a-f0-9]{64}$/i.test(env.CONFIG_ENCRYPTION_KEY??''))throw new Error('Configuration encryption unavailable');
 const bytes=Uint8Array.from(env.CONFIG_ENCRYPTION_KEY!.match(/../g)!,v=>parseInt(v,16));
 return crypto.subtle.importKey('raw',bytes,'AES-GCM',false,['encrypt','decrypt']);
}
export async function encryptCredential(env:MaintenanceEnv,value:string,tenant:string) {
 const iv=crypto.getRandomValues(new Uint8Array(12));
 const data=await crypto.subtle.encrypt({name:'AES-GCM',iv,additionalData:new TextEncoder().encode(tenant)},await encryptionKey(env),new TextEncoder().encode(value));
 return btoa(String.fromCharCode(...iv))+'.'+btoa(String.fromCharCode(...new Uint8Array(data)));
}
export async function decryptCredential(env:MaintenanceEnv,value:string,tenant:string) {
 const [iv,data]=value.split('.');
 const result=await crypto.subtle.decrypt({name:'AES-GCM',iv:Uint8Array.from(atob(iv),c=>c.charCodeAt(0)),additionalData:new TextEncoder().encode(tenant)},await encryptionKey(env),Uint8Array.from(atob(data),c=>c.charCodeAt(0)));
 return new TextDecoder().decode(result);
}
export async function configuredMail(db:Client,env:MaintenanceEnv,tenant:string):Promise<MailEnv> {
 const row=singleConfiguration((await db.query('SELECT sender,api_key_ciphertext,templates FROM tenant_mail_configuration WHERE tenant_id=$1',[tenant])).rows);
 if(!row)return env;
 const mail=configuredMailFields(row);
 return {...env,EMAIL_FROM:mail.sender,EMAIL_TEMPLATES:mail.templates};
}
/** Called only after live session authorization and tenant binding, under transaction locks. */
export async function maintenance(db:Client,env:MaintenanceEnv,actor:{id:string;tenant_id:string;roles:string;email:string},method:string,path:string,body:Record<string,unknown>) {
 if(!actor.tenant_id || !maintenanceRoles.includes(actor.roles))return {status:403,body:{error:'Maintenance access required'}};
 const tenant=String(actor.tenant_id);
 if(method==='GET') {
  const row=singleConfiguration((await db.query('SELECT sender,api_key_ciphertext,templates,revision,updated_at FROM tenant_mail_configuration WHERE tenant_id=$1',[tenant])).rows);
  const mail=row?configuredMailFields(row):null;
  const revision=row?configurationRevision(row.revision):0;
  const updatedAt=row?configurationUpdatedAt(row.updated_at):null;

  const encryptionReady=/^[a-f0-9]{64}$/i.test(env.CONFIG_ENCRYPTION_KEY??'');
  return {status:200,body:{sender:mail?.sender??env.EMAIL_FROM??'',provider:'cloudflare',keyConfigured:false,bindingConfigured:!!env.EMAIL,settingsReady:true,encryptionReady,revision,updatedAt,templates:{...templates,...mail?.templates},emailReady:mailReady({...env,EMAIL_FROM:mail?.sender??env.EMAIL_FROM}),deliveryVerified:false,pending:[
   ...(!env.EMAIL?['Deployment administrator: deploy the native Cloudflare EMAIL binding.']:[]),
   'IT: onboard the sender domain under Cloudflare Email Service > Email Sending. General recipient delivery requires Workers Paid; free sending is limited to verified destination addresses.',
   ...(!mailReady({...env,EMAIL_FROM:mail?.sender??env.EMAIL_FROM})?['IT: save the configured Cloudflare sender email.']:[]),
   'IT: send a test email to your own account and check inbox/spam; a provider acceptance is not proof of delivery.',
   'IT: test Forgot Password on Android, including a complete reset and sign-in.',
   'Developers: connect the remaining email templates to their appointment, invitation and payment events.'
  ],externalConfiguration:[{name:'API gateway URL',value:'https://primecare-api-gateway.itpro-mohammed.workers.dev',instructions:'Build-time setting. Update Android workflow and rebuild the APK to change it.'},{name:'Database connection',value:'Configured on the server',instructions:'Deployment administrator manages PRODUCTION_DATABASE_URL / DB_URL. Never copy it into an app.'},{name:'Cloudflare credentials',value:'Deployment only',instructions:'Deployment administrator manages CLOUDFLARE_API_TOKEN and CLOUDFLARE_ACCOUNT_ID in GitHub secrets.'},{name:'Encryption key',value:encryptionReady?'Configured':'Pending',instructions:'Server-only CONFIG_ENCRYPTION_KEY. Back up securely. Do not rotate without re-encrypting stored keys.'}],audit:configurationAudit((await db.query('SELECT action,created_at FROM tenant_configuration_audit WHERE tenant_id=$1 ORDER BY created_at DESC LIMIT 20',[tenant])).rows)}};
 }
 if(path.endsWith('/test-email')) {
  if(Object.keys(body).length)return {status:400,body:{error:'Test email always goes to your signed-in account'}};
  try {const mail=await configuredMail(db,env,tenant);await sendEmail(mail,actor.email,'security_notice',{message:'PrimeCare maintenance email test.',support:'your IT team'},'maintenance-test-'+crypto.randomUUID());}
  catch {return {status:503,body:{error:'Email provider did not accept the test. Check Cloudflare sender verification, recipient eligibility and EMAIL binding.'}};}
  confirmConfigurationAudit((await db.query("INSERT INTO tenant_configuration_audit(tenant_id,actor_user_id,action) VALUES($1,$2,'test_email_accepted') RETURNING tenant_id,actor_user_id,action",[tenant,actor.id])).rows,tenant,actor.id,'test_email_accepted');
  return {status:200,body:{message:'Provider accepted the test. Check your inbox/spam to confirm delivery.'}};
 }
 const input=validateSettings(body);
 if(!input)return {status:400,body:{error:'Invalid settings. Use a sender email and retain all required template placeholders.'}};
 const existing=singleConfiguration((await db.query('SELECT revision,api_key_ciphertext FROM tenant_mail_configuration WHERE tenant_id=$1 FOR UPDATE',[tenant])).rows);
 const revision=existing?configurationRevision(existing.revision):0;
 if(existing && !(existing.api_key_ciphertext===null || typeof existing.api_key_ciphertext==='string'))throw Error('Invalid retained credential');
 if(revision!==input.revision)return {status:409,body:{error:'Settings changed. Reload before saving.'}};
 if(env.EMAIL_ALLOWED_SENDER && emailSender(input.sender)?.email.toLowerCase()!==env.EMAIL_ALLOWED_SENDER.toLowerCase())return {status:400,body:{error:'Use the sender address configured for the Cloudflare Worker.'}};
 // Retain legacy encrypted credentials for rollback; native delivery never reads them.
 const ciphertext=existing?.api_key_ciphertext??null;
 const saved=requiredRow((await db.query('INSERT INTO tenant_mail_configuration(tenant_id,sender,api_key_ciphertext,templates,revision,updated_at) VALUES($1,$2,$3,$4,1,NOW()) ON CONFLICT(tenant_id) DO UPDATE SET sender=$2,api_key_ciphertext=$3,templates=$4,revision=tenant_mail_configuration.revision+1,updated_at=NOW() RETURNING tenant_id,sender,api_key_ciphertext,templates,revision,updated_at',[tenant,input.sender,ciphertext,JSON.stringify(input.templates)])).rows);
 const savedMail=configuredMailFields(saved);
 if(saved.tenant_id!==tenant || savedMail.sender!==input.sender || saved.api_key_ciphertext!==ciphertext || configurationRevision(saved.revision)!==revision+1)throw Error('Invalid configuration save');
 configurationUpdatedAt(saved.updated_at);
 const expectedKeys=Object.keys(input.templates).sort(),actualKeys=Object.keys(savedMail.templates).sort();
 if(JSON.stringify(expectedKeys)!==JSON.stringify(actualKeys) || expectedKeys.some(id=>['subject','title','body'].some(field=>savedMail.templates[id as keyof typeof templates]![field as keyof Template]!==input.templates[id][field as keyof Template])))throw Error('Invalid saved template');
 confirmConfigurationAudit((await db.query("INSERT INTO tenant_configuration_audit(tenant_id,actor_user_id,action) VALUES($1,$2,'email_configuration_changed') RETURNING tenant_id,actor_user_id,action",[tenant,actor.id])).rows,tenant,actor.id,'email_configuration_changed');
 return {status:200,body:{message:'Settings saved. Send a test email to check delivery.'}};
}

/** Caller rolls back unconfirmed audit writes together with the setting save. */
function confirmConfigurationAudit(rows:unknown,tenant:string,actor:string,action:string) {
 const row=requiredRow(rows);
 if(row.tenant_id!==tenant || accountId(row.actor_user_id)!==actor || row.action!==action)throw Error('Invalid configuration audit write');
}
