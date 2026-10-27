const uuid=v=>typeof v==='string'&&/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i.test(v);
const id=v=>typeof v==='string'&&/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(v);
const digest=v=>typeof v==='string'&&/^[a-f0-9]{64}$/.test(v);
const fail=()=>{throw Error('Business execution receipt unavailable');};
/** Durable Object storage adapter, never an authorization service. Pass only
 * private transactional storage owned by the authenticated business host.
 * Pending entries have no retry lease or TTL: an ambiguous write must not run
 * again after a timeout, restart or alarm. Host retention must outlive accepted
 * call/replay windows. No public route or native session is created here. */
export class DurableVapiBusinessJournal {
 #storage;
 constructor(storage){if(typeof storage?.transaction!=='function')throw Error('Transactional durable storage required');this.#storage=storage;}
 async #key(input){
  if(!input||!uuid(input.callId)||!id(input.scopeKey)||!id(input.toolCallId)||!digest(input.digest))fail();
  const bytes=await crypto.subtle.digest('SHA-256',new TextEncoder().encode(JSON.stringify([input.callId,input.scopeKey,input.toolCallId])));
  return 'vapi_business_receipt_v1_'+Array.from(new Uint8Array(bytes),b=>b.toString(16).padStart(2,'0')).join('');
 }
 #check(row,input){
  if(!row||row.version!==1||row.digest!==input.digest||!['pending','complete'].includes(row.status)||row.status==='complete'&&(typeof row.result!=='string'||new TextEncoder().encode(row.result).length>8192))fail();
 }
 async begin(input){
  // Copy before awaiting: callers cannot rebind the transaction's digest.
  const entry={...input},key=await this.#key(entry);
  return this.#storage.transaction(async tx=>{
   const row=await tx.get(key);
   if(row!==undefined){this.#check(row,entry);return row.status==='complete'?{status:'complete',digest:row.digest,result:row.result}:{status:'pending',digest:row.digest};}
   await tx.put(key,{version:1,status:'pending',digest:entry.digest});
   return {status:'new'};
  });
 }
 async complete(input){
  const entry={...input},key=await this.#key(entry);
  if(typeof entry.result!=='string'||new TextEncoder().encode(entry.result).length>8192)fail();
  return this.#storage.transaction(async tx=>{
   const row=await tx.get(key);this.#check(row,entry);
   if(row.status==='complete'){if(row.result!==entry.result)fail();return;}
   await tx.put(key,{version:1,status:'complete',digest:entry.digest,result:entry.result});
  });
 }
}
