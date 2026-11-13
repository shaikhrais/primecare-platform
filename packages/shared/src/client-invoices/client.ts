export type InvoiceScope={userId:string;tenantId:string;roles:string};
export type Invoice={id:string;status:string|null;currency:string|null;subtotal:string|null;tax:string|null;total:string|null;created_at:string;updated_at:string};
export type InvoicePage={invoices:readonly Invoice[];pagination:{limit:number;offset:number;total:number;hasMore:boolean}};
export type InvoiceState={status:'idle'|'loading'|'ready'|'error'|'disposed';page:InvoicePage|null;error:string|null};
const record=(v:unknown):v is Record<string,unknown>=>!!v&&typeof v==='object'&&!Array.isArray(v);
const exact=(v:Record<string,unknown>,keys:string[])=>Object.keys(v).sort().join('|')===[...keys].sort().join('|');
const integer=(v:unknown):v is number=>typeof v==='number'&&Number.isSafeInteger(v)&&v>=0;
const text=(v:unknown):v is string=>typeof v==='string'&&v.length<=4096&&!v.includes('\0');
const stamp=(v:unknown):v is string=>typeof v==='string'&&/^\d{4}-\d\d-\d\dT/.test(v)&&Number.isFinite(Date.parse(v))&&new Date(v).toISOString()===v;
export function validateInvoicePage(raw:unknown,limit=25,offset=0):InvoicePage{
 if(!record(raw)||!exact(raw,['invoices','pagination'])||!Array.isArray(raw.invoices)||raw.invoices.length>limit||!record(raw.pagination)||!exact(raw.pagination,['limit','offset','total','hasMore']))throw Error('invalid_response');
 const p=raw.pagination;if(p.limit!==limit||p.offset!==offset||!integer(p.total)||typeof p.hasMore!=='boolean'||p.hasMore!==(offset+limit<p.total)||raw.invoices.length!==Math.min(limit,Math.max(0,p.total-offset)))throw Error('invalid_response');
 const seen=new Set<string>();const invoices=raw.invoices.map((r:unknown)=>{
  if(!record(r)||!exact(r,['id','status','currency','subtotal','tax','total','created_at','updated_at'])||!text(r.id)||!r.id||r.id.length>200||seen.has(r.id)||![r.status,r.currency].every(v=>v===null||text(v))||![r.subtotal,r.tax,r.total].every(v=>v===null||typeof v==='string'&&/^-?\d+(?:\.\d+)?$/.test(v))||!stamp(r.created_at)||!stamp(r.updated_at))throw Error('invalid_response');
  seen.add(r.id);return Object.freeze({...r}) as Invoice;
 });return Object.freeze({invoices:Object.freeze(invoices),pagination:Object.freeze({limit,offset,total:p.total,hasMore:p.hasMore})});
}
export class ClientInvoices{
 private state:InvoiceState={status:'idle',page:null,error:null};private scope:InvoiceScope|null=null;private epoch=0;private dead=false;private abort=new AbortController();private listeners=new Set<()=>void>();private origin:string;
 constructor(gateway:string,private token:string,private expected:{userId:string;role:string},private isCurrent:()=>boolean,private fetcher:typeof fetch=fetch){
  const u=new URL(gateway);if(!['https:','http:'].includes(u.protocol)||u.protocol==='http:'&&!['127.0.0.1','localhost','[::1]'].includes(u.hostname)||u.username||u.password||u.search||u.hash||!['','/'].includes(u.pathname)||!token||!expected.userId||expected.role!=='guest')throw Error('invalid_binding');this.origin=u.origin;this.expected=Object.freeze({...expected});
 }
 get current():InvoiceState{return {...this.state};}
 subscribe(fn:()=>void){this.listeners.add(fn);fn();return ()=>this.listeners.delete(fn);}
 private emit(){for(const fn of this.listeners)fn();}
 private currentRequest(n:number){return !this.dead&&this.epoch===n&&this.isCurrent();}
 private async json(path:string,n:number,signal:AbortSignal):Promise<unknown>{
  if(!this.currentRequest(n))throw Error('scope_changed');
  // Native browser fetch must not receive this client object as its Window receiver.
  const send=this.fetcher;
  const response=await send(this.origin+path,{method:'GET',headers:{authorization:'Bearer '+this.token,accept:'application/json'},cache:'no-store',credentials:'omit',redirect:'error',signal});
  if(!this.currentRequest(n)){await response.body?.cancel();throw Error('scope_changed');}
  if(response.status!==200){await response.body?.cancel();throw Error(response.status===401?'unauthenticated':response.status===403?'forbidden':response.status===404?'unavailable':'request_failed');}
  if(!response.headers.get('content-type')?.toLowerCase().includes('application/json')||!response.body){await response.body?.cancel();throw Error('invalid_response');}
  const reader=response.body.getReader();let size=0;const parts:Uint8Array[]=[];
  try{for(;;){const part=await reader.read();if(!this.currentRequest(n))throw Error('scope_changed');if(part.done)break;size+=part.value.byteLength;if(size>131072)throw Error('invalid_response');parts.push(part.value);}}
  catch(error){await reader.cancel().catch(()=>{});throw error;}finally{reader.releaseLock();}
  const bytes=new Uint8Array(size);let offset=0;for(const part of parts){bytes.set(part,offset);offset+=part.length;}return JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(bytes));
 }
 private async self(n:number,signal:AbortSignal):Promise<InvoiceScope>{
  const raw=await this.json('/v1/auth/me',n,signal);
  if(!record(raw)||raw.status!=='authenticated'||raw.userId!==this.expected.userId||!text(raw.tenantId)||!raw.tenantId||raw.roles!==this.expected.role)throw Error('scope_changed');
  return {userId:raw.userId as string,tenantId:raw.tenantId,roles:raw.roles as string};
 }
 async load(offset=0){
  if(this.dead)return;if(!Number.isSafeInteger(offset)||offset<0||offset>100000||offset%25!==0)throw Error('invalid_page');
  const n=++this.epoch;this.abort.abort();this.abort=new AbortController();const signal=this.abort.signal;this.state={status:'loading',page:null,error:null};this.emit();
  try{
   const scope=await this.self(n,signal);if(!this.currentRequest(n))return;
   if(this.scope&&JSON.stringify(this.scope)!==JSON.stringify(scope))throw Error('scope_changed');this.scope=scope;
   const page=validateInvoicePage(await this.json('/v1/client/invoices?limit=25&offset='+offset,n,signal),25,offset);
   const after=await this.self(n,signal);if(!this.currentRequest(n))return;if(JSON.stringify(after)!==JSON.stringify(scope))throw Error('scope_changed');
   this.state={status:'ready',page,error:null};this.emit();
  }catch(error){if(!this.currentRequest(n)){if(!this.dead&&this.epoch===n)this.dispose();return;}const code=error instanceof Error?error.message:'request_failed';this.state={status:'error',page:null,error:['scope_changed','unauthenticated','forbidden','unavailable','invalid_response'].includes(code)?code:'request_failed'};this.emit();}
 }
 dispose(){if(this.dead)return;this.dead=true;this.epoch++;this.abort.abort();this.scope=null;this.state={status:'disposed',page:null,error:null};this.emit();this.listeners.clear();}
}
