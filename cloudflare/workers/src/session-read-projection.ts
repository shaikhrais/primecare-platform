import {resultRows} from './database-results';
/** Internal session identities validate a page but never enter its response. */
export function sessionRows(value:unknown,maximum:number,currentHash?:string):Record<string,unknown>[] {
 const seen=new Set<string>();return resultRows(value,maximum).map(row=>{
  const hash=row.token_hash;
  if(typeof hash!=='string'||!/^[a-f0-9]{64}$/.test(hash)||seen.has(hash))throw Error('Invalid session identity');
  if(currentHash!==undefined&&(typeof row.current!=='boolean'||row.current!==(hash===currentHash)))throw Error('Invalid current-session binding');
  seen.add(hash);return row;
 });
}
