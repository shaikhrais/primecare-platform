/** Offline configuration tests: the pg loader never opens a database connection. */
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {spawnSync} from 'node:child_process';
import {mkdtemp,writeFile,rm,readFile} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {fileURLToPath,pathToFileURL} from 'node:url';

const production='postgres://fixture:configuration-only@pooled.db.prisma.io/postgres';
const other=production+'?conflicting=1';
const scripts=['read-bridge.mjs','audit-tables.mjs'];
const cases=[
 ['missing',{},false],
 ['retired alias only',{GOVERNANCE_DATABASE_URL:production},false],
 ['canonical only',{PRODUCTION_DATABASE_URL:production},true],
 ['identical leftover alias',{PRODUCTION_DATABASE_URL:production,GOVERNANCE_DATABASE_URL:production},true],
 ['conflicting alias',{PRODUCTION_DATABASE_URL:production,GOVERNANCE_DATABASE_URL:other},false],
 ['malformed canonical',{PRODUCTION_DATABASE_URL:'not a URL',GOVERNANCE_DATABASE_URL:production},false],
 ['unexpected host',{PRODUCTION_DATABASE_URL:'postgres://fixture:configuration-only@127.0.0.1/postgres'},false],
 ['unexpected database',{PRODUCTION_DATABASE_URL:production.replace('/postgres','/other')},false],
 ['unexpected protocol',{PRODUCTION_DATABASE_URL:production.replace('postgres:','https:')},false],
];

test('the production pin declares one connection source',async()=>{
 const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url),'utf8'));
 assert.deepEqual(pin.connectionVariables,['PRODUCTION_DATABASE_URL']);
 assert.equal(pin.sqliteFallback,false);
});

test('reader and audit require the canonical source and keep conflict/target guards',async t=>{
 const dir=await mkdtemp(join(tmpdir(),'production-url-configuration-'));
 try{
  const stub=join(dir,'pg.mjs'),loader=join(dir,'loader.mjs');
  await writeFile(stub,`import assert from 'node:assert/strict';
class Client {
 constructor(options){assert.equal(options.connectionString,process.env.PRODUCTION_DATABASE_URL);assert.deepEqual(options.ssl,{rejectUnauthorized:true});assert.equal(options.connectionTimeoutMillis,10000);}
 async connect(){throw Object.assign(Error('offline driver sentinel'),{code:'28P01'});}
 async end(){}
}
export default {Client};`);
  await writeFile(loader,`import {registerHooks} from 'node:module';registerHooks({resolve(specifier,context,next){if(specifier==='pg')return {url:${JSON.stringify(pathToFileURL(stub).href)},shortCircuit:true};return next(specifier,context);}});`);
  for(const script of scripts)for(const [name,extra,accepted] of cases)await t.test(script+': '+name,()=>{
   // Deliberately do not inherit any database URL, loader or fixture flag.
   const env={PATH:process.env.PATH,HOME:dir,...extra};
   const result=spawnSync(process.execPath,['--import',loader,fileURLToPath(new URL('./'+script,import.meta.url))],{env,encoding:'utf8',timeout:10000});
   assert.equal(result.error,undefined);assert.equal(result.signal,null);assert.equal(result.status,1);
   const output=result.stdout+result.stderr;
   assert.doesNotMatch(output,/configuration-only/);
   assert.equal(output.includes('28P01'),accepted,output);
   if(script==='read-bridge.mjs'){
    const receipt=JSON.parse(result.stdout);
    assert.equal(receipt.phase,accepted?'connection':'configuration');
    if(name==='retired alias only')assert.equal(receipt.code,'MISSING_DATABASE_URL');
    if(name==='conflicting alias')assert.equal(receipt.code,'CONFLICTING_DATABASE_URLS');
   }
  });
 }finally{await rm(dir,{recursive:true,force:true});}
});
