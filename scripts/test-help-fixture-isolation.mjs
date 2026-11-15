import test from 'node:test';
import assert from 'node:assert/strict';
import pg from 'pg';
import {PGlite} from '@electric-sql/pglite';
import * as fixtures from './help-reader-service-fixture.mjs';
import {postgresStoreFixture} from './help-postgres-store-fixture.mjs';

const {helpFixture,helpFixtureConnectionString}=fixtures;
const local='postgresql://fixture:fixture@127.0.0.1:5432/help_service';
const invalid=[
 local+'?host=example.invalid',local+'?hostaddr=203.0.113.1',local+'?port=6543',local+'?sslmode=disable',
 local+'#fragment',local.replace('127.0.0.1','example.invalid'),local.replace('/help_service','/postgres'),
 local.replace(':5432',':6543'),local.replace(':5432',''),local.replace('postgresql:','https:'),'',undefined,
];
const markerNames=['PRODUCTION_DATABASE_URL','GOVERNANCE_DATABASE_URL','DATABASE_URL','DB_URL','DIRECT_URL'];
async function environment(values,run){
 const saved=Object.fromEntries(Object.keys(values).map(key=>[key,{present:Object.hasOwn(process.env,key),value:process.env[key]}]));
 try{for(const [key,value]of Object.entries(values)){if(value===undefined)delete process.env[key];else process.env[key]=value;}return await run();}
 finally{for(const [key,entry]of Object.entries(saved)){if(entry.present)process.env[key]=entry.value;else delete process.env[key];}}
}

test('fixture parser permits only the explicit named loopback database or the isolated memory engine',()=>{
 assert.equal(helpFixtureConnectionString({}),null);
 for(const protocol of ['postgresql:','postgres:']){
  const accepted=helpFixtureConnectionString({HELP_SERVICE_TEST_DATABASE_URL:local.replace('postgresql:',protocol)});
  const parsed=new URL(accepted);assert.equal(parsed.hostname,'127.0.0.1');assert.equal(parsed.port,'5432');assert.equal(parsed.pathname,'/help_service');
  assert.equal(new pg.Client({connectionString:accepted}).connectionParameters.host,'127.0.0.1');
 }
 for(const value of invalid)assert.throws(()=>helpFixtureConnectionString({HELP_SERVICE_TEST_DATABASE_URL:value}),/Isolated Help service fixture only/);
});

test('production and governance markers are rejected by presence, even empty or undefined',()=>{
 for(const name of [...markerNames,...markerNames.map(name=>name.toLowerCase()),'READ_ONLY_PRODUCTION_DB_URL']){
  for(const value of ['',undefined])for(const env of [{[name]:value},{HELP_SERVICE_TEST_DATABASE_URL:local,[name]:value}]){
   assert.throws(()=>helpFixtureConnectionString(env),/Isolated Help service fixture only/);
  }
 }
});

test('native connection guard rejects disguised remote URLs before connect',async t=>{
 let connected=0;
 t.mock.method(pg.Client.prototype,'connect',async function(){connected++;throw Error('Synthetic connect sentinel');});
 for(const value of invalid.filter(value=>value!==undefined))await environment({HELP_SERVICE_TEST_DATABASE_URL:value},async()=>{
  await assert.rejects(helpFixture(),/Isolated Help service fixture only/);
 });
 assert.equal(connected,0);
});

test('a valid explicit loopback URL reaches exactly one mocked connect without SQL or real network',async t=>{
 let connected=0,queries=0;
 t.mock.method(pg.Client.prototype,'connect',async function(){connected++;assert.equal(this.connectionParameters.host,'127.0.0.1');assert.equal(this.connectionParameters.port,5432);throw Error('Synthetic connect sentinel');});
 t.mock.method(pg.Client.prototype,'query',function(){queries++;throw Error('Unexpected SQL');});
 await environment({HELP_SERVICE_TEST_DATABASE_URL:local},async()=>{await assert.rejects(helpFixture(),/^Error: Synthetic connect sentinel$/);});
 assert.equal(connected,1);assert.equal(queries,0);
});

test('production markers also stop the memory fixture before engine allocation',async()=>{
 for(const name of markerNames)await environment({HELP_SERVICE_TEST_DATABASE_URL:undefined,[name]:''},async()=>{
  await assert.rejects(helpFixture(),/Isolated Help service fixture only/);
 });
});

test('store fixture retains its captured memory-engine choice after environment mutation during setup',async t=>{
 let changed=false,connected=0;const exec=PGlite.prototype.exec;
 t.mock.method(PGlite.prototype,'exec',async function(sql,...args){
  if(!changed&&sql.startsWith('CREATE SCHEMA "')){changed=true;process.env.HELP_SERVICE_TEST_DATABASE_URL='postgresql://fixture:fixture@example.invalid:5432/help_service';}
  return exec.call(this,sql,...args);
 });
 t.mock.method(pg.Client.prototype,'connect',async function(){connected++;throw Error('Synthetic remote connect sentinel');});
 await environment({HELP_SERVICE_TEST_DATABASE_URL:undefined},async()=>{
  const f=await postgresStoreFixture();
  try{assert.equal(changed,true);assert.equal(connected,0);assert.equal((await f.quota.query('SELECT 1 AS n')).rows[0].n,1);assert.equal(Number((await f.db.query('SELECT count(*) n FROM public.help_reader_rate')).rows[0].n),0);}
  finally{await f.close();}
 });
 assert.equal(connected,0);
});
