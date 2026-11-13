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
 if(!kind||!['profile','project','analytics','activity','search'].includes(kind)||!options.isCurrent())return null;
 const {data,locale}=options,scope={tenantId:data.organization.id,userId:data.identity.userId,role:data.identity.role,dataset:data.dataset};
 validateDashboardResponseScope(data,scope);
 if(kind==='profile'&&scope.dataset!=='live')return null;
 const main=root.querySelector<HTMLElement>('main.tenant-dashboard-main');if(!main)return null;
 const slot=root.ownerDocument.createElement('section');slot.dataset.pcTenantReadHost=kind;main.prepend(slot);
 let dead=false,view:PrimeApplicationModule|undefined,session:WorkModuleSession|undefined;
 const current=()=>!dead&&root.contains(slot)&&options.isCurrent()&&sessionStorage.getItem('primecare_session')===options.token;
 const handle:TenantReadHost={dispose:()=>{if(dead)return;dead=true;view?.dispose();session?.dispose();slot.remove();},syncControls:()=>{if(dead)return;if(!root.contains(slot)){handle.dispose();return;}if(!current())return;view?.render();}};
 try{
  if(kind==='profile'){
   const port=new ApplicationProfilePort(options.gateway,options.token,scope,()=>{if(!current())throw Error('scope_changed');return {token:options.token,scope};},application.locales[locale]);
   // Hold transport results while the owner is in BFCache, before the profile guard or renderer runs.
   const read=port.read.bind(port);port.read=async(query,signal)=>{await options.whenActive();return read(query,signal);};
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
 }catch(error){handle.dispose();throw error;}
}
