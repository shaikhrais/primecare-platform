import {PrimeApplicationModule,ApplicationProfilePort,WorkModuleSession} from '../../../../packages/primecare_ui/web/application-modules';
import {renderDashboardProjection} from '../../../../packages/primecare_ui/web/dashboard-pages';
import {renderRecordPage} from '../../../../packages/primecare_ui/web/record-pages';
import {projectDashboard,validateDashboardResponseScope} from '../../../../packages/shared/src/dashboard-pages/projection.mjs';
import {projectRecordPage} from '../../../../packages/shared/src/dashboard-pages/record-pages.mjs';
import application from '../../../../packages/primecare_ui/catalogs/application-modules.registration.json';
import contract from '../../../../tools/governance-production/dashboard-pages-contract.json';
import tenant from '../../../../packages/shared/src/tenant-dashboard/catalog.json';
export type TenantReadHost={dispose:()=>void;syncControls:()=>void};
/** Optional registered read views of this response; no new route, query or business mutation. */
export function mountTenantReadHost(root:HTMLElement,options:{gateway:string;token:string;data:any;params:URLSearchParams;locale:'en'|'fr'|'es';isCurrent:()=>boolean;whenActive:()=>Promise<boolean>}):TenantReadHost|null {
 const kind=options.params.get('readPage');
 if(!kind||!['profile','project','analytics','activity','search'].includes(kind))return null;
 const {data,locale,gateway,token}=options,isCurrent=options.isCurrent.bind(options),whenActive=options.whenActive.bind(options);
 const scope=Object.freeze({tenantId:data.organization.id,userId:data.identity.userId,role:data.identity.role,dataset:data.dataset});
 const parentCurrent=()=>{try{return isCurrent()===true;}catch{return false;}};
 if(!parentCurrent())return null;
 validateDashboardResponseScope(data,scope);
 if(kind==='profile'&&scope.dataset!=='live')return null;
 const main=root.querySelector<HTMLElement>('main.tenant-dashboard-main');if(!main)return null;
 const slot=root.ownerDocument.createElement('section');slot.dataset.pcTenantReadHost=kind;main.prepend(slot);
 let dead=false,view:PrimeApplicationModule|undefined,session:WorkModuleSession|undefined,port:ApplicationProfilePort|undefined;
 const current=()=>{try{return !dead&&root.contains(slot)&&parentCurrent()&&!dead&&root.contains(slot)&&sessionStorage.getItem('primecare_session')===token;}catch{return false;}};
 const handle:TenantReadHost={dispose:()=>{
  if(dead)return;dead=true;let failure:{error:unknown}|undefined;
  const attempt=(cleanup:()=>void)=>{try{cleanup();}catch(error){failure??={error};}};
  attempt(()=>view?.dispose());attempt(()=>session?.dispose());attempt(()=>port?.dispose());attempt(()=>slot.remove());
  if(failure)throw failure.error;
 },syncControls:()=>{if(dead)return;if(!current()){handle.dispose();return;}view?.render();}};
 try{
  if(kind==='profile'){
   // The parent suspends in BFCache. Hold headers and body chunks before the port's scope guard.
   const fetcher:typeof fetch=async(input,init)=>{
    const response=await fetch(input,init);
    try{if(!await whenActive()||!current())throw Error('scope_changed');}catch(error){await response.body?.cancel().catch(()=>{});throw error;}
    if(!response.body)return response;
    const reader=response.body.getReader();
    const body=new ReadableStream<Uint8Array>({async pull(controller){try{const part=await reader.read();if(!await whenActive()||!current()){await reader.cancel();throw Error('scope_changed');}if(part.done)controller.close();else controller.enqueue(part.value);}catch(error){await reader.cancel().catch(()=>{});controller.error(error);}},cancel:reason=>reader.cancel(reason)});
    return new Response(body,{status:response.status,statusText:response.statusText,headers:response.headers});
   };
   port=new ApplicationProfilePort(gateway,token,scope,()=>{if(!current())throw Error('scope_changed');return {token,scope};},application.locales[locale],fetcher);
   session=new WorkModuleSession(scope,'profile',port);
   class OwnedProfile extends PrimeApplicationModule {override render(){if(current())super.render();}}
   view=new OwnedProfile(slot,session,{locale,year:Number(data.today.slice(0,4)),month:Number(data.today.slice(5,7)),firstWeekday:1});
  }else{
   const resources=Object.fromEntries(Object.entries(contract.resources).map(([key,value])=>[key.slice('dashboardPages.'.length),value[locale]]));
   const labels={...resources,live:tenant.labels.live,demo:tenant.labels.demo,bounded:resources.partial};
   if(kind==='activity'||kind==='search')renderRecordPage(slot,projectRecordPage(kind,data,scope,kind==='search'?options.params.get('readQuery')??'':''),labels);
   else renderDashboardProjection(slot,projectDashboard(kind,data,scope),{...labels,title:resources[kind],denied:resources.denied,unavailable:resources.unavailable,metrics:resources});
  }
  return handle;
 }catch(error){try{handle.dispose();}catch{}throw error;}
}
