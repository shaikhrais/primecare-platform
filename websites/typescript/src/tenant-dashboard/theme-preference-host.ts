import {PreferenceSyncClient, preferenceKey} from '../../../../packages/shared/src/preference-sync/client';
import {preferenceHttpTransport,preferenceStorageCache} from '../../../../packages/shared/src/preference-sync/transport';
import {mountTenantThemeMigration} from '../../../../packages/primecare_ui/web/advanced-theme-tenant-control';

type Options={gateway:string;token:string;locale:'en'|'fr'|'es';tenantId:string;userId:string;dataset:'live'|'demo';isCurrent:()=>boolean};
/** Mount the registered controls only when the owned preference service is available. */
export function mountTenantThemePreference(root:HTMLElement,options:Options) {
 let disposed=false,removeControl:(()=>void)|undefined,client:PreferenceSyncClient|undefined;
 const dialog=root.querySelector<HTMLElement>('[data-cy=theme-center]');
 if(!dialog)return ()=>{};
 try {
  const scope={tenantId:options.tenantId,userId:options.userId,role:'tenant_admin',dataset:options.dataset};
  const binding={scope,kind:'theme' as const,resource:'advanced-v2',policy:{panelIds:[],screenIds:[]}};
  const key='primecare-themes:v1:'+encodeURIComponent(JSON.stringify(['tenant-dashboard',scope.dataset,scope.tenantId,scope.userId,scope.role]));
  if(localStorage.getItem(key)===null&&localStorage.getItem(preferenceKey(binding))===null)return ()=>{};
  client=new PreferenceSyncClient(binding,preferenceHttpTransport(options.gateway,options.token),preferenceStorageCache(localStorage));
  const current=client;
  void (async()=>{
   await current.load();
   if(disposed||!options.isCurrent()||!root.contains(dialog))return;
   const state=current.current;
   if(!state.loaded||!['clean','dirty','conflict','offline'].includes(state.status))return;
   if(localStorage.getItem(key)===null&&!state.pending)return;
   removeControl=mountTenantThemeMigration(dialog,current,localStorage,options.locale,()=>options.isCurrent()&&root.contains(dialog));
  })().catch(()=>{});
 }catch{}
 return ()=>{disposed=true;removeControl?.();if(client)void client.dispose();};
}
