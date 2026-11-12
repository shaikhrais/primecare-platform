import {test} from 'node:test';import assert from 'node:assert/strict';import {api} from './component-catalogue-fixtures.mjs';
test('code is preserved literally and bounded even with unfinished comments and malicious markup',()=>{for(const s of ['<script>fetch("secret")</script>','/*'.repeat(16000),'"\\'.repeat(16000),'😀 const ready = true;'])assert.equal(api.codeTokens(s).map(t=>t.text).join(''),s);assert.throws(()=>api.codeTokens('x'.repeat(32769)));});
test('countdown recomputes from absolute time and cannot become negative',()=>{assert.equal(api.remainingSeconds(10000,1001),9);assert.equal(api.remainingSeconds(10000,9999),1);assert.equal(api.remainingSeconds(10000,30000),0);for(const v of [NaN,-1,Infinity,Number.MAX_SAFE_INTEGER+1])assert.throws(()=>api.remainingSeconds(v,0));});
test('responsive form geometry is bounded and handles a narrow viewport without overflow columns',()=>{assert.equal(api.responsiveColumns(100,240,16),1);assert.equal(api.responsiveColumns(1000,240,16),3);assert.equal(api.responsiveColumns(100000,1,0),12);for(const a of [[NaN,1,1],[100,0,1],[100,1,-1]])assert.throws(()=>api.responsiveColumns(...a));});

const built=await (await import('esbuild')).build({entryPoints:['packages/shared/src/component-catalogue/async-task.ts'],bundle:true,platform:'node',format:'esm',write:false});const {AsyncTask}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
test('disposing from a loading subscription prevents the loader from starting',async()=>{
 const task=new AsyncTask();let calls=0;task.subscribe(()=>{if(task.current.status==='loading')task.dispose();});
 await task.load('disposed-before-start',async()=>{calls++;return 'stale';});assert.equal(calls,0);assert.deepEqual(task.current,{status:'disposed',data:null});
});
test('a loading subscription can replace a request without starting its superseded loader',async()=>{
 const task=new AsyncTask();let replaced=false,newest,calls=0,signal;
 task.subscribe(()=>{if(task.current.status==='loading'&&!replaced){replaced=true;newest=task.load('latest',async current=>{signal=current;return 'latest';});}});
 await task.load('superseded',async()=>{calls++;return 'stale';});await newest;
 assert.equal(calls,0);assert.equal(signal.aborted,false);assert.deepEqual(task.current,{status:'ready',data:'latest'});task.dispose();assert.equal(signal.aborted,true);
});
test('reentrant abort replacement retains the newest controller and skips the interrupted loader',async()=>{
 const task=new AsyncTask();let oldSignal,newSignal,newest,finish,calls=0;
 const old=task.load('old',signal=>{oldSignal=signal;signal.addEventListener('abort',()=>{newest=task.load('newest',current=>{newSignal=current;return new Promise(resolve=>finish=resolve);});},{once:true});return Promise.resolve('old');});
 await task.load('interrupted',async()=>{calls++;return 'interrupted';});await old;
 assert.equal(oldSignal.aborted,true);assert.equal(calls,0);assert.equal(newSignal.aborted,false);assert.deepEqual(task.current,{status:'loading',data:null});
 task.dispose();assert.equal(newSignal.aborted,true,'disposal must abort the current replacement signal');finish('late newest');await newest;assert.deepEqual(task.current,{status:'disposed',data:null});
});
test('async boundaries clear old data and ignore stale actor results and disposed completions',async()=>{let release;const pending=new Promise(r=>release=r),task=new AsyncTask();const old=task.load('old',()=>pending);await task.load('new',async()=> 'new data');release('old data');await old;assert.equal(task.current.data,'new data');await task.load('new',async()=>{throw Error('server');});assert.equal(task.current.status,'error');assert.equal(task.current.data,null);task.dispose();await assert.rejects(()=>task.load('new',async()=> 'bad'));});
