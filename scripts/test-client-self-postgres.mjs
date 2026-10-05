import {Client} from 'pg';import {build} from 'esbuild';import assert from 'node:assert/strict';import {randomUUID,createHash} from 'node:crypto';import {mkdtemp} from 'node:fs/promises';import {tmpdir} from 'node:os';import {join} from 'node:path';import {createRequire} from 'node:module';
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');if(!['127.0.0.1','localhost'].includes(url.hostname)||url.pathname!=='/auth_test')throw Error('Disposable loopback auth_test required');
const dir=await mkdtemp(join(tmpdir(),'client-self-pg-'));await build({entryPoints:['cloudflare/workers/src/client-self.ts'],outfile:join(dir,'client.cjs'),bundle:true,platform:'node',format:'cjs'});const {clientSelf}=createRequire(import.meta.url)(join(dir,'client.cjs'));const db=new Client({connectionString:url.href});await db.connect();
const ids=[randomUUID(),randomUUID(),randomUUID()],tenants=[randomUUID(),randomUUID()],profiles=[randomUUID(),randomUUID(),randomUUID()],tokens=['m'.repeat(43),'n'.repeat(43),'o'.repeat(43)];const hash=s=>createHash('sha256').update(s).digest('hex');let checks=0,createdProfiles=false,createdInvoices=false,createdBookings=false,createdVisits=false,createdRequests=false;
const call=(path='/home/profile',query='',token=tokens[0],headers={})=>clientSelf(new Request('https://fixture'+path+query,{headers:{authorization:'Bearer '+token,...headers}}),{DB_URL:url.href,SERVICE_NAME:'client'},path,{});
try{
 // Disposable domain fixtures use the registered column names and text domain
 // identities; the auth actor/session identity still follows the CI matrix.
 await db.query('CREATE TABLE client_profiles(id TEXT PRIMARY KEY,user_id TEXT UNIQUE NOT NULL,tenant_id TEXT NOT NULL,full_name TEXT NOT NULL,city TEXT,province TEXT,postal_code TEXT,updated_at TIMESTAMP NOT NULL DEFAULT NOW(),dob TIMESTAMP)');createdProfiles=true;
 await db.query('CREATE TABLE invoices(id TEXT PRIMARY KEY,client_id TEXT NOT NULL,tenant_id TEXT NOT NULL,status TEXT NOT NULL,currency TEXT NOT NULL,subtotal NUMERIC NOT NULL,tax NUMERIC NOT NULL,total NUMERIC NOT NULL,created_at TIMESTAMP NOT NULL DEFAULT NOW(),updated_at TIMESTAMP NOT NULL DEFAULT NOW(),stripe_invoice_id TEXT)');createdInvoices=true;
 for(let i=0;i<3;i++){await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'patient',$3,'unused','active')",[ids[i],ids[i]+'@example.invalid',tenants[i===2?1:0]]);await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(tokens[i]),ids[i]]);await db.query('INSERT INTO client_profiles(id,user_id,tenant_id,full_name,dob) VALUES($1,$2,$3,$4,NOW())',[profiles[i],ids[i],tenants[i===2?1:0],'Client '+i]);}
 for(let i=0;i<3;i++)await db.query("INSERT INTO invoices(id,client_id,tenant_id,status,currency,subtotal,tax,total,stripe_invoice_id) VALUES($1,$2,$3,'pending','CAD',100.10,13.01,113.11,'private-processor-id')",[randomUUID(),profiles[i],tenants[i===2?1:0]]);
 // Deliberately malformed invoice: same client but a foreign tenant.
 await db.query("INSERT INTO invoices(id,client_id,tenant_id,status,currency,subtotal,tax,total) VALUES($1,$2,$3,'pending','CAD',1,0,1)",[randomUUID(),profiles[0],tenants[1]]);
 await db.query('CREATE TABLE bookings(id TEXT PRIMARY KEY,client_id TEXT NOT NULL,tenant_id TEXT NOT NULL,start_at TIMESTAMP NOT NULL,end_at TIMESTAMP NOT NULL,service_type TEXT NOT NULL,priority TEXT NOT NULL,status TEXT NOT NULL,recurrence_rule TEXT,notes TEXT)');createdBookings=true;
 const bookings=[randomUUID(),randomUUID(),randomUUID()];
 for(let i=0;i<3;i++)await db.query("INSERT INTO bookings(id,client_id,tenant_id,start_at,end_at,service_type,priority,status,notes) VALUES($1,$2,$3,NOW(),NOW()+INTERVAL '1 hour','massage','normal','pending','private-note')",[bookings[i],profiles[i===2?0:i],tenants[i===2?1:0]]);
 const bookingList=await (await call('/bookings','?limit=1')).json();assert.equal(bookingList.pagination.total,1);assert.equal(bookingList.bookings[0].id,bookings[0]);assert.ok(!JSON.stringify(bookingList).includes('private-note'));checks++;
 const bookingDetail=await (await call('/bookings/'+bookings[0])).json();assert.equal(bookingDetail.booking.id,bookings[0]);checks++;
 assert.equal((await call('/bookings/'+bookings[1])).status,404);assert.equal((await call('/bookings/'+bookings[2])).status,404);checks++;
 const bookingPage=await (await call('/bookings','?offset=1')).json();assert.equal(bookingPage.bookings.length,0);assert.equal(bookingPage.pagination.total,1);checks++;
 const bookingSummary=await (await call('/bookings/summary')).json();assert.equal(bookingSummary.pagination.total,1);assert.equal(bookingSummary.groups[0].count,1);assert.equal(bookingSummary.groups[0].status,'pending');checks++;
 const bookingSummaryPage=await (await call('/bookings/summary','?offset=1')).json();assert.equal(bookingSummaryPage.groups.length,0);assert.equal(bookingSummaryPage.pagination.total,1);checks++;

 await db.query('CREATE TABLE visits(id TEXT PRIMARY KEY,client_id TEXT NOT NULL,tenant_id TEXT NOT NULL,service_id TEXT NOT NULL,requested_start_at TIMESTAMP NOT NULL,duration_minutes INTEGER NOT NULL,status TEXT,priority TEXT,updated_at TIMESTAMP NOT NULL DEFAULT NOW(),management_notes TEXT)');createdVisits=true;
 const visits=[randomUUID(),randomUUID(),randomUUID()];
 for(let i=0;i<3;i++)await db.query("INSERT INTO visits(id,client_id,tenant_id,service_id,requested_start_at,duration_minutes,status,priority,management_notes) VALUES($1,$2,$3,'service',NOW(),60,'requested','normal','private-notes')",[visits[i],profiles[i===2?0:i],tenants[i===2?1:0]]);
 const visitList=await (await call('/visits','?limit=1')).json();assert.equal(visitList.pagination.total,1);assert.equal(visitList.visits[0].id,visits[0]);assert.ok(!JSON.stringify(visitList).includes('private'));checks++;
 const visitDetail=await (await call('/visits/'+visits[0])).json();assert.equal(visitDetail.visit.duration_minutes,60);checks++;
 for(const id of visits.slice(1))assert.equal((await call('/visits/'+id)).status,404);checks++;
 const visitPage=await (await call('/visits','?offset=1')).json();assert.equal(visitPage.visits.length,0);assert.equal(visitPage.pagination.total,1);checks++;

 const batch15=await (await call('/visits/summary')).json();assert.equal(batch15.pagination.total,1);assert.equal(batch15.groups[0].count,1);checks++;
 const batch15Page=await (await call('/visits/summary','?offset=1')).json();assert.equal(batch15Page.groups.length,0);assert.equal(batch15Page.pagination.total,1);checks++;
 // Null is a distinct stored-status group; other owners/tenants remain excluded.
 await db.query('UPDATE visits SET status=NULL WHERE client_id=$1',[profiles[0]]);
 const batch15Null=await (await call('/visits/summary')).json();assert.deepEqual(batch15Null.groups,[{status:null,count:1}]);checks++;
 await db.query('DELETE FROM visits WHERE client_id=$1',[profiles[0]]);
 const batch15Empty=await (await call('/visits/summary')).json();assert.deepEqual(batch15Empty.groups,[]);assert.equal(batch15Empty.pagination.total,0);assert.equal(batch15Empty.pagination.hasMore,false);checks++;

 await db.query('CREATE TABLE booking_requests(id TEXT PRIMARY KEY,client_id TEXT NOT NULL,tenant_id TEXT NOT NULL,service_type TEXT NOT NULL,preferred_date TIMESTAMP NOT NULL,preferred_time TEXT,status TEXT NOT NULL,created_at TIMESTAMP NOT NULL DEFAULT NOW(),updated_at TIMESTAMP NOT NULL DEFAULT NOW(),notes TEXT)');createdRequests=true;
 const requests=[randomUUID(),randomUUID(),randomUUID()];
 for(let i=0;i<3;i++)await db.query("INSERT INTO booking_requests(id,client_id,tenant_id,service_type,preferred_date,status,notes) VALUES($1,$2,$3,'massage',NOW(),'pending','private-request-note')",[requests[i],profiles[i===2?0:i],tenants[i===2?1:0]]);
 const requestList=await (await call('/booking-requests','?limit=1')).json();assert.equal(requestList.pagination.total,1);assert.equal(requestList.requests[0].id,requests[0]);assert.ok(!JSON.stringify(requestList).includes('private'));checks++;
 const requestDetail=await (await call('/booking-requests/'+requests[0])).json();assert.equal(requestDetail.request.preferred_time,null);assert.equal(requestDetail.request.id,requests[0]);checks++;
 for(const id of requests.slice(1))assert.equal((await call('/booking-requests/'+id)).status,404);checks++;
 const requestPage=await (await call('/booking-requests','?offset=1')).json();assert.deepEqual(requestPage.requests,[]);assert.equal(requestPage.pagination.total,1);checks++;
 await db.query('DELETE FROM booking_requests WHERE id=$1',[requests[0]]);
 const noRequests=await (await call('/booking-requests')).json();assert.deepEqual(noRequests.requests,[]);assert.equal(noRequests.pagination.total,0);checks++;
 const own=await (await call()).json();assert.equal(own.profile.id,profiles[0]);assert.ok(!('dob' in own.profile));checks++;
 const list=await (await call('/invoices')).json();assert.equal(list.pagination.total,1);assert.equal(list.invoices[0].total,'113.11');assert.ok(!JSON.stringify(list).includes('private-processor'));checks++;
 const detail=await (await call('/invoices/'+list.invoices[0].id)).json();assert.equal(detail.invoice.total,'113.11');assert.ok(!JSON.stringify(detail).includes('private-processor'));checks++;
 const foreignInvoice=(await db.query('SELECT id FROM invoices WHERE client_id=$1',[profiles[1]])).rows[0].id;assert.equal((await call('/invoices/'+foreignInvoice)).status,404);checks++;
 for(const [currency,status,amount] of [['CAD','pending','0.10'],['USD','paid','2.00']])await db.query('INSERT INTO invoices(id,client_id,tenant_id,status,currency,subtotal,tax,total) VALUES($1,$2,$3,$4,$5,$6,0,$6)',[randomUUID(),profiles[0],tenants[0],status,currency,amount]);
 const summary=await (await call('/invoices/summary')).json();assert.equal(summary.pagination.total,2);assert.equal(summary.groups.find(g=>g.currency==='CAD').total,'113.21');assert.equal(summary.groups.find(g=>g.currency==='USD').total,'2.00');assert.equal(summary.groups.find(g=>g.currency==='CAD').invoiceCount,2);checks++;
 const summaryPage=await (await call('/invoices/summary','?limit=1&offset=1')).json();assert.equal(summaryPage.groups.length,1);assert.equal(summaryPage.pagination.total,2);checks++;
 // Restore the original list fixture so its paging checks retain their scope.
 await db.query("DELETE FROM invoices WHERE client_id=$1 AND (currency='USD' OR total=0.10)",[profiles[0]]);
 const other=await (await call('/invoices','',tokens[1])).json();assert.equal(other.pagination.total,1);assert.notEqual(other.invoices[0].id,list.invoices[0].id);checks++;
 const empty=await (await call('/invoices','?offset=1')).json();assert.equal(empty.invoices.length,0);assert.equal(empty.pagination.total,1);checks++;
 assert.equal((await call('/home/profile','',tokens[0],{'x-tenant-id':tenants[1]})).status,403);checks++;
 await db.query('UPDATE client_profiles SET tenant_id=$1 WHERE id=$2',[tenants[1],profiles[0]]);assert.equal((await call()).status,404);checks++;
 await db.query("UPDATE users SET status='inactive' WHERE id=$1",[ids[1]]);assert.equal((await call('/invoices','',tokens[1])).status,401);checks++;
 console.log(`Client self passed ${checks} PostgreSQL checks (${process.env.AUTH_TEST_ID_TYPE} auth identities).`);
}finally{if(createdRequests)await db.query('DROP TABLE booking_requests');if(createdVisits)await db.query('DROP TABLE visits');if(createdBookings)await db.query('DROP TABLE bookings');if(createdInvoices)await db.query('DROP TABLE invoices');if(createdProfiles)await db.query('DROP TABLE client_profiles');await db.query('DELETE FROM auth_sessions WHERE user_id::text=ANY($1)',[ids]);await db.query('DELETE FROM users WHERE id::text=ANY($1)',[ids]);await db.end();}
