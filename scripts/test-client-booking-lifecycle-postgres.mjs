import {Client} from 'pg';import {build} from 'esbuild';import assert from 'node:assert/strict';import {randomUUID,createHash} from 'node:crypto';import {mkdtemp,readFile} from 'node:fs/promises';import {tmpdir} from 'node:os';import {join} from 'node:path';import {createRequire} from 'node:module';
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');if(!['127.0.0.1','localhost'].includes(url.hostname)||url.pathname!=='/auth_test')throw Error('Disposable loopback auth_test required');
const dir=await mkdtemp(join(tmpdir(),'booking-lifecycle-pg-'));await build({entryPoints:['cloudflare/workers/src/client-booking-lifecycle.ts'],outfile:join(dir,'lifecycle.cjs'),bundle:true,platform:'node',format:'cjs'});const {clientBookingLifecycle}=createRequire(import.meta.url)(join(dir,'lifecycle.cjs'));
const db=new Client({connectionString:url.href});await db.connect();
const ids=[randomUUID(),randomUUID(),randomUUID()],tenants=[randomUUID(),randomUUID()],profiles=[randomUUID(),randomUUID(),randomUUID()],tokens=['x'.repeat(43),'y'.repeat(43),'z'.repeat(43)],hash=s=>createHash('sha256').update(s).digest('hex');
let checks=0,createdProfiles=false,createdRequests=false,createdAudit=false;
const input={service_type:'massage',preferred_date:'2026-10-06T12:00:00Z',preferred_time:null,notes:'private note'};
function call(path='/booking-requests',key='create-key',body=path==='/booking-requests'?input:undefined,token=tokens[0],headers={}){return clientBookingLifecycle(new Request('https://fixture'+path,{method:path.includes('/audit')?'GET':'POST',headers:{authorization:'Bearer '+token,'content-type':'application/json','idempotency-key':key,...headers},body:body===undefined?undefined:JSON.stringify(body)}),{DB_URL:url.href,SERVICE_NAME:'client'},path.split('?')[0],{});}
try{
 await db.query('CREATE TABLE client_profiles(id TEXT PRIMARY KEY,user_id TEXT NOT NULL,tenant_id TEXT NOT NULL)');createdProfiles=true;
 await db.query('CREATE TABLE booking_requests(id TEXT PRIMARY KEY,client_id TEXT NOT NULL,tenant_id TEXT NOT NULL,service_type TEXT NOT NULL,preferred_date TIMESTAMP NOT NULL,preferred_time TEXT,notes TEXT,status TEXT NOT NULL,created_at TIMESTAMP NOT NULL,updated_at TIMESTAMP NOT NULL)');createdRequests=true;
 await db.query(await readFile('packages/database/migrations/20261005_booking_request_audit.sql','utf8'));createdAudit=true;
 // Applying the additive migration twice must preserve data and constraints.
 await db.query(await readFile('packages/database/migrations/20261005_booking_request_audit.sql','utf8'));
 for(let i=0;i<3;i++){await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'patient',$3,'unused','active')",[ids[i],ids[i]+'@example.invalid',tenants[i===2?1:0]]);await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(tokens[i]),ids[i]]);await db.query('INSERT INTO client_profiles(id,user_id,tenant_id) VALUES($1,$2,$3)',[profiles[i],ids[i],tenants[i===2?1:0]]);}
 const concurrent=await Promise.all([call(),call()]);for(const r of concurrent)assert.equal(r.status,201);const results=await Promise.all(concurrent.map(r=>r.json()));assert.equal(results[0].request.id,results[1].request.id);const id=results[0].request.id;checks++;
 assert.equal((await db.query('SELECT COUNT(*)::int AS count FROM booking_requests')).rows[0].count,1);assert.equal((await db.query('SELECT COUNT(*)::int AS count FROM booking_request_audit')).rows[0].count,1);checks++;
 const saved=(await db.query('SELECT * FROM booking_requests WHERE id=$1',[id])).rows[0];assert.equal(saved.client_id,profiles[0]);assert.equal(saved.tenant_id,tenants[0]);assert.equal(saved.status,'pending');assert.equal(saved.notes,'private note');assert.ok(!JSON.stringify(results).includes('private'));checks++;
 assert.equal((await call('/booking-requests','create-key',{...input,service_type:'different'})).status,409);checks++;
 const foreign=(await (await call('/booking-requests','other-create',input,tokens[1])).json()).request.id;
 const foreignTenant=(await (await call('/booking-requests','foreign-create',input,tokens[2])).json()).request.id;
 for(const requestId of [foreign,foreignTenant]){assert.equal((await call('/booking-requests/'+requestId+'/cancel','deny-cancel')).status,404);assert.equal((await call('/booking-requests/'+requestId+'/audit')).status,404);}checks++;
 // A row carrying this client's ID with a foreign tenant must also be denied.
 const malformed=randomUUID();await db.query("INSERT INTO booking_requests(id,client_id,tenant_id,service_type,preferred_date,status,created_at,updated_at) VALUES($1,$2,$3,'massage',NOW(),'pending',NOW(),NOW())",[malformed,profiles[0],tenants[1]]);assert.equal((await call('/booking-requests/'+malformed+'/cancel','deny-malformed')).status,404);checks++;
 assert.equal((await call('/booking-requests','wrong-tenant',input,tokens[0],{'x-tenant-id':tenants[1]})).status,403);checks++;
 const cancelPath='/booking-requests/'+id+'/cancel';const cancellations=await Promise.all([call(cancelPath,'cancel-one'),call(cancelPath,'cancel-two')]);assert.deepEqual(cancellations.map(r=>r.status).sort(),[200,409]);checks++;
 const winningKey=cancellations[0].status===200?'cancel-one':'cancel-two';const replay=await call(cancelPath,winningKey);assert.equal(replay.status,200);assert.equal(replay.headers.get('idempotency-replayed'),'true');assert.equal((await replay.json()).request.status,'cancelled');checks++;
 const history=await (await call('/booking-requests/'+id+'/audit')).json();assert.equal(history.pagination.total,2);assert.deepEqual(history.events.map(e=>e.action),['cancelled','created']);assert.ok(!JSON.stringify(history).includes('private'));checks++;
 const historyPage=await (await call('/booking-requests/'+id+'/audit?limit=1&offset=1')).json();assert.equal(historyPage.events.length,1);assert.equal(historyPage.pagination.total,2);checks++;
 // Idempotency stores the original response even after a later cancellation.
 const submitReplay=await call();assert.equal(submitReplay.status,201);assert.equal((await submitReplay.json()).request.status,'pending');checks++;
 const rollbackId=(await (await call('/booking-requests','rollback-create')).json()).request.id;
 await db.query("ALTER TABLE booking_request_audit ADD CONSTRAINT reject_cancel_fixture CHECK (request_id <> '"+rollbackId+"' OR action <> 'cancelled')");
 assert.equal((await call('/booking-requests/'+rollbackId+'/cancel','rollback-cancel')).status,503);
 assert.equal((await db.query('SELECT status FROM booking_requests WHERE id=$1',[rollbackId])).rows[0].status,'pending');assert.equal((await db.query("SELECT COUNT(*)::int AS count FROM booking_request_audit WHERE request_id=$1 AND action='cancelled'",[rollbackId])).rows[0].count,0);checks++;
 await db.query('ALTER TABLE booking_request_audit DROP CONSTRAINT reject_cancel_fixture');
 // Missing audit storage must prevent creation, not produce unaudited success.
 await db.query('ALTER TABLE booking_request_audit RENAME TO booking_request_audit_hidden');
 try{const before=(await db.query('SELECT COUNT(*)::int AS count FROM booking_requests')).rows[0].count;assert.equal((await call('/booking-requests','missing-audit')).status,503);assert.equal((await db.query('SELECT COUNT(*)::int AS count FROM booking_requests')).rows[0].count,before);checks++;}finally{await db.query('ALTER TABLE booking_request_audit_hidden RENAME TO booking_request_audit');}
 // A retry after profile reassignment must not expose the old request response.
 await db.query('UPDATE client_profiles SET id=$1 WHERE id=$2',[randomUUID(),profiles[0]]);assert.equal((await call()).status,404);checks++;
 await db.query("UPDATE auth_sessions SET expires_at=NOW()-INTERVAL '1 second' WHERE user_id=$1",[ids[1]]);assert.equal((await call('/booking-requests','expired-session',input,tokens[1])).status,401);checks++;
 await db.query("UPDATE users SET status='inactive' WHERE id=$1",[ids[2]]);assert.equal((await call('/booking-requests','inactive',input,tokens[2])).status,401);checks++;
 console.log(`Booking request lifecycle passed ${checks} PostgreSQL checks (${process.env.AUTH_TEST_ID_TYPE} auth identities).`);
}finally{if(createdAudit)await db.query('DROP TABLE booking_request_audit');if(createdRequests)await db.query('DROP TABLE booking_requests');if(createdProfiles)await db.query('DROP TABLE client_profiles');await db.query('DELETE FROM auth_sessions WHERE user_id::text=ANY($1)',[ids]);await db.query('DELETE FROM users WHERE id::text=ANY($1)',[ids]);await db.end();}
