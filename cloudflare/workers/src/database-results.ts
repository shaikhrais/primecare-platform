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
