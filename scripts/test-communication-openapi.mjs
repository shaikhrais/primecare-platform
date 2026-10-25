import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import Ajv from 'ajv';
import {createConfig,lintFromString} from '@redocly/openapi-core';
import {buildCommunicationOpenApi,generateCommunicationOpenApi} from './export-communication-openapi.mjs';
import {NativeVoiceHttpAdapter} from '../packages/shared/src/communications/voice-native-http.mjs';
const voice=JSON.parse(await readFile('tools/governance-production/twilio-contracts-registration.json','utf8'));
const messaging=JSON.parse(await readFile('packages/shared/src/communications/registered-contracts.json','utf8'));
const inbound=JSON.parse(await readFile('tools/governance-production/messaging-contracts-registration.json','utf8'));
const nativeLinks=JSON.parse(await readFile('tools/governance-production/sms-link-contracts-registration.json','utf8'));
const spec=buildCommunicationOpenApi(voice,messaging,inbound,nativeLinks),ajv=new Ajv({strict:false});
const schema=ref=>spec.components.schemas[ref.$ref.split('/').at(-1)];
test('OpenAPI 3.1 structure is valid and checked-in output is reproducible',async()=>{
 const config=await createConfig({rules:{struct:'error','no-unresolved-refs':'error'}});
 const problems=await lintFromString({source:JSON.stringify(spec),absoluteRef:'communications.openapi.json',config});
 assert.deepEqual(problems,[]);await generateCommunicationOpenApi(true);
});
test('all 32 exact registered method/path pairs have unique IDs and explicit security',()=>{
 const expected=[...[...voice.operations,...inbound.operations,...nativeLinks.operations].map(o=>[o.path,o.method.toLowerCase()]),...messaging.apis.map(o=>[o.path,o.method.toLowerCase()])];
 const actual=Object.entries(spec.paths).flatMap(([path,methods])=>Object.keys(methods).map(method=>[path,method]));
 assert.deepEqual(actual.sort(),expected.sort());const ids=actual.map(([p,m])=>spec.paths[p][m].operationId);assert.equal(new Set(ids).size,32);
 for(const [path,method]of actual){const op=spec.paths[path][method];assert.equal(op.security.length,1);assert.equal(op['x-vapi-exposable'],false);assert.ok(Object.keys(op.responses).length>1);}
 assert.equal(spec['x-production-ready'],false);assert.equal(spec.servers[0].variables.deploymentHost.default,'example.invalid');
});
test('every registered voice schema is preserved exactly and every native example validates',()=>{
 for(const source of [...voice.operations,...nativeLinks.operations]){const op=spec.paths[source.path][source.method.toLowerCase()];if(op.requestBody){const media=source.authentication==='native-session-csrf'?'application/json':'application/x-www-form-urlencoded';const content=op.requestBody.content[media];assert.deepEqual(schema(content.schema),source.request);if(source.authentication==='native-session-csrf'){const validate=ajv.compile(source.request);assert.equal(validate(content.example),true,JSON.stringify(validate.errors));const forged={...content.example,tenantId:'other'};assert.equal(validate(forged),false);}}}
});
test('query, multipart, binary and websocket operations have distinct valid transport contracts',()=>{
 for(const source of messaging.apis){const op=spec.paths[source.path][source.method.toLowerCase()];if(source.method==='GET'){assert.equal(op.requestBody,undefined);const variants=source.requestSchema.oneOf??[source.requestSchema];assert.deepEqual(op.parameters.map(p=>p.name).sort(),[...new Set(variants.flatMap(v=>Object.keys(v.properties)))].sort());assert.deepEqual(schema(op['x-query-schema']),source.requestSchema);}}
 const inbox=spec.paths['/v1/messages/email/inbox'].get;assert.equal(inbox.parameters.find(p=>p.name==='direction').required,true);assert.equal(inbox.parameters.find(p=>p.name==='mailboxId').required,false);assert.equal(ajv.validate(schema(inbox['x-query-schema']),{direction:'inbound'}),false);assert.equal(ajv.validate(schema(inbox['x-query-schema']),{direction:'outbound',mailboxId:'forged'}),false);
 assert.equal(spec.paths['/v1/messages/pictures'].post.requestBody.content['multipart/form-data'].schema.properties.file.format,'binary');
 assert.ok(spec.paths['/v1/messages/pictures'].get.responses['200'].content['image/png']);
 assert.ok(spec.paths['/v1/voice/voicemail/audio'].post.responses['200'].content['audio/wav']);
 const socket=spec.paths['/v1/twilio/voice/relay'].get;assert.equal(socket.requestBody,undefined);assert.equal(socket.responses['101'].content,undefined);assert.equal(socket.responses['200'],undefined);
 assert.equal(spec.paths['/v1/twilio/sms/status'].post.responses['204'].content,undefined);
});
test('published native response and error schemas validate actual adapter responses',async()=>{
 let value={token:'synthetic-token',identity:'synthetic-identity',ttlSeconds:120};
 const unused=async()=>{throw Error('Unused fixture service');};
 const adapter=new NativeVoiceHttpAdapter({origin:'https://fixture.invalid',maxRequestBytes:4096,maxAudioBytes:4096,
  async authenticate(){return {actor:{id:'fixture-user',tenantId:'fixture-tenant'},sessionHash:'a'.repeat(64),expiresAt:Date.now()+300000};},async authorize(){},
  services:{tokens:{async issue(){return value;}},extensions:{assign:unused,publish:unused},voicemail:{read:unused,audio:unused},audio:{download:unused},otp:{start:unused,check:unused},confirmations:{preview:unused,approve:unused}}});
 const request=body=>new Request('https://fixture.invalid/v1/voice/token',{method:'POST',headers:{authorization:'Bearer fixture','content-type':'application/json'},body:JSON.stringify(body)});
 const valid=await adapter.respond(request({}));assert.equal(valid.status,200);const success=ajv.compile(schema(spec.paths['/v1/voice/token'].post.responses['200'].content['application/json'].schema));assert.equal(success(await valid.json()),true);
 const denied=await adapter.respond(request({tenantId:'other'}));assert.equal(denied.status,400);assert.equal(ajv.validate(spec.components.schemas.TransportError,await denied.json()),true);
 value={...value,ttlSeconds:500};const invalidOutput=await adapter.respond(request({}));assert.equal(invalidOutput.status,503);assert.equal(ajv.validate(spec.components.schemas.TransportError,await invalidOutput.json()),true);
});
test('documentation has no invented Vapi execution or approval bypass route',()=>{
 assert.ok(!Object.keys(spec.paths).some(path=>path.includes('/vapi/')||path.includes('/execute')));
 for(const path of ['/v1/voice/otp/start','/v1/voice/otp/check','/v1/voice/tasks/approve'])assert.deepEqual(spec.paths[path].post.security,[{nativeSession:[]}]);
});
test('inbound SMS documents the exact signed form and empty XML receipt without app-session authority',()=>{
 const source=inbound.operations[0],op=spec.paths[source.path].post;
 assert.deepEqual(op.security,[{twilioSignature:[]}]);assert.deepEqual(schema(op.requestBody.content['application/x-www-form-urlencoded'].schema),source.request);
 assert.equal(ajv.validate(schema(op.responses['200'].content['text/xml'].schema),'<Response/>'),true);
 assert.equal(ajv.validate(schema(op.responses['200'].content['text/xml'].schema),{message:'sent'}),false);
 const changed=structuredClone(inbound);changed.operations[0].authentication='none';assert.throws(()=>buildCommunicationOpenApi(voice,messaging,changed),/Exact inbound SMS scope/);
});
test('SMS link mutations remain native-only, require fresh sessions and cannot accept model-selected identity',()=>{
 for(const source of nativeLinks.operations){
  const op=spec.paths[source.path].post;assert.deepEqual(op.security,[{nativeSession:[]}]);assert.equal(op['x-vapi-exposable'],false);assert.equal(op['x-fresh-native-session-required'],source.key!=='link.status');
  for(const field of ['phone','actor','tenantId','provider','sessionHash'])assert.equal(ajv.validate(source.request,{...op.requestBody.content['application/json'].example,[field]:'forged'}),false);
 }
 const changed=structuredClone(nativeLinks);changed.operations[0].authentication='none';assert.throws(()=>buildCommunicationOpenApi(voice,messaging,inbound,changed),/Exact native SMS link scope/);
});
