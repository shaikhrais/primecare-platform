import templates from './email-templates.json';
export interface MailEnv { RESEND_API_KEY?:string; EMAIL_FROM?:string }
export type EmailTemplate = keyof typeof templates;
const escape=(value:string)=>value.replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));
/** One shared renderer. Templates contain plain text, never executable HTML. */
export function renderEmail(id:EmailTemplate,values:Record<string,string>) {
 const template=templates[id];
 if(!template || template.required.some(key=>typeof values[key]!=='string' || !values[key]))throw new Error('Missing template variables');
 const interpolate=(text:string)=>text.replace(/\{\{([a-zA-Z]+)\}\}/g,(_,key)=>values[key]??'');
 const subject=interpolate(template.subject).replace(/[\r\n]/g,' ');
 const title=interpolate(template.title),text=interpolate(template.body);
 return {subject,text,html:`<!doctype html><html><body style="font-family:Arial,sans-serif;color:#172d3b;max-width:600px;margin:auto;padding:32px"><h2>PrimeCare</h2><h1>${escape(title)}</h1><p style="line-height:1.6">${escape(text)}</p><hr><p>PrimeCare · Automated message. Do not reply with passwords or medical information.</p></body></html>`};
}
/** All email callers use this adapter; provider credentials stay on the server. */
export async function sendEmail(env:MailEnv,to:string,id:EmailTemplate,values:Record<string,string>,idempotencyKey:string) {
 if(!env.RESEND_API_KEY || !env.EMAIL_FROM)throw new Error('Email delivery unavailable');
 const message=renderEmail(id,values);
 const response=await fetch('https://api.resend.com/emails',{method:'POST',signal:AbortSignal.timeout(10000),
  headers:{authorization:`Bearer ${env.RESEND_API_KEY}`,'content-type':'application/json','idempotency-key':idempotencyKey},
  body:JSON.stringify({from:env.EMAIL_FROM,to:[to],...message})});
 if(!response.ok)throw new Error('Email delivery unavailable');
 const data=await response.json() as {id?:string};
 if(!data.id)throw new Error('Email delivery unavailable');
 return data.id;
}
