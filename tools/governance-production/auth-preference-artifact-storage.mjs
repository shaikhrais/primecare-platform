/** Respect the pinned governance import's tagged JSONB representation and internal row key. */
export async function artifactStorage(db,pin,manifest){
 const table=manifest?.tables?.find(t=>t.name==='runtime_artifacts');if(!table||!Array.isArray(table.columns)||new Set(table.columns.map(c=>c.name)).size!==table.columns.length||table.columns.some(c=>!Array.isArray(c.storage_types)||c.storage_types.length>1))throw Error('Pinned artifact storage definition required');
 const expected={_primecare_import_row:'bigint',...Object.fromEntries(table.columns.map(c=>[c.name,({integer:'bigint',text:'text',real:'double precision',blob:'bytea'})[c.storage_types[0]]??'jsonb']))};
 const rows=(await db.query('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=$1 AND table_name=$2 ORDER BY ordinal_position',[pin.schema,pin.tablePrefix+'runtime_artifacts'])).rows;const actual=Object.fromEntries(rows.map(r=>[r.column_name,r.data_type]));if(Object.keys(actual).length!==Object.keys(expected).length||Object.keys(expected).some(k=>actual[k]!==expected[k]))throw Error('Physical artifact storage differs from the pinned manifest');
 const column=name=>{const c=table.columns.find(c=>c.name===name);if(!c)throw Error('Unknown artifact column');return c;};
 const integer=c=>c.declared_type.toUpperCase().includes('INT');const text=c=>['TEXT','CHAR','CLOB'].some(t=>c.declared_type.toUpperCase().includes(t));
 return {
  encode(name,value){const c=column(name);if(value===null||c.storage_types.length)return value;if(integer(c)&&Number.isSafeInteger(value))return JSON.stringify({t:'integer',v:String(value)});if(text(c)&&typeof value==='string')return JSON.stringify({t:'text',v:value});throw Error('Unsupported tagged artifact value');},
  decode(name,value){const c=column(name);if(value===null)return null;if(c.storage_types.length)return c.storage_types[0]==='integer'?Number(value):value;if(!value||typeof value!=='object'||Object.keys(value).sort().join(',')!=='t,v')throw Error('Invalid tagged artifact readback');if(integer(c)&&value.t==='integer'&&typeof value.v==='string'&&/^-?\d+$/.test(value.v)&&Number.isSafeInteger(Number(value.v)))return Number(value.v);if(text(c)&&value.t==='text'&&typeof value.v==='string')return value.v;throw Error('Unexpected artifact storage tag');},
 };
}
