import assert from 'node:assert/strict';import {build} from 'esbuild';import {Miniflare} from 'miniflare';import {mkdir,writeFile} from 'node:fs/promises';
const contents="import {internalCallDatabaseOptions} from './cloudflare/workers/src/business-tasks/internal-call-database.ts';export default {fetch(_request,env){const options=internalCallDatabaseOptions(env.CALL_DATABASE);return Response.json({accepted:!!options.connectionString,internalHost:env.CALL_DATABASE.host.endsWith('.hyperdrive.local'),localTransport:new URL(options.connectionString).searchParams.get('sslmode')==='disable'});}};";
const built=await build({stdin:{resolveDir:process.cwd(),contents},bundle:true,write:false,format:'esm',platform:'neutral'});
const runtime=new Miniflare({modules:true,script:built.outputFiles[0].text,compatibilityDate:'2026-07-30',hyperdrives:{CALL_DATABASE:'postgres://fixture:fixture-only@127.0.0.1:5432/postgres'}});
try{
 const response=await runtime.dispatchFetch('https://fixture.invalid/');assert.equal(response.status,200);assert.deepEqual(await response.json(),{accepted:true,internalHost:true,localTransport:true});
 const receipt={source:process.env.GITHUB_SHA,engine:'workerd',actualGeneratedHyperdriveBinding:true,localTransportAccepted:true,originConnectionAttempted:false,credentialsRecorded:false,passed:true};await mkdir('test-results/internal-calls',{recursive:true});await writeFile('test-results/internal-calls/database-workerd.json',JSON.stringify(receipt,null,2)+'\n');console.log('INTERNAL_CALL_DATABASE_WORKERD '+JSON.stringify(receipt));
}finally{await runtime.dispose();}
