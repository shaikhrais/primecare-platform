import pg from 'pg';const {Client}=pg;import bcrypt from 'bcryptjs';import {pathToFileURL} from 'node:url';import {randomUUID} from 'node:crypto';import {validateBootstrap} from './bootstrap-validation.mjs';
import {validateCodeAdminOwner,verifyCodeAdminOwnerRegistration} from './code-admin-owner.mjs';
/** Protected operator workflow only. Never promote or overwrite an existing account. */
export async function bootstrapCodeAdmin(db,input){
 const {email,tenant,password}=validateBootstrap(input);const hash=await bcrypt.hash(password,12);await db.query('BEGIN');
 try{
  await db.query("SELECT pg_advisory_xact_lock(hashtext('first-code-admin'))");
  if((await db.query("SELECT id FROM tenants WHERE id=$1 AND LOWER(status)='active' FOR SHARE",[tenant])).rows.length!==1)throw Error('Active root tenant required');
  if((await db.query("SELECT id FROM users WHERE roles='code_admin' LIMIT 1")).rows.length)throw Error('First Code administrator already exists');
  await db.query('SELECT pg_advisory_xact_lock(hashtext($1))',[email]);
  if((await db.query('SELECT id FROM users WHERE LOWER(email)=$1 LIMIT 1',[email])).rows.length)throw Error('Existing account cannot be overwritten');
  const id=randomUUID();const result=await db.query("INSERT INTO users(email,tenant_id,roles,password_hash,status,id,updated_at) VALUES($1,$2,'code_admin',$3,'active',$4,NOW()) RETURNING id,email,tenant_id,roles,status",[email,tenant,hash,id]);
  if(result.rows.length!==1||result.rows[0].id!==id||result.rows[0].email!==email||result.rows[0].tenant_id!==tenant||result.rows[0].roles!=='code_admin'||result.rows[0].status!=='active')throw Error('Bootstrap identity not persisted');
  const audit=await db.query("INSERT INTO auth_bootstrap_audit(user_id,tenant_id,source) VALUES($1,$2,'protected_workflow') RETURNING user_id,tenant_id,source",[id,tenant]);
  if(audit.rows.length!==1||audit.rows[0].user_id!==id||audit.rows[0].tenant_id!==tenant||audit.rows[0].source!=='protected_workflow')throw Error('Bootstrap audit not persisted');
  await db.query('COMMIT');return {created:true};
 }catch(error){await db.query('ROLLBACK');throw error;}
}
async function main(){
 if(process.env.CONFIRM_BOOTSTRAP!=='CREATE_FIRST_CODE_ADMIN')throw Error('Explicit confirmation required');
 if(!process.env.PRODUCTION_DATABASE_URL)throw Error('Database secret required');
 const input=validateBootstrap({email:validateCodeAdminOwner(process.env.BOOTSTRAP_CODE_ADMIN_EMAIL),tenant:process.env.BOOTSTRAP_TENANT_ID,password:process.env.BOOTSTRAP_CODE_ADMIN_PASSWORD});
 const db=new Client({connectionString:process.env.PRODUCTION_DATABASE_URL,ssl:{rejectUnauthorized:true}});await db.connect();try{await verifyCodeAdminOwnerRegistration(db);console.log(JSON.stringify(await bootstrapCodeAdmin(db,input)));}finally{await db.end();}
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)main().catch(()=>{console.error('Code admin bootstrap failed; credentials and database details are not logged.');process.exitCode=1;});
