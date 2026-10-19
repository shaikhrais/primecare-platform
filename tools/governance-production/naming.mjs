/** Production governance table namespace; SQLite source names remain unchanged. */
export const GOVERNANCE_MANIFEST_TABLE='govt_source_manifest';
export function govtTableName(name){
 if(typeof name!=='string'||!name||name.includes('\0'))throw Error('Invalid governance table name');
 const result=name.startsWith('govt_')?name:'govt_'+name;
 if(Buffer.byteLength(result)>63)throw Error('Prefixed governance table name exceeds PostgreSQL limit');
 return result;
}
