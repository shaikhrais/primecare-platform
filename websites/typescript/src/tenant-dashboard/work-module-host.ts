import {PrimeWorkModule,WorkModuleSession} from '../../../../packages/primecare_ui/web/work-modules';
import {TenantTaskModulePort} from '../../../../packages/shared/src/work-modules/tenant-task-adapter';
import {tenantTaskModuleTransport} from './work-module-transport';
import {WorkFailure,type WorkModule} from '../../../../packages/domain/src/work_modules';
export type TenantWorkHost={blocked:()=>boolean;dispose:()=>void;syncControls:()=>void};
const hosts=new WeakMap<HTMLElement,TenantWorkHost>();
export function clearTenantWorkHost(root:HTMLElement){hosts.get(root)?.dispose();}
/** Existing registered host/controls/APIs only. URL opt-in does not grant a view or a task action. */
export function mountTenantWorkHost(root:HTMLElement,options:{gateway:string;token:string;data:any;view:string;params:URLSearchParams;isCurrent?:()=>boolean;whenActive?:()=>Promise<boolean>;lock:(blocked:boolean)=>void;invalidated:()=>void;verified:()=>void}):TenantWorkHost|null {
 const {data,view,gateway,token}=options,params=new URLSearchParams(options.params),isCurrent=options.isCurrent?.bind(options),whenActive=options.whenActive?.bind(options),lock=options.lock.bind(options),invalidated=options.invalidated.bind(options),verified=options.verified.bind(options);
 const scope=Object.freeze({tenantId:data?.organization?.id,userId:data?.identity?.userId,role:data?.identity?.role,dataset:data?.dataset}),previewTenant=data?.synthetic&&params.has('tenant')&&data?.globalPreview===true;
 const parentCurrent=()=>{try{return !isCurrent||isCurrent()===true;}catch{return false;}};
 clearTenantWorkHost(root);if(!parentCurrent())return null;const module=params.get('workModule');
 if(!module||!['calendar','contacts','tasks','notes','board'].includes(module))return null;
 const required=module==='contacts'?'people':'tasks';
 if(view!==required||!Array.isArray(data.allowedViews)||!data.allowedViews.includes(required))return null;
 const original=root.querySelector<HTMLElement>(module==='contacts'?'[data-tenant-directory-source]':'[data-cy=tenant-task-table]')?.closest<HTMLElement>('section');
 if(!original||!/^\d{4}-\d{2}-\d{2}$/.test(data.today))throw Error('Invalid registered work host');
 const language=root.ownerDocument.documentElement.lang.toLowerCase().split('-')[0],locale=language==='fr'||language==='es'?language:'en';
 const slot=root.ownerDocument.createElement('section');slot.dataset.pcTenantWorkHost=module;
 let dead=false;const send=tenantTaskModuleTransport(gateway,token);
 const owned=()=>{try{if(dead||!parentCurrent()||dead)return false;const sameToken=sessionStorage.getItem('primecare_session')===token;return sameToken&&!dead&&root.isConnected&&root.contains(slot);}catch{return false;}};
 const transport:typeof send=async(request,signal)=>{
  if(!owned())throw new WorkFailure('unavailable');
  try{return await send({...request,filters:{...request.filters,...(previewTenant?{tenant:scope.tenantId}:{})}},signal);}
  finally{if(whenActive&&!await whenActive())throw new WorkFailure('unavailable');if(!owned())throw new WorkFailure('unavailable');}
 };
 const session=new WorkModuleSession(scope,module as WorkModule,new TenantTaskModulePort(scope,module as WorkModule,transport));
 original.before(slot);const hidden=original.hidden;original.hidden=true;
 let notifiedVersion='';let work:PrimeWorkModule;const abort=new AbortController();let off=()=>{};let observer:MutationObserver|undefined;
 const handle:TenantWorkHost={syncControls:()=>update(),blocked:()=>!dead&&sessionStorage.getItem('primecare_session')===token&&(session.current.pending||session.status==='saving'||work?.hasUnsavedChanges===true),dispose:()=>{if(dead)return;dead=true;let failure:{error:unknown}|undefined;const attempt=(cleanup:()=>void)=>{try{cleanup();}catch(error){failure??={error};}};attempt(()=>abort.abort());attempt(()=>observer?.disconnect());attempt(()=>off());attempt(()=>work?.dispose());attempt(()=>session.dispose());attempt(()=>slot.remove());attempt(()=>{if(original.isConnected)original.hidden=hidden;});attempt(()=>lock(false));if(hosts.get(root)===handle)hosts.delete(root);if(failure)throw failure.error;}};
 const update=()=>{if(dead||!parentCurrent()||dead)return;if(!root.isConnected||!root.contains(slot)){handle.dispose();return;}if(sessionStorage.getItem('primecare_session')!==token||session.status==='denied'){let failure:{error:unknown}|undefined;try{handle.dispose();}catch(error){failure={error};}try{invalidated();}catch(error){failure??={error};}if(failure)throw failure.error;return;}const blocked=handle.blocked(),state=session.current,version=state.status==='success'?JSON.stringify(state.snapshot?.items.map(i=>[i.id,i.version])):'';lock(blocked);if(!owned()||!root.contains(slot))return;if(state.status==='success'&&!blocked&&version!==notifiedVersion){notifiedVersion=version;verified();}};
 // Reuse the existing control; its DOM renders share the parent presentation boundary.
 class TenantWorkModule extends PrimeWorkModule {override render(){if(owned())super.render();}}
 try{work=new TenantWorkModule(slot,session,{locale,year:Number(data.today.slice(0,4)),month:Number(data.today.slice(5,7)),firstWeekday:1});if(!owned()){handle.dispose();return null;}hosts.set(root,handle);off=session.subscribe(update);
  slot.addEventListener('input',update,{signal:abort.signal});slot.addEventListener('change',update,{signal:abort.signal});slot.addEventListener('click',update,{signal:abort.signal});
  observer=new MutationObserver(update);observer.observe(root.ownerDocument,{childList:true,subtree:true});
  root.ownerDocument.defaultView?.addEventListener('pagehide',e=>{if(!e.persisted)handle.dispose();},{signal:abort.signal});
  root.ownerDocument.defaultView?.addEventListener('beforeunload',e=>{if(handle.blocked()){e.preventDefault();e.returnValue='';}},{signal:abort.signal});
  update();return handle;
 }catch(error){try{handle.dispose();}catch{}throw error;}
}
