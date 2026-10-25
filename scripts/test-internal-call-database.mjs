import {test} from 'node:test';import assert from 'node:assert/strict';
import {internalCallDatabaseOptions,measuredCallDatabase} from '../cloudflare/workers/src/business-tasks/internal-call-database.ts';
import {callDatabaseName,callDatabaseOrigin,assertCallDatabaseConfiguration} from './internal-call-deployment-plan.mjs';
test('fresh transport uses trusted local tunnel fields, including opaque database IDs and reserved credentials',()=>{
 const binding={host:'a'.repeat(32)+'.hyperdrive.local',port:5432,database:'opaque-local-database',user:'local-user',password:'p@ss#word/%',connectionString:'unused generated URL'};
 const options=internalCallDatabaseOptions(binding);assert.equal(options.host,binding.host);assert.equal(options.database,binding.database);assert.equal(options.password,binding.password);assert.equal(options.ssl,false);assert.equal(options.connectionString,undefined);
 assert.equal(internalCallDatabaseOptions({...binding,password:''}).password,'');
 for(const value of [undefined,{...binding,host:'public.example'},{...binding,port:6543},{...binding,database:''},{...binding,user:null},{...binding,password:undefined}])assert.throws(()=>internalCallDatabaseOptions(value),/required/);
});
test('only an exact pinned cache-disabled owned configuration may be deployed',()=>{
 const origin=callDatabaseOrigin('postgres://fixture:fixture-only@pooled.db.prisma.io:5432/postgres?sslmode=require');
 const configuration={id:'a'.repeat(32),name:callDatabaseName,origin:{...origin,password:undefined},caching:{disabled:true},origin_connection_limit:5,mtls:{sslmode:'require'}};
 assert.equal(assertCallDatabaseConfiguration(configuration,origin),configuration.id);
 for(const change of [v=>v.caching.disabled=false,v=>v.name='foreign',v=>v.origin.host='foreign',v=>v.origin.user='foreign',v=>v.origin.database='other',v=>v.origin_connection_limit=4,v=>v.origin_connection_limit=60,v=>v.mtls.sslmode='none']){const v=structuredClone(configuration);change(v);assert.throws(()=>assertCallDatabaseConfiguration(v,origin),/preserved/);}
 assert.throws(()=>assertCallDatabaseConfiguration(configuration,origin,'b'.repeat(32)),/preserved/);
 assert.throws(()=>callDatabaseOrigin('postgres://fixture:fixture-only@foreign/postgres'),/pinned/);
});
test('aggregate timing ports retain neither SQL nor parameters and release actual clients',async()=>{
 const metrics=new Map();let releases=0,queries=0;
 const database=measuredCallDatabase({async query(){queries++;return {rows:[]};},async connect(){return {async query(){queries++;throw Error('fixture failure');},release(){releases++;}};}},metrics);
 await database.query('SELECT private_value FROM auth_sessions WHERE token_hash=$1',['fixture-sensitive-value']);
 const client=await database.connect();try{await assert.rejects(client.query('SELECT private_value FROM govt_api_endpoints'),/fixture failure/);}finally{client.release();}
 assert.equal(queries,2);assert.equal(releases,1);assert.equal(metrics.get('session').count,1);assert.equal(metrics.get('permissions').count,1);assert.equal(metrics.get('connect').count,1);
 assert.doesNotMatch(JSON.stringify([...metrics]),/private_value|fixture-sensitive-value|token_hash/);
});
