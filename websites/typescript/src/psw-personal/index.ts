import {ownCareRoute,type CareOwnership} from '../care/ownership';
import {LiveCareClient} from '../care/live-client';
import {requireScreenManager,showScreenConfigurationError,ScreenConfigurationError} from '../../../../packages/primecare_ui/web/screen-manager';
import {resolveManagedRoute} from '../managed-routes';
import {BaseSessionClient} from '../infrastructure/http/base-session-client';
import {renderPersonalView} from './view.mjs';
import {personalStyles} from './style';
export class PersonalClient extends BaseSessionClient{
 protected endpoint='/v1/governance/care/personal';
 constructor(gateway:string,token:string,readonly dataset='live',readonly tenant=''){super(gateway,token);}
 protected accountChangedError(){return Error('Account changed. Reload your workspace.');}
 protected rejectResponse(r:Response,v:unknown):never{if(r.status===401){sessionStorage.removeItem('primecare_session');location.assign('/login');}throw Error(String(this.errorData(v).error||'Personal workspace unavailable.'));}
 private query(from?:string){return '?'+new URLSearchParams({dataset:this.dataset,...(this.tenant?{tenant:this.tenant}:{}),...(from?{from}:{})});}
 async read(from?:string){return this.requestJson(this.query(from),'GET');}
 async mutate(body:unknown,from?:string){return this.requestJson(this.query(from),'POST',body);}
}
export function mountPersonalStyles(){document.getElementById('psw-workspace-styles')?.remove();if(document.getElementById('personal-style'))return;const el=document.createElement('style');el.id='personal-style';el.textContent=personalStyles+'[data-native-care] .app-shell{display:block;min-height:0}[data-native-care] main{padding:0;max-width:none}[data-native-care] .section{padding:16px;border:1px solid #dce5ed;border-radius:10px;margin:12px 0}[data-native-care] label{display:block;margin:12px 0}[data-native-care] .growth-hero,[data-native-care] aside,[data-native-care] .topbar{display:none!important}[hidden]{display:none!important}';document.head.append(el);}
// Personal mode shares presentation lifetime, never clinical authorization.
function personalSnapshot(value:any){
 if(!value||!Number.isSafeInteger(value.version)||value.version<=0||typeof value.workspaceKey!=='string'||!value.workspaceKey||typeof value.identity?.userId!=='string'||typeof value.identity?.tenantId!=='string'||typeof value.profile?.name!=='string'||typeof value.profile?.role!=='string'||typeof value.today!=='string'||typeof value.from!=='string'||typeof value.synthetic!=='boolean'||!value.state||!value.state.available||!['visits','time','expenses','messages','requests','audit'].every(k=>Array.isArray(value.state[k])))throw Error('Invalid personal workspace response.');
 return value;
}
class ManagedPersonalClient extends PersonalClient{
 private identity='';private readonly receipts=new Map<string,any>();
 constructor(gateway:string,token:string,dataset:string,tenant:string,private owner:CareOwnership){super(gateway,token,dataset,tenant);owner.onDispose(()=>this.receipts.clear());}
 protected rejectResponse(r:Response,v:unknown):never{throw Object.assign(Error(String(this.errorData(v).error||'Personal workspace unavailable.')),{status:r.status});}
 private accept(value:any){
  personalSnapshot(value);const identity=this.key(value);
  if(this.identity&&this.identity!==identity)throw Error('Personal workspace changed. Reload your workspace.');
  this.identity=identity;return value;
 }
 private key(value:any){return JSON.stringify([value?.workspaceKey,value?.identity?.userId,value?.identity?.tenantId,value?.dataset]);}
 private reflected(value:any,receipt:any){const ack=receipt.result;return ack&&this.key(ack)===this.key(value)&&Number.isSafeInteger(ack.version)&&ack.version>0&&Number.isSafeInteger(receipt.version)&&ack.version>receipt.version&&Number.isSafeInteger(value.version)&&value.version>=ack.version;}
 // Only a successfully published authorized view releases acknowledgements.
 confirmSnapshot(value:any){if(!this.owner.current())return;for(const[key,receipt]of this.receipts)if(this.reflected(value,receipt))this.receipts.delete(key);}
 async read(from?:string){if(!this.owner.current())throw Error('Personal renderer is no longer current');return this.accept(await super.read(from));}
 async mutate(body:any,from?:string){
  if(!this.owner.current())throw Error('Personal renderer is no longer current');const key=JSON.stringify([from,body]);
  const saved=this.receipts.get(key);
  if(saved){const snapshot=await this.read(from);if(!this.reflected(snapshot,saved))throw Error('Personal workspace unavailable. Refresh to confirm saved data.');return snapshot;}
  const result=await super.mutate(body,from),receipt={result,version:body.version};this.receipts.set(key,receipt);const snapshot=this.accept(result);if(!this.reflected(snapshot,receipt))throw Error('Personal workspace unavailable. Refresh to confirm saved data.');return snapshot;
 }
}
export async function renderPersonal(root:HTMLElement,gateway:string,token:string,dataset:string,tenant='',existingOwner?:CareOwnership){
 const owner=existingOwner??ownCareRoute(root);if(!owner.current()||owner.token!==token)return;
 mountPersonalStyles();const api=new ManagedPersonalClient(gateway,token,dataset,tenant,owner),initial=await api.read();await owner.whenActive();if(!owner.current())return;
 await renderPersonalView(root,gateway,initial,api,{owner,clinical:new LiveCareClient(gateway,token,owner)});
}
const esc=(s:unknown)=>String(s??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));

// Queue authentication effects belong to the current renderer. Other personal
// and care renderers retain PersonalClient's existing error/redirect contract.
class RequestQueueClient extends PersonalClient{
 protected rejectResponse(r:Response,v:unknown):never{throw Object.assign(Error(String(this.errorData(v).error||'Personal workspace unavailable.')),{status:r.status});}
}
const requestRenders=new WeakMap<HTMLElement,()=>void>();
export async function renderPSWRequests(root:HTMLElement,gateway:string){
 requestRenders.get(root)?.();
 const manager=requireScreenManager(root),entry=resolveManagedRoute('/psw-requests',''),documentRoute=location.pathname+location.search;
 const eventTarget=root.ownerDocument.defaultView??window;
 let alive=true,suspended=false,busy=false,epoch=0,generation=0,owner:MutationObserver|undefined;
 let ownedNodes=Array.from(root.childNodes);
 const dialogs=new Set<HTMLDialogElement>(),resumes=new Set<()=>void>();
 // An acknowledged write survives a failed refresh or a closed dialog. Reopening
 // that same version retries its read, never submits an already accepted write.
 const receipts=new Map<string,{status:string;review:string}>();
 const release=()=>{for(const resume of resumes)resume();resumes.clear();};
 const whenActive=()=>suspended&&alive?new Promise<void>(resolve=>resumes.add(resolve)):Promise.resolve();
 const ownsRoot=()=>alive&&requestRenders.get(root)===teardown;
 function owned(){
  if(!ownsRoot())return false;
  const nodes=Array.from(root.childNodes);
  if(!root.isConnected||nodes.length!==ownedNodes.length||nodes.some((node,i)=>node!==ownedNodes[i])){teardown();return false;}
  return true;
 }
 function fail(error:unknown){if(owned()){teardown();showScreenConfigurationError(root,error);}return false;}
 let token:string|null;
 try{token=sessionStorage.getItem('primecare_session');}catch{showScreenConfigurationError(root,new ScreenConfigurationError('Session storage is unavailable'));return;}
 function context(){
  if(!owned())return false;
  if(location.pathname!==entry.route||location.pathname+location.search!==documentRoute){teardown();root.replaceChildren();return false;}
  try{if(sessionStorage.getItem('primecare_session')!==token){teardown();root.replaceChildren();return false;}}catch{return fail(new ScreenConfigurationError('Session storage is unavailable'));}
  return true;
 }
 function current(){if(suspended||!context())return false;try{manager.enter(entry.id,entry.route);}catch(error){return fail(error);}return context();}
 const onHistory=()=>{if(!suspended)context();};
 const leave=(event:PageTransitionEvent)=>{if(event.persisted)suspended=true;else teardown();};
 const resume=(event:PageTransitionEvent)=>{if(!event.persisted||!suspended||!ownsRoot())return;suspended=false;current();release();};
 function teardown(){
  if(!alive)return;alive=false;suspended=false;epoch++;generation++;release();owner?.disconnect();
  eventTarget.removeEventListener('popstate',onHistory);eventTarget.removeEventListener('hashchange',onHistory);eventTarget.removeEventListener('pagehide',leave);eventTarget.removeEventListener('pageshow',resume);
  for(const dialog of dialogs){dialog.close();dialog.remove();}dialogs.clear();
  if(requestRenders.get(root)===teardown)requestRenders.delete(root);
 }
 requestRenders.set(root,teardown);
 owner=new MutationObserver(()=>{if(!owned())return;for(const dialog of dialogs)if(!dialog.isConnected){dialogs.delete(dialog);dialog.close();}});owner.observe(root.ownerDocument,{childList:true,subtree:true});
 eventTarget.addEventListener('popstate',onHistory);eventTarget.addEventListener('hashchange',onHistory);eventTarget.addEventListener('pagehide',leave);eventTarget.addEventListener('pageshow',resume);
 if(!current())return;
 if(!token){teardown();root.replaceChildren();location.assign('/login?enable-semantics=true');return;}
 mountPersonalStyles();const api=new RequestQueueClient(gateway,token,'queue');
 function denied(error:unknown){
  if((error as {status?:number}).status!==401)return false;
  try{sessionStorage.removeItem('primecare_session');}catch{fail(new ScreenConfigurationError('Session storage is unavailable'));return true;}
  teardown();root.replaceChildren();
  try{location.assign('/login?enable-semantics=true');}catch(error){showScreenConfigurationError(root,error);}
  return true;
 }
 function bindLinks(active:()=>boolean){root.querySelectorAll<HTMLAnchorElement>('a').forEach(link=>link.addEventListener('click',event=>{
  if(!active()||busy)event.preventDefault();
  // Clicks may be canceled, including by beforeunload. Actual route departure
  // retires the owner; a click alone must not strand the current draft.
 }));}
 function draw(data:any,message=''){
  if(!current())return false;
  const presentation=`<main class="main" data-cy="screen-psw-personal-requests_review"><div class="heading"><div><p class="caption">TENANT OPERATIONS · ${esc(data.identity.organization)}</p><h1>PSW requests & follow-up</h1><p>Saved worker requests. Clinical records, staffing approval and payroll keep their separate workflows.</p></div><a href="/care?enable-semantics=true">Care workspace</a></div>${data.truncated?'<div class="banner warn">First 500 requests shown. Resolve older items and use the request references for follow-up.</div>':''}<section class="card"><div class="table-wrap"><table><thead><tr><th>Worker / request</th><th>Details</th><th>Status / response</th><th></th></tr></thead><tbody>${data.records.map((r:any)=>`<tr><td><strong>${esc(r.staff_name)}</strong>${esc(r.type)}<small>${esc(r.id)}</small></td><td>${esc(r.detail)}</td><td>${esc(r.status)}<small>${esc(r.review||'Awaiting team review')}</small></td><td>${r.staff_id!==data.identity.userId&&['requested','in_review'].includes(r.status)?`<button data-cy="psw-personal-review-request" data-review="${r.id}">Review request</button>`:'Read only'}</td></tr>`).join('')||'<tr><td colspan="4" class="empty">No worker requests yet.</td></tr>'}</tbody></table></div></section><p role="status" data-queue-status></p></main>`;
  const drawn=++generation,active=()=>drawn===generation&&current();
  root.innerHTML=presentation;ownedNodes=Array.from(root.childNodes);bindLinks(active);
  root.querySelector('[data-queue-status]')!.textContent=message;
  root.querySelectorAll<HTMLButtonElement>('[data-review]').forEach(button=>button.onclick=()=>{
   if(!active()||busy||dialogs.size||!button.isConnected||!root.contains(button))return;
   const row=data.records.find((record:any)=>record.id===button.dataset.review);
   if(row)openReview(row,button,active);
  });
  return true;
 }
 const saved='Response saved to PostgreSQL and visible in the worker workspace.';
 function openReview(row:any,opener:HTMLButtonElement,active:()=>boolean){
  const dialog=document.createElement('dialog'),key=JSON.stringify([row.id,row.version]);
  dialog.innerHTML=`<form><header><h2>Review ${esc(row.type)}</h2></header><div class="dialog-body"><p>${esc(row.staff_name)} · ${esc(row.detail)}</p><label>Status<select name="status"><option value="in_review">In review</option><option value="resolved">Resolved</option><option value="declined">Declined</option></select></label><label>Response and evidence<textarea name="review" minlength="10" maxlength="2000" required></textarea></label><div class="banner warn">Resolving a request does not approve leave, assign a visit, approve reported time or release payroll. Complete those actions in their authorized workflow.</div><p role="alert"></p></div><footer><button type="button" data-close>Close</button><button class="primary" data-cy="psw-personal-save-response">Save response</button></footer></form>`;
  document.body.append(dialog);dialogs.add(dialog);dialog.showModal();
  const form=dialog.querySelector('form')!,status=dialog.querySelector<HTMLSelectElement>('[name=status]')!,review=dialog.querySelector<HTMLTextAreaElement>('[name=review]')!;
  const accepted=receipts.get(key);if(accepted){status.value=accepted.status;review.value=accepted.review;status.disabled=true;review.disabled=true;}
  const open=()=>active()&&dialogs.has(dialog)&&dialog.isConnected&&dialog.open&&dialog.contains(form);
  const remove=()=>{dialogs.delete(dialog);dialog.remove();if(active()&&opener.isConnected)opener.focus();};
  dialog.addEventListener('close',remove);dialog.addEventListener('cancel',event=>{event.preventDefault();dialog.close();});
  dialog.querySelector('[data-close]')!.addEventListener('click',()=>dialog.close());
  form.onsubmit=async event=>{
   event.preventDefault();if(!open()||busy)return;
   const values={status:status.value,review:review.value};let reading=false;
   busy=true;epoch++;
   const controls=Array.from(dialog.querySelectorAll<HTMLInputElement|HTMLButtonElement|HTMLSelectElement|HTMLTextAreaElement>('input,button,select,textarea'));
   const disabled=controls.map(control=>control.disabled);controls.forEach(control=>control.disabled=true);
   try{
    if(!receipts.has(key)){
     await api.mutate({version:row.version,action:'request_review',value:{id:row.id,...values}});
     // Keep acknowledgement even while suspended/closed; do not touch the UI
     // until both the route and dialog are still current.
     receipts.set(key,values);
    }
    await whenActive();if(!open())return;
    root.querySelector('[data-queue-status]')!.textContent=saved;
    reading=true;const id=++epoch,data=await api.read();await whenActive();if(id!==epoch||!open())return;
    // Build and publish before closing the dialog, so a malformed or failed
    // read keeps the accepted receipt and response available for read retry.
    if(draw(data,saved)){
     dialog.close();
     const visible=new Set(data.records.map((record:any)=>JSON.stringify([record.id,record.version])));
     for(const receipt of receipts.keys())if(!visible.has(receipt))receipts.delete(receipt);
    }
   }catch(error){
    await whenActive();
    // A denied queue read belongs to the current route even if its dialog was
    // closed meanwhile. It must retire old controls, but never a newer owner.
    if(reading&&(error as {status?:number}).status===403){if(active())unavailable(error);return;}
    if(!open()||denied(error))return;
    dialog.querySelector('[role=alert]')!.textContent=(error as Error).message;
   }finally{
    await whenActive();busy=false;if(open())controls.forEach((control,i)=>control.disabled=(receipts.has(key)&&(control===status||control===review))||disabled[i]);
   }
  };
 }
 function unavailable(error:unknown){
  const failed=++generation;for(const dialog of dialogs)dialog.close();
  root.innerHTML='<main class="main"><h1>Requests unavailable</h1><p role="alert"></p><a href="/success?enable-semantics=true">Account</a></main>';
  ownedNodes=Array.from(root.childNodes);
  root.querySelector('[role=alert]')!.textContent=(error as Error).message;bindLinks(()=>failed===generation&&current());
 }
 async function load(){
  if(!current()||busy||dialogs.size)return;const id=++epoch;
  try{const data=await api.read();await whenActive();if(id!==epoch||!current())return;draw(data);}
  catch(error){
   await whenActive();if(id!==epoch||!current()||denied(error))return;
   unavailable(error);
  }
 }
 await load();
}
