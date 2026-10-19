import pg from 'pg';
const {Client}=pg;
import bcrypt from 'bcryptjs';
import { pathToFileURL } from 'node:url';
import {randomUUID} from 'node:crypto';

import {validateBootstrap} from './bootstrap-validation.mjs';
export {validateBootstrap} from './bootstrap-validation.mjs';

export async function bootstrap(db, input) {
  const {email,tenant,password}=validateBootstrap(input);
  const hash=await bcrypt.hash(password,12);
  await db.query('BEGIN');
  try {
    const organization=await db.query("SELECT id FROM tenants WHERE id=$1 AND LOWER(status)='active' FOR UPDATE",[tenant]);
    if(organization.rows.length!==1) throw new Error('Active tenant not found');
    // Lock the tenant so simultaneous bootstrap attempts cannot create two initial CEOs.
    const existing=await db.query("SELECT id FROM users WHERE tenant_id=$1 AND roles='ceo' LIMIT 1",[tenant]);
    if(existing.rows.length) throw new Error('CEO already exists; bootstrap is disabled for this tenant');
    await db.query('SELECT pg_advisory_xact_lock(hashtext($1))',[email]);
    const duplicate=await db.query('SELECT id FROM users WHERE LOWER(email)=$1 LIMIT 1',[email]);
    if(duplicate.rows.length) throw new Error('Existing account cannot be promoted or overwritten by bootstrap');
    const id=randomUUID();
    const result=await db.query("INSERT INTO users(email,tenant_id,roles,password_hash,status,id,updated_at) VALUES($1,$2,'ceo',$3,'active',$4,NOW()) RETURNING id,email,tenant_id,roles,status",[email,tenant,hash,id]);
    const user=result.rows[0];
    if(result.rows.length!==1||user.id!==id||user.email!==email||user.tenant_id!==tenant||user.roles!=='ceo'||user.status!=='active')throw Error('Bootstrap identity not persisted');
    const audit=await db.query("INSERT INTO auth_bootstrap_audit(user_id,tenant_id,source) VALUES($1,$2,'protected_workflow') RETURNING user_id,tenant_id,source",[id,tenant]);
    const event=audit.rows[0];
    if(audit.rows.length!==1||event.user_id!==id||event.tenant_id!==tenant||event.source!=='protected_workflow')throw Error('Bootstrap audit not persisted');
    await db.query('COMMIT');
    return {created:true};
  } catch(error) {
    await db.query('ROLLBACK'); throw error;
  }
}

async function main(){
  if(process.env.CONFIRM_BOOTSTRAP!=='CREATE_FIRST_CEO') throw new Error('Explicit bootstrap confirmation is required');
  if(!process.env.PRODUCTION_DATABASE_URL) throw new Error('Missing database secret');
  const input=validateBootstrap({email:process.env.BOOTSTRAP_CEO_EMAIL,tenant:process.env.BOOTSTRAP_TENANT_ID,password:process.env.BOOTSTRAP_CEO_PASSWORD});
  const db=new Client({connectionString:process.env.PRODUCTION_DATABASE_URL,ssl:{rejectUnauthorized:true}});
  await db.connect();try{ console.log(JSON.stringify(await bootstrap(db,input))); }finally{await db.end();}
}
if(process.argv[1] && import.meta.url===pathToFileURL(process.argv[1]).href){
  main().catch(()=>{console.error('CEO bootstrap failed; no credentials or database details are logged.');process.exitCode=1;});
}
