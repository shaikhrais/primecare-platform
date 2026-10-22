import {test,after} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import pg from 'pg';
if(!process.env.MFA_TEST_DATABASE_URL)throw Error('Disposable native PostgreSQL required');
const db=new pg.Client({connectionString:process.env.MFA_TEST_DATABASE_URL});await db.connect();
const schema='privileged_'+crypto.randomUUID().replaceAll('-','');await db.query('CREATE SCHEMA '+schema);await db.query('SET search_path TO '+schema);
const migration=readFileSync('packages/database/migrations/20261027_auth_privileged_access.sql','utf8');
after(async()=>{await db.query('DROP SCHEMA '+schema+' CASCADE');await db.end();});
test('schema rollback creates no operational capability tables; repeated apply is idempotent',async()=>{
 await db.query('BEGIN');await db.query(migration);await db.query('ROLLBACK');
 assert.equal((await db.query("SELECT to_regclass('auth_privilege_elevations') AS name")).rows[0].name,null);
 await db.query(migration);const before=(await db.query("SELECT table_name,column_name,data_type,column_default,is_nullable FROM information_schema.columns WHERE table_schema=$1 ORDER BY table_name,ordinal_position",[schema])).rows;
 await db.query(migration);assert.deepEqual((await db.query("SELECT table_name,column_name,data_type,column_default,is_nullable FROM information_schema.columns WHERE table_schema=$1 ORDER BY table_name,ordinal_position",[schema])).rows,before);
 assert.equal(new Set(before.map(row=>row.table_name)).size,3);
});
const scope='["tenant_security_summary"]';
async function elevation({id=crypto.randomUUID(),seconds=900,scopes=scope,hash='a'.repeat(64)}={}){
 await db.query("INSERT INTO auth_privilege_elevations(id,user_id,tenant_id,session_hash,reason,scopes,expires_at) VALUES($1,'actor','home',$2,'Synthetic support validation',$3::jsonb,NOW()+$4*INTERVAL '1 second')",[id,hash,scopes,seconds]);return id;
}
test('database rejects longer expired unknown-action and transferable malformed capability records',async()=>{
 for(const input of [{seconds:901},{seconds:0},{seconds:-1},{scopes:'["clinical_records"]'},{scopes:'["tenant_security_summary","impersonation"]'},{hash:'raw-token'}])await assert.rejects(elevation(input));
 await elevation();
});
test('support requires a stored elevation and consistent explicit approval or revocation state',async()=>{
 const id=await elevation();
 const insert=async(elevationId,state,approvedBy=null,approvedAt=null,revokedBy=null,revokedAt=null)=>db.query("INSERT INTO auth_tenant_support_requests(id,elevation_id,requester_user_id,requester_tenant_id,requester_session_hash,target_tenant_id,ticket,reason,scopes,state,approved_by,approved_at,revoked_by,revoked_at,expires_at) VALUES($1,$2,'actor','home',$3,'target','SYN-1','Synthetic support validation',$4::jsonb,$5,$6,$7,$8,$9,NOW()+INTERVAL '10 minutes')",[crypto.randomUUID(),elevationId,'a'.repeat(64),scope,state,approvedBy,approvedAt,revokedBy,revokedAt]);
 await assert.rejects(insert(crypto.randomUUID(),'pending'));
 await assert.rejects(insert(id,'approved'));
 await assert.rejects(insert(id,'pending','approver',new Date()));
 await assert.rejects(insert(id,'revoked'));
 await insert(id,'pending');await insert(id,'approved','approver',new Date());await insert(id,'revoked',null,null,'actor',new Date());
});
test('capability and audit writes roll back together on audit constraint failure',async()=>{
 const id=crypto.randomUUID();await db.query('BEGIN');await elevation({id});
 await assert.rejects(db.query("INSERT INTO auth_privileged_access_audit(id,actor_user_id,actor_tenant_id,elevation_id,action) VALUES($1,'actor','home',$2,'clinical_access')",[crypto.randomUUID(),id]));await db.query('ROLLBACK');
 assert.equal((await db.query('SELECT id FROM auth_privilege_elevations WHERE id=$1',[id])).rows.length,0);
});
