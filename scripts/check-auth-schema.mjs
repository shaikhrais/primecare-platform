import {Client} from 'pg';
import {pathToFileURL} from 'node:url';

// Schema metadata only: never select account records or serialize driver errors.
export const requirements = {
 users:{id:'uuid',email:'text',tenant_id:'uuid',roles:'text',status:'text',password_hash:'text'},
 auth_sessions:{token_hash:'text',user_id:'uuid',expires_at:'timestamptz'},
 auth_account_audit:{actor_user_id:'uuid',target_user_id:'uuid',tenant_id:'uuid',action:'text'},
 auth_bootstrap_audit:{user_id:'uuid',tenant_id:'uuid',source:'text'},
 auth_management_audit:{actor_user_id:'uuid',target_user_id:'uuid',tenant_id:'uuid',previous_state:'jsonb',new_state:'jsonb'},
 auth_password_audit:{user_id:'uuid',action:'text'},
 auth_rate_limits:{subject_hash:'text',attempts:'int4',reset_at:'timestamptz'},
};

export function schemaProblems(rows) {
 const columns=new Map(rows.map(r=>[`${r.table_name}.${r.column_name}`,r.udt_name]));
 const problems=[];
 for(const [table,fields] of Object.entries(requirements)) for(const [column,declaredType] of Object.entries(fields)) {
  const base=columns.get(column==='tenant_id'?'users.tenant_id':'users.id');
  const type=declaredType==='uuid' && ['text','varchar'].includes(base)?'text':declaredType;
  const actual=columns.get(`${table}.${column}`);
  if(actual!==type && !(type==='text' && actual==='varchar'))
   problems.push(`${table}.${column}: expected ${type}, found ${actual??'missing'}`);
 }
 return problems;
}

export function safeFailureReason(error) {
 // Classify known driver/proxy failures without printing the source message.
 const message=typeof error?.message==='string'?error.message:'';
 if(/unsupported startup parameter/i.test(message)) return 'database proxy rejected a startup parameter';
 if(/invalid.*url/i.test(message)) return 'invalid database URL configuration';
 if(/password must be a string/i.test(message)) return 'database password missing from configuration';
 if(/timeout|timed out/i.test(message)) return 'database operation timed out';
 if(/connection terminated/i.test(message)) return 'database connection terminated';
 const reasons={
  '28P01':'database authentication rejected', '28000':'database authorization rejected',
  '42501':'database permission denied', '3D000':'configured database does not exist',
  '42601':'schema inspection SQL syntax error', '42883':'schema inspection function/operator unavailable',
  '42703':'schema inspection column unavailable', '42P01':'schema inspection relation unavailable',
  'ETIMEDOUT':'database connection timed out', 'ECONNREFUSED':'database connection refused',
  'ENOTFOUND':'database hostname could not be resolved', 'ECONNRESET':'database connection reset',
  'SELF_SIGNED_CERT_IN_CHAIN':'database TLS certificate chain rejected',
  'DEPTH_ZERO_SELF_SIGNED_CERT':'database TLS certificate rejected',
  'UNABLE_TO_VERIFY_LEAF_SIGNATURE':'database TLS certificate could not be verified',
 };
 return reasons[error?.code]??'database preflight unavailable (unclassified error)';
}

export async function checkAuthSchema(connectionString) {
 if(!connectionString) throw new Error('Database configuration missing');
 // Client-side timeout avoids startup parameters rejected by pooled proxies.
 const db=new Client({connectionString,connectionTimeoutMillis:10000,query_timeout:10000});
 try {
  await db.connect();
  await db.query('BEGIN READ ONLY');
  const result=await db.query(`SELECT c.relname AS table_name,a.attname AS column_name,t.typname AS udt_name
   FROM pg_class c JOIN pg_attribute a ON a.attrelid=c.oid
   JOIN pg_type t ON t.oid=a.atttypid
   WHERE c.oid=ANY(SELECT to_regclass(x) FROM unnest($1::text[]) x)
   AND a.attnum>0 AND NOT a.attisdropped`,[Object.keys(requirements)]);
  const problems=schemaProblems(result.rows);
  if(!problems.length) {
   const rights=await db.query(`SELECT x AS table_name,
    has_table_privilege(current_user,to_regclass(x),'SELECT') AS readable,
    has_table_privilege(current_user,to_regclass(x),'INSERT') AS insertable
    FROM unnest($1::text[]) x`,[Object.keys(requirements)]);
   for(const row of rights.rows) if(!row.readable||!row.insertable) problems.push(`${row.table_name}: missing SELECT or INSERT privilege`);
  }
  await db.query('ROLLBACK');
  return problems;
 } finally {await db.end();}
}

if(process.argv[1] && import.meta.url===pathToFileURL(process.argv[1]).href) {
 try {
  const problems=await checkAuthSchema(process.env.PRODUCTION_DATABASE_URL);
  if(problems.length){console.error('Auth schema preflight failed:\n'+problems.join('\n'));process.exitCode=1;}
  else console.log('Auth schema metadata preflight passed; no account data read or changed. This does not prove production login.');
 } catch(error) {console.error('Auth schema preflight failed: '+safeFailureReason(error)+'. No credentials logged.');process.exitCode=1;}
}
