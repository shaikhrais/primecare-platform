import {test} from 'node:test';
import assert from 'node:assert/strict';
import {describeWorkerPreservation as describe} from './describe-worker-preservation.mjs';

test('description reports sorted dependency names and count without binding values or credentials',()=>{
 const settings={observability:{enabled:true},credentials:'do-not-publish-token',bindings:[
  {type:'secret_text',name:'DB_URL',text:'do-not-publish-db'},
  {type:'secret_text',name:'Z_KEY',text:'do-not-publish-z'},
  {type:'plain_text',name:'PUBLIC_BINDING',text:'do-not-publish-ordinary-value'},
  {type:'secret_text',name:'A_KEY',value:'do-not-publish-a'}]};
 const config={observability:{enabled:true},vars:{OTHER:'do-not-publish-config'}},before=structuredClone({settings,config});
 const result=describe('governance',settings,config);
 assert.deepEqual(result,{service:'governance',liveObservability:{enabled:true},generatedObservability:{enabled:true},
  additionalSecretCount:2,additionalSecretNames:['A_KEY','Z_KEY']});
 assert.doesNotMatch(JSON.stringify(result),/do-not-publish/);assert.deepEqual({settings,config},before);
});
test('no additional secret still reports an explicit empty dependency list',()=>{
 assert.deepEqual(describe('client',{bindings:[{type:'secret_text',name:'DB_URL'}]},{}),
  {service:'client',liveObservability:null,generatedObservability:null,additionalSecretCount:0,additionalSecretNames:[]});
});
test('invalid scope, missing metadata and unnamed secrets fail closed',()=>{
 for(const [service,settings,config] of [['auth',{bindings:[]},{}],['other',{bindings:[]},{}],['client',null,{}],
  ['client',{bindings:[]},null],['client',{bindings:[{type:'secret_text'}]},{}],['client',{bindings:[{type:'secret_text',name:''}]},{}]])
  assert.throws(()=>describe(service,settings,config));
});
