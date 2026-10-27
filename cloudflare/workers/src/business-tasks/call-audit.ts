/** Private metadata projection. Nothing caller/model supplied becomes identity. */
export type AuditPayload = {kind:string;source:string;at:string;[key:string]:unknown};
export const uuid=(v:unknown):v is string=>typeof v==='string'&&/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i.test(v);
export const canonical=(v:any):string=>Array.isArray(v)?'['+v.map(canonical).join(',')+']':v&&typeof v==='object'?'{'+Object.keys(v).sort().map(k=>JSON.stringify(k)+':'+canonical(v[k])).join(',')+'}':JSON.stringify(v);
export const hash=async(v:unknown)=>Array.from(new Uint8Array(await crypto.subtle.digest('SHA-256',new TextEncoder().encode(canonical(v)))),b=>b.toString(16).padStart(2,'0')).join('');
const zero='0'.repeat(64);
const words=(v:unknown,max=120)=>typeof v==='string'&&v.length<=max&&/^[a-zA-Z0-9_.:-]+$/.test(v)?v:undefined;
const date=(v:unknown)=>typeof v==='string'&&Number.isFinite(Date.parse(v))?new Date(v).toISOString():undefined;
const fields=['kind','source','at','traceId','suppliedCallId','callId','callSid','assistantId','phoneNumberId','orgId','from','to','direction','status','startedAt','endedAt','endedReason','providerMatched','toolCallId','toolName','action','phase','outcome','reason','httpStatus','durationMs','verified','codeRequested','resultId','configurationHash','observedAt','coverage','evidence','resultStatus'];
/** Reject extra fields rather than redacting after serialization. Never hash codes. */
export function project(input:AuditPayload):AuditPayload {
 if(Object.keys(input).some(k=>!fields.includes(k)))throw Error('Audit field refused');
 const out:any={};
 for(const [k,v] of Object.entries(input)){
  if(v===undefined)continue;
  if(['from','to'].includes(k)){if(typeof v!=='string'||!/^\+[1-9][0-9]{6,14}$/.test(v))throw Error('Invalid audit phone');out[k]=v;}
  else if(['at','startedAt','endedAt','observedAt'].includes(k)){if(!date(v))throw Error('Invalid audit time');out[k]=date(v);}
  else if(['providerMatched','verified','codeRequested'].includes(k)){if(typeof v!=='boolean')throw Error('Invalid audit flag');out[k]=v;}
  else if(['httpStatus','durationMs'].includes(k)){if(!Number.isSafeInteger(v)||Number(v)<0)throw Error('Invalid audit number');out[k]=v;}
  else {if(!words(v,200))throw Error('Invalid audit identifier');out[k]=v;}
 }
 if(!out.kind||!out.source||!out.at)throw Error('Audit envelope required');
 return out;
}
export class PostgresCallAudit {
 constructor(readonly pool:any){if(typeof pool?.connect!=='function')throw Error('Audit database required');}
 async append(callId:string,key:string,input:AuditPayload){
  if(!/^[a-zA-Z0-9:-]{1,100}$/.test(callId))throw Error('Audit stream invalid');
  const payload=project(input),eventKey=await hash([callId,key]);const db=await this.pool.connect();
  try{
   await db.query('BEGIN');await db.query("SET LOCAL statement_timeout='8s'");
   await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',['primecare-call-audit:'+callId]);
   const old=(await db.query('SELECT payload,event_hash FROM public.communication_call_audit WHERE event_key=$1',[eventKey])).rows[0];
   if(old){if(canonical(old.payload)!==canonical(payload))throw Error('Audit replay conflict');await db.query('COMMIT');return old.event_hash;}
   const last=(await db.query('SELECT sequence::float8 AS sequence,event_hash FROM public.communication_call_audit WHERE call_id=$1 ORDER BY sequence DESC LIMIT 1',[callId])).rows[0];
   const sequence=(last?.sequence??0)+1,previous=last?.event_hash??zero,eventHash=await hash({callId,sequence,previous,payload});
   await db.query('INSERT INTO public.communication_call_audit(call_id,sequence,event_key,previous_hash,event_hash,payload) VALUES($1,$2,$3,$4,$5,$6)',[callId,sequence,eventKey,previous,eventHash,JSON.stringify(payload)]);
   await db.query('COMMIT');return eventHash;
  }catch(e){await db.query('ROLLBACK');throw e;}finally{db.release();}
 }
 async timeline(callId:string){return (await this.pool.query('SELECT sequence::float8 AS sequence,previous_hash,event_hash,payload,received_at FROM public.communication_call_audit WHERE call_id=$1 ORDER BY sequence',[callId])).rows;}
 async verify(callId:string){const rows=await this.timeline(callId);let previous=zero,n=0;for(const row of rows){if(row.sequence!==++n||row.previous_hash!==previous||row.event_hash!==await hash({callId,sequence:n,previous,payload:row.payload}))return {valid:false,count:rows.length};previous=row.event_hash;}return {valid:true,count:n,head:previous};}
}
export const safeWord=words;
/** Inspect structure only. Do not persist arguments, result strings or messages. */
export function toolObservations(message:any){
 const out:any[]=[];
 const messages=[...(Array.isArray(message?.messages)?message.messages:[]),...(Array.isArray(message?.artifact?.messages)?message.artifact.messages:[]),...(Array.isArray(message?.messagesOpenAIFormatted)?message.messagesOpenAIFormatted:[])];
 for(const m of messages){
  for(const t of (m.tool_calls??m.toolCalls??[]))if(words(t.id)&&words(t.function?.name))out.push({toolCallId:t.id,toolName:t.function.name,phase:'provider_observed_request',outcome:'observed'});
  if(['tool','tool_call_result'].includes(m.role)&&words(m.tool_call_id??m.toolCallId))out.push({toolCallId:m.tool_call_id??m.toolCallId,phase:'provider_observed_result',outcome:'observed'});
 }
 return out;
}
