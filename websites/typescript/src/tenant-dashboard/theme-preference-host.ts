import {themeLibraryAbsent} from '../../../../packages/primecare_ui/web/theme-restore-storage';
import {PreferenceSyncClient,PreferenceFailure} from '../../../../packages/shared/src/preference-sync/client';
import {preferenceHttpTransport,preferenceStorageCache} from '../../../../packages/shared/src/preference-sync/transport';
import {mountTenantThemeMigration} from '../../../../packages/primecare_ui/web/advanced-theme-tenant-control';
import {mountTenantThemeRestore} from '../../../../packages/primecare_ui/web/advanced-theme-tenant-restore-control';

type Options={gateway:string;token:string;locale:'en'|'fr'|'es';tenantId:string;userId:string;dataset:'live'|'demo';isCurrent:()=>boolean;whenActive?:()=>Promise<boolean>};
/** Mount the registered controls only when the owned preference service is available. */
export function mountTenantThemePreference(root:HTMLElement,options:Options) {
 const {gateway,token,locale,tenantId,userId,dataset}=options,isCurrent=options.isCurrent.bind(options),whenActive=options.whenActive?.bind(options);
 const scope=Object.freeze({tenantId,userId,role:'tenant_admin',dataset});
 const parentCurrent=()=>{try{return isCurrent()===true;}catch{return false;}};
 let disposed=false,removeControl:(()=>void)|undefined,client:PreferenceSyncClient|undefined,draftChanged=false;
 const dialog=root.querySelector<HTMLElement>('[data-cy=theme-center]');
 const opener=root.querySelector<HTMLElement>('[data-cy=appearance-open]');
 if(!dialog||!opener||!parentCurrent())return ()=>{};
 let started=false;let start=()=>{};
 const touched=(event:Event)=>{const target=event.target;if(target instanceof Element&&!target.closest('[data-cy=theme-restore-review],[data-cy=theme-restore-confirm]')&&target.closest('[data-cy^=theme-center-],[data-cy^=theme-quick-]'))draftChanged=true;};
 for(const name of ['input','change','click'])dialog.addEventListener(name,touched,true);
 const dispose=()=>{
  if(disposed)return;disposed=true;let failure:{error:unknown}|undefined;
  const attempt=(cleanup:()=>void)=>{try{cleanup();}catch(error){failure??={error};}};
  attempt(()=>opener.removeEventListener('click',start));for(const name of ['input','change','click'])attempt(()=>dialog.removeEventListener(name,touched,true));
  attempt(()=>removeControl?.());attempt(()=>{if(client)void client.dispose();});if(failure)throw failure.error;
 };
 try {
  const binding={scope,kind:'theme' as const,resource:'advanced-v2',policy:{panelIds:[],screenIds:[]}};
  const key='primecare-themes:v1:'+encodeURIComponent(JSON.stringify(['tenant-dashboard',scope.dataset,scope.tenantId,scope.userId,scope.role]));
  const send=preferenceHttpTransport(gateway,token);
  const valid=()=>!disposed&&root.contains(dialog)&&parentCurrent()&&!disposed&&root.contains(dialog);
  client=new PreferenceSyncClient(binding,async(request,signal)=>{
   if(!valid())throw new PreferenceFailure('busy_or_disposed');
   try{return await send(request,signal);}
   finally{if(whenActive&&!await whenActive())throw new PreferenceFailure('busy_or_disposed');if(!valid())throw new PreferenceFailure('busy_or_disposed');}
  },preferenceStorageCache(localStorage));
  const current=client;
  start=()=>{if(started||!valid())return;started=true;void (async()=>{
   await current.load();
   if(!valid())return;
   const state=current.current;
   if(!state.loaded||!['clean','dirty','conflict','offline'].includes(state.status))return;
   if(localStorage.getItem(key)!==null||state.pending)removeControl=mountTenantThemeMigration(dialog,current,localStorage,locale,valid);
   else if(themeLibraryAbsent(localStorage,key)&&state.status==='clean'&&state.base.document!==null&&state.base.revision>0)removeControl=mountTenantThemeRestore(dialog,current,localStorage,key,locale,valid,()=>draftChanged,()=>root.ownerDocument.defaultView?.location.reload());
  })().catch(()=>{}).finally(()=>{if(!removeControl)started=false;});};
  opener.addEventListener('click',start);
  if(dialog.closest('dialog')?.open)start();
 }catch{try{dispose();}catch{}}
 return dispose;

}
