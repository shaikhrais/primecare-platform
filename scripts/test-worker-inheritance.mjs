import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
async function load(path) {
  const built = await build({entryPoints:[path],bundle:true,write:false,platform:'node',format:'esm',external:['pg','bcryptjs']});
  // The base module has no dependencies; service bundling below includes dependencies.
  return import('data:text/javascript;base64,' + Buffer.from(built.outputFiles[0].text).toString('base64'));
}
const {BaseWorker,workerHandler} = await load('cloudflare/workers/src/core/base-worker.ts');
test('preflight terminates before business dispatch', async () => {
  let handled=0;
  class Worker extends BaseWorker {
    preflight(){return new Response(null,{status:204});}
    async handle(){handled++;return new Response('wrong');}
  }
  const {fetch}=workerHandler(new Worker());
  assert.equal((await fetch(new Request('https://fixture'),{})).status,204);
  assert.equal(handled,0);
});
test('shared base awaits asynchronous hooks and delegates errors', async () => {
  const events=[];
  class Worker extends BaseWorker {
    async preflight(){events.push('preflight');return null;}
    async handle(){events.push('handle');throw Error('failure');}
    onError(){events.push('error');return new Response('safe',{status:500});}
  }
  const response=await workerHandler(new Worker()).fetch(new Request('https://fixture'),{});
  assert.equal(response.status,500);
  assert.deepEqual(events,['preflight','handle','error']);
});
test('parallel requests retain their own environment', async () => {
  class Worker extends BaseWorker {
    async handle(request,env){await Promise.resolve();return new Response(env.name+new URL(request.url).pathname);}
  }
  const handler=workerHandler(new Worker());
  const responses=await Promise.all(['a','b'].map(name=>handler.fetch(new Request('https://fixture/'+name),{name})));
  assert.deepEqual(await Promise.all(responses.map(r=>r.text())),['a/a','b/b']);
});
test('unhandled gateway failures retain rejection semantics', async () => {
  class Worker extends BaseWorker {async handle(){throw Error('binding unavailable');}}
  await assert.rejects(workerHandler(new Worker()).fetch(new Request('https://fixture'),{}),/binding unavailable/);
});
const noDatabase={name:'no-database',setup(builder){
  builder.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));
  builder.onLoad({filter:/.*/,namespace:'fixture'},()=>({loader:'js',contents:'export class Client {constructor(){throw Error("Unexpected database access")}}'}));
}};
const serviceBuild=await build({entryPoints:['cloudflare/workers/src/service.ts'],bundle:true,write:false,platform:'node',format:'esm',plugins:[noDatabase]});
const {default:service}=await import('data:text/javascript;base64,'+Buffer.from(serviceBuild.outputFiles[0].text).toString('base64'));
for(const name of ['auth','client','provider','visit','notes','billing','scheduling','notification','verification','compliance','governance','franchise-reporting']) {
  test(name+' uses central lifecycle without database access for root/preflight', async()=>{
    const env={SERVICE_NAME:name};
    const {fetch}=service;
    const root=await fetch(new Request('https://fixture/'),env);
    assert.deepEqual(await root.json(),{status:'ok',service:name});
    const preflight=await fetch(new Request('https://fixture/private',{method:'OPTIONS',headers:{origin:'https://primecare-client.pages.dev'}}),env);
    assert.equal(preflight.status,204);
    const denied=await fetch(new Request('https://fixture/',{headers:{origin:'https://untrusted.invalid'}}),env);
    assert.equal(denied.status,403);
  });
}
const registryBuild=await build({entryPoints:['cloudflare/workers/src/business-modules.ts'],bundle:true,write:false,platform:'node',format:'esm',plugins:[noDatabase]});
const {businessModules}=await import('data:text/javascript;base64,'+Buffer.from(registryBuild.outputFiles[0].text).toString('base64'));
test('central module registry retains reviewed precedence and cannot mutate',()=>{
  assert.deepEqual(businessModules.map(module=>module.name),[
    'client-booking-lifecycle','provider-timesheet-items','provider-records',
    'provider-self','client-self','governance','workspace',
  ]);
  assert.ok(Object.isFrozen(businessModules));
  assert.ok(businessModules.every(module=>Object.isFrozen(module)));
  assert.throws(()=>businessModules.reverse(),TypeError);
});
const {default:ts}=await import('typescript');
const {readFileSync}=await import('node:fs');
test('concrete Workers inherit fetch and cannot bypass the central lifecycle',()=>{
  for(const [path,parent] of [
    ['cloudflare/workers/src/service.ts','ServiceApplication'],
    ['cloudflare/workers/src/service-application.ts','WorkerApplication'],
    ['cloudflare/workers/src/runtime/worker-application.ts','BaseWorker'],
    ['cloudflare/workers/src/gateway.ts','BaseWorker'],
  ]) {
    const source=ts.createSourceFile(path,readFileSync(path,'utf8'),ts.ScriptTarget.Latest,true);
    const classes=source.statements.filter(ts.isClassDeclaration);
    assert.equal(classes.length,1,path);
    assert.ok(classes[0].heritageClauses.some(clause=>clause.types.some(type=>type.expression.getText(source)===parent)),path);
    assert.ok(!classes[0].members.some(member=>member.name?.getText(source)==='fetch'),path);
  }
});
