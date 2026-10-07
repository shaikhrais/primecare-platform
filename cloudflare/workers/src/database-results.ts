import {accountId} from './account-read-projection';
/** Validate adapter cardinality before using database rows as authority. */
export function resultRows(value:unknown,maximum=Number.MAX_SAFE_INTEGER):Record<string,unknown>[] {
 if(!Array.isArray(value) || value.length>maximum)throw Error('Invalid database result cardinality');
 return value.map(row=>{
  if(!row || typeof row!=='object' || Array.isArray(row))throw Error('Invalid database result row');
  return row as Record<string,unknown>;
 });
}
export function optionalRow(value:unknown):Record<string,unknown>|null {
 return resultRows(value,1)[0]??null;
}
export function requiredRow(value:unknown):Record<string,unknown> {
 const row=optionalRow(value);
 if(!row)throw Error('Missing database result row');
 return row;
}

/** Owned-read identities remain strings; absent tenants retain denial semantics. */
export function scopedActor(value:unknown):{id:string;tenant_id:string|null}|null {
 const row=optionalRow(value);if(!row)return null;
 const id=accountId(row.id),tenant=row.tenant_id;
 if(tenant===null || tenant===undefined || tenant==='')return {id,tenant_id:null};
 if(typeof tenant!=='string')throw Error('Invalid actor tenant');
 return {id,tenant_id:tenant};
}
export function boundRow(value:unknown,expected:string|null):Record<string,unknown>|null {
 const row=optionalRow(value);
 if(row && accountId(row.id)!==expected)throw Error('Invalid requested record binding');
 return row;
}
