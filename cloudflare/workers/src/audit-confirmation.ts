import {requiredRow,dataObject} from './database-results';
import {accountId,accountTimestamp} from './account-read-projection';

function sameValue(actual:unknown,expected:unknown):boolean {
 if(expected===null||typeof expected!=='object')return actual===expected;
 if(!actual||typeof actual!=='object'||Array.isArray(actual)||Array.isArray(expected))return false;
 const a=dataObject(actual),e=expected as Record<string,unknown>;
 const keys=Object.keys(e);return Object.keys(a).length===keys.length&&keys.every(k=>Object.hasOwn(a,k)&&sameValue(a[k],e[k]));
}
/** Confirm database persistence inside the caller's transaction, before success. */
export function confirmedAudit(rows:unknown,expected:Record<string,unknown>):void {
 const row=requiredRow(rows);accountId(row.id);accountTimestamp(row.created_at);
 for(const [key,value] of Object.entries(expected))if(!sameValue(row[key],value))throw Error('Invalid persisted account audit');
}
