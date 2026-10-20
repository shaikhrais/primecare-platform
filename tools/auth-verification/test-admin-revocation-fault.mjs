// Existing administrator-session contract, native fault proof on disposable PostgreSQL only.
import {Client} from 'pg';import {build} from 'esbuild';import {readFile,mkdtemp} from 'node:fs/promises';import {execFileSync} from 'node:child_process';import {tmpdir} from 'node:os';import {join,dirname} from 'node:path';import {randomUUID,createHash} from 'node:crypto';import {createRequire} from 'node:module';import assert from 'node:assert/strict';
if(process.env.PRODUCTION_DATABASE_URL||process.env.GOVERNANCE_DATABASE_URL)throw Error('Production credentials forbidden');
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');if(!['localhost','127.0.0.1'].includes(url.hostname)||url.pathname!='/auth_test')throw Error('Disposable loopback auth_test required');
const base='bb7517bd9068b745ff682788daa151e896c56a4f';
const files=['auth.ts','account-admin.ts','self-sessions.ts'];
const previous=Object.fromEntries(files.map(file=>[file,execFileSync('git',['show',base+':cloudflare/workers/src/'+file],{encoding:'utf8'})]));
const current=Object.fromEntries(await Promise.all(files.map(async file=>[file,await readFile('cloudflare/workers/src/'+file,'utf8')])));
const anchor='    const previous={sessionCount:deleted}';
const guard="    const remaining=exactCount(requiredRow((await db.query('SELECT COUNT(*)::int AS count FROM auth_sessions WHERE user_id=$1',[target.id])).rows).count);\n    if(remaining!==0)throw Error('Session revocation incomplete');\n";
assert(previous['account-admin.ts'].includes(anchor)&&!previous['account-admin.ts'].includes(guard));
const candidate={...current};
const actual=current['account-admin.ts'].includes(guard);
if(!actual){
 candidate['account-admin.ts']=current['account-admin.ts'].replace(anchor,()=>guard+anchor);
 candidate['self-sessions.ts']=current['self-sessions.ts'].replace('async function requestHasContent','export async function requestHasContent');
 candidate['auth.ts']=current['auth.ts'].replace("import {selfSessions} from './self-sessions';","import {selfSessions,requestHasContent} from './self-sessions';").replace('const adminRequest=parseAccountAdminRequest(request,path);',`let adminRequest=parseAccountAdminRequest(request,path);
  if(adminRequest&&'error' in adminRequest&&adminRequest.status===400&&request.body!==null&&!(await requestHasContent(request))){
    adminRequest=parseAccountAdminRequest(new Request(request.url,{method:request.method,headers:request.headers}),path);
  }`);
}
const dir=await mkdtemp(join(tmpdir(),'admin-session-fault-')),handlers={};
for(const [mode,sources] of [['baseline',previous],['candidate',candidate]]){
 const out=join(dir,mode+'.cjs');
 const plugins=mode==='candidate'&&actual?[]:[{name:'admin-revocation-proof',setup(b){b.onLoad({filter:/(?:auth|account-admin|self-sessions)\.ts$/},args=>{const file=args.path.split('/').at(-1);return {contents:sources[file],loader:'ts',resolveDir:dirname(args.path)};});}}];
 await build({entryPoints:['cloudflare/workers/src/auth.ts'],outfile:out,bundle:true,platform:'node',format:'cjs',plugins});handlers[mode]=createRequire(import.meta.url)(out).auth;
}
const db=new Client({connectionString:url.href});await db.connect();
const ids=[randomUUID(),randomUUID(),randomUUID()],tenants=[randomUUID(),randomUUID()],tokens=['m'.repeat(43),'n'.repeat(43),'o'.repeat(43),'p'.repeat(43)],hash=v=>createHash('sha256').update(v).digest('hex');
const path='/admin/users/'+ids[1]+'/sessions';
const call=(mode,body)=>handlers[mode](new Request('https://fixture'+path,{method:'DELETE',headers:{authorization:'Bearer '+tokens[0]},...(body===undefined?{}:{body})}),{SERVICE_NAME:'auth',DB_URL:url.href},path,{});
try{
 await db.query(await readFile('services/auth_api/dev_schema.sql','utf8'));
 await db.query('ALTER TABLE users ADD COLUMN IF NOT EXISTS tenant_id UUID');
 await db.query('ALTER TABLE users ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP NOT NULL DEFAULT NOW()');
 for(const name of ['20260925_auth_identity_compatibility.sql','20260926_auth_sessions.sql','20260928_auth_rate_limits.sql','20260928_auth_management_audit.sql'])await db.query(await readFile('packages/database/migrations/'+name,'utf8'));
 for(let n=0;n<3;n++)await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,$3,$4,'unused','active')",[ids[n],ids[n]+'@example.invalid',n===1?'rmt':'ceo',tenants[n===2?1:0]]);
 const seed=async()=>{await db.query('DELETE FROM auth_sessions');await db.query('DELETE FROM auth_management_audit');await db.query('DELETE FROM auth_rate_limits');for(let n=0;n<4;n++)await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(tokens[n]),ids[n===0?0:n===3?2:1]]);};
 const snapshot=async()=>({sessions:(await db.query('SELECT * FROM auth_sessions ORDER BY token_hash')).rows,audits:(await db.query('SELECT * FROM auth_management_audit ORDER BY id')).rows});
 await seed();const beforeEmpty=await snapshot();assert.equal((await call('baseline','')).status,400);assert.deepEqual(await snapshot(),beforeEmpty);
 console.log('REPRODUCED: existing administrator endpoint rejects a zero-byte streamed DELETE before authorization');
 await db.query("CREATE FUNCTION fixture_admin_partial_delete() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN IF OLD.token_hash='"+hash(tokens[1])+"' THEN RETURN NULL; END IF; RETURN OLD; END $$");
 for(const mode of ['baseline','candidate']){
  await seed();await db.query('CREATE TRIGGER fixture_admin_partial_delete BEFORE DELETE ON auth_sessions FOR EACH ROW EXECUTE FUNCTION fixture_admin_partial_delete()');
  try{
   const before=await snapshot(),r=await call(mode,mode==='candidate'?'':undefined);
   if(mode==='baseline'){assert.equal(r.status,200);assert.equal((await r.json()).revokedSessions,1);assert.equal((await db.query('SELECT COUNT(*)::int AS count FROM auth_sessions WHERE user_id=$1',[ids[1]])).rows[0].count,1);console.log('REPRODUCED: administrator revocation acknowledged success with a target session still active');}
   else{assert.equal(r.status,503);assert.deepEqual(await snapshot(),before);console.log('PASS: candidate accepts the empty stream, detects partial deletion and rolls back sessions plus audit');}
  }finally{await db.query('DROP TRIGGER fixture_admin_partial_delete ON auth_sessions');}
 }
 const success=await call('candidate','');assert.equal(success.status,200);assert.deepEqual(await success.json(),{userId:ids[1],revokedSessions:2});
 assert.equal((await db.query('SELECT COUNT(*)::int AS count FROM auth_sessions WHERE user_id=$1',[ids[1]])).rows[0].count,0);
 for(const id of [ids[0],ids[2]])assert.equal((await db.query('SELECT COUNT(*)::int AS count FROM auth_sessions WHERE user_id=$1',[id])).rows[0].count,1);
 const audit=(await db.query('SELECT actor_user_id,target_user_id,tenant_id,previous_state,new_state FROM auth_management_audit')).rows;
 assert.equal(audit.length,1);assert.equal(audit[0].actor_user_id,ids[0]);assert.equal(audit[0].target_user_id,ids[1]);assert.equal(audit[0].tenant_id,tenants[0]);assert.deepEqual(audit[0].previous_state,{sessionCount:2});assert.deepEqual(audit[0].new_state,{sessionCount:0,action:'sessions_revoked'});
 console.log('PASS: zero-byte retry confirms both target sessions revoked, one exact audit and unchanged actor/foreign sessions; actual_source='+actual);
}finally{await db.query('DROP TRIGGER IF EXISTS fixture_admin_partial_delete ON auth_sessions').catch(()=>{});await db.query('DROP FUNCTION IF EXISTS fixture_admin_partial_delete()').catch(()=>{});await db.end();}
