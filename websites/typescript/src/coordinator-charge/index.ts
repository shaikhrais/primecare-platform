import {BaseSessionClient} from '../infrastructure/http/base-session-client';
import {requireScreenManager,showScreenConfigurationError,ScreenConfigurationError} from '../../../../packages/primecare_ui/web/screen-manager';
import {resolveManagedRoute} from '../managed-routes';
import {chargeView,chargeStyles} from '../../../../packages/shared/src/coordinator-charge/view.mjs';
import catalog from '../../../../packages/shared/src/coordinator-charge/catalog.json';
import {renderShell,bindShell} from '../shell';

const chargeRenders=new WeakMap<HTMLElement,()=>void>();
class ChargeClient extends BaseSessionClient{
 protected endpoint=catalog.endpoint;
 constructor(gateway:string,token:string,readonly tenant=''){super(gateway,token);}
 protected accountChangedError(){return Error('Your account changed. Reload the workspace.');}
 // Only the current route owner may apply authentication side effects.
 protected rejectResponse(r:Response,v:unknown):never{throw Object.assign(Error(String(this.errorData(v).error||'Responsibility service unavailable.')),{status:r.status});}
 read(){return this.requestJson(this.tenant?'?tenant='+encodeURIComponent(this.tenant):'','GET');}
 mutate(body:unknown){return this.requestJson(this.tenant?'?tenant='+encodeURIComponent(this.tenant):'','POST',body);}
}

export async function renderCoordinatorCharge(root:HTMLElement,gateway:string){
 chargeRenders.get(root)?.();
 const manager=requireScreenManager(root),entry=resolveManagedRoute(catalog.route,''),documentRoute=location.pathname+location.search;
 const eventTarget=root.ownerDocument.defaultView??window;
 let alive=true,suspended=false,busy=false,epoch=0,version=0,owner:MutationObserver|undefined;
 // Capture even an empty root before the first read. A replacement during that
 // read must not be mistaken for this renderer's first shell.
 let ownedNodes=Array.from(root.childNodes);
 const dialogs=new Set<HTMLDialogElement>(),resumes=new Set<()=>void>();
 const release=()=>{for(const resume of resumes)resume();resumes.clear();};
 const whenActive=()=>suspended&&alive?new Promise<void>(resolve=>resumes.add(resolve)):Promise.resolve();
 const ownsRoot=()=>alive&&chargeRenders.get(root)===teardown;
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
  if(location.pathname!==catalog.route||location.pathname+location.search!==documentRoute){teardown();root.replaceChildren();return false;}
  try{if(sessionStorage.getItem('primecare_session')!==token){teardown();root.replaceChildren();return false;}}catch{return fail(new ScreenConfigurationError('Session storage is unavailable'));}
  return true;
 }
 function current(){if(suspended||!context())return false;try{manager.enter(entry.id,entry.route);}catch(error){return fail(error);}return context();}
 const onHistory=()=>{if(!suspended)context();};
 const leave=(event:PageTransitionEvent)=>{if(event.persisted)suspended=true;else teardown();};
 const resume=(event:PageTransitionEvent)=>{if(!event.persisted||!suspended||!ownsRoot())return;suspended=false;current();release();};
 function teardown(){
  if(!alive)return;alive=false;suspended=false;epoch++;version++;release();owner?.disconnect();
  eventTarget.removeEventListener('popstate',onHistory);eventTarget.removeEventListener('hashchange',onHistory);eventTarget.removeEventListener('pagehide',leave);eventTarget.removeEventListener('pageshow',resume);
  for(const dialog of dialogs){dialog.close();dialog.remove();}dialogs.clear();
  if(chargeRenders.get(root)===teardown)chargeRenders.delete(root);
 }
 chargeRenders.set(root,teardown);
 owner=new MutationObserver(()=>{if(!owned())return;for(const dialog of dialogs)if(!dialog.isConnected){dialogs.delete(dialog);dialog.close();}});owner.observe(root.ownerDocument,{childList:true,subtree:true});
 eventTarget.addEventListener('popstate',onHistory);eventTarget.addEventListener('hashchange',onHistory);eventTarget.addEventListener('pagehide',leave);eventTarget.addEventListener('pageshow',resume);
 if(!current())return;
 if(!token){teardown();root.replaceChildren();location.assign('/login?enable-semantics=true');return;}
 const tenant=new URLSearchParams(location.search).get('tenant')||'',api=new ChargeClient(gateway,token,tenant);
 if(!document.getElementById('charge-style')){const style=document.createElement('style');style.id='charge-style';style.textContent=chargeStyles;document.head.append(style);}
 const formValues=()=>{const form=root.querySelector<HTMLFormElement>('[data-cy=charge-form]');return form?JSON.stringify(Object.fromEntries(new FormData(form))):'';};
 let savedValues='';
 const hasDraft=()=>formValues()!==savedValues;
 function notice(message:string){const status=root.querySelector('[data-cy=charge-status]');if(status)status.textContent=message;}
 function denied(error:unknown){
  if((error as {status?:number}).status!==401)return false;
  try{sessionStorage.removeItem('primecare_session');sessionStorage.removeItem('primecare_care_charge');}
  catch{fail(new ScreenConfigurationError('Session storage is unavailable'));return true;}
  teardown();root.replaceChildren();
  try{location.assign('/login?enable-semantics=true');}catch(error){showScreenConfigurationError(root,error);}
  return true;
 }
 async function refresh(){
  if(!current()||busy||dialogs.size)return;
  await load('',false,true);
 }
 function draw(data:any,message='',draft?:Record<string,string>){
  if(!current())return;
  // Build the existing presentation before advancing the render generation.
  // Invalid response data must remain a recoverable read error, not look like
  // an obsolete completion from a prior render.
  const presentation={home:'/platform/administration',role:data.identity.role==='tenant_admin'?catalog.labels.en.primary:data.identity.role.replaceAll('_',' '),description:'Separate coordinator responsibility',navigation:'<a href="/platform/administration">Tenant administration</a><a href="/coordinator-charge" aria-current="page">Coordinator additional charge</a><a href="/success">Account & security</a>',controls:'<a href="/success">Account</a>',content:chargeView(data)};
  const drawn=++version,active=()=>drawn===version&&current();
  renderShell(root,presentation);
  ownedNodes=Array.from(root.childNodes);
  bindShell(root,catalog.title,'en','coordinator-charge',()=>[]);
  if(!active())return;
  notice(message||(data.truncated?'The first 100 assignments/events or team members are displayed.':''));
  root.querySelectorAll<HTMLAnchorElement>('a').forEach(a=>a.addEventListener('click',event=>{
   if(!active()||busy){event.preventDefault();return;}
   // Preserve normal modified-click navigation without retiring the current tab.
   if(event.defaultPrevented||event.ctrlKey||event.metaKey||event.shiftKey||event.altKey||event.button>0)return;
   if(a.getAttribute('href')==='/platform/administration')sessionStorage.removeItem('primecare_care_charge');
   // Navigation can be canceled by another listener or beforeunload. The actual
   // pagehide or route change retires this owner, not the click itself.
  }));
  root.querySelector<HTMLSelectElement>('[data-cy=charge-tenant]')?.addEventListener('change',e=>{
   if(!active()||busy)return;const destination='/coordinator-charge?'+new URLSearchParams({tenant:(e.target as HTMLSelectElement).value,'enable-semantics':'true'});
   try{location.assign(destination);}catch(error){if(active())notice((error as Error).message);}
  });
  root.querySelector('[data-cy=charge-refresh]')?.addEventListener('click',()=>{if(active())void refresh();});
  const form=root.querySelector<HTMLFormElement>('[data-cy=charge-form]');
  if(form){
   const start=form.querySelector<HTMLInputElement>('[name=startsOn]')!;
   start.value=new Intl.DateTimeFormat('en-CA',{timeZone:'America/Toronto',year:'numeric',month:'2-digit',day:'2-digit'}).format(new Date());
   form.onsubmit=e=>{e.preventDefault();if(active()&&!dialogs.size)void save({action:'assign',...Object.fromEntries(new FormData(form))},active);};
  }
  savedValues=formValues();
  if(form&&draft)for(const field of form.querySelectorAll<HTMLInputElement|HTMLSelectElement|HTMLTextAreaElement>('[name]')){
   const name=field.getAttribute('name')!;
   if(!(name in draft))continue;
   // Refreshed server options remain authoritative; never restore a user who
   // is no longer offered for assignment.
   if(name==='userId'&&!Array.from(field.querySelectorAll('option')).some(option=>option.getAttribute('value')===draft[name]))continue;
   field.value=draft[name];
  }
  root.querySelectorAll<HTMLButtonElement>('[data-enter]').forEach(b=>b.onclick=()=>{if(active()&&!dialogs.size)void save({action:'enter',id:b.dataset.enter},active,b.dataset.enter);});
  root.querySelectorAll<HTMLButtonElement>('[data-revoke]').forEach(b=>b.onclick=()=>{if(active()&&!busy&&!dialogs.size)openRevoke(b,active);});
 }
 function openRevoke(button:HTMLButtonElement,active:()=>boolean){
  const dialog=document.createElement('dialog'),opener=button;
  dialog.innerHTML='<form><h2>End coordinator additional charge</h2><p>The Tenant Admin role and audit history are retained.</p><label>Reason<textarea name="reason" minlength="10" maxlength="1000" required data-cy="charge-revoke-reason"></textarea></label><p role="alert"></p><button type="button" data-cy="charge-cancel">Cancel</button> <button data-cy="charge-confirm-revoke">End additional charge</button></form>';
  document.body.append(dialog);dialogs.add(dialog);dialog.showModal();
  const open=()=>active()&&dialogs.has(dialog)&&dialog.isConnected&&dialog.open;
  const remove=()=>{dialogs.delete(dialog);dialog.remove();if(active()&&opener.isConnected)opener.focus();};
  dialog.addEventListener('close',remove);
  dialog.addEventListener('cancel',e=>{e.preventDefault();dialog.close();});
  dialog.querySelector('[data-cy=charge-cancel]')!.addEventListener('click',()=>dialog.close());
  dialog.querySelector('form')!.onsubmit=async e=>{
   e.preventDefault();if(!open()||busy)return;
   const body={action:'revoke',id:button.dataset.revoke,version:Number(button.dataset.version),reason:new FormData(e.currentTarget as HTMLFormElement).get('reason')};
   busy=true;epoch++;const restore=disableControls(dialog);
   try{
    await api.mutate(body);await whenActive();if(!open())return;
    // A corrupt optional workspace marker must not turn an acknowledged revoke
    // into a failed mutation. Only the matching assignment marker is removed.
    try{const stored=JSON.parse(sessionStorage.getItem('primecare_care_charge')||'null');if(stored?.id===body.id)sessionStorage.removeItem('primecare_care_charge');}catch{}
    dialog.close();await load('Additional charge ended. Primary role retained.',true,true);
   }catch(error){await whenActive();if(!open()||denied(error))return;dialog.querySelector('[role=alert]')!.textContent=(error as Error).message;
   }finally{await whenActive();busy=false;if(open())restore();}
  };
 }
 function disableControls(container:HTMLElement){
  const disabled=new Map<HTMLInputElement|HTMLButtonElement|HTMLSelectElement|HTMLTextAreaElement,boolean>();
  container.querySelectorAll<HTMLInputElement|HTMLButtonElement|HTMLSelectElement|HTMLTextAreaElement>('input,button,select,textarea').forEach(control=>{disabled.set(control,control.disabled);control.disabled=true;});
  return()=>{for(const [control,previous]of disabled)if(control.isConnected)control.disabled=previous;};
 }
 async function save(body:unknown,active:()=>boolean,enter?:string){
  if(!active()||busy||dialogs.size)return;busy=true;epoch++;const restore=disableControls(root);
  try{
   await api.mutate(body);await whenActive();if(!active())return;
   if(enter){sessionStorage.setItem('primecare_care_charge',JSON.stringify({token,id:enter}));location.assign('/care?dataset=live&enable-semantics=true');return;}
   await load('Additional charge saved to PostgreSQL. Primary role unchanged.',true);
  }catch(error){await whenActive();if(!active()||denied(error))return;notice((error as Error).message);
  }finally{await whenActive();busy=false;if(active())restore();}
 }
 async function load(message='',afterMutation=false,preserveDraft=false){
  if(!current()||(!afterMutation&&busy)||dialogs.size)return;
  const id=++epoch,values=formValues(),drawn=version,draft=preserveDraft&&hasDraft()?JSON.parse(formValues()) as Record<string,string>:undefined;
  try{
   const data=await api.read();await whenActive();
   if(id!==epoch||drawn!==version||!current())return;
   // A pending read cannot discard an assignment being edited or a revoke reason.
   if((busy&&!afterMutation)||dialogs.size||formValues()!==values)return;
   draw(data,message,draft);
  }catch(error){
   await whenActive();if(id!==epoch||drawn!==version||!current()||denied(error))return;
   if(root.querySelector('[data-cy=charge-status]')){notice((error as Error).message);return;}
   root.innerHTML='<main class="charge-page"><h1>Additional charge unavailable</h1><p role="alert"></p><a href="/platform/administration">Return to administration</a> <button data-cy="charge-retry">Retry</button></main>';
   ownedNodes=Array.from(root.childNodes);const failed=++version;
   root.querySelector('[role=alert]')!.textContent=(error as Error).message;
   root.querySelector('[data-cy=charge-retry]')!.addEventListener('click',()=>{if(failed===version&&current())void load();});
  }
 }
 await load();
}
