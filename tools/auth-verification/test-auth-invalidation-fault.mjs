// Real PostgreSQL trigger faults. Never run with production credentials.
import {Client} from 'pg';import bcrypt from 'bcryptjs';import {build} from 'esbuild';
import {readFile,mkdtemp,mkdir,writeFile} from 'node:fs/promises';import {execFileSync} from 'node:child_process';
import {tmpdir} from 'node:os';import {join,dirname} from 'node:path';import {createRequire} from 'node:module';
import {randomUUID,createHash} from 'node:crypto';import assert from 'node:assert/strict';
if(process.env.PRODUCTION_DATABASE_URL||process.env.GOVERNANCE_DATABASE_URL)throw Error('Production credentials forbidden');
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');
if(!['localhost','127.0.0.1'].includes(url.hostname)||url.pathname!='/auth_test')throw Error('Disposable loopback auth_test required');
const dir=await mkdtemp(join(tmpdir(),'auth-invalidation-')),handlers={},base='7a875f6511838ecfdfbe6763798a676b3e138aa8';
const old=Object.fromEntries(['password-change.ts','password-recovery.ts','account-management.ts'].map(p=>[p,execFileSync('git',['show',base+':cloudflare/workers/src/'+p],{encoding:'utf8'})]));
for(const mode of ['baseline','candidate']){
 const file=join(dir,mode+'.cjs');
 await build({entryPoints:['cloudflare/workers/src/auth.ts'],outfile:file,bundle:true,platform:'node',format:'cjs',plugins:mode==='candidate'?[]:[{name:'baseline',setup(b){b.onLoad({filter:/(?:password-change|password-recovery|account-management)\.ts$/},a=>({contents:old[a.path.split('/').at(-1)],loader:'ts',resolveDir:dirname(a.path)}));}}]});
 handlers[mode]=createRequire(import.meta.url)(file).auth;
}
const db=new Client({connectionString:url.href});await db.connect();
const ids=[randomUUID(),randomUUID(),randomUUID()],tenant=randomUUID(),foreign=randomUUID(),tokens=['s'.repeat(43),'t'.repeat(43),'u'.repeat(43),'v'.repeat(43)];
const hash=s=>createHash('sha256').update(s).digest('hex'),email=ids[1]+'@example.invalid',password='Owned-old-password-2026',next='Owned-new-password-2026',original=await bcrypt.hash(password,4),code='ABC123ABC123';
const cases=[['change','auth_sessions'],['change','auth_password_resets'],['reset','auth_sessions'],['reset','auth_password_resets'],['manage','auth_sessions']];
const receipt={scope:'password-change/reset/account-management partial invalidation',identity:process.env.AUTH_TEST_ID_TYPE||'uuid',baselineReproductions:[],repairedRollbacks:[],successfulRetries:[],wholeAuthVerified:false};
const call=(mode,operation)=>{const path=operation==='change'?'/change-password':operation==='reset'?'/reset-password':'/admin/users';const body=operation==='change'?{currentPassword:password,newPassword:next}:operation==='reset'?{email,code,newPassword:next}:{id:ids[1],role:'physio',status:'inactive'};return handlers[mode](new Request('https://fixture'+path,{method:'POST',headers:{'content-type':'application/json',...(operation==='reset'?{}:{authorization:'Bearer '+tokens[operation==='change'?1:0]})},body:JSON.stringify(body)}),{SERVICE_NAME:'auth',DB_URL:url.href},path,{});};
const snapshot=async()=>Object.fromEntries(await Promise.all(['users','auth_sessions','auth_password_resets','auth_password_audit','auth_management_audit'].map(async t=>[t,(await db.query('SELECT * FROM '+t+' ORDER BY '+(t==='users'?'id':t==='auth_sessions'||t==='auth_password_resets'?'token_hash':'id'))).rows])));
const seed=async()=>{
 for(const t of ['auth_sessions','auth_password_resets','auth_password_audit','auth_management_audit','auth_rate_limits'])await db.query('DELETE FROM '+t);
 await db.query("UPDATE users SET password_hash=$1,status='active',roles=CASE WHEN id=$2 THEN 'rmt' ELSE 'ceo' END,updated_at=NOW()",[original,ids[1]]);
 for(let n=0;n<4;n++)await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(tokens[n]),ids[n===0?0:n===3?2:1]]);
 for(const [c,id,address] of [[code,ids[1],email],['DEF456DEF456',ids[1],email],['789ABC789ABC',ids[2],ids[2]+'@example.invalid']])await db.query("INSERT INTO auth_password_resets(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '10 minutes')",[hash(address+':'+c),id]);
};
try{
 const text=process.env.AUTH_TEST_ID_TYPE==='text';
 if(text)await db.query('CREATE TABLE users(id TEXT PRIMARY KEY,email TEXT UNIQUE NOT NULL,roles TEXT NOT NULL,password_hash TEXT,status TEXT NOT NULL DEFAULT \'active\')');
 else await db.query(await readFile('services/auth_api/dev_schema.sql','utf8'));
 await db.query('ALTER TABLE users ADD COLUMN IF NOT EXISTS tenant_id '+(text?'TEXT':'UUID'));await db.query('ALTER TABLE users ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP NOT NULL DEFAULT NOW()');
 for(const m of ['20260925_auth_identity_compatibility.sql','20260926_auth_sessions.sql','20260928_auth_rate_limits.sql','20260928_auth_management_audit.sql','20260928_auth_password_audit.sql','20261003_auth_password_resets.sql'])await db.query(await readFile('packages/database/migrations/'+m,'utf8'));
 for(let n=0;n<3;n++)await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,$3,$4,$5,'active')",[ids[n],ids[n]+'@example.invalid',n===1?'rmt':'ceo',n===2?foreign:tenant,original]);
 for(const [operation,table] of cases){
  const retained=table==='auth_sessions'?hash(tokens[1]):hash(email+':DEF456DEF456');
  await db.query("CREATE OR REPLACE FUNCTION fixture_invalidation_fault() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN IF OLD.token_hash='"+retained+"' THEN RETURN NULL; END IF; RETURN OLD; END $$");
  for(const mode of ['baseline','candidate']){
   await seed();await db.query('CREATE TRIGGER fixture_invalidation_fault BEFORE DELETE ON '+table+' FOR EACH ROW EXECUTE FUNCTION fixture_invalidation_fault()');
   try{
    const before=await snapshot(),r=await call(mode,operation),label=operation+':'+table;
    if(mode==='baseline'){
     assert.equal(r.status,200);assert.equal((await db.query('SELECT COUNT(*)::int AS count FROM '+table+' WHERE user_id=$1',[ids[1]])).rows[0].count,1);receipt.baselineReproductions.push(label);
    }else{
     assert.equal(r.status,503);assert.equal(r.headers.get('cache-control'),'no-store');assert.deepEqual(await snapshot(),before);receipt.repairedRollbacks.push(label);
     const error=await r.text();assert(!error.includes(retained)&&!error.includes(password)&&!error.includes('invalidation'));
    }
   }finally{await db.query('DROP TRIGGER fixture_invalidation_fault ON '+table);}
  }
  await seed();const foreignBefore=(await snapshot());const result=await call('candidate',operation);assert.equal(result.status,200);
  assert.equal((await db.query('SELECT COUNT(*)::int AS count FROM auth_sessions WHERE user_id=$1',[ids[1]])).rows[0].count,0);
  if(operation!=='manage'){
   assert.equal((await db.query('SELECT COUNT(*)::int AS count FROM auth_password_resets WHERE user_id=$1',[ids[1]])).rows[0].count,0);
   assert(await bcrypt.compare(next,(await db.query('SELECT password_hash FROM users WHERE id=$1',[ids[1]])).rows[0].password_hash));
   assert.equal((await db.query('SELECT COUNT(*)::int AS count FROM auth_password_audit WHERE user_id=$1',[ids[1]])).rows[0].count,1);
  }else{assert.equal((await db.query('SELECT COUNT(*)::int AS count FROM auth_management_audit WHERE target_user_id=$1',[ids[1]])).rows[0].count,1);}
  const after=await snapshot();for(const key of ['users','auth_sessions','auth_password_resets']){const own=key==='users'?'id':'user_id';assert.deepEqual(after[key].filter(x=>String(x[own])!==ids[1]),foreignBefore[key].filter(x=>String(x[own])!==ids[1]));}
  receipt.successfulRetries.push(operation+':'+table);
 }
 receipt.passed=true;
}catch(e){receipt.error=e.message;throw e;}
finally{await db.query('DROP FUNCTION IF EXISTS fixture_invalidation_fault() CASCADE').catch(()=>{});await db.end();await mkdir('test-results/auth-invalidation',{recursive:true});await writeFile('test-results/auth-invalidation/'+receipt.identity+'.json',JSON.stringify(receipt,null,2));console.log('AUTH_INVALIDATION_FAULT_PROOF '+JSON.stringify(receipt));}
