// This entry point creates only an MFA-pending identity. The existing active-account
// bootstrap readiness lock is never opened by this workflow.
import pg from 'pg';
import {readFileSync} from 'node:fs';
import {bootstrapCodeAdmin} from './bootstrap-first-code-admin.mjs';
import {validateCodeAdminOwner,verifyCodeAdminOwnerRegistration} from './code-admin-owner.mjs';
import {resolveCodeAdminControlTenant} from './bootstrap-code-admin-control-tenant.mjs';
import {validateBootstrap} from './bootstrap-validation.mjs';
if(process.env.MFA_LIVE_PROOF_REQUIRED!=='1')throw Error('Verified MFA deployment required');
const receipt=JSON.parse(readFileSync('test-results/live-mfa/receipt.json'));
if(receipt.passed!==true||receipt.source!==process.env.GITHUB_SHA||receipt.results.length!==3||!['en','fr','es'].every(locale=>receipt.results.some(r=>r.locale===locale&&r.enrolled&&r.noPrematureSession&&r.replayDenied&&r.nativeDatabase&&r.syntheticCleanup)))throw Error('Exact current-source live MFA proof required');
const db=new pg.Client({connectionString:process.env.PRODUCTION_DATABASE_URL,ssl:{rejectUnauthorized:true}});await db.connect();
try{
 await verifyCodeAdminOwnerRegistration(db);const email=validateCodeAdminOwner(process.env.BOOTSTRAP_CODE_ADMIN_EMAIL),tenant=await resolveCodeAdminControlTenant(db);
 const input=validateBootstrap({email,tenant,password:process.env.BOOTSTRAP_CODE_ADMIN_PASSWORD});
 const existing=await db.query('SELECT id,status,roles,tenant_id::text AS tenant_id FROM users WHERE LOWER(email)=$1',[email]);
 if(existing.rows.length){if(existing.rows.length!==1||existing.rows[0].roles!=='code_admin'||existing.rows[0].tenant_id!==tenant||!['mfa_pending','active'].includes(existing.rows[0].status))throw Error('Preserve existing owner account');console.log('CODE_ADMIN_ENROLLMENT '+JSON.stringify({created:false,existingPreserved:true,accountReadyForEnrollment:existing.rows[0].status==='mfa_pending'}));}
 else {await bootstrapCodeAdmin(db,input);console.log('CODE_ADMIN_ENROLLMENT '+JSON.stringify({created:true,status:'mfa_pending',fullAccess:false,authenticatorEnrollmentRequired:true}));}
}finally{await db.end();}
