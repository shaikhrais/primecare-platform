import {PrimeApplicationShortcuts,ApplicationShortcutEditor} from '../../../../packages/primecare_ui/web/application-shortcuts';
import {ApplicationSettingsPort} from '../../../../packages/shared/src/application-modules/settings-port';
import {preferenceHttpTransport,preferenceStorageCache} from '../../../../packages/shared/src/preference-sync/transport';
import {PreferenceFailure} from '../../../../packages/shared/src/preference-sync/client';
import {validateDashboardResponseScope} from '../../../../packages/shared/src/dashboard-pages/projection.mjs';
import destinations from '../../../../packages/primecare_ui/catalogs/application-shortcuts.destinations.json';
import application from '../../../../packages/primecare_ui/catalogs/application-modules.registration.json';
export type TenantShortcutHost={blocked:()=>boolean;syncControls:()=>void;dispose:()=>void};
/** Pilot uses existing active role-screen permissions; API777 still authorizes every read/write. */
export function mountTenantShortcutHost(root:HTMLElement,options:{gateway:string;token:string;data:any;params:URLSearchParams;locale:'en'|'fr'|'es';isCurrent:()=>boolean;whenActive:()=>Promise<boolean>;lock:(blocked:boolean)=>void;invalidated:()=>void}):TenantShortcutHost|null {
 if(options.params.get('applicationModule')!=='settings')return null;
 const {gateway,token,locale,data}=options,isCurrent=options.isCurrent.bind(options),whenActive=options.whenActive.bind(options),lock=options.lock.bind(options),invalidated=options.invalidated.bind(options);
 const scope=Object.freeze({tenantId:data?.organization?.id,userId:data?.identity?.userId,role:data?.identity?.role,dataset:data?.dataset});
 const parentCurrent=()=>{try{return isCurrent()===true;}catch{return false;}};
 if(!parentCurrent()||scope.dataset!=='live'||scope.role!==destinations.host.role)return null;
 validateDashboardResponseScope(data,scope);
 if(destinations.kind!=='verified_metadata_export'||destinations.host.screenId!==2534||!destinations.source.jobId||destinations.destinations.some(d=>!/^\/[a-z0-9/-]+(?:#[a-z0-9-]+)?$/.test(d.route)))throw Error('Verified shortcut destinations required');
 const main=root.querySelector<HTMLElement>('main.tenant-dashboard-main');if(!main)return null;const slot=root.ownerDocument.createElement('section');slot.dataset.pcTenantShortcutHost='';main.prepend(slot);
 let dead=false,port:ApplicationSettingsPort|undefined,editor:ApplicationShortcutEditor|undefined,view:PrimeApplicationShortcuts|undefined,off=()=>{};let observer:MutationObserver|undefined;
 const current=()=>{try{if(dead||!root.contains(slot)||!parentCurrent()||dead||!root.contains(slot))return false;const sameToken=sessionStorage.getItem('primecare_session')===token;return sameToken&&!dead&&root.contains(slot);}catch{return false;}};
 const handle:TenantShortcutHost={
  blocked:()=>{if(dead||!editor)return false;const state=editor.current;return state.dirty||!!state.pending||!!state.remote||!!editor.recoveryPreview||['loading','saving','discarding','recovering'].includes(state.status);},
  syncControls:()=>{
   if(dead)return;if(!root.contains(slot)||!current()){handle.dispose();return;}
   if(editor&&['scope_changed','forbidden','unauthenticated'].includes(editor.current.error??'')){
    let failure:{error:unknown}|undefined;try{handle.dispose();}catch(error){failure={error};}try{invalidated();}catch(error){failure??={error};}if(failure)throw failure.error;return;
   }
   lock(handle.blocked());if(current())view?.render();else handle.dispose();
  },
  dispose:()=>{
   if(dead)return;dead=true;
   let failure:{error:unknown}|undefined;
   const attempt=(cleanup:()=>void)=>{try{cleanup();}catch(error){failure??={error};}};
   attempt(()=>observer?.disconnect());attempt(()=>off());attempt(()=>view?.dispose());attempt(()=>editor?.dispose());attempt(()=>port?.dispose());attempt(()=>slot.remove());attempt(()=>lock(false));
   if(failure)throw failure.error;
  }
 };
 try{
  const send=preferenceHttpTransport(gateway,token),binding={scope,kind:'shortcuts' as const,resource:'navigation',policy:{panelIds:[],screenIds:destinations.destinations.map(d=>d.id)}};
  port=new ApplicationSettingsPort(binding,async(request,signal)=>{if(!await whenActive()||!current())throw new PreferenceFailure('scope_changed',403);try{return await send(request,signal);}finally{if(!await whenActive()||!current())throw new PreferenceFailure('scope_changed',403);}},preferenceStorageCache(localStorage),Object.fromEntries(destinations.destinations.map(d=>[d.id,d.title])),application.locales[locale],['2534']);
  editor=new ApplicationShortcutEditor(port);view=new PrimeApplicationShortcuts(slot,editor,locale,current);off=editor.subscribe(()=>handle.syncControls());observer=new MutationObserver(()=>{if(!root.isConnected||!root.contains(slot))handle.dispose();});observer.observe(root.ownerDocument,{childList:true,subtree:true});void editor.load().catch(()=>handle.syncControls());return handle;
 }catch(error){try{handle.dispose();}catch{}throw error;}
}
