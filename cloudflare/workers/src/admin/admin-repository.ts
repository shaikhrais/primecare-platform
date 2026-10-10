import bcrypt from 'bcryptjs';
import {randomUUID} from 'node:crypto';
import type {Client} from 'pg';
import {WorkflowFailure,assignableRoles,type AdminRepository,type UserInput} from '../../../../packages/domain/src/workflows/admin-workflow';

export abstract class BaseTenantRepository {
  constructor(protected db:Client, protected tenantId:string){}
}
export class AdminSqlRepository extends BaseTenantRepository implements AdminRepository {
  async audit(offset:number){
    const source=`SELECT 'creation:' || id::text AS id,actor_user_id::text AS actor,target_user_id::text AS target,action,created_at AS "createdAt",NULL::jsonb AS "before",NULL::jsonb AS "after" FROM auth_account_audit WHERE tenant_id=$1
      UNION ALL SELECT 'management:' || id::text,actor_user_id::text,target_user_id::text,CASE WHEN new_state->>'action'='sessions_revoked' THEN 'sessions_revoked' ELSE 'account_updated' END,created_at,
      jsonb_strip_nulls(jsonb_build_object('email',previous_state->>'email','role',previous_state->>'role','status',previous_state->>'status')),
      jsonb_strip_nulls(jsonb_build_object('email',new_state->>'email','role',new_state->>'role','status',new_state->>'status')) FROM auth_management_audit WHERE tenant_id=$1`;
    const count=await this.db.query(`SELECT COUNT(*)::int AS total FROM (${source}) events`,[this.tenantId]);
    const rows=await this.db.query(`SELECT * FROM (${source}) events ORDER BY "createdAt" DESC,id DESC LIMIT 25 OFFSET $2`,[this.tenantId,offset]);
    return {events:rows.rows,total:count.rows[0].total,offset,limit:25};
  }
  async lockedAccount(id:string){
    const result=await this.db.query('SELECT id,roles AS role FROM users WHERE id=$1 AND tenant_id=$2 FOR UPDATE',[id,this.tenantId]);
    return result.rows[0]??null;
  }
  async organization(){
    const result=await this.db.query('SELECT id,name,status FROM tenants WHERE id=$1',[this.tenantId]);
    if(result.rows.length!==1)throw new WorkflowFailure(404,'Organization not found');
    return result.rows[0];
  }
  async users(offset:number){
    const counts=await this.db.query("SELECT COUNT(*)::int AS total, COUNT(*) FILTER (WHERE LOWER(status)='active')::int AS active FROM users WHERE tenant_id=$1",[this.tenantId]);
    const result=await this.db.query("SELECT id,email,roles AS role,CASE WHEN LOWER(status)='active' THEN 'active' ELSE 'inactive' END AS status FROM users WHERE tenant_id=$1 ORDER BY LOWER(email),id LIMIT 25 OFFSET $2",[this.tenantId,offset]);
    return {users:result.rows,total:counts.rows[0].total,active:counts.rows[0].active,offset,limit:25};
  }
  async create(actorId:string, input:UserInput){
    const id=randomUUID();
    const rows=await this.db.query("INSERT INTO users(id,email,roles,status,tenant_id,password_hash,updated_at) VALUES($1,$2,$3,'active',$4,$5,NOW()) RETURNING id,email,roles AS role,status",[id,input.email,input.role,this.tenantId,await bcrypt.hash(input.password!,12)]);
    if(rows.rows.length!==1)throw Error('Account creation failed');
    const audit=await this.db.query("INSERT INTO auth_account_audit(actor_user_id,target_user_id,tenant_id,action) VALUES($1,$2,$3,'account_created') RETURNING id",[actorId,id,this.tenantId]);
    if(audit.rows.length!==1)throw Error('Account audit failed');
    return rows.rows[0];
  }
  async update(actorId:string,id:string,input:UserInput){
    const target=await this.db.query('SELECT id,email,roles,status FROM users WHERE id=$1 AND tenant_id=$2 FOR UPDATE',[id,this.tenantId]);
    if(target.rows.length!==1)throw new WorkflowFailure(404,'Account not found');
    const previous=target.rows[0];
    if(id===actorId || !assignableRoles.includes(previous.roles))throw new WorkflowFailure(403,'Protected account');
    const updated=await this.db.query('UPDATE users SET email=$1,roles=$2,status=$3,updated_at=NOW() WHERE id=$4 AND tenant_id=$5 RETURNING id,email,roles AS role,status',[input.email,input.role,input.status,id,this.tenantId]);
    if(updated.rows.length!==1)throw Error('Account update failed');
    await this.db.query('DELETE FROM auth_sessions WHERE user_id=$1',[id]);
    const audit=await this.db.query('INSERT INTO auth_management_audit(actor_user_id,target_user_id,tenant_id,previous_state,new_state) VALUES($1,$2,$3,$4,$5) RETURNING id',[actorId,id,this.tenantId,JSON.stringify({email:previous.email,role:previous.roles,status:previous.status}),JSON.stringify({email:input.email,role:input.role,status:input.status})]);
    if(audit.rows.length!==1)throw Error('Account audit failed');
    return updated.rows[0];
  }
}
