import {PrimeWorkModule,WorkModuleSession} from '../../../../packages/primecare_ui/web/work-modules';
import {TenantTaskModulePort} from '../../../../packages/shared/src/work-modules/tenant-task-adapter';
import {tenantTaskModuleTransport} from './work-module-transport';
import type {WorkModule} from '../../../../packages/domain/src/work_modules';
export type TenantWorkHost={blocked:()=>boolean;dispose:()=>void;syncControls:()=>void};
const hosts=new WeakMap<HTMLElement,TenantWorkHost>();
export function clearTenantWorkHost(root:HTMLElement){hosts.get(root)?.dispose();}
/** Existing registered host/controls/APIs only. URL opt-in does not grant a view or a task action. */
export function mountTenantWorkHost(root:HTMLElement,options:{gateway:string;token:string;data:any;view:string;params:URLSearchParams;lock:(blocked:boolean)=>void;invalidated:()=>void;verified:()=>void}):TenantWorkHost|null {
 clearTenantWorkHost(root);const {data,view,params}=options,module=params.get('workModule');
 if(!module||!['calendar','contacts','tasks','notes','board'].includes(module))return null;
 const required=module==='contacts'?'people':'tasks';
 if(view!==required||!Array.isArray(data.allowedViews)||!data.allowedViews.includes(required))return null;
 const original=root.querySelector<HTMLElement>(module==='contacts'?'[data-tenant-directory-source]':'[data-cy=tenant-task-table]')?.closest<HTMLElement>('section');
 if(!original||!/^\d{4}-\d{2}-\d{2}$/.test(data.today))throw Error('Invalid registered work host');
 const language=root.ownerDocument.documentElement.lang.toLowerCase().split('-')[0],locale=language==='fr'||language==='es'?language:'en';
 const scope={tenantId:data.organization.id,userId:data.identity.userId,role:data.identity.role,dataset:data.dataset},send=tenantTaskModuleTransport(options.gateway,options.token);
 const transport:typeof send=(request,signal)=>send({...request,filters:{...request.filters,...(data.synthetic&&params.has('tenant')&&data.globalPreview===true?{tenant:scope.tenantId}:{})}},signal);
 const session=new WorkModuleSession(scope,module as WorkModule,new TenantTaskModulePort(scope,module as WorkModule,transport));
 const slot=root.ownerDocument.createElement('section');slot.dataset.pcTenantWorkHost=module;original.before(slot);const hidden=original.hidden;original.hidden=true;
 let dead=false,notifiedVersion='';let work:PrimeWorkModule;const abort=new AbortController();let off=()=>{};let observer:MutationObserver|undefined;
 const handle:TenantWorkHost={syncControls:()=>update(),blocked:()=>!dead&&sessionStorage.getItem('primecare_session')===options.token&&(session.current.pending||session.status==='saving'||work?.hasUnsavedChanges===true),dispose:()=>{if(dead)return;dead=true;abort.abort();observer?.disconnect();off();work?.dispose();session.dispose();slot.remove();if(original.isConnected)original.hidden=hidden;options.lock(false);if(hosts.get(root)===handle)hosts.delete(root);}};
 const update=()=>{if(dead)return;if(!root.isConnected||!root.contains(slot)){handle.dispose();return;}if(sessionStorage.getItem('primecare_session')!==options.token||session.status==='denied'){handle.dispose();options.invalidated();return;}const blocked=handle.blocked(),state=session.current,version=state.status==='success'?JSON.stringify(state.snapshot?.items.map(i=>[i.id,i.version])):'';options.lock(blocked);if(state.status==='success'&&!blocked&&version!==notifiedVersion){notifiedVersion=version;options.verified();}};
 try{work=new PrimeWorkModule(slot,session,{locale,year:Number(data.today.slice(0,4)),month:Number(data.today.slice(5,7)),firstWeekday:1});hosts.set(root,handle);off=session.subscribe(update);
  slot.addEventListener('input',update,{signal:abort.signal});slot.addEventListener('change',update,{signal:abort.signal});slot.addEventListener('click',update,{signal:abort.signal});
  observer=new MutationObserver(update);observer.observe(root.ownerDocument,{childList:true,subtree:true});
  root.ownerDocument.defaultView?.addEventListener('pagehide',e=>{if(!e.persisted)handle.dispose();},{signal:abort.signal});
  root.ownerDocument.defaultView?.addEventListener('beforeunload',e=>{if(handle.blocked()){e.preventDefault();e.returnValue='';}},{signal:abort.signal});
  update();return handle;
 }catch(error){handle.dispose();throw error;}
}
