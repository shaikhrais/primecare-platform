import {requireMasterDashboard} from "../../../../packages/primecare_master/web/primecare_ui/web/dashboard-render-policy";
import {mountTenantShortcutHost,type TenantShortcutHost} from './shortcut-settings-host';
import {mountTenantReadHost,type TenantReadHost} from './read-page-host';
import {requireScreenManager,showScreenConfigurationError,ScreenConfigurationError} from "../../../../packages/primecare_master/web/primecare_ui/web/screen-manager";
import {resolveManagedRoute} from '../managed-routes';
import {mountTenantThemePreference} from './theme-preference-host';
import {TenantPreferenceDraft} from "../../../../packages/primecare_master/web/shared/src/tenant-dashboard/preference-draft";
import {mountTenantWorkHost,clearTenantWorkHost,type TenantWorkHost} from './work-module-host';
import {BaseSessionClient} from '../infrastructure/http/base-session-client';
import {TenantAdminDashboard} from './dashboard-presentation';
import {shellIcon} from '../shell-icons';
import {installTenantDashboardStyles,renderTenantDashboardControls,renderTenantDashboardLoading,renderTenantDashboardUnavailable,tenantView,tenantNavigation,taskForm,taskDetail,esc} from "../../../../packages/primecare_master/web/primecare_ui/web/tenant-dashboard-presentation";
import catalog from "../../../../packages/primecare_master/web/shared/src/tenant-dashboard/catalog.json";
const tenantRenders=new WeakMap<HTMLElement,()=>void>();
const taskPanelHistoryKey='primecareTenantTaskPanel';
let tenantDialogSequence=0;
class TenantClient extends BaseSessionClient{
 protected endpoint=catalog.endpoint;
 constructor(gateway:string,token:string,readonly dataset:string,readonly tenant:string){super(gateway,token);}
 protected accountChangedError(){return Object.assign(Error('Your account changed. Reload this workspace.'),{status:401});}
 protected rejectResponse(r:Response,v:unknown):never{throw Object.assign(Error(String(this.errorData(v).error||'Tenant dashboard unavailable. Refresh to confirm saved changes.')),{status:r.status});}
 read(filters:Record<string,string>){return this.requestJson('?'+new URLSearchParams({dataset:this.dataset,...(this.tenant?{tenant:this.tenant}:{}),...filters}),'GET');}
 mutate(body:unknown,requestId?:string){return this.requestJson('?'+new URLSearchParams({dataset:this.dataset,...(this.tenant?{tenant:this.tenant}:{})}),'POST',body,undefined,requestId);}
}
export async function renderTenantDashboard(root:HTMLElement,gateway:string){
 const manager=requireScreenManager(root);
 requireMasterDashboard(root);
 // main.ts owns this existing document entry. Hash views are server-filtered
 // tenant views, not new ScreenManager registrations or authorization grants.
 const entry=resolveManagedRoute(catalog.route,'');
 const documentRoute=location.pathname+location.search;
 const language=root.ownerDocument.documentElement.lang.toLowerCase().split('-')[0],locale=language==='fr'||language==='es'?language:'en';
 tenantRenders.get(root)?.();let alive=true,suspended=false;let owner:MutationObserver|undefined,ownedShell:Element|null=null,renderVersion=0;
 const eventTarget=root.ownerDocument.defaultView??window;
 let taskPanel:{dialog:HTMLDialogElement,key:number}|undefined;
 let returningFromTaskPanel:number|undefined;
 const historyState=()=>history.state&&typeof history.state==='object'?history.state:{};
 const hasTaskPanelEntry=(key:number)=>historyState()[taskPanelHistoryKey]===key;
 function clearTaskPanelEntry(){
  const next={...historyState()};
  if(!(taskPanelHistoryKey in next))return;
  delete next[taskPanelHistoryKey];
  history.replaceState(Object.keys(next).length?next:null,'',location.href);
 }
 let themePreferenceDispose: (()=>void)|undefined,workHost:TenantWorkHost|null=null,readHost:TenantReadHost|null=null,shortcutHost:TenantShortcutHost|null=null;
 const hostsBlocked=()=>workHost?.blocked()||shortcutHost?.blocked();
 const ownsRoot=()=>alive&&tenantRenders.get(root)===teardown;
 function owned(){if(!ownsRoot())return false;if(root.isConnected===false||(ownedShell&&!root.contains(ownedShell))){teardown();return false;}return true;}
 function fail(error:unknown){if(owned()){teardown();showScreenConfigurationError(root,error);}return false;}
 function context(){
  if(!owned())return false;
  if(location.pathname!==catalog.route||location.pathname+location.search!==documentRoute){teardown();root.replaceChildren();return false;}
  try{if(sessionStorage.getItem('primecare_session')!==token){accessChanged();return false;}}catch{return fail(new ScreenConfigurationError('Session storage is unavailable'));}
  return true;
 }
 // BFCache suspension keeps task dialogs and durable preference retries intact.
 // Network results wait for the restored owner instead of repainting a hidden page.
 const resumes=new Set<()=>void>();
 const release=()=>{for(const resume of resumes)resume();resumes.clear();};
 const whenActive=()=>suspended&&alive?new Promise<void>(resolve=>resumes.add(resolve)):Promise.resolve();
 function current(){if(suspended||!context())return false;try{manager.enter(entry.id,entry.route);}catch(error){return fail(error);}return context();}
 let storedToken:string|null;try{storedToken=sessionStorage.getItem('primecare_session');}catch{showScreenConfigurationError(root,new ScreenConfigurationError('Session storage is unavailable'));return;}
 if(!storedToken){root.replaceChildren();location.assign('/login?enable-semantics=true');return;}const token=storedToken;
 const params=new URLSearchParams(location.search),api=new TenantClient(gateway,token,params.get('dataset')||'live',params.get('tenant')||'');let data:any,busy=false,view=catalog.views.some(v=>v.id===location.hash.slice(1))?location.hash.slice(1):'',search='',status='all',taskOffset=0,flowOffset=0,notice='',epoch=0;
 let dashboard:TenantAdminDashboard;
 try{dashboard=new TenantAdminDashboard(root,manager,entry,{
  className:'td-dialog td-root',headingSelector:'h2',closeSelector:'[data-td-close]',statusKey:'tenant-dialog-status',
  current,revision:()=>renderVersion,
  canDismiss:(dialog,reason)=>canDismissDialog(dialog,reason==='discard'),
  onClosed:(dialog,reason)=>{
   const activeTask=taskPanel?.dialog===dialog?taskPanel:undefined;
   if(activeTask)taskPanel=undefined;
   if(activeTask&&reason==='local'&&current()&&hasTaskPanelEntry(activeTask.key)){
    returningFromTaskPanel=activeTask.key;
    history.back();
    // Navigation may be suppressed by the browser; don't leave the shell locked.
    eventTarget.setTimeout(()=>{
     if(returningFromTaskPanel!==activeTask.key||!current())return;
     returningFromTaskPanel=undefined;
     if(hasTaskPanelEntry(activeTask.key))clearTaskPanelEntry();
    },1000);
   }
  },
 });}catch(error){showScreenConfigurationError(root,error);return;}
 const {dialogs}=dashboard;
 installTenantDashboardStyles(root.ownerDocument);
 let preferenceDraft:TenantPreferenceDraft|undefined;let preferenceDraftScope='';
 const draftMessage=()=>preferenceDraft?.error==='draft_cache_unavailable'?'Your default-view choice is kept in this tab, but browser storage is unavailable.':preferenceDraft?.error?'Your saved draft is unavailable or no longer allowed. Refresh to discard it before choosing again.':preferenceDraft?.pendingRequest?'A previous save is awaiting confirmation. Save retries that original choice before submitting newer edits.':'';
 function saveDraftView(){if(!current()||!data)return;const field=root.querySelector<HTMLSelectElement>('[data-cy=tenant-preference-view]');if(!field)return;try{preferenceDraft?.edit(field.value,data.preference,data.allowedViews);notice=draftMessage();}catch{notice=draftMessage()||'Unable to keep this default-view choice.';}const status=root.querySelector('[data-cy=tenant-status]');if(status)status.textContent=notice;}
 async function refresh(){if(!current()||busy||hostsBlocked())return;if(preferenceDraft?.pendingRequest&&!preferenceDraft.pendingWasRejected&&preferenceDraft.error!=='pending_view_revoked'){inlineError('A previous save is awaiting confirmation. Use Save to retry that original request before discarding your draft.');return;}if(preferenceDraft?.unresolved){if(!window.confirm('Discard your unsaved default-view choice and reload the saved preference?'))return;if(!current())return;try{preferenceDraft.discard();}catch{inlineError('Your draft could not be removed from this browser. It has been kept.');return;}}await load();}
 const filters=()=>({search,status,taskOffset:String(taskOffset),flowOffset:String(flowOffset)});
 function draw(){if(!current())return;readHost?.dispose();readHost=null;shortcutHost?.dispose();shortcutHost=null;const version=++renderVersion,drawnHash=location.hash,active=()=>version===renderVersion&&location.hash===drawnHash&&current(),resumeActive=async()=>{await whenActive();return active();};themePreferenceDispose?.();themePreferenceDispose=undefined;clearTenantWorkHost(root);workHost=null;try{ownedShell=dashboard.mount({view,allowedViews:data.allowedViews,locale,profileScope:JSON.stringify(['tenant-dashboard',data.dataset,data.organization.id,data.identity.userId,data.identity.role]),current:active,select,panels:{'tenant-preference-form':'section:has([data-cy=tenant-preference-form])'},shell:{home:'/tenant-dashboard?enable-semantics=true',role:data.identity.role.replaceAll('_',' '),description:data.organization.name,footer:'PrimeCare · '+esc(data.organization.name),navigation:tenantNavigation(view,shellIcon,data.allowedViews,data.canManage),controls:renderTenantDashboardControls(data.today,locale,shellIcon,data.synthetic,data.identity.role),content:tenantView(data,{view,search,status,notice},shellIcon),mainAttributes:'class="tenant-dashboard-main"'}});}catch(error){if(ownsRoot()){teardown();showScreenConfigurationError(root,error);}return;}
 if(data.identity.role==='tenant_admin') themePreferenceDispose=mountTenantThemePreference(root,{gateway,token,locale,tenantId:data.organization.id,userId:data.identity.userId,dataset:data.dataset,isCurrent:active,whenActive:resumeActive});
 if(!active()){themePreferenceDispose?.();return;}
 root.querySelectorAll<HTMLElement>('[data-td-view]').forEach(b=>b.onclick=e=>{e.preventDefault();if(active())select(b.dataset.tdView!);});root.querySelector('[data-cy=tenant-refresh]')!.addEventListener('click',()=>{if(active())void refresh();});root.querySelector<HTMLElement>('[data-cy=tenant-create-task]')?.addEventListener('click',e=>{if(active())openForm(undefined,undefined,e.currentTarget as HTMLElement);});
 root.querySelector<HTMLFormElement>('[data-cy=tenant-search-form]')!.onsubmit=e=>{e.preventDefault();if(!active())return;search=String(new FormData(e.currentTarget as HTMLFormElement).get('search')||'');taskOffset=flowOffset=0;void load();};root.querySelector<HTMLSelectElement>('[data-cy=tenant-task-filter]')?.addEventListener('change',e=>{if(!active())return;status=(e.target as HTMLSelectElement).value;taskOffset=0;void load();});
 for(const [id,key,delta] of [['tasks-prev','task',-100],['tasks-next','task',100],['flows-prev','flow',-100],['flows-next','flow',100]] as const)root.querySelector('[data-cy=tenant-'+id+']')?.addEventListener('click',()=>{if(!active())return;if(key==='task')taskOffset=Math.max(0,taskOffset+delta);else flowOffset=Math.max(0,flowOffset+delta);void load();});
 root.querySelectorAll<HTMLElement>('[data-open-task]').forEach(b=>b.onclick=()=>{if(active())openTask(data.tasks.find((t:any)=>t.id===b.dataset.openTask),b);});root.querySelectorAll<HTMLElement>('[data-flow-task]').forEach(b=>b.onclick=()=>{if(active())openForm(undefined,b.dataset.flowTask,b);});
 const preferenceForm=root.querySelector<HTMLFormElement>('[data-cy=tenant-preference-form]')!,preferenceSelect=preferenceForm.querySelector<HTMLSelectElement>('[name=view]')!;
 preferenceSelect.value=preferenceDraft?.value(data.preference,data.allowedViews)??data.preference.view;
 preferenceSelect.addEventListener('change',()=>{if(active())saveDraftView();});
 preferenceForm.onsubmit=e=>{e.preventDefault();if(!active()||busy)return;try{if(preferenceSelect.value!==(preferenceDraft!.current?.view??data.preference.view))preferenceDraft!.edit(preferenceSelect.value,data.preference,data.allowedViews);const command=preferenceDraft!.prepare(data.preference,data.allowedViews,data.synthetic?data.workspaceVersion:undefined);void mutate(command.body,undefined,command.requestId);}catch{inlineError(draftMessage()||'Refresh to resolve your saved preference draft first.');}};
 if(draftMessage()){if(!notice.includes(draftMessage()))notice=[notice,draftMessage()].filter(Boolean).join(' ');root.querySelector('[data-cy=tenant-status]')!.textContent=notice;}
 root.querySelector<HTMLSelectElement>('[data-cy=tenant-select-organization]')?.addEventListener('change',e=>{if(active())location.assign('/tenant-dashboard?'+new URLSearchParams({dataset:'demo',tenant:(e.target as HTMLSelectElement).value,'enable-semantics':'true'}));});
 root.querySelector('[data-cy=tenant-demo-load]')?.addEventListener('click',()=>{if(active())void mutate({action:'demo_load'});});root.querySelector('[data-cy=tenant-demo-clear]')?.addEventListener('click',()=>{if(!active())return;const dialog=modal('<h2>Clear marked demo data?</h2><p>Only this synthetic tenant dashboard workspace is cleared. Live tasks and audit history remain intact. Load demo data restores the samples.</p><button data-cy="tenant-confirm-demo-clear">Clear demo data</button> <button data-td-close data-cy="tenant-dialog-close">Cancel</button>');dialog.querySelector('[data-cy=tenant-confirm-demo-clear]')!.addEventListener('click',()=>{if(active()&&dialog.open&&dialogs.has(dialog))void mutate({action:'demo_clear'},dialog);});});
 shortcutHost=mountTenantShortcutHost(root,{gateway,token,data,params,locale,isCurrent:active,whenActive:resumeActive,invalidated:()=>{if(active())accessChanged();},lock:blocked=>{if(!active())return;for(const selector of ['[data-cy=tenant-refresh]','[data-cy=tenant-create-task]','[data-cy=tenant-search-form] button']){const node=root.querySelector<HTMLButtonElement>(selector);if(node)node.disabled=busy||blocked||!!workHost?.blocked();}for(const node of root.querySelectorAll<HTMLElement>('[data-td-view]')){if(blocked||workHost?.blocked())node.setAttribute('aria-disabled','true');else node.removeAttribute('aria-disabled');}}});
 readHost=mountTenantReadHost(root,{gateway,token,data,params,locale,isCurrent:active,whenActive:resumeActive});
 ownedShell=root.querySelector('[data-cy=app-shell]');workHost=mountTenantWorkHost(root,{gateway,token,data,view,params,isCurrent:active,whenActive:resumeActive,verified:()=>{if(!active())return;notice='Saved to PostgreSQL and independently verified.';void load();},invalidated:()=>{if(active())accessChanged();},lock:blocked=>{if(!active())return;for(const selector of ['[data-cy=tenant-refresh]','[data-cy=tenant-create-task]','[data-cy=tenant-search-form] button']){const node=root.querySelector<HTMLButtonElement>(selector);if(node)node.disabled=busy||blocked||!!shortcutHost?.blocked();}for(const node of root.querySelectorAll<HTMLElement>('[data-td-view]')){if(blocked||shortcutHost?.blocked())node.setAttribute('aria-disabled','true');else node.removeAttribute('aria-disabled');}}});
 }
 function select(next:string){if(!current()||busy||dialogs.size||returningFromTaskPanel||hostsBlocked()||!data.allowedViews.includes(next)||next===view)return;view=next;history.pushState(null,'','#'+next);draw();root.querySelector<HTMLElement>('h1')?.setAttribute('tabindex','-1');root.querySelector<HTMLElement>('h1')?.focus();}
 const onPop=(event:Event)=>{
  if(!current()||!data)return;
  returningFromTaskPanel=undefined;
  const next=location.hash.slice(1);
  if(taskPanel){
   const {dialog,key}=taskPanel;
   if(next!==view){
    // Keep explicit hash-view navigation blocked while any dialog is open.
    history.replaceState({...historyState(),[taskPanelHistoryKey]:key},'','#'+view);
    return;
   }
   if(hasTaskPanelEntry(key)||event.type!=='popstate'||!event.isTrusted)return;
   if(!canDismissDialog(dialog,false)){
    // Traversal changes the pointer first. Restore a disposable same-view entry.
    history.pushState({...historyState(),[taskPanelHistoryKey]:key},'','#'+view);
    return;
   }
   dialogs.close(dialog,'history');
   return; // Back dismisses without redrawing or resetting filters.
  }else if(taskPanelHistoryKey in historyState()){
   // Forward after dismissal must not resurrect an old task or draft.
   clearTaskPanelEntry();
  }
  if(busy||dialogs.size||hostsBlocked()||!data.allowedViews.includes(next)){history.replaceState(null,'','#'+view);return;}
  if(next!==view){view=next;draw();}
 };
 eventTarget.addEventListener('popstate',onPop);eventTarget.addEventListener('hashchange',onPop);
 // Keep unsaved registered dialog fields and unresolved writes in their current document.
 const beforeLeave=(event:BeforeUnloadEvent)=>{if(!current())return;if(busy||hostsBlocked()||dialogs.hasOpenDraft()){event.preventDefault();event.returnValue='';}};
 const leave=(event:PageTransitionEvent)=>{if(event.persisted)suspended=true;else teardown();};
 const resume=(event:PageTransitionEvent)=>{if(!event.persisted||!suspended||!ownsRoot())return;suspended=false;if(current()){workHost?.syncControls();readHost?.syncControls();shortcutHost?.syncControls();}release();};
 eventTarget.addEventListener('beforeunload',beforeLeave);eventTarget.addEventListener('pagehide',leave);eventTarget.addEventListener('pageshow',resume);
 function teardown(){if(!alive)return;alive=false;suspended=false;release();renderVersion++;readHost?.dispose();readHost=null;shortcutHost?.dispose();shortcutHost=null;themePreferenceDispose?.();themePreferenceDispose=undefined;epoch++;owner?.disconnect();eventTarget.removeEventListener('popstate',onPop);eventTarget.removeEventListener('hashchange',onPop);eventTarget.removeEventListener('beforeunload',beforeLeave);eventTarget.removeEventListener('pagehide',leave);eventTarget.removeEventListener('pageshow',resume);clearTenantWorkHost(root);workHost=null;if(taskPanel&&hasTaskPanelEntry(taskPanel.key))clearTaskPanelEntry();taskPanel=undefined;dashboard.dispose();if(tenantRenders.get(root)===teardown)tenantRenders.delete(root);}
 tenantRenders.set(root,teardown);owner=new MutationObserver(()=>{if(ownedShell&&(!root.isConnected||!root.contains(ownedShell)))teardown();});owner.observe(root.ownerDocument,{childList:true,subtree:true});
 function denied(error:unknown){const status=(error as {status?:number}).status;if(status===401){sessionStorage.removeItem('primecare_session');teardown();root.replaceChildren();location.assign('/login?enable-semantics=true');return true;}if(status===403){accessChanged();return true;}return false;}
 function accessChanged(){if(!owned())return;unavailable('Your access changed. Reload this workspace.');}
 function unavailable(message:string){if(!owned())return;teardown();workHost=null;const errorRoot=renderTenantDashboardUnavailable(root,message);root.querySelector('[data-cy=tenant-retry]')!.addEventListener('click',()=>{if(root.isConnected&&root.firstElementChild===errorRoot&&location.pathname+location.search===documentRoute&&!tenantRenders.has(root))void renderTenantDashboard(root,gateway);});}
 function inlineError(message:string){if(!current())return;const p=root.ownerDocument.createElement('p');p.setAttribute('role','alert');p.textContent=message;root.querySelector('main')?.prepend(p);}

 function canDismissDialog(dialog:HTMLDialogElement,explicitDiscard:boolean){
  if(busy||hostsBlocked()){
   dialogs.status(dialog,'Please wait for the current operation to finish.');
   return false;
  }
  if(!dialogs.isDirty(dialog))return true;
  if(explicitDiscard)return eventTarget.confirm('Discard your unsaved task changes?');
  dialogs.status(dialog,'Your changes are unsaved. Save them or use Cancel to discard them.');
  return false;
 }
 function modal(html:string,opener?:HTMLElement,task=false){
  const dialog=dialogs.open(html,opener);
  if(task&&typeof history.back==='function'){
   const key=++tenantDialogSequence;
   try{history.pushState({...historyState(),[taskPanelHistoryKey]:key},'',location.href);taskPanel={dialog,key};}catch{/* Native Cancel and Escape still work without History API support. */}
  }
  return dialog;
 }
 function openForm(task?:any,flowId?:string,opener?:HTMLElement,reuse?:HTMLDialogElement){
  if(!current()||busy||hostsBlocked()||returningFromTaskPanel||(reuse?!reuse.open:dialogs.size>0))return;
  const version=renderVersion,html=taskForm(data,task,flowId);
  const d=reuse??modal(html,opener,true);
  if(reuse)dialogs.replaceContent(d,html);
  d.querySelector<HTMLFormElement>('form')!.onsubmit=e=>{e.preventDefault();if(version!==renderVersion||!d.open||!dialogs.has(d)||!current())return;void mutate({action:task?'edit':'create',...(task?{id:task.id,version:task.version}:{}),value:Object.fromEntries(new FormData(e.currentTarget as HTMLFormElement))},d);};
 }
 function openTask(task:any,opener:HTMLElement){
  if(!task||!current()||busy||hostsBlocked()||returningFromTaskPanel||dialogs.size)return;
  const version=renderVersion,d=modal(taskDetail(task),opener,true);
  d.querySelectorAll<HTMLButtonElement>('[data-task-action]').forEach(b=>b.onclick=()=>{
   if(version!==renderVersion||!d.open||!dialogs.has(d)||!current())return;
   const action=b.dataset.taskAction!;
   if(action==='edit'){if(canDismissDialog(d,false))openForm(task,undefined,undefined,d);return;}
   void mutate({action,id:task.id,version:task.version,value:{evidence:d.querySelector<HTMLTextAreaElement>('[data-cy=tenant-task-evidence]')!.value}},d);
  });
 }
 async function mutate(body:any,dialog?:HTMLDialogElement,requestId?:string){if(!current()||busy||hostsBlocked()||(dialog&&(!dialog.open||!dialogs.has(dialog))))return;const version=renderVersion;busy=true;const buttons=dialog||root,disabled=new Map<HTMLButtonElement|HTMLInputElement|HTMLSelectElement|HTMLTextAreaElement,boolean>();buttons.querySelectorAll<HTMLButtonElement|HTMLInputElement|HTMLSelectElement|HTMLTextAreaElement>(dialog?'button,input,select,textarea':'button').forEach(b=>{disabled.set(b,b.disabled);b.disabled=true;});try{const acknowledged=await api.mutate(requestId?body:{...body,...(data.synthetic?{workspaceVersion:data.workspaceVersion}:{})},requestId);await whenActive();if(version!==renderVersion||!current())return;if(body.action==='preferences')preferenceDraft!.acknowledge({view:body.value.view,version:body.version},acknowledged.preference,requestId);if(dialog)dialogs.close(dialog);notice=body.action==='preferences'?(preferenceDraft?.current?'Your previous choice was saved. Your newer default-view edit is still unsaved.':'Default view saved to PostgreSQL.'):'Saved to PostgreSQL. Workflow, clinical and payroll approvals remain separate.';await load();}catch(e){await whenActive();if(version!==renderVersion||!current())return;if(denied(e))return;if(body.action==='preferences'&&requestId&&(e as {status?:number}).status===409)preferenceDraft!.rejectPending(requestId);const message=body.action==='preferences'&&(e as {status?:number}).status===409?'The saved version changed. Your unsaved choice is kept. Refresh to discard it and load the latest preference.':(e as Error).message;if(dialog){dialogs.status(dialog,message);}else{notice=message;if(hostsBlocked())inlineError(message);else draw();}}finally{await whenActive();busy=false;if(alive&&current()){for(const [button,wasDisabled] of disabled){if(button.isConnected)button.disabled=wasDisabled;}workHost?.syncControls();shortcutHost?.syncControls();}}}
 // A refresh begun before a dialog opened must not replace that dialog's shell
 // and strand its draft. The next explicit refresh can fetch a newer snapshot.
 async function load(){if(!current()||hostsBlocked())return;const id=++epoch;try{const next=await api.read(filters());await whenActive();if(!alive||id!==epoch||!current()||hostsBlocked()||dialogs.hasOpen())return;dashboard.allowedViews(next.allowedViews);const nextScope=JSON.stringify([next.organization.id,next.identity.userId,next.identity.role,next.dataset]);if(nextScope!==preferenceDraftScope){const nextDraft=new TenantPreferenceDraft({tenantId:next.organization.id,userId:next.identity.userId,role:next.identity.role,dataset:next.dataset},{getItem:key=>localStorage.getItem(key),setItem:(key,value)=>localStorage.setItem(key,value),removeItem:key=>localStorage.removeItem(key)});preferenceDraft=nextDraft;preferenceDraftScope=nextScope;}data=next;const requested=location.hash.slice(1);if(data.allowedViews.includes(requested))view=requested;else if(!requested)view='';if(!view||!data.allowedViews.includes(view))view=data.allowedViews.includes(data.preference.view)?data.preference.view:data.allowedViews[0];if(location.hash!=='#'+view)history.replaceState(null,'','#'+view);draw();}catch(e){await whenActive();if(!alive||id!==epoch||!current())return;if(denied(e))return;if(hostsBlocked()||dialogs.hasOpen()){inlineError((e as Error).message);return;}unavailable((e as Error).message);}}
 if(!current())return;
 ownedShell=renderTenantDashboardLoading(root);await load();
}
