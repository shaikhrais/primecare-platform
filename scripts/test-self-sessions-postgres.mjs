import {Client} from 'pg';import {build} from 'esbuild';import assert from 'node:assert/strict';
import {randomUUID,createHash} from 'node:crypto';import {mkdtemp} from 'node:fs/promises';import {tmpdir} from 'node:os';import {join} from 'node:path';import {createRequire} from 'node:module';
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');if(!['127.0.0.1','localhost'].includes(url.hostname)||url.pathname!=='/auth_test')throw Error('Disposable loopback auth_test required');
const dir=await mkdtemp(join(tmpdir(),'self-sessions-pg-'));await build({entryPoints:['cloudflare/workers/src/auth.ts'],outfile:join(dir,'auth.cjs'),bundle:true,platform:'node',format:'cjs'});const {auth}=createRequire(import.meta.url)(join(dir,'auth.cjs'));
const db=new Client({connectionString:url.href});await db.connect();const ids=[randomUUID(),randomUUID()],tenant=randomUUID(),tokens=['i'.repeat(43),'j'.repeat(43),'k'.repeat(43),'l'.repeat(43)];const hash=s=>createHash('sha256').update(s).digest('hex');let trigger=false,checks=0;
const call=(method='GET',token=tokens[0],query='')=>auth(new Request('https://fixture/user/sessions'+query,{method,headers:{authorization:'Bearer '+token}}),{SERVICE_NAME:'auth',DB_URL:url.href},'/user/sessions',{});
try{
 for(let i=0;i<2;i++)await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'rmt',$3,'unused','active')",[ids[i],ids[i]+'@example.invalid',tenant]);
 for(let i=0;i<4;i++)await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+($3 * INTERVAL '1 hour'))",[hash(tokens[i]),ids[i===3?1:0],i===2?-1:1]);
 const list=await (await call()).json();assert.equal(list.pagination.total,2);assert.equal(typeof list.pagination.total,'number');assert.equal(list.sessions.filter(s=>s.current).length,1);assert.ok(!JSON.stringify(list).includes('token_hash'));checks++;

 for(const offset of [0,1,2]) {
  const page=await call('GET',tokens[0],'?limit=1&offset='+offset);assert.equal(page.status,200);
  const data=await page.json();assert.equal(data.pagination.total,2);assert.equal(data.sessions.length,offset<2?1:0);checks++;
 }
 const originalDate=(await db.query('SELECT created_at FROM auth_sessions WHERE token_hash=$1',[hash(tokens[1])])).rows[0].created_at;
 await db.query("UPDATE auth_sessions SET created_at='infinity' WHERE token_hash=$1",[hash(tokens[1])]);
 try {const invalid=await call();assert.equal(invalid.status,503);assert.equal(invalid.headers.get('cache-control'),'no-store');checks++;}
 finally {await db.query('UPDATE auth_sessions SET created_at=$2 WHERE token_hash=$1',[hash(tokens[1]),originalDate]);}
 await db.query(`CREATE FUNCTION test_self_audit_failure() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN IF NEW.actor_user_id::text='${ids[0]}' AND NEW.new_state->>'initiatedBy'='self' THEN RAISE EXCEPTION 'fixture failure'; END IF; RETURN NEW; END $$`);await db.query('CREATE TRIGGER test_self_audit_failure BEFORE INSERT ON auth_management_audit FOR EACH ROW EXECUTE FUNCTION test_self_audit_failure()');trigger=true;
 assert.equal((await call('DELETE')).status,503);assert.equal(Number((await db.query('SELECT COUNT(*)::int AS count FROM auth_sessions WHERE user_id=$1',[ids[0]])).rows[0].count),3);checks++;
 await db.query('DROP TRIGGER test_self_audit_failure ON auth_management_audit');trigger=false;
 const revoked=await call('DELETE');assert.equal(revoked.status,200);const revokedBody=await revoked.json();assert.equal(revokedBody.revokedSessions,3);assert.equal(typeof revokedBody.revokedSessions,'number');checks++;
 for(const token of tokens.slice(0,3))assert.equal((await call('GET',token)).status,401);assert.equal((await call('GET',tokens[3])).status,200);checks++;
 const audit=(await db.query('SELECT previous_state,new_state FROM auth_management_audit WHERE actor_user_id=$1 AND target_user_id=$1',[ids[0]])).rows;assert.equal(audit.length,1);assert.equal(audit[0].previous_state.sessionCount,3);assert.equal(audit[0].new_state.initiatedBy,'self');checks++;
 assert.equal((await call('DELETE')).status,401);checks++;
 console.log(`Self sessions batches 6 and 202 passed ${checks} PostgreSQL checks (${process.env.AUTH_TEST_ID_TYPE}).`);
}finally{if(trigger)await db.query('DROP TRIGGER IF EXISTS test_self_audit_failure ON auth_management_audit');await db.query('DROP FUNCTION IF EXISTS test_self_audit_failure()');await db.query('DELETE FROM auth_management_audit WHERE actor_user_id::text=ANY($1)',[ids]);await db.query('DELETE FROM auth_sessions WHERE user_id::text=ANY($1)',[ids]);await db.query('DELETE FROM auth_rate_limits WHERE subject_hash=ANY($1)',[ids.map(id=>hash('manageAccount:'+id))]);await db.query('DELETE FROM users WHERE id::text=ANY($1)',[ids]);await db.end();}
