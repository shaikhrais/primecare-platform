import {createRequire} from 'node:module';
import {readFile} from 'node:fs/promises';
import {createServer} from 'node:http';
import assert from 'node:assert/strict';
import {test} from 'node:test';
import {makeFixtureHandler} from './endpoint-prototype.mjs';
import {makeScopedCountReader} from './postgres-read-prototype.mjs';

const {PGlite}=createRequire(import.meta.url)(process.env.PGLITE_FIXTURE_MODULE);
await test('HTTP to isolated PostgreSQL: scoped read and revocation',async t=>{
 const db=new PGlite();
 const load=n=>readFile(new URL('./'+n,import.meta.url),'utf8');
 const credentials=new Map([
  ['fixture-a',{userId:'a',tenantId:'one',role:'clinical_director'}],
  ['fixture-b',{userId:'b',tenantId:'two',role:'clinical_director'}],
  ['fixture-office',{userId:'staff',tenantId:'one',role:'therapist'}],
 ]);
 let server,reads=0;
 try {
  await db.exec(`
    CREATE TABLE tenants(id text PRIMARY KEY,status text NOT NULL);
    CREATE TABLE users(id text PRIMARY KEY,tenant_id text REFERENCES tenants(id),roles text,status text);
    CREATE TABLE bookings(id text PRIMARY KEY,tenant_id text REFERENCES tenants(id),branch_id text,start_at timestamptz);
    INSERT INTO tenants VALUES('one','active'),('two','active');
    INSERT INTO users VALUES('a','one','clinical_director','active'),('b','two','clinical_director','active'),('staff','one','therapist','active');
    INSERT INTO bookings VALUES ('east-1','one','east','2026-11-18T19:00Z'),('west-1','one','west','2026-11-18T19:00Z'),('east-2a','two','east','2026-11-18T19:00Z'),('east-2b','two','east','2026-11-18T19:01Z');
  `);
  await db.exec(await load('proposed-schema.sql'));
  await db.exec(`
    INSERT INTO clinical_dashboard_branches VALUES('one','east'),('one','west'),('two','east');
    INSERT INTO clinical_director_branch_assignments
    SELECT tenant_id,'east',id,CURRENT_TIMESTAMP-interval '1 day',CURRENT_TIMESTAMP+interval '1 day',NULL
    FROM users WHERE id IN ('a','b');
  `);
  const readScopedCounts=makeScopedCountReader({
     sql:await load('scoped-bookings-example.sql'),
     reportingWindow:async()=>({start:new Date('2026-11-18T00:00Z'),end:new Date('2026-11-19T00:00Z')}),
     query:async(...args)=>{reads++;return db.query(...args);},
  });
  const handle=makeFixtureHandler({
     verifySession:async request=>credentials.get(request.headers.get('authorization')?.replace(/^Bearer /,'')),
     readScopedCounts,
  });
  server=createServer(async(req,res)=>{
   const response=await handle(new Request('http://127.0.0.1'+req.url,{method:req.method,headers:req.headers}));
   res.writeHead(response.status,Object.fromEntries(response.headers));res.end(await response.text());
  });
  await new Promise((resolve,reject)=>{server.once('error',reject);server.listen(0,'127.0.0.1',resolve);});
  const call=(token,qs='')=>fetch('http://127.0.0.1:'+server.address().port+'/v1/clinical/dashboard'+qs,{headers:token?{authorization:'Bearer '+token}:{}});
  await t.test('separate tenants with the same branch ID see only their own count',async()=>{
    const one=await call('fixture-a'),two=await call('fixture-b');
    assert.equal(one.status,200);assert.equal(two.status,200);
    assert.deepEqual(await one.json(),{bookingCount:1});assert.deepEqual(await two.json(),{bookingCount:2});
  });
  await t.test('wrong role, missing session, and caller scope never query the database',async()=>{
    const before=reads;
    assert.equal((await call(null)).status,401);
    assert.equal((await call('fixture-office')).status,403);
    assert.equal((await call('fixture-a','?tenantId=two')).status,400);
    assert.equal((await call('fixture-a','?branchId=west')).status,400);
    assert.equal(reads,before);
  });
  await t.test('revocation takes effect on the next request only for the revoked actor',async()=>{
    await db.exec("UPDATE clinical_director_branch_assignments SET revoked_at=CURRENT_TIMESTAMP WHERE tenant_id='one' AND director_user_id='a'");
    assert.equal((await call('fixture-a')).status,403);
    assert.equal((await call('fixture-b')).status,200);
  });
  await t.test('missing schema does not leak database details or become a successful zero',async()=>{
    await db.exec('DROP VIEW clinical_director_effective_branch_scope');
    const r=await call('fixture-b');assert.equal(r.status,503);assert.deepEqual(await r.json(),{error:'unavailable'});
  });
 } finally {
    if(server)await new Promise(resolve=>server.close(resolve));
    await db.close();
 }
});
