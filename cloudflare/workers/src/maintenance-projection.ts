import {dataObject,optionalRow,resultRows} from './database-results';
import {validatedEmailTemplate} from './email-template-validation';
import templates from './email-templates.json';
import {accountTimestamp} from './account-read-projection';

const object=dataObject;
/** Absent configuration uses deployment defaults; ambiguous results never do. */
export function singleConfiguration(rows:unknown):Record<string,unknown>|null {
  return optionalRow(rows);
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
    projected[id as keyof typeof templates]=validatedEmailTemplate(id,value);
  }
  return {sender,templates:projected};
}
export function configurationAudit(rows:unknown) {
  return resultRows(rows,20).map(value=>{
    const row=object(value);
    if(!['email_configuration_changed','test_email_accepted'].includes(row.action as string))throw Error('Invalid maintenance audit action');
    return {action:row.action as string,created_at:accountTimestamp(row.created_at)};
  });
}
