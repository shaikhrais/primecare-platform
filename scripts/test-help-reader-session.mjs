/** Actual shared session/client regressions with isolated transport ports. No browser or provider traffic. */
import test from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';

const compiled=await build({stdin:{contents:"export {createHelpReaderSession} from './packages/shared/src/help-reader/session'; export {HelpReadFailure} from './packages/shared/src/help-reader/protocol';",resolveDir:process.cwd(),loader:'ts'},bundle:true,write:false,platform:'node',format:'esm'});
const {createHelpReaderSession,HelpReadFailure}=await import('data:text/javascript;base64,'+Buffer.from(compiled.outputFiles[0].text+'\n//# sourceURL=help-reader-session-fixture.mjs').toString('base64'));
const scope={tenantId:'tenant-a',userId:'psw-a',role:'psw',dataset:'live'};
const statuses={invalid_request:400,unauthenticated:401,forbidden:403,not_found:404,conflict:409,rate_limited:429,unavailable:503};
function session(fetcher,callbacks={}){return createHelpReaderSession({origin:'https://help.example',scope,getToken:()=> 't'.repeat(43),isCurrent:()=>true,fetcher,...callbacks});}
function contaminated(code,status){
 const error=new HelpReadFailure(code,status);
 error.message='private upstream article content';error.stack='private bearer token';
 error.cause={search:'private search'};error.transportHeaders={authorization:'private credential'};
 return error;
}
function canonical(error,code,status){
 assert.ok(error instanceof HelpReadFailure);assert.equal(error.code,code);assert.equal(error.status,status);assert.equal(error.message,code);
 assert.deepEqual(Object.keys(error).sort(),['code','status']);assert.equal(Object.hasOwn(error,'cause'),false);assert.equal(Object.hasOwn(error,'transportHeaders'),false);
 assert.equal(error.stack.includes('private'),false);assert.equal(Object.isFrozen(error),true);
 assert.equal(Reflect.set(error,'message','observer mutation'),false);assert.equal(Reflect.set(error,'status',200),false);
}

for(const [code,status] of Object.entries(statuses))test('actual transport '+code+' failure publishes only a fresh immutable canonical session error',async()=>{
 const raw=contaminated(code,status),reader=session(async()=>{throw raw;});
 const seen=[];reader.subscribe(state=>seen.push(state));
 try{
  await reader.load();const snapshot=reader.state;
  assert.notEqual(snapshot.error,raw);canonical(snapshot.error,code,status);assert.equal(Object.isFrozen(snapshot),true);
  assert.equal(snapshot.phase,[401,403,409].includes(status)?'retired':'error');
  assert.equal(reader.canRetry,![400,401,403,409].includes(status));assert.equal(seen.at(-1),snapshot);
  raw.message='later producer mutation';raw.status=200;assert.equal(snapshot.error.message,code);assert.equal(snapshot.error.status,status);
 }finally{reader.dispose();}
});

test('public retirement sanitizes supplied failures before notifying independent observers',()=>{
 const raw=contaminated('forbidden',403),reader=session(async()=>{throw Error('No transport expected');});
 const seen=[];
 reader.subscribe(state=>{if(state.error){assert.equal(Reflect.set(state.error,'message','private observer data'),false);}});
 reader.subscribe(state=>seen.push(state));
 try{reader.retire(raw);assert.equal(reader.state.phase,'retired');assert.notEqual(reader.state.error,raw);canonical(seen[0].error,'forbidden',403);}
 finally{reader.dispose();}
});

test('mismatched transport status is normalized to the approved unavailable failure',async()=>{
 const reader=session(async()=>{throw contaminated('unavailable',200);});
 try{await reader.load();canonical(reader.state.error,'unavailable',503);assert.equal(reader.canRetry,true);}
 finally{reader.dispose();}
});

test('prototype property names cannot masquerade as approved failure pairs',()=>{
 const raw=contaminated('unavailable',503),reader=session(async()=>{throw Error('No transport expected');});
 raw.code='toString';raw.status=Object.prototype.toString;
 try{reader.retire(raw);canonical(reader.state.error,'unavailable',503);}
 finally{reader.dispose();}
});

test('a hostile failure accessor cannot leak a producer exception or interrupt retirement',()=>{
 const raw=contaminated('forbidden',403),reader=session(async()=>{throw Error('No transport expected');});
 let accessed=0;Object.defineProperty(raw,'code',{get(){accessed++;reader.dispose();throw Error('private accessor detail');}});
 try{assert.doesNotThrow(()=>reader.retire(raw));canonical(reader.state.error,'unavailable',503);assert.equal(reader.state.phase,'retired');assert.equal(accessed,0);}
 finally{reader.dispose();}
});

test('valid actual client response still produces a scoped immutable session snapshot without an error',async()=>{
 let calls=0;
 const identity={status:'authenticated',tenantId:scope.tenantId,userId:scope.userId,roles:scope.role};
 const reply={version:1,locale:'en',action:'list',scope,items:[],offset:0,limit:25,total:0};
 const reader=session(async url=>{calls++;return Response.json(url.endsWith('/v1/auth/me')?identity:reply);});
 try{await reader.load();assert.equal(reader.state.phase,'empty');assert.equal(reader.state.error,null);assert.equal(Object.isFrozen(reader.state),true);assert.equal(reader.canRetry,false);assert.equal(calls,3);}
 finally{reader.dispose();}
});

test('producer descriptor reentrancy cannot overwrite disposal with retired state',()=>{
 const reader=session(async()=>{throw Error('No transport expected');});let inspected=0;
 const raw=new Proxy(contaminated('forbidden',403),{getOwnPropertyDescriptor(target,key){inspected++;reader.dispose();return Reflect.getOwnPropertyDescriptor(target,key);}});
 const seen=[];reader.subscribe(state=>seen.push(state));
 reader.retire(raw);assert.ok(inspected>0);assert.equal(reader.state.phase,'disposed');assert.equal(reader.state.error,null);assert.deepEqual(seen,[]);
});

const identity={status:'authenticated',tenantId:scope.tenantId,userId:scope.userId,roles:scope.role};
const reply={version:1,locale:'en',action:'list',scope,items:[],offset:0,limit:25,total:0};
const valid=kind=>kind==='isCurrent'?true:'t'.repeat(43);
// Count the public callback invocations of a real completed client/session read;
// the last callback is its final owner check, after independent identity reads.
async function finalCallback(kind,fails){
 let calls=0;const reader=session(async url=>{if(fails)throw new HelpReadFailure('unavailable',503);return Response.json(url.endsWith('/v1/auth/me')?identity:reply);},{[kind]:()=>{calls++;return valid(kind);}});
 try{await reader.load();return calls;}finally{reader.dispose();}
}
for(const kind of ['isCurrent','getToken'])for(const boundary of ['initial','reply','failure','sessionChanged'])test('reentrant '+kind+' at '+boundary+' cannot replace or retire the newer request',async()=>{
 const target=['reply','failure'].includes(boundary)?await finalCallback(kind,boundary==='failure'):0;
 let reader,replacement,finish,calls=0,armed=false,holdHeaders=false,failed=false;
 const held=new Promise(resolve=>finish=resolve);
 const callback=()=>{
  calls++;
  if(armed&&(!target||calls===target)){
   armed=false;holdHeaders=true;replacement=reader.search('replacement');
   return ['initial','sessionChanged'].includes(boundary)?(kind==='isCurrent'?false:null):valid(kind);
  }
  return valid(kind);
 };
 reader=session(async url=>{
  if(holdHeaders){holdHeaders=false;return held;}
  if(boundary==='failure'&&!failed){failed=true;throw new HelpReadFailure('unavailable',503);}
  return Response.json(url.endsWith('/v1/auth/me')?identity:reply);
 },{[kind]:callback});
 try{
  armed=true;
  if(boundary==='sessionChanged')reader.sessionChanged();else await reader.load();
  assert.ok(replacement,'Public callback must start the independent newer request');
  assert.equal(reader.state.phase,'loading');assert.equal(reader.state.query,'replacement');
  finish(Response.json(identity));await replacement;
  assert.equal(reader.state.phase,'empty');assert.equal(reader.state.query,'replacement');assert.equal(reader.state.error,null);
 }finally{finish(Response.json(identity));await replacement;reader.dispose();}
});
