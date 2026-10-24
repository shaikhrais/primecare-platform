import pg from 'pg';
import {mkdir,writeFile} from 'node:fs/promises';
const names=['platform_master_records','platform_administration_audit','platform_administration_requests','platform_administration_rate'];
const db=new pg.Client({connectionString:process.env.PRODUCTION_DATABASE_URL,ssl:{rejectUnauthorized:true}});
try {
 await db.connect();await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
 const {rows}=await db.query("SELECT table_name,column_name,udt_name FROM information_schema.columns WHERE table_schema='public' AND table_name=ANY($1::text[]) ORDER BY table_name,ordinal_position",[names]);
 const missing=names.filter(name=>!rows.some(row=>row.table_name===name));
 const report={tables:names.map(name=>({name,present:!missing.includes(name),columns:rows.filter(row=>row.table_name===name).map(row=>({name:row.column_name,type:row.udt_name}))})),missing,businessRecordsRead:false,writesAttempted:false};
 await mkdir('test-results/platform-master-metadata',{recursive:true});
 await writeFile('test-results/platform-master-metadata/schema.json',JSON.stringify(report,null,2)+'\n');
 console.log('PLATFORM_MASTER_SCHEMA '+JSON.stringify(report));
 await db.query('ROLLBACK');
}catch(error){console.error('PLATFORM_MASTER_SCHEMA_FAILED '+JSON.stringify({code:/^[A-Z0-9]{5}$/.test(error?.code||'')?error.code:null}));process.exitCode=1;}finally{await db.end();}
