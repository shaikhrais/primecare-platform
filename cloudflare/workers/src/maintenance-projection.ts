import templates from './email-templates.json';
import {accountTimestamp} from './account-read-projection';

const object=(value:unknown):Record<string,unknown>=>{
  if(!value || typeof value!=='object' || Array.isArray(value))throw Error('Invalid maintenance result');
  return value as Record<string,unknown>;
};
/** Absent configuration uses deployment defaults; ambiguous results never do. */
export function singleConfiguration(rows:unknown):Record<string,unknown>|null {
  if(!Array.isArray(rows) || rows.length>1)throw Error('Invalid maintenance cardinality');
  return rows.length?object(rows[0]):null;
}
export function configurationRevision(value:unknown):number {
  if(typeof value!=='number' || !Number.isSafeInteger(value) || value<1 || value>2147483647)throw Error('Invalid maintenance revision');
  return value;
}
export const configurationUpdatedAt=(value:unknown)=>accountTimestamp(value);

/** Project persisted overrides to the same content/placeholder bounds as the
 * writer. Required variables come from the canonical template, never storage.
 * Extra stored fields are discarded and legacy provider secrets are ignored.
 */
export function configuredMailFields(value:unknown) {
  const row=object(value),sender=row.sender;
  if(typeof sender!=='string' || sender.length>254 || /[\r\n]/.test(sender) || !/^[^\s<>@]+@[^\s<>@]+\.[^\s<>@]+$/.test(sender))throw Error('Invalid maintenance sender');
  const overrides=object(row.templates);
  const projected:Partial<typeof templates>={};
  for(const [id,value] of Object.entries(overrides)) {
    if(!Object.hasOwn(templates,id))throw Error('Invalid maintenance template');
    const fields=object(value),base=templates[id as keyof typeof templates];
    for(const key of ['subject','title','body']) {
      if(typeof fields[key]!=='string' || !(fields[key] as string).trim() || (fields[key] as string).length>(key==='body'?4000:200))throw Error('Invalid maintenance template');
    }
    if(/[\r\n]/.test(fields.subject as string))throw Error('Invalid maintenance subject');
    const combined=[fields.subject,fields.title,fields.body].join(' ');
    const variables=[...combined.matchAll(/\{\{([a-zA-Z]+)\}\}/g)].map(m=>m[1]);
    if(variables.some(k=>!base.required.includes(k)) || base.required.some(k=>!variables.includes(k)) || combined.replace(/\{\{[a-zA-Z]+\}\}/g,'').includes('{{'))throw Error('Invalid maintenance placeholders');
    projected[id as keyof typeof templates]={subject:fields.subject as string,title:fields.title as string,body:fields.body as string,required:[...base.required]};
  }
  return {sender,templates:projected};
}
export function configurationAudit(rows:unknown) {
  if(!Array.isArray(rows) || rows.length>20)throw Error('Invalid maintenance audit');
  return rows.map(value=>{
    const row=object(value);
    if(!['email_configuration_changed','test_email_accepted'].includes(row.action as string))throw Error('Invalid maintenance audit action');
    return {action:row.action as string,created_at:accountTimestamp(row.created_at)};
  });
}
