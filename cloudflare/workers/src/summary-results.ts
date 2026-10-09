import {resultRows} from './database-results';

/** SQL GROUP BY yields unique typed keys and at least one source row per group. */
export function summaryRows(value:unknown,maximum:number,fields:string[],countField='count'):Record<string,unknown>[] {
 const seen=new Set<string>();return resultRows(value,maximum).map(row=>{
  const keys=fields.map(field=>{
   const key=row[field];
   if(key!==null&&typeof key!=='string'&&typeof key!=='boolean'&&!(typeof key==='number'&&Number.isFinite(key)))throw Error('Invalid summary key');
   return key;
  });
  const key=JSON.stringify(keys),count=row[countField];
  if(seen.has(key)||typeof count!=='number'||!Number.isSafeInteger(count)||count<1)throw Error('Invalid summary group');
  seen.add(key);return row;
 });
}
