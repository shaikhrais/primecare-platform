import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
/** Host supplies current session/registry authorization and durable claim storage.
 * A claimed mutation is never automatically repeated after an ambiguous result. */
export async function handleVapiAdmin(request,{client,authorize,claim,complete}){
 const headers={'cache-control':'private, no-store','x-content-type-options':'nosniff'};
 const reply=(body,status=200)=>Response.json(body,{status,headers});
 const url=new URL(request.url),operation=url.pathname.split('/').at(-1);
 const methods={inventory:'GET',assistants:'POST',tools:'POST',attachment:'POST'};
 if(!Object.hasOwn(methods,operation))return reply({error:'not_found'},404);
 if(request.method!==methods[operation])return reply({error:'method_not_allowed'},405);
 if(url.search||url.hash||request.headers.has('x-tenant-id'))return reply({error:'invalid_request'},400);
 try{
  await authorize(operation);
  if(!client)return reply({error:'configuration_required'},503);
  if(operation==='inventory')return reply(await client.inventory());
  if(request.headers.get('content-type')?.split(';')[0]!=='application/json'||request.headers.has('content-encoding'))return reply({error:'invalid_request'},415);
  let body;try{body=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(await new BoundedBinaryAdapterBase(40000).readBoundedBody(request.body)));}catch{return reply({error:'invalid_request'},400);}
  const keys={assistants:['firstMessage','name','prompt'],tools:['key'],attachment:['assistantId','attached','key','toolId']}[operation];
  if(!body||Array.isArray(body)||Object.keys(body).sort().join(',')!==keys.sort().join(','))return reply({error:'invalid_request'},400);
  const key=request.headers.get('idempotency-key');if(!key||! /^[A-Za-z0-9_-]{16,100}$/.test(key))return reply({error:'idempotency_required'},400);
  const previous=await claim(key,operation,body);if(previous)return reply(previous.body,previous.status);
  await authorize(operation);
  const result=operation==='assistants'?await client.createAgent(body):operation==='tools'?await client.createTool(body.key):await client.attach(body.assistantId,body.toolId,body.key,body.attached);
  await authorize(operation);await complete(key,result);return reply(result,operation==='assistants'?201:200);
 }catch(e){const code=e?.code;const status=e?.status??(code==='invalid_configuration'||code==='invalid_resource'?400:code==='scope_denied'?403:code==='capability_not_ready'?409:503);return reply({error:status===401?'unauthorized':status===403?'forbidden':status===409?'reconciliation_required':status===400?'invalid_configuration':'unavailable'},status);}
}
