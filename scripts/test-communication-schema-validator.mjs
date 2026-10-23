import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {createContext,runInContext} from 'node:vm';
import {build} from 'esbuild';
import Ajv from 'ajv';
import addFormats from 'ajv-formats';

const catalog=JSON.parse(readFileSync('packages/shared/src/communications/registered-contracts.json'));
const bundle=await build({stdin:{contents:`import catalog from './packages/shared/src/communications/registered-contracts.json';import {validateRegisteredCommunicationSchema as check} from './cloudflare/workers/src/business-tasks/schema-validator.ts';export function validate(id,kind,value){return check(catalog.apis.find(api=>api.id===id)?.[kind+'Schema'],value)}export {check};`,resolveDir:process.cwd()},bundle:true,format:'cjs',platform:'neutral',write:false});
const context=createContext({module:{exports:{}}},{codeGeneration:{strings:false,wasm:false}});
runInContext(bundle.outputFiles[0].text,context);
const {validate,check}=context.module.exports;
const ajv=new Ajv({strict:false});addFormats(ajv);ajv.addFormat('binary',true);
function sample(schema){
 if(schema.const!==undefined)return schema.const;
 if(schema.enum)return schema.enum[0];
 if(schema.oneOf)return sample(schema.oneOf[0]);
 if(schema.type==='object')return Object.fromEntries((schema.required??[]).map(key=>[key,sample(schema.properties[key])]));
 if(schema.type==='array')return Array.from({length:schema.minItems??0},()=>sample(schema.items));
 if(schema.type==='integer'||schema.type==='number')return schema.minimum??0;
 if(schema.type==='boolean')return false;
 return schema.format==='email'?'synthetic@example.invalid':'x'.repeat(Math.max(1,schema.minLength??1));
}
test('registered validators operate when dynamic code generation is forbidden',()=>{
 assert.throws(()=>runInContext('new Function("return true")',context),/Code generation/);
 assert.equal(validate(710,'request',{action:'read',id:'thread'}),true);
 assert.equal(validate(710,'request',{action:'read',id:'thread',tenantId:'forged'}),false);
 assert.equal(check({type:'object'},{}),false);assert.equal(check(null,{}),false);
});
test('all registered request variants and response schemas agree with the build compiler without mutating input',()=>{
 let checked=0;
 for(const api of catalog.apis)for(const kind of ['request','response']){
  const schema=api[kind+'Schema'],reference=ajv.compile(schema);
  const examples=(schema.oneOf??[schema]).map(sample);
  const values=[...examples,null,{},[],0,true,'',...examples.flatMap(value=>typeof value==='object'&&value!==null&&!Array.isArray(value)?[{...value,actorId:'forged'},...Object.keys(value).map(key=>({...value,[key]:null}))]:[])];
  for(const value of values){const before=JSON.stringify(value);assert.equal(validate(api.id,kind,value),reference(value),api.id+' '+kind);assert.equal(JSON.stringify(value),before);checked++;}
 }
 assert.ok(checked>100);
});
test('registered wire enum, email format and Unicode length are retained',()=>{
 const base={action:'signal',id:'thread',key:'key',version:1,callId:'call'};
 assert.equal(validate(16510,'request',{...base,signal:{type:'ice',candidate:{candidate:'synthetic'}}}),true);
 assert.equal(validate(16510,'request',{...base,signal:{type:'candidate',candidate:{candidate:'synthetic'}}}),false);
 const email={action:'queue',id:'mail',key:'key',to:'synthetic@example.invalid',subject:'Subject',text:'Text'};
 assert.equal(validate(16511,'request',email),true);assert.equal(validate(16511,'request',{...email,to:'invalid'}),false);
 assert.equal(validate(710,'response',{id:'😀'.repeat(200),version:1}),true);
 assert.equal(validate(710,'response',{id:'😀'.repeat(201),version:1}),false);
});
