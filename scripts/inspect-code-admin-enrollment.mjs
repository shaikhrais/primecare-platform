import pg from 'pg';
import {owner,verifyCodeAdminOwnerRegistration} from './code-admin-owner.mjs';
const db=new pg.Client({connectionString:process.env.PRODUCTION_DATABASE_URL,ssl:{rejectUnauthorized:true}});await db.connect();
try{
 await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');await verifyCodeAdminOwnerRegistration(db);
 const rows=(await db.query("SELECT u.status,u.roles,COALESCE(m.enabled,false) AS mfa_enabled,(SELECT COUNT(*)::int FROM auth_sessions s WHERE s.user_id=u.id AND s.expires_at>NOW()) AS active_sessions FROM users u LEFT JOIN auth_mfa_credentials m ON m.user_id=u.id::text WHERE encode(sha256(convert_to(LOWER(u.email),'UTF8')),'hex')=$1 LIMIT 2",[owner.emailSha256])).rows;
 if(rows.length>1)throw Error('Ambiguous approved owner');const row=rows[0];
 const result={ownerBound:true,accountExists:!!row,codeAdmin:row?.roles==='code_admin',pendingEnrollment:row?.roles==='code_admin'&&row.status==='mfa_pending',mfaEnabled:row?.mfa_enabled===true,activated:row?.roles==='code_admin'&&row.status==='active'&&row.mfa_enabled===true,activeSessions:row?.active_sessions??0};
 await db.query('ROLLBACK');console.log('CODE_ADMIN_ENROLLMENT_STATUS '+JSON.stringify(result));
}finally{await db.end();}
