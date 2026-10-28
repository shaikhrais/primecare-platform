import {readFile} from 'node:fs/promises';
import pg from 'pg';
if(process.env.PRIMECARE_DEMO_SEED_AUTHORIZATION!=='APPLY_APPROVED_CODE_ADMIN_DEMO')throw Error('Explicit demo seed authorization required');
const db=new pg.Client({connectionString:process.env.PRODUCTION_DATABASE_URL});await db.connect();
try{
 const migrations=[['20261011_platform_administration',['platform_master_records','platform_administration_audit']],['20261013_growth_marketing',['growth_leads']],['20261013_growth_operations',['growth_calls']],['20261013_growth_contacts',['growth_duplicate_reviews']],['20261014_growth_intake',['growth_intake_links']],['20261015_territory_allocation',['platform_territory_sales','platform_territory_catalog']],['20261016_platform_bundle',['platform_documents','platform_launch','platform_support_tickets','platform_support_messages','platform_routed_enquiries','platform_bundle_audit']],['20261016_territory_intake',['growth_territory_receipts']]];
 const applied=[];
 for(const [migration,tables] of migrations){let missing=false;for(const table of tables)if(!(await db.query('SELECT to_regclass($1) AS name',[table])).rows[0]?.name)missing=true;if(missing){await db.query(await readFile(new URL('../packages/database/migrations/'+migration+'.sql',import.meta.url),'utf8'));applied.push(migration);}}
 if(!(await db.query("SELECT 1 FROM information_schema.columns WHERE table_schema=current_schema() AND table_name='growth_intake_links' AND column_name='source'")).rowCount){await db.query(await readFile(new URL('../packages/database/migrations/20261014_growth_offline.sql',import.meta.url),'utf8'));applied.push('20261014_growth_offline');}
 // This migration inserts the governed planning catalogue with ON CONFLICT DO NOTHING.
 await db.query(await readFile(new URL('../packages/database/migrations/20261015_territory_catalog.sql',import.meta.url),'utf8'));
 console.log(JSON.stringify({schemaReady:true,additiveMigrationsApplied:applied,customerRowsUpdated:0,territoriesAllocated:0}));
}finally{await db.end();}
