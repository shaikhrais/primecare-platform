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

/** Record pages expose identifiers usable by their existing detail routes. */
export function recordRows(value:unknown,maximum:number):Record<string,unknown>[] {
 const seen=new Set<string>();return resultRows(value,maximum).map(row=>{
  const id=accountId(row.id);if(seen.has(id))throw Error('Duplicate record identity');
  seen.add(id);return row;
 });
}

/** A page cannot contain rows beyond its count in the same read snapshot.
 * Partial pages remain valid; this checks contradictions, not page fullness.
 */
export function pageRows(value:unknown,limit:number,offset:number,total:number):Record<string,unknown>[] {
 if(!Number.isSafeInteger(limit)||limit<1||limit>100||!Number.isSafeInteger(offset)||offset<0||offset>100000||!Number.isSafeInteger(total)||total<0)throw Error('Invalid database pagination');
 const rows=resultRows(value,limit);
 if(rows.length>Math.max(0,total-offset))throw Error('Inconsistent database pagination');
 return rows;
}
