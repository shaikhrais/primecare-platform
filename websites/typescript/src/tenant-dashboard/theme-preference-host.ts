import {PreferenceSyncClient} from '../../../../packages/shared/src/preference-sync/client';
import {preferenceHttpTransport,preferenceStorageCache} from '../../../../packages/shared/src/preference-sync/transport';
import {mountTenantThemeMigration} from '../../../../packages/primecare_ui/web/advanced-theme-tenant-control';
import {mountTenantThemeRestore} from '../../../../packages/primecare_ui/web/advanced-theme-tenant-restore-control';

type Options={gateway:string;token:string;locale:'en'|'fr'|'es';tenantId:string;userId:string;dataset:'live'|'demo';isCurrent:()=>boolean};
/** Mount the registered controls only when the owned preference service is available. */
export function mountTenantThemePreference(root:HTMLElement,options:Options) {
 let disposed=false,removeControl:(()=>void)|undefined,client:PreferenceSyncClient|undefined,draftChanged=false;
 const dialog=root.querySelector<HTMLElement>('[data-cy=theme-center]');
 if(!dialog)return ()=>{};
 const touched=(event:Event)=>{const target=event.target;if(target instanceof Element&&!target.closest('[data-cy=theme-restore-review],[data-cy=theme-restore-confirm]')&&target.closest('[data-cy^=theme-center-],[data-cy^=theme-quick-]'))draftChanged=true;};
 for(const name of ['input','change','click'])dialog.addEventListener(name,touched,true);
 try {
  const scope={tenantId:options.tenantId,userId:options.userId,role:'tenant_admin',dataset:options.dataset};
  const binding={scope,kind:'theme' as const,resource:'advanced-v2',policy:{panelIds:[],screenIds:[]}};
  const key='primecare-themes:v1:'+encodeURIComponent(JSON.stringify(['tenant-dashboard',scope.dataset,scope.tenantId,scope.userId,scope.role]));
  client=new PreferenceSyncClient(binding,preferenceHttpTransport(options.gateway,options.token),preferenceStorageCache(localStorage));
  const current=client;
  void (async()=>{
   await current.load();
   if(disposed||!options.isCurrent()||!root.contains(dialog))return;
   const state=current.current;
   if(!state.loaded||!['clean','dirty','conflict','offline'].includes(state.status))return;
   const valid=()=>!disposed&&options.isCurrent()&&root.contains(dialog);
   if(localStorage.getItem(key)!==null||state.pending)removeControl=mountTenantThemeMigration(dialog,current,localStorage,options.locale,valid);
   else if(state.status==='clean'&&state.base.document!==null&&state.base.revision>0)removeControl=mountTenantThemeRestore(dialog,current,localStorage,key,options.locale,valid,()=>draftChanged,()=>root.ownerDocument.defaultView?.location.reload());
  })().catch(()=>{});
 }catch{}
 return ()=>{disposed=true;for(const name of ['input','change','click'])dialog.removeEventListener(name,touched,true);removeControl?.();if(client)void client.dispose();};
}
