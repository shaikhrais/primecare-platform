import {test} from 'node:test';import assert from 'node:assert/strict';import {build} from 'esbuild';
const bundle=await build({entryPoints:['packages/shared/src/preference-sync/transport.ts'],bundle:true,platform:'node',format:'esm',write:false});
const client=await build({entryPoints:['packages/shared/src/preference-sync/client.ts'],bundle:true,platform:'node',format:'esm',write:false});
const api=await import('data:text/javascript;base64,'+Buffer.from(client.outputFiles[0].text).toString('base64'));const {preferenceHttpTransport}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
const {PreferenceSyncClient,PreferenceFailure,preferenceKey,preferenceRequest}=api;
const binding={scope:{tenantId:'tenant1',userId:'user1',role:'psw',dataset:'live'},kind:'shortcuts',resource:'navigation',policy:{panelIds:[],screenIds:['1','2']}};
const doc=id=>({version:1,screenIds:[id]});let sequence=1;const uuid=()=>`00000000-0000-4000-8000-${String(sequence++).padStart(12,'0')}`;
function cache(){const data=new Map();return {data,read:async k=>data.get(k)??null,write:async(k,v)=>{data.set(k,v);},remove:async k=>{data.delete(k);}};}
function server(){let snapshot={version:1,scope:binding.scope,kind:binding.kind,resource:binding.resource,revision:0,document:null};const receipts=new Map();let offline=false,lost=false;return {get snapshot(){return structuredClone(snapshot);},set offline(v){offline=v;},set lost(v){lost=v;},transport:async r=>{if(offline)throw Error('network');if(r.action==='read')return structuredClone(snapshot);if(receipts.has(r.requestId))return receipts.get(r.requestId);if(r.revision!==snapshot.revision)throw new PreferenceFailure('revision_conflict',409,structuredClone(snapshot));snapshot={...snapshot,revision:snapshot.revision+1,document:r.action==='write'?r.document:null};receipts.set(r.requestId,structuredClone(snapshot));if(lost){lost=false;throw Error('lost acknowledgement');}return structuredClone(snapshot);}};}
const make=(s,c=cache(),b=binding)=>new PreferenceSyncClient(b,s.transport,c,uuid);
test('two devices conflict, explicit local/remote resolution, reload and monotonic reset/delete',async()=>{const s=server(),a=make(s),c=cache(),b=make(s,c);await a.load();await b.load();await a.edit(doc('1'));await a.save();await b.edit(doc('2'));await b.save();assert.equal(b.current.status,'conflict');assert.deepEqual(b.current.draft,doc('2'));await b.keepLocal();await b.save();assert.equal(s.snapshot.revision,2);const reloaded=make(s,c);await reloaded.load();assert.deepEqual(reloaded.current.draft,doc('2'));await a.edit(doc('1'));await a.save();await a.acceptRemote();assert.deepEqual(a.current.draft,doc('2'));await a.edit(null);await a.save('reset');assert.equal(s.snapshot.revision,3);await a.save('delete');assert.equal(s.snapshot.revision,4);assert.equal(s.snapshot.document,null);});
test('lost acknowledgement survives reload and retries exact request UUID once',async()=>{const s=server(),c=cache(),a=make(s,c);await a.load();await a.edit(doc('1'));s.lost=true;await a.save();assert.equal(a.current.status,'offline');const requestId=a.current.pending.requestId;await a.dispose();const b=make(s,c);await b.load();assert.equal(b.current.status,'conflict');assert.equal(b.current.pending.requestId,requestId);await b.retryPending();assert.equal(s.snapshot.revision,1);assert.equal(b.current.status,'clean');});
test('restart after lost acknowledgement retains a newer cached draft',async()=>{const s=server(),c=cache(),a=make(s,c);await a.load();await a.edit(doc('1'));s.lost=true;await a.save();await a.edit(doc('2'));await a.dispose();const b=make(s,c);await b.load();await b.retryPending();assert.equal(b.current.status,'dirty');assert.deepEqual(b.current.draft,doc('2'));assert.equal(b.current.base.revision,1);await b.save();assert.deepEqual(s.snapshot.document,doc('2'));assert.equal(s.snapshot.revision,2);});
test('offline initialization queues a durable CAS request without automatic retry',async()=>{const s=server(),c=cache(),a=make(s,c);s.offline=true;await a.load();await a.edit(doc('1'));await a.save();assert.equal(a.current.status,'offline');assert.ok(a.current.pending);s.offline=false;assert.equal(s.snapshot.revision,0);await a.retryPending();assert.equal(s.snapshot.revision,1);});
test('refresh preserves unsaved edits; edit while acknowledgement is pending stays dirty',async()=>{const s=server(),a=make(s);await a.load();await a.edit(doc('1'));await a.load();assert.deepEqual(a.current.draft,doc('1'));let release;const blocked=new Promise(r=>release=r),transport=s.transport;s.transport=async r=>{if(r.action!=='read')await blocked;return transport(r);};const b=make(s);await b.load();await b.edit(doc('1'));const saving=b.save();await new Promise(r=>setTimeout(r,0));await b.edit(doc('2'));release();await saving;assert.equal(b.current.status,'dirty');assert.deepEqual(b.current.draft,doc('2'));await b.save();assert.deepEqual(s.snapshot.document,doc('2'));});
test('storage rejection prevents a mutation from reaching the transport',async()=>{let calls=0;const s=server(),c=cache(),a=new PreferenceSyncClient(binding,async r=>{if(r.action!=='read')calls++;return s.transport(r);},c,uuid);await a.load();await a.edit(doc('1'));c.write=async()=>{throw Error('denied');};await a.save();assert.equal(calls,0);assert.equal(a.current.status,'error');assert.equal(a.current.error,'cache_unavailable');});
test('strict schemas, account/dataset isolation and proven migration only',async()=>{const s=server(),c=cache(),a=make(s,c);await a.load();await assert.rejects(()=>a.adoptLocal(doc('1'),{...binding.scope,userId:'other'}));assert.throws(()=>preferenceRequest({version:1,action:'read',dataset:'live',kind:'shortcuts',resource:'navigation',expectedScope:binding.scope,tenantId:'other'},binding.policy));await assert.rejects(()=>a.edit(doc('99')));assert.notEqual(preferenceKey(binding),preferenceKey({...binding,scope:{...binding.scope,dataset:'demo'}}));const b=make(s,cache(),{...binding,scope:{...binding.scope,userId:'other'}});await b.load();assert.equal(b.current.error,'scope_changed');assert.throws(()=>{a.binding.policy.screenIds.push('99');});});
test('disposed client ignores delayed responses',async()=>{let release;const wait=new Promise(r=>release=r),s=server(),a=new PreferenceSyncClient(binding,async r=>{await wait;return s.transport(r);},cache(),uuid);const loading=a.load();await a.dispose();release();await loading;assert.equal(a.current.status,'disposed');assert.equal(a.current.base.revision,0);});
test('disposing during durable request storage prevents a later network mutation',async()=>{
 const s=server(),c=cache();let calls=0;const a=new PreferenceSyncClient(binding,async r=>{if(r.action!=='read')calls++;return s.transport(r);},c,uuid);
 await a.load();await a.edit(doc('1'));let release,started;const blocked=new Promise(r=>release=r),entered=new Promise(r=>started=r),write=c.write;
 c.write=async(k,v)=>{started();await blocked;await write(k,v);};
 const saving=a.save();await entered;const disposed=a.dispose();release();await Promise.all([saving,disposed]);
 assert.equal(calls,0);assert.equal(s.snapshot.revision,0);assert.equal(a.current.status,'disposed');
 // The original command remains recoverable by the same actor, with explicit retry only.
 const b=make(s,c);await b.load();assert.equal(s.snapshot.revision,0);assert.ok(b.current.pending);await b.retryPending();assert.equal(s.snapshot.revision,1);await b.dispose();
});
test('HTTP adapter uses registered POST, bearer only, bounded replies and typed conflict',async()=>{let captured;const transport=preferenceHttpTransport('https://example.test','x'.repeat(43),async(url,options)=>{captured={url,options};return Response.json({error:'revision_conflict',current:{revision:1}},{status:409});});await assert.rejects(()=>transport({action:'read'},new AbortController().signal),e=>e.code==='revision_conflict'&&e.current.revision===1);assert.equal(captured.url,'https://example.test/v1/user/preferences');assert.equal(captured.options.credentials,'omit');assert.equal(captured.options.redirect,'error');assert.throws(()=>preferenceHttpTransport('https://example.test/arbitrary','x'.repeat(43)));const huge=preferenceHttpTransport('https://example.test','x'.repeat(43),async()=>new Response('x'.repeat(262145)));await assert.rejects(()=>huge({},new AbortController().signal),e=>e.code==='invalid_response');});
test('discard locks edits and mutations until storage finishes',async()=>{const s=server(),c=cache(),a=make(s,c);await a.load();await a.edit(doc('1'));let release;c.remove=()=>new Promise(r=>release=r);const discard=a.discardLocal();await new Promise(r=>setImmediate(r));assert.equal(a.current.status,'discarding');for(const action of [()=>a.edit(doc('2')),()=>a.save(),()=>a.load(),()=>a.discardLocal()])await assert.rejects(action,e=>e.code==='busy_or_disposed');release();await discard;assert.equal(a.current.status,'idle');assert.equal(s.snapshot.revision,0);});
test('failed discard retains the draft and reports storage failure',async()=>{const s=server(),c=cache(),a=make(s,c);await a.load();await a.edit(doc('1'));c.remove=async()=>{throw Error('denied');};await assert.rejects(()=>a.discardLocal(),e=>e.code==='cache_unavailable');assert.equal(a.current.error,'cache_unavailable');assert.deepEqual(a.current.draft,doc('1'));await a.edit(doc('2'));assert.deepEqual(a.current.draft,doc('2'));});
test('late discard completion cannot revive a disposed actor',async()=>{const s=server(),c=cache(),a=make(s,c);await a.load();await a.edit(doc('1'));let release;c.remove=()=>new Promise(r=>release=r);const discard=a.discardLocal();await new Promise(r=>setImmediate(r));await a.dispose();release();await discard;assert.equal(a.current.status,'disposed');assert.deepEqual(a.current.draft,doc('1'));});
for(const operation of ['edit','acceptRemote','keepLocal'])test(`late ${operation} storage failure cannot revive a disposed actor`,async()=>{
 const s=server(),c=cache();let changes=0;const a=new PreferenceSyncClient(binding,s.transport,c,uuid,()=>changes++);await a.load();await a.edit(doc('1'));
 if(operation!=='edit'){const other=make(s);await other.load();await other.edit(doc('2'));await other.save();await a.load();assert.equal(a.current.status,'conflict');await other.dispose();}
 let release,started;const blocked=new Promise(r=>release=r),entered=new Promise(r=>started=r);c.write=async()=>{started();await blocked;throw Error('late storage denial');};
 const work=operation==='edit'?a.edit(doc('2')):a[operation]();
 const completed=operation==='edit'?work:assert.rejects(work,e=>e.code==='cache_unavailable');await entered;const disposed=a.dispose(),notifications=changes;release();await Promise.all([completed,disposed]);
 assert.equal(a.current.status,'disposed');assert.equal(changes,notifications);assert.equal(s.snapshot.revision,operation==='edit'?0:1);
});

test('receipt replay records the acknowledged base while retaining a newer remote conflict',async()=>{
 const s=server(),c=cache(),a=make(s,c),other=make(s);
 await a.load();await a.edit(doc('1'));s.lost=true;await a.save();
 await other.load();await other.edit(doc('2'));await other.save();
 await a.dispose();const restarted=make(s,c);await restarted.load();await restarted.retryPending();
 assert.equal(restarted.current.status,'conflict');
 assert.equal(restarted.current.pending,null);
 assert.equal(restarted.current.base.revision,1);
 assert.equal(restarted.current.remote.revision,2);
 assert.equal(JSON.parse(c.data.get(preferenceKey(binding))).base.revision,1);
 await restarted.acceptRemote();assert.deepEqual(restarted.current.draft,doc('2'));
});

for(const mode of ['clean','dirty','restart','conflict'])test(`stale refresh preserves ${mode} preference recovery state`,async()=>{
 const s=server(),c=cache();let stale=null;
 const transport=async r=>r.action==='read'&&stale?structuredClone(stale):s.transport(r);
 let a=new PreferenceSyncClient(binding,transport,c,uuid);
 await a.load();const revisionZero=s.snapshot;await a.edit(doc('1'));await a.save();
 if(mode==='dirty')await a.edit(doc('2'));
 if(mode==='restart'){await a.dispose();a=new PreferenceSyncClient(binding,transport,c,uuid);}
 if(mode==='conflict'){
  await a.edit(doc('2'));const other=make(s);await other.load();await other.edit(doc('2'));await other.save();await a.load();await other.dispose();
 }
 const before=a.current,stored=c.data.get(preferenceKey(binding));
 stale=mode==='conflict'?{...s.snapshot,revision:1,document:doc('1')}:revisionZero;
 await a.load();
 assert.equal(a.current.status,'error');assert.equal(a.current.error,'invalid_response');
 assert.equal(a.current.base.revision,1);assert.deepEqual(a.current.draft,mode==='restart'?doc('1'):before.draft);
 assert.deepEqual(a.current.pending,before.pending);assert.deepEqual(a.current.remote,before.remote);
 assert.equal(c.data.get(preferenceKey(binding)),stored);
 if(mode==='conflict')await assert.rejects(()=>a.save(),e=>e.code==='explicit_resolution_required');
 stale=null;await a.load();assert.equal(a.current.status,mode==='conflict'?'conflict':mode==='dirty'?'dirty':'clean');await a.dispose();
});

for(const mode of ['clean','dirty','restart','remote'])test(`same-revision changed content preserves ${mode} recovery state`,async()=>{
 const s=server(),c=cache();let response=null;
 const transport=async r=>r.action==='read'&&response?structuredClone(response):s.transport(r);
 let a=new PreferenceSyncClient(binding,transport,c,uuid);
 await a.load();await a.edit(doc('1'));await a.save();
 if(mode==='dirty'||mode==='remote')await a.edit(doc('2'));
 if(mode==='remote'){const other=make(s);await other.load();await other.edit(doc('2'));await other.save();await a.load();await other.dispose();}
 if(mode==='restart'){await a.dispose();a=new PreferenceSyncClient(binding,transport,c,uuid);await a.load();}
 const before=a.current,stored=c.data.get(preferenceKey(binding));response={...s.snapshot,document:mode==='remote'?doc('1'):doc('2')};
 await a.load();assert.equal(a.current.error,'invalid_response');
 for(const key of ['base','draft','pending','remote','dirty'])assert.deepEqual(a.current[key],before[key]);
 assert.equal(c.data.get(preferenceKey(binding)),stored);response=null;await a.load();assert.equal(a.current.error,mode==='remote'?'revision_conflict':null);await a.dispose();
});
for(const mode of ['stale','changed'])test(`invalid ${mode} conflict reply retains original pending receipt and newer remote`,async()=>{
 const s=server(),a=make(s);await a.load();await a.edit(doc('1'));s.lost=true;await a.save();
 const other=make(s);await other.load();await other.edit(doc('2'));await other.save();await a.load();
 const before=a.current,original=s.transport;
 // Restore the durable pending receipt with a transport that can return an invalid conflict.
 const c=cache();c.data.set(preferenceKey(binding),JSON.stringify({version:1,base:before.base,draft:before.draft,dirty:before.dirty,pending:before.pending}));
 let bad=false;const b=new PreferenceSyncClient(binding,async r=>{if(bad)throw new PreferenceFailure('revision_conflict',409,mode==='stale'?{...s.snapshot,revision:0,document:null}:{...s.snapshot,document:doc('1')});return original(r);},c,uuid);
 await b.load();const known=b.current;bad=true;await b.retryPending();assert.equal(b.current.error,'invalid_response');
 for(const key of ['base','draft','pending','remote','dirty'])assert.deepEqual(b.current[key],known[key]);
 bad=false;await b.retryPending();assert.equal(b.current.base.revision,1);assert.equal(b.current.remote.revision,2);assert.equal(b.current.status,'conflict');
 await a.dispose();await b.dispose();await other.dispose();
});

test('subscriptions observe direct state changes alongside the original host callback',async()=>{
 const s=server(),host=[],events=[];let a;a=new PreferenceSyncClient(binding,s.transport,cache(),uuid,()=>host.push(a.current.status));
 const unsubscribe=a.subscribe(()=>events.push(a.current.status));assert.deepEqual(events,[]);
 await a.load();await a.edit(doc('1'));await a.save();assert.deepEqual(events,['loading','clean','dirty','saving','clean']);assert.deepEqual(host,events);
 unsubscribe();await a.edit(doc('2'));assert.equal(events.length,5);assert.equal(host.at(-1),'dirty');await a.dispose();
});
test('duplicate listeners have independent idempotent unsubscribe ownership',async()=>{
 const a=make(server());await a.load();let calls=0;const listener=()=>calls++,first=a.subscribe(listener),second=a.subscribe(listener);
 await a.edit(doc('1'));assert.equal(calls,2);first();first();await a.edit(doc('2'));assert.equal(calls,3);second();await a.edit(doc('1'));assert.equal(calls,3);await a.dispose();second();
});
test('notification snapshot respects removal and defers subscriptions created during dispatch',async()=>{
 const a=make(server());await a.load();let secondCalls=0,addedCalls=0,added=false,removeSecond;
 a.subscribe(()=>{if(!added){removeSecond();a.subscribe(()=>addedCalls++);added=true;}});removeSecond=a.subscribe(()=>secondCalls++);
 await a.edit(doc('1'));assert.equal(secondCalls,0);assert.equal(addedCalls,0);await a.edit(doc('2'));assert.equal(secondCalls,0);assert.equal(addedCalls,1);await a.dispose();
});
test('subscriber failures cannot turn persistence success into an offline or error state',async()=>{
 const s=server(),a=make(s);let notifications=0;a.subscribe(()=>{throw Error('observer failed');});a.subscribe(()=>notifications++);
 await a.load();await a.edit(doc('1'));await a.save();assert.equal(a.current.status,'clean');assert.equal(a.current.error,null);assert.equal(s.snapshot.revision,1);assert.equal(notifications,5);await a.dispose();
});
test('disposal during a notification prevents remaining observers and future subscriptions',async()=>{
 const a=make(server());await a.load();let late=0;a.subscribe(()=>{void a.dispose();});const remove=a.subscribe(()=>late++);
 await a.edit(doc('1'));assert.equal(a.current.status,'disposed');assert.equal(late,0);remove();assert.throws(()=>a.subscribe(()=>{}),e=>e.code==='busy_or_disposed');
});
test('original host callback can unsubscribe an observer before its notification',async()=>{
 let remove;const a=new PreferenceSyncClient(binding,server().transport,cache(),uuid,()=>remove?.());let calls=0;remove=a.subscribe(()=>calls++);
 await a.load();assert.equal(calls,0);assert.equal(a.current.status,'clean');await a.dispose();
});

test('throwing original host observer cannot lock load or corrupt durable saves',async()=>{
 const s=server(),c=cache();let notifications=0;const a=new PreferenceSyncClient(binding,s.transport,c,uuid,()=>{throw Error('host render failed');});
 a.subscribe(()=>notifications++);await a.load();assert.equal(a.current.status,'clean');await a.edit(doc('1'));await a.save();
 assert.equal(a.current.status,'clean');assert.equal(a.current.error,null);assert.equal(s.snapshot.revision,1);assert.equal(notifications,5);
 await a.load();assert.equal(a.current.status,'clean');assert.equal(notifications,7);await a.dispose();
 const restored=make(s,c);await restored.load();assert.deepEqual(restored.current.draft,doc('1'));assert.equal(restored.current.base.revision,1);await restored.dispose();
});
