import templates from './email-templates.json';
import {validatedEmailTemplate} from './email-template-validation';
export interface NativeEmailBinding {
 send(message:{from:string;to:string;subject:string;text:string;html:string}):Promise<{messageId:string}>;
}
export interface MailEnv { EMAIL?:NativeEmailBinding; EMAIL_FROM?:string; EMAIL_ALLOWED_SENDER?:string; EMAIL_TEMPLATES?:Partial<typeof templates> }
/** Parse configured sender without allowing header injection. */
export function emailSender(value:string|undefined) {
 if(typeof value!=='string' || !value || /[\r\n]/.test(value))return null;
 const named=/^([^<>]+)\s*<([^<>]+)>$/.exec(value.trim());
 const email=(named?named[2]:value).trim();
 if(email.length>254 || !/^[^\s<>@]+@[^\s<>@]+\.[^\s<>@]+$/.test(email))return null;
 return {email,...(named?{name:named[1].trim()}: {})};
}
export function mailReady(env:MailEnv) {
 const sender=emailSender(env.EMAIL_FROM);
 return typeof env.EMAIL?.send==='function' && !!sender && (!env.EMAIL_ALLOWED_SENDER || typeof env.EMAIL_ALLOWED_SENDER==='string' && sender.email.toLowerCase()===env.EMAIL_ALLOWED_SENDER.toLowerCase());
}
export type EmailTemplate = keyof typeof templates;
const escape=(value:string)=>value.replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));
/** One shared renderer. Templates contain plain text, never executable HTML. */
export function renderEmail(id:EmailTemplate,values:Record<string,string>,overrides?:Partial<typeof templates>) {
 if(overrides!==undefined&&(!overrides||typeof overrides!=='object'||Array.isArray(overrides)))throw new Error('Invalid email overrides');
 const template=validatedEmailTemplate(id,overrides&&Object.hasOwn(overrides,id)?overrides[id]:templates[id]);
 if(!template || template.required.some(key=>typeof values[key]!=='string' || !values[key]))throw new Error('Missing template variables');
 const interpolate=(text:string)=>text.replace(/\{\{([a-zA-Z]+)\}\}/g,(_,key)=>values[key]??'');
 const subject=interpolate(template.subject).replace(/[\r\n]/g,' ');
 const title=interpolate(template.title),text=interpolate(template.body);
 return {subject,text,html:`<!doctype html><html><body style="font-family:Arial,sans-serif;color:#172d3b;max-width:600px;margin:auto;padding:32px"><h2>PrimeCare</h2><h1>${escape(title)}</h1><p style="line-height:1.6">${escape(text)}</p><hr><p>PrimeCare · Automated message. Do not reply with passwords or medical information.</p></body></html>`};
}
/** Native Cloudflare email transport. No external provider keys or public send endpoint.
 * Cloudflare acceptance is not proof of inbox delivery. Do not retry ambiguous sends here.
 */
export async function sendEmail(env:MailEnv,to:string,id:EmailTemplate,values:Record<string,string>,_idempotencyKey:string) {
 const recipient=emailSender(to);
 if(!mailReady(env) || !recipient)throw new Error('Email delivery unavailable');
 const message=renderEmail(id,values,env.EMAIL_TEMPLATES);
 try {
  const result=await env.EMAIL!.send({from:emailSender(env.EMAIL_FROM)!.email,to:recipient.email,...message});
  const messageId=result?.messageId;
  if(!result || typeof result!=='object' || Array.isArray(result) || typeof messageId!=='string' || !messageId || messageId.trim()!==messageId || /[\u0000-\u001f\u007f]/.test(messageId))throw new Error('Email delivery unavailable');
  return messageId;
 } catch {throw new Error('Email delivery unavailable');}
}
