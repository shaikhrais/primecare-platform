import {readFile,writeFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {pathToFileURL} from 'node:url';
const requestExamples={
 token:{},'extension.assign':{userId:'example-user'},'extension.publish':{userId:'example-user',version:1,published:true},
 'voicemail.read':{recordingSid:'RE'+'a'.repeat(32)},'voicemail.audio':{recordingSid:'RE'+'a'.repeat(32)},
 'otp.start':{callSid:'CA'+'a'.repeat(32),pairingCode:'12345678'},'otp.check':{callSid:'CA'+'a'.repeat(32),code:'123456'},
 'task.preview':{intentId:'11111111-1111-4111-8111-111111111111'},'task.approve':{intentId:'11111111-1111-4111-8111-111111111111',digest:'a'.repeat(64)},
};
const behavior={
 token:'Issue a short-lived Voice SDK token for the current published destination. Token issuance does not assign an extension or grant permission.',
 'extension.assign':'Assign a globally unique four-digit extension to an authorized active tenant/user. Assignment does not publish it.',
 'extension.publish':'Publish or revoke an authorized extension at the exact current version. Re-read directory state; no external-number forwarding.',
 'voicemail.read':'Read metadata for a private recording owned by the current user and tenant.',
 'voicemail.audio':'Download private bounded WAV audio after current owner/session checks before and after provider retrieval.',
 'otp.start':'Bind the signed call pairing code to the current app session and send OTP to its previously verified contact. This is an app operation, never an AI tool.',
 'otp.check':'Submit the OTP in the authenticated app. A false verified result is not authentication. Codes must not be spoken to an AI agent.',
 'task.preview':'Read the exact server-owned task summary and digest for independent app confirmation. This does not execute a task.',
 'task.approve':'Approve the exact unexpired digest in the authenticated app. It does not itself execute a task. Never attach this operation to an AI assistant.',
 'voice.incoming':'Return the four-digit extension/reception/AI menu for a signed incoming Twilio call.',
 'voice.gather':'Resolve 0 to configured reception, 1 to configured verified app pairing, or a published four-digit extension. Unknown, ambiguous or revoked destinations fall back to reception or an unavailable message.',
 'voice.connect':'Connect an authorized Voice SDK caller using the canonical provider call and current scoped directory.',
 'voice.dial_complete':'Handle busy/no-answer/failed dial outcomes using a previously reserved private voicemail route.',
 'voice.record_action':'Validate voicemail recording completion against its reserved call/destination.',
 'voice.recording_status':'Verify the provider recording and enqueue an authorized private voicemail notification. Enqueued does not prove delivered.',
 'voice.pair':'Issue an app pairing code outside the model stream. This code is distinct from the six-digit OTP.',
 'voice.wait':'Recheck the current app pairing/OTP state before proceeding to the verified agent or reception.',
 'voice.agent':'Start ConversationRelay only for the canonical live call with current verified identity and task authorization.',
 'voice.agent_complete':'Return from the verified AI connection through its registered completion handler.',
 'voice.relay':'Upgrade the exact signed WebSocket request. The relay rechecks canonical call, OTP identity, durable session claim and task authorization; no caller-selected actor or tenant is trusted.',
 'sms.status':'Persist, deduplicate or quarantine signed delivery observations before returning 204. Delivery callbacks are not SMS read receipts.',
 'sms.incoming':'Verify the exact signed Twilio form and persist the inbound SMS before returning empty TwiML. Durable duplicates do not create a second AI turn. Control messages and unsupported media stay outside the AI queue. The provider signature does not authenticate a PrimeCare account; verified linking and current consent remain required for any reply. Registration does not mount or activate this route.',
};
const schemaName=key=>key.split(/[._]/).map(s=>s[0].toUpperCase()+s.slice(1)).join('');
const jsonContent=schema=>({'application/json':{schema}});
const ref=name=>({$ref:'#/components/schemas/'+name});
const digest=value=>createHash('sha256').update(JSON.stringify(value)).digest('hex');
export function buildCommunicationOpenApi(voice,messaging,inbound){
 if(voice.service!=='governance'||voice.activation!==false||voice.operations.length!==21||messaging.activation!==false||messaging.apis.length!==7)throw Error('Exact registered communication scope required');
 if(inbound&&(inbound.service!=='governance'||inbound.activation!==false||inbound.operations?.length!==1||inbound.operations[0].key!=='sms.incoming'||inbound.operations[0].method!=='POST'||inbound.operations[0].path!=='/v1/twilio/sms/incoming'||inbound.operations[0].authentication!=='twilio-signed-form'||inbound.operations[0].permission!=='twilio.signature'||inbound.operations[0].responseKind!=='twiml'))throw Error('Exact inbound SMS scope required');
 const spec={openapi:'3.1.0',info:{title:'PrimeCare communication API implementation contract',version:'1.0.0',description:'Typed registered contracts and implemented transport behavior. This document is not proof of deployment, grants, business-tool connectivity or live acceptance. All examples are synthetic. Replace the invalid deployment host only after deployment verification.'},
  'x-production-ready':false,'x-source-authority':'pinned-production-postgresql-registration-snapshots','x-source-sha256':{voice:digest(voice),messaging:digest(messaging),...(inbound?{inbound:digest(inbound)}:{})},
  servers:[{url:'https://{deploymentHost}',description:'Deployment required; no live server is asserted.',variables:{deploymentHost:{default:'example.invalid',description:'Exact independently verified API host. Do not enter provider credentials or secrets here.'}}}],
  tags:[{name:'Voice app'},{name:'Twilio provider'},{name:'Communication'}],paths:{},components:{securitySchemes:{
   nativeSession:{type:'http',scheme:'bearer',description:'Opaque current PrimeCare session token, not a JWT or Vapi management key. Voice APIs reject cookie-only access. Identity and tenant come from the server session.'},
   twilioSignature:{type:'apiKey',in:'header',name:'X-Twilio-Signature',description:'Twilio-generated signature verified with the server Auth Token and exact configured public URL. Never send the Auth Token in this header. WebSocket signatures use the configured WSS URL.'},
  },schemas:{},responses:{}}};
 const error={type:'object',required:['error'],properties:{error:{type:'string'}},additionalProperties:false};
 spec.components.schemas.TransportError=error;
 const errors={400:'Malformed, invalid or oversized input. Body limits are host-configured; do not retry unchanged requests.',401:'Missing, invalid or expired native session.',403:'Signature, origin, permission, current identity or resource scope denied.',404:'Unregistered route, wrong origin, or scoped resource unavailable.',405:'Wrong HTTP method. Inspect Allow header.',409:'Version, state or idempotency conflict. Do not retry mutations automatically.',413:'Host request or media byte limit exceeded.',415:'Unsupported content type or encoding.',426:'WebSocket Upgrade required.',503:'Dependency or validation failure. A mutation may already have committed; reconcile before retry.'};
 for(const [status,description] of Object.entries(errors))spec.components.responses['Error'+status]={description,content:jsonContent(ref('TransportError'))};
 const add=(path,method,operation)=>{if(spec.paths[path]?.[method])throw Error('Duplicate registered operation');(spec.paths[path]??={})[method]=operation;};
 for(const source of [...voice.operations,...(inbound?.operations??[])]){
  const native=source.authentication==='native-session-csrf',socket=source.responseKind==='websocket-upgrade';
  const name='Voice'+schemaName(source.key),requestName=name+'Request',responseName=name+'Response';
  spec.components.schemas[requestName]=structuredClone(source.request);
  spec.components.schemas[responseName]=structuredClone(source.response);
  const op={operationId:'voice_'+source.key.replaceAll('.','_'),summary:behavior[source.key]?.split('.')[0]??source.key,description:(behavior[source.key]??source.key)+' This registered route is not activated by documentation. Query strings and fragments are rejected. Provider identity is never accepted as native user authentication.',tags:[native?'Voice app':'Twilio provider'],
   security:[{[native?'nativeSession':'twilioSignature']:[]}],parameters:[],responses:{},'x-registration-key':source.key,'x-registration-status':voice.implementationStatus,'x-runtime-source':'cloudflare/workers/src/business-tasks/voice-composition.ts','x-permission-key':source.permission,'x-vapi-exposable':false};
  if(native)op.parameters.push({name:'Origin',in:'header',required:false,schema:{type:'string',format:'uri'},description:'If present, must exactly match the API origin or a configured approved app origin. Cross-site cookie-only requests cannot authorize this operation.'});
  if(socket){
   op.parameters.push({name:'Upgrade',in:'header',required:true,schema:{type:'string',const:'websocket'}});
   op.responses['101']={description:'Switching Protocols. Original client WebSocket is returned; no HTTP response body. Subsequent relay frames are not described as ordinary REST responses.'};
  }else{
   const media=native?'application/json':'application/x-www-form-urlencoded';
   op.requestBody={required:true,content:{[media]:{schema:ref(requestName),...(requestExamples[source.key]?{example:requestExamples[source.key]}:{})}}};
   if(source.responseKind==='no-content')op.responses['204']={description:'Callback durably accepted; no response body.'};
   else {
    const contentType=source.key==='sms.incoming'?'text/xml':source.responseKind==='twiml'?'application/xml':source.responseKind==='private-audio-wav'?'audio/wav':'application/json';
    op.responses['200']={description:source.responseKind==='private-audio-wav'?'Private bounded RIFF/WAVE audio; never a public Twilio recording URL.':'Successful transport/service response; not evidence of a confirmed appointment.',content:{[contentType]:{schema:ref(responseName)}}};
   }
  }
  const statuses=native?[400,401,403,404,405,415,503]:socket?[400,403,404,405,426,503]:[400,403,404,405,415,503];
  for(const status of statuses)op.responses[status]={$ref:'#/components/responses/Error'+status};
  if(native)op['x-retry-policy']='No automatic mutation retries. Session/grant may change after a write; reconcile state through an authorized read.';
  add(source.path,source.method.toLowerCase(),op);
 }
 for(const source of messaging.apis){
  const name='Communication'+schemaName(source.operation),requestName=name+'Request',responseName=name+'Response';
  spec.components.schemas[requestName]=structuredClone(source.requestSchema);spec.components.schemas[responseName]=structuredClone(source.responseSchema);
  const op={operationId:'communication_'+source.operation.replaceAll('.','_'),summary:source.operation,description:'Shared inherited communication operation. Current session, exact API/linked-screen grants and conversation/case/mailbox restrictions are enforced server-side. Registration and documentation do not activate this route. Request identity/tenant overrides are forbidden.',tags:['Communication'],security:[{nativeSession:[]}],parameters:[],responses:{},'x-governance-id':source.id,'x-registration-status':source.status,'x-permission-key':source.permission,'x-vapi-exposable':false};
  if(source.method==='GET'){
   const variants=source.requestSchema.oneOf??[source.requestSchema];
   const names=[...new Set(variants.flatMap(variant=>Object.keys(variant.properties??{})))];
   for(const name of names){
    const schemas=[...new Map(variants.filter(v=>v.properties?.[name]).map(v=>[JSON.stringify(v.properties[name]),v.properties[name]])).values()];
    op.parameters.push({name,in:'query',required:variants.every(v=>v.required?.includes(name)),schema:schemas.length===1?schemas[0]:{oneOf:schemas},description:name==='limit'?'Decimal query value parsed as integer by the adapter.':name==='mailboxId'?'Required when direction=inbound; forbidden when direction=outbound. See x-query-schema for the complete cross-parameter contract.':'Registered query parameter. Duplicate parameters are rejected.'});
   }
   op['x-query-schema']=ref(requestName);
  }else if(source.operation==='picture.upload'){
   const schema=structuredClone(source.requestSchema);schema.properties.file={type:'string',format:'binary',contentMediaType:'image/png',description:'Binary multipart image, not the internal validator sentinel string.'};
   op.requestBody={required:true,content:{'multipart/form-data':{schema}}};
  }else op.requestBody={required:true,content:{'application/json':{schema:ref(requestName)}}};
  const media=source.operation==='picture.open'?'image/png':'application/json';
  op.responses['200']={description:source.operation==='picture.open'?'Authorized private PNG image.':'Validated service result. Email queued/accepted does not prove delivery; audio signaling does not prove a device answered.',content:{[media]:{schema:ref(responseName)}}};
  for(const status of [400,401,403,404,405,409,413,415,503])op.responses[status]={$ref:'#/components/responses/Error'+status};
  add(source.path,source.method.toLowerCase(),op);
 }
 return spec;
}
export async function generateCommunicationOpenApi(check=false){
 const voice=JSON.parse(await readFile('tools/governance-production/twilio-contracts-registration.json','utf8'));
 const messaging=JSON.parse(await readFile('packages/shared/src/communications/registered-contracts.json','utf8'));
 const inbound=JSON.parse(await readFile('tools/governance-production/messaging-contracts-registration.json','utf8'));
 const spec=buildCommunicationOpenApi(voice,messaging,inbound),output=JSON.stringify(spec,null,2)+'\n',path='packages/contracts/communications.openapi.json';
 if(check){if(await readFile(path,'utf8')!==output)throw Error('Communication OpenAPI differs; regenerate explicitly');}else await writeFile(path,output);
 return {operations:Object.values(spec.paths).reduce((count,methods)=>count+Object.keys(methods).length,0),productionReady:false};
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href){
 if(process.argv.slice(2).some(arg=>arg!=='--check'))throw Error('Only --check is supported');
 console.log(JSON.stringify(await generateCommunicationOpenApi(process.argv.includes('--check'))));
}
