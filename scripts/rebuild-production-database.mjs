import {Client} from 'pg';
import bcrypt from 'bcryptjs';
import {randomUUID} from 'node:crypto';
import {readFileSync} from 'node:fs';
import {pathToFileURL} from 'node:url';
import {validateBootstrap} from './bootstrap-first-ceo.mjs';

export async function rebuild(db, manifest, input) {
  const identity=validateBootstrap(input);
  const hash=await bcrypt.hash(identity.password,12);
  const backup='primecare_backup_'+Date.now();
  const expected=manifest.validation.tables;
  if (!manifest.sql || !Array.isArray(manifest.columns) || expected!==new Set(manifest.columns.map(c=>c.table_name)).size) throw new Error('Invalid governed baseline');
  await db.query('BEGIN');
  try {
    await db.query("SET LOCAL lock_timeout='10s'");
    await db.query("SET LOCAL statement_timeout='120s'");
    await db.query("SELECT pg_advisory_xact_lock(hashtext('primecare-database-rebuild'))");
    const before=await db.query("SELECT count(*)::int AS count FROM pg_tables WHERE schemaname='public'");
    // Preserve all original tables and data inside this database. The schema
    // swap and the entire rebuild commit together, or roll back together.
    await db.query('ALTER SCHEMA public RENAME TO '+backup);
    await db.query('CREATE SCHEMA public');
    await db.query('SET LOCAL search_path=public,pg_catalog');
    await db.query(manifest.sql);
    for (const name of Object.keys(manifest.migrations).sort()) {
      const sql=manifest.migrations[name].replace(/^\s*(?:BEGIN|COMMIT);\s*$/gm,'');
      await db.query(sql);
    }
    await db.query("INSERT INTO tenants(id,name,slug,status,updated_at,allowed_vpn_ranges,cors_allowed_origins,cors_allowed_methods,cors_allowed_headers) VALUES ($1,'PrimeCare Admin HQ','primecare-admin','active',NOW(),'',$2,$3,$4)",[identity.tenant,JSON.stringify(input.origins),JSON.stringify(['GET','POST','PATCH','DELETE','OPTIONS']),JSON.stringify(['Content-Type','Authorization'])]);
    const user=randomUUID();
    await db.query("INSERT INTO users(id,email,tenant_id,roles,password_hash,status,updated_at) VALUES ($1,$2,$3,'ceo',$4,'active',NOW())",[user,identity.email,identity.tenant,hash]);
    await db.query("INSERT INTO auth_bootstrap_audit(user_id,tenant_id,source) VALUES ($1,$2,'protected_workflow')",[user,identity.tenant]);
    const after=await db.query("SELECT count(*)::int AS count FROM pg_tables WHERE schemaname='public'");
    if(after.rows[0].count!==expected) throw new Error('Rebuilt table count mismatch');
    const archive=await db.query('SELECT count(*)::int AS count FROM pg_tables WHERE schemaname=$1',[backup]);
    if(archive.rows[0].count!==before.rows[0].count) throw new Error('Archive table count mismatch');
    const cols=await db.query("SELECT table_name,column_name,udt_name,is_nullable FROM information_schema.columns WHERE table_schema='public'");
    const actual=new Map(cols.rows.map(c=>[c.table_name+'.'+c.column_name,c]));
    for(const column of manifest.columns){const a=actual.get(column.table_name+'.'+column.column_name);if(!a||a.udt_name!==column.udt_name||a.is_nullable!==column.is_nullable)throw new Error('Schema mismatch');}
    const users=await db.query('SELECT email,roles,password_hash FROM users');
    if(users.rows.length!==1||users.rows[0].email!==identity.email||users.rows[0].roles!=='ceo'||!await bcrypt.compare(identity.password,users.rows[0].password_hash))throw new Error('CEO verification failed');
    await db.query('COMMIT');
    return {rebuilt:true,tables:expected,ceoCreated:true,backupSchema:backup};
  } catch(error) {await db.query('ROLLBACK');throw error;}
}

if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href){
 let db;
 try {
  if(process.env.CONFIRM_REBUILD!=='REBUILD_PRIMECARE_DATABASE')throw new Error('Confirmation required');
  const url=new URL(process.env.PRODUCTION_DATABASE_URL);
  if(url.hostname!=='pooled.db.prisma.io'||url.pathname!=='/postgres')throw new Error('Unexpected target');
  const manifest=JSON.parse(readFileSync(process.argv[2],'utf8'));
  db=new Client({connectionString:process.env.PRODUCTION_DATABASE_URL,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});
  await db.connect();
  const result=await rebuild(db,manifest,{email:'itpro.mohammed@gmail.com',tenant:'tenant-hq',password:process.env.BOOTSTRAP_CEO_PASSWORD,origins:['https://primecare-clinic.pages.dev','https://primecare-corporate.pages.dev','https://primecare-business-development.pages.dev','https://primecare-franchise.pages.dev','https://primecare-marketing.pages.dev','https://primecare-client.pages.dev','https://primecare-support.pages.dev','https://primecare-governance.pages.dev']});
  console.log(JSON.stringify(result));
 } catch {console.error('Rebuild failed; transaction rolled back if not committed. No credentials logged.');process.exitCode=1;}
 finally {if(db)await db.end();}
}
