// Native fault proof against disposable loopback auth_test only; no production credentials.
import {Client} from 'pg';import {build} from 'esbuild';import {readFile,mkdtemp} from 'node:fs/promises';import {tmpdir} from 'node:os';import {join} from 'node:path';import {randomUUID,createHash} from 'node:crypto';import {createRequire} from 'node:module';import assert from 'node:assert/strict';
if(process.env.PRODUCTION_DATABASE_URL||process.env.GOVERNANCE_DATABASE_URL)throw Error('Production credentials forbidden');
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');if(!['localhost','127.0.0.1'].includes(url.hostname)||url.pathname!='/auth_test')throw Error('Disposable auth_test required');
const db=new Client({connectionString:url.href});await db.connect();const dir=await mkdtemp(join(tmpdir(),'session-revoke-postcondition-'));
const file='cloudflare/workers/src/self-sessions.ts',source=await readFile(file,'utf8');
const anchor="        const previous={sessionCount:count}";
assert(source.includes(anchor));
const guard="        const remaining=exactCount(requiredRow((await db.query('SELECT COUNT(*)::int AS count FROM auth_sessions WHERE user_id=$1',[actor.id])).rows).count);\n        if(remaining!==0)throw Error('Session revocation incomplete');\n";
const fixed=source.replace(anchor,guard+anchor);
const handlers={};
for(const [mode,contents] of [['baseline',source],['candidate',fixed]]){
 const out=join(dir,mode+'.cjs');await build({entryPoints:['cloudflare/workers/src/auth.ts'],outfile:out,bundle:true,platform:'node',format:'cjs',plugins:[{name:'revocation-candidate',setup(b){b.onLoad({filter:/self-sessions\.ts$/},()=>({contents,loader:'ts',resolveDir:join(process.cwd(),'cloudflare/workers/src')}));}}]});handlers[mode]=createRequire(import.meta.url)(out).auth;
}
const ids=[randomUUID(),randomUUID()],tenant=randomUUID(),tokens=['a'.repeat(43),'b'.repeat(43),'c'.repeat(43)],hash=v=>createHash('sha256').update(v).digest('hex');
try{
 await db.query(await readFile('services/auth_api/dev_schema.sql','utf8'));
 await db.query('ALTER TABLE users ADD COLUMN IF NOT EXISTS tenant_id UUID');
 await db.query('ALTER TABLE users ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP NOT NULL DEFAULT NOW()');
 for(const name of ['20260925_auth_identity_compatibility.sql','20260926_auth_sessions.sql','20260928_auth_rate_limits.sql','20260928_auth_management_audit.sql'])await db.query(await readFile('packages/database/migrations/'+name,'utf8'));
 for(const id of ids)await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'rmt',$3,'unused','active')",[id,id+'@example.invalid',tenant]);
 const seed=async()=>{await db.query('DELETE FROM auth_sessions');await db.query('DELETE FROM auth_management_audit');await db.query('DELETE FROM auth_rate_limits');for(let n=0;n<3;n++)await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(tokens[n]),ids[n===2?1:0]]);};
 const snapshot=async()=>({sessions:(await db.query('SELECT * FROM auth_sessions ORDER BY token_hash')).rows,audits:(await db.query('SELECT * FROM auth_management_audit ORDER BY id')).rows});
 const call=mode=>handlers[mode](new Request('https://fixture/user/sessions',{method:'DELETE',headers:{authorization:'Bearer '+tokens[0]}}),{SERVICE_NAME:'auth',DB_URL:url.href},'/user/sessions',{});
 await db.query("CREATE FUNCTION fixture_suppress_own_delete() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN IF OLD.token_hash='"+hash(tokens[0])+"' THEN RETURN NULL; END IF; RETURN OLD; END $$");
 for(const mode of ['baseline','candidate']){
  await seed();await db.query('CREATE TRIGGER fixture_suppress_own_delete BEFORE DELETE ON auth_sessions FOR EACH ROW EXECUTE FUNCTION fixture_suppress_own_delete()');
  try{
   const before=await snapshot(),r=await call(mode);
   if(mode==='baseline'){assert.equal(r.status,200);assert.equal((await r.json()).revokedSessions,1);assert.equal((await db.query('SELECT COUNT(*)::int AS count FROM auth_sessions WHERE user_id=$1',[ids[0]])).rows[0].count,1);console.log('REPRODUCED: baseline acknowledged sign-out while its bearer session remained active');}
   else{assert.equal(r.status,503);assert.equal(r.headers.get('set-cookie'),null);assert.deepEqual(await snapshot(),before);console.log('PASS: candidate rolls back partial deletion and audit, preserves retry session and returns sanitized 503');}
  }finally{await db.query('DROP TRIGGER fixture_suppress_own_delete ON auth_sessions');}
 }
 const success=await call('candidate');assert.equal(success.status,200);assert.equal((await success.json()).revokedSessions,2);
 assert.equal((await db.query('SELECT COUNT(*)::int AS count FROM auth_sessions WHERE user_id=$1',[ids[0]])).rows[0].count,0);
 assert.equal((await db.query('SELECT COUNT(*)::int AS count FROM auth_sessions WHERE user_id=$1',[ids[1]])).rows[0].count,1);
 console.log('PASS: retry revokes both own sessions and preserves the other account');
}finally{await db.query('DROP TRIGGER IF EXISTS fixture_suppress_own_delete ON auth_sessions').catch(()=>{});await db.query('DROP FUNCTION IF EXISTS fixture_suppress_own_delete()').catch(()=>{});await db.end();}
