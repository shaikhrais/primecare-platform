import {test} from 'node:test';import assert from 'node:assert/strict';import {build} from 'esbuild';
const bundle=await build({entryPoints:['packages/shared/src/data-controls/upload-task.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {UploadTask}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
const policy={maxFiles:2,maxBytes:100,types:['text/plain']},files=[{name:'a.txt',size:5,type:'text/plain',handle:{}},{name:'b.txt',size:5,type:'text/plain',handle:{}}];
async function uploaded(remove,read,safe=false){const task=new UploadTask('actor-session',policy,async()=>({receiptId:'r1'}),true,remove,read,safe);task.choose(files);await task.send();return task;}
const state=present=>({scope:'actor-session',receiptId:'r1',present});
for(const change of ['types','bytes','files'])test('upload retains construction '+change+' limits and receipt after caller policy mutation',async()=>{
 const supplied={maxFiles:1,maxBytes:10,types:['text/plain']};let sends=0;const task=new UploadTask('actor-session',supplied,async()=>{sends++;return{receiptId:'r1'};});task.choose([files[0]]);await task.send();
 let invalid;
 if(change==='types'){supplied.types.push('text/html');invalid=[{...files[0],type:'text/html'}];}
 else if(change==='bytes'){supplied.maxBytes=100;invalid=[{...files[0],size:11}];}
 else{supplied.maxFiles=2;invalid=files;}
 assert.throws(()=>task.choose(invalid),'construction policy cannot be widened by caller mutation');
 assert.equal(task.status,'success');assert.equal(task.receiptId,'r1');assert.equal(task.progress,1);assert.deepEqual(task.files,[files[0]]);assert.equal(sends,1);task.dispose();
});
test('upload keeps allowed original types when caller clears or replaces its list',()=>{
 const supplied={maxFiles:1,maxBytes:10,types:['text/plain']},task=new UploadTask('actor-session',supplied);
 supplied.types.length=0;supplied.types=['text/html'];task.choose([files[0]]);assert.equal(task.status,'ready');assert.deepEqual(task.files,[files[0]]);task.dispose();
});
test('remove selection only before upload',async()=>{const task=new UploadTask('actor-session',policy,async()=>({receiptId:'r1'}));task.choose(files);task.removeSelection(0);assert.deepEqual(task.files.map(f=>f.name),['b.txt']);task.removeSelection(0);assert.equal(task.status,'idle');assert.throws(()=>task.removeSelection(0));task.choose(files);await task.send();assert.throws(()=>task.removeSelection(0));task.dispose();});
test('delete success requires matching acknowledgement and independent absence',async()=>{let present=true,writes=0,reads=0;const task=await uploaded(async()=>{writes++;present=false;return{receiptId:'r1',removed:true};},async()=>{reads++;return state(present);});await task.removeUpload();assert.equal(task.status,'removed');assert.equal(writes,1);assert.equal(reads,1);assert.equal(task.receiptId,null);assert.deepEqual(task.files,[]);task.dispose();});
test('acknowledged delete retries readback only after read failure',async()=>{let writes=0,reads=0;const task=await uploaded(async()=>{writes++;return{receiptId:'r1',removed:true};},async()=>{if(++reads===1)throw Error('offline');return state(false);});await task.removeUpload();assert.equal(task.status,'remove-error');assert.equal(task.receiptId,'r1');assert.equal(task.files.length,2);assert.throws(()=>task.choose(files));await task.removeUpload();assert.equal(task.status,'removed');assert.equal(writes,1);task.dispose();});
test('lost acknowledgement is reconciled without a duplicate delete',async()=>{let writes=0;const task=await uploaded(async()=>{writes++;throw Error('lost response after commit');},async()=>state(false));await task.removeUpload();assert.equal(task.status,'remove-error');await task.removeUpload();assert.equal(task.status,'removed');assert.equal(writes,1);task.dispose();});
test('unsafe retry never repeats a denied or uncertain mutation',async()=>{let writes=0;const task=await uploaded(async()=>{writes++;throw Error('denied');},async()=>state(true));await task.removeUpload();await task.removeUpload();assert.equal(task.status,'remove-error');assert.equal(writes,1);assert.equal(task.receiptId,'r1');task.dispose();});
test('declared idempotent retry preserves the exact delete key',async()=>{let writes=0,present=true;const keys=[];const task=await uploaded(async request=>{keys.push(request.operationKey);if(++writes===1)throw Error('offline before commit');present=false;return{receiptId:'r1',removed:true};},async()=>state(present),true);await task.removeUpload();await task.removeUpload();assert.equal(task.status,'removed');assert.equal(keys[0],keys[1]);task.dispose();});
test('mismatched receipt, foreign scope and a still-present item cannot become removed',async()=>{for(const mode of ['ack','scope','present']){const task=await uploaded(async()=>({receiptId:mode==='ack'?'foreign':'r1',removed:true}),async()=>mode==='scope'?{...state(false),scope:'foreign'}:state(true));await task.removeUpload();assert.equal(task.status,'remove-error');assert.equal(task.receiptId,'r1');task.dispose();}});
test('dispose suppresses late delete completion and unbound deletion is inert',async()=>{let finish;const task=await uploaded(()=>new Promise(resolve=>finish=resolve),async()=>state(false));const operation=task.removeUpload();task.dispose();finish({receiptId:'r1',removed:true});await operation;assert.equal(task.status,'disposed');const unbound=await uploaded();await unbound.removeUpload();assert.equal(unbound.status,'success');unbound.dispose();});

test('invalid replacement preserves selection, retry key and acknowledged receipt',async()=>{
 const keys=[],task=new UploadTask('actor-session',policy,async request=>{keys.push(request.operationKey);if(keys.length===1)throw Error('offline');return{receiptId:'r1'};},true,async()=>({receiptId:'r1',removed:true}),async()=>state(false));
 task.choose(files);await task.send();let notifications=0;task.subscribe(()=>notifications++);
 for(const invalid of [[],[{...files[0],size:101}],[{...files[0],type:'text/html'}]]){assert.throws(()=>task.choose(invalid));assert.equal(task.status,'error');assert.deepEqual(task.files,files);assert.equal(notifications,0);}
 await task.send();assert.equal(keys[0],keys[1]);assert.equal(task.status,'success');const before=notifications;
 assert.throws(()=>task.choose([{...files[0],name:'../bad'}]));assert.equal(task.receiptId,'r1');assert.equal(task.progress,1);assert.equal(task.status,'success');assert.deepEqual(task.files,files);assert.equal(notifications,before);
 await task.removeUpload();assert.equal(task.status,'removed');task.dispose();
});
test('valid replacement commits once without an intermediate empty selection',()=>{
 const task=new UploadTask('actor-session',policy),observed=[];task.choose(files);task.subscribe(()=>observed.push({status:task.status,names:task.files.map(f=>f.name)}));task.choose([files[1]]);assert.deepEqual(observed,[{status:'ready',names:['b.txt']}]);task.dispose();
});

test('synchronous upload cancellation prevents transport and retains retry selection',async()=>{
 let sends=0;const task=new UploadTask('actor-session',policy,async()=>{sends++;return{receiptId:'r1'};},true);task.choose(files);
 const unsubscribe=task.subscribe(()=>{if(task.status==='uploading')task.cancel();});
 await task.send();assert.equal(sends,0);assert.equal(task.status,'cancelled');assert.deepEqual(task.files,files);
 unsubscribe();await task.send();assert.equal(sends,1);assert.equal(task.status,'success');task.dispose();
});
test('synchronous upload disposal prevents transport',async()=>{
 let sends=0;const task=new UploadTask('actor-session',policy,async()=>{sends++;return{receiptId:'r1'};});task.choose(files);
 task.subscribe(()=>{if(task.status==='uploading')task.dispose();});await task.send();assert.equal(sends,0);assert.equal(task.status,'disposed');
});
test('synchronous removal disposal prevents mutation and receipt reads',async()=>{
 let removes=0,reads=0;const task=await uploaded(async()=>{removes++;return{receiptId:'r1',removed:true};},async()=>{reads++;return state(false);});
 task.subscribe(()=>{if(task.status==='removing')task.dispose();});await task.removeUpload();assert.equal(removes,0);assert.equal(reads,0);assert.equal(task.status,'disposed');
});

test('upload cancellation retains disposal performed by the adapter abort callback',async()=>{
 let finish;const task=new UploadTask('actor-session',policy,request=>{request.signal.addEventListener('abort',()=>task.dispose(),{once:true});return new Promise(resolve=>finish=resolve);},true);task.choose(files);
 const pending=task.send();task.cancel();assert.equal(task.status,'disposed');finish({receiptId:'late'});await pending;assert.equal(task.status,'disposed');assert.equal(task.receiptId,null);
});
test('retry setup retains abort callback disposal and does not call transport again',async()=>{
 let sends=0;const task=new UploadTask('actor-session',policy,async request=>{sends++;request.signal.addEventListener('abort',()=>task.dispose(),{once:true});throw Error('offline');},true);task.choose(files);await task.send();assert.equal(task.status,'error');await task.send();assert.equal(task.status,'disposed');assert.equal(sends,1);
});
test('removal setup retains upload abort callback disposal and performs no deletion',async()=>{
 let removes=0,reads=0;const task=new UploadTask('actor-session',policy,async request=>{request.signal.addEventListener('abort',()=>task.dispose(),{once:true});return{receiptId:'r1'};},true,async()=>{removes++;return{receiptId:'r1',removed:true};},async()=>{reads++;return state(false);});task.choose(files);await task.send();await task.removeUpload();assert.equal(task.status,'disposed');assert.equal(removes,0);assert.equal(reads,0);
});
test('disposal becomes terminal before adapter abort callbacks can restart an errored upload',async()=>{
 let sends=0,restart;const task=new UploadTask('actor-session',policy,async request=>{sends++;request.signal.addEventListener('abort',()=>{restart=task.send();},{once:true});throw Error('offline');},true);task.choose(files);await task.send();task.dispose();await restart;assert.equal(task.status,'disposed');assert.equal(sends,1);
});
