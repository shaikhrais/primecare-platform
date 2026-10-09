import {dataObject} from './database-results';
import templates from './email-templates.json';

/** Static template IDs and required variables are authoritative. Stored or
 * deployment overrides supply bounded plain-text content, never variable rules.
 */
export function validatedEmailTemplate(id:string,value:unknown) {
  if(!Object.hasOwn(templates,id)||!value||typeof value!=='object'||Array.isArray(value))throw Error('Invalid email template');
  const fields=dataObject(value),base=templates[id as keyof typeof templates];
  for(const key of ['subject','title','body']) {
    if(typeof fields[key]!=='string'||!(fields[key] as string).trim()||(fields[key] as string).length>(key==='body'?4000:200))throw Error('Invalid email template');
  }
  if(/[\r\n]/.test(fields.subject as string))throw Error('Invalid email subject');
  const combined=[fields.subject,fields.title,fields.body].join(' ');
  const variables=[...combined.matchAll(/\{\{([a-zA-Z]+)\}\}/g)].map(m=>m[1]);
  if(variables.some(k=>!base.required.includes(k))||base.required.some(k=>!variables.includes(k))||combined.replace(/\{\{[a-zA-Z]+\}\}/g,'').includes('{{'))throw Error('Invalid email placeholders');
  return {subject:fields.subject as string,title:fields.title as string,body:fields.body as string,required:[...base.required]};
}
