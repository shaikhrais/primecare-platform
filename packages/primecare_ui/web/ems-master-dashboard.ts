import {MasterDashboard} from './master-dashboard';
import {requireMasterDashboard} from './dashboard-render-policy';
import type {ScreenManager,ScreenRegistration} from './screen-manager';
import {mountCodeAdminEms,emsTitle} from './code-admin-ems';
import definition from '../../shared/src/endpoint-management/contract.json';
type Locale='en'|'fr'|'es';
/** EMS inherits the actual registered master shell; this grants no API authority. */
export class EmsMasterDashboard extends MasterDashboard {}
export function mountEmsMasterDashboard(root:HTMLElement,manager:ScreenManager,entry:Pick<ScreenRegistration,'id'|'route'>,options:{gateway:string;token:string;locale:Locale;profileScope:string;current:()=>boolean;controls?:string}){
 root.dataset.pcEmsMaster='';
 const release=requireMasterDashboard(root);let stop=()=>{};
 const title=emsTitle(options.locale);
 let master:EmsMasterDashboard;
 try{master=new EmsMasterDashboard(root,manager,entry,{screenCode:definition.screenCode,route:entry.route,title,views:[{id:'ems',label:title}]},{current:options.current,revision:()=>0,canDismiss:()=>false,className:'pc-dashboard-dialog',headingSelector:'h2',closeSelector:'[data-dashboard-close]',statusKey:'ems-dialog-status'},()=>{stop();release();root.removeAttribute('data-pc-ems-master');});}
 catch(error){release();throw error;}
 try{
  master.mount({locale:options.locale,profileScope:options.profileScope,allowedViews:['ems'],view:'ems',current:options.current,select:()=>{},shell:{home:'/platform/administration',role:'Code Admin',description:'Endpoint management',navigation:'<section class="code-admin-nav-group"><h2>WORKSPACE</h2><a href="/platform/administration">Overview</a></section><section class="code-admin-nav-group"><h2>SYSTEM</h2><a href="#ems" aria-current="page">'+title+'</a></section>',controls:options.controls??'',footer:'PrimeCare · Endpoint management',content:'<section class="code-admin-page"><header class="code-admin-page-header"><p class="code-admin-breadcrumb">PrimeCare / Code Admin / EMS</p><h1>'+title+'</h1></header><div data-cy="ems-master-content"></div></section>'}});
  stop=mountCodeAdminEms(root.querySelector<HTMLElement>('[data-cy=ems-master-content]')!,options.gateway,options.token,options.locale,options.current);
 }catch(error){master.dispose();throw error;}
 return ()=>{stop();master.dispose();};
}
