export const platformMasterTables=['platform_master_records','platform_administration_audit','platform_administration_requests','platform_administration_rate'];
export async function platformMasterSchemaProfile(db,schema,table){
 if(!/^[a-z][a-z0-9_]*$/.test(schema)||!platformMasterTables.includes(table))throw Error('Invalid platform schema scope');
 const columns=(await db.query(`SELECT a.attname AS name,format_type(a.atttypid,a.atttypmod) AS type,a.attnotnull AS not_null,pg_get_expr(d.adbin,d.adrelid) AS default_value
 FROM pg_attribute a JOIN pg_class c ON c.oid=a.attrelid JOIN pg_namespace n ON n.oid=c.relnamespace LEFT JOIN pg_attrdef d ON d.adrelid=a.attrelid AND d.adnum=a.attnum
 WHERE n.nspname=$1 AND c.relname=$2 AND c.relkind='r' AND a.attnum>0 AND NOT a.attisdropped ORDER BY a.attnum`,[schema,table])).rows;
 const constraints=(await db.query(`SELECT con.contype AS type,pg_get_constraintdef(con.oid,false) AS definition FROM pg_constraint con JOIN pg_class c ON c.oid=con.conrelid JOIN pg_namespace n ON n.oid=c.relnamespace
 WHERE n.nspname=$1 AND c.relname=$2 ORDER BY con.contype,pg_get_constraintdef(con.oid,false)`,[schema,table])).rows;
 const normalize=value=>value.replaceAll('"'+schema+'".','<schema>.').replaceAll(schema+'.','<schema>.');
 const indexes=(await db.query('SELECT indexname AS name,indexdef AS definition FROM pg_indexes WHERE schemaname=$1 AND tablename=$2 ORDER BY indexname',[schema,table])).rows.map(row=>({...row,definition:normalize(row.definition)}));
 return {columns,constraints:constraints.map(row=>({...row,definition:normalize(row.definition)})),indexes};
}
export function platformMasterMigrationBody(sql){
 if(!sql.startsWith('BEGIN;\n')||!sql.endsWith('COMMIT;\n'))throw Error('Reviewed transaction wrapper required');
 return sql.slice('BEGIN;\n'.length,-'COMMIT;\n'.length);
}
