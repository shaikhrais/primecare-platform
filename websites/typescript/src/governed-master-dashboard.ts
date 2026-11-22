import {MasterDashboard} from "../../../packages/primecare_master/web/primecare_ui/web/master-dashboard.ts";
import {requireMasterDashboard} from "../../../packages/primecare_master/web/primecare_ui/web/dashboard-render-policy.ts";
import {ScreenConfigurationError,type ScreenManager} from "../../../packages/primecare_master/web/primecare_ui/web/screen-manager.ts";
import {resolveManagedRoute} from './managed-routes';

export type GovernedDashboardPage = Readonly<{code:string;name:string;route:string;renderer:string}>;

export function governedDashboardDescriptor(page: GovernedDashboardPage) {
  if (page.renderer!=='dashboard' || !page.code.trim() || !page.name.trim() ||
      resolveManagedRoute(page.route,'').adapter!=='workspace')
    throw new ScreenConfigurationError('A dedicated route cannot use the generic dashboard adapter');
  return {screenCode:page.code,route:page.route,title:page.name,views:[{id:'overview',label:page.name}]};
}

/** A single empty subclass for all generic governed dashboards. */
export class GovernedMasterDashboard extends MasterDashboard {}

export function connectGovernedMasterDashboard(root:HTMLElement,manager:ScreenManager,page:GovernedDashboardPage,current:()=>boolean) {
  const config=governedDashboardDescriptor(page);
  const releaseGuard=requireMasterDashboard(root);
  try {
    const master=new GovernedMasterDashboard(root,manager,{id:'governed:'+page.code,route:page.route},config,{
      current,revision:()=>0,canDismiss:()=>false,className:'pc-dashboard-dialog',
      headingSelector:'h2',closeSelector:'[data-dashboard-close]',statusKey:'dashboard-dialog-status',
    },releaseGuard);
    return {code:page.code,route:page.route,master};
  } catch (error) {
    releaseGuard();
    throw error;
  }
}
