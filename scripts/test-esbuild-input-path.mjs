import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {mkdtemp,writeFile,readFile,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join,isAbsolute,resolve} from 'node:path';
import {esbuildInputPath} from './esbuild-input-path.mjs';

for(const mixed of [false,true])test(`real JSON import evidence resolves with mixed imports=${mixed}`,async()=>{
 const dir=await mkdtemp(join(tmpdir(),'primecare-import-evidence-'));
 try{
  const file=join(dir,'policy.json'),text='{"version":2}';
  await writeFile(file,text);
  const result=await build({stdin:{contents:'import policy from "./policy.json" with {type:"json"};'+(mixed?'import plain from "./policy.json";console.log(plain);':'')+'console.log(policy);',resolveDir:dir},bundle:true,write:false,metafile:true});
  const entries=Object.entries(result.metafile.inputs).filter(([name])=>name!=='<stdin>');
  assert.equal(entries.length,mixed?2:1);
  const [name,input]=entries.find(([,input])=>input.with);
  assert.deepEqual(input.with,{type:'json'});
  if(mixed)await assert.rejects(readFile(isAbsolute(name)?name:resolve(name)),{code:'ENOENT'});
  const path=esbuildInputPath(name,input);
  assert.equal(await readFile(path,'utf8'),text);
 }finally{await rm(dir,{recursive:true,force:true});}
});

test('plain inputs retain their identity and unsupported attributes fail closed',()=>{
 assert.equal(esbuildInputPath('src/service.ts',{}),'src/service.ts');
 for(const attributes of [null,{type:'css'},{type:'json',extra:'value'}])assert.throws(()=>esbuildInputPath('src/policy.json',{with:attributes}));
 assert.equal(esbuildInputPath('src/policy.json',{with:{type:'json'}}),'src/policy.json');
});
