import scope from './dashboard-activation.json';

type ActiveDashboard = Readonly<{project:string;appCode:string;code:string;route:string}>;
type PortalIdentity = Readonly<{project:string;appCode:string}>;
const perRoot = new WeakMap<HTMLElement,PortalIdentity>();
const tuple = ({project,appCode,code,route}:ActiveDashboard) => JSON.stringify([project,appCode,code,route]);
const active = new Set([...scope.retained,...scope.cohorts.flatMap(cohort=>cohort.dashboards)].map(tuple));

/** Capture the fetched portal identity once. This never grants route or data access. */
export function installDashboardActivation(root:HTMLElement,project:string,appCode:string):void {
  const prior=perRoot.get(root);
  if(prior&&(prior.project!==project||prior.appCode!==appCode))throw Error('Dashboard activation portal changed');
  if(!prior)perRoot.set(root,Object.freeze({project,appCode}));
}

/** Only select the shell after the owner and route have independently been authorized. */
export function dashboardActivated(root:HTMLElement,code:string,route:string,screenAppCode?:string):boolean {
  const portal=perRoot.get(root);
  return !!portal&&(screenAppCode===undefined||portal.appCode===screenAppCode)&&active.has(tuple({...portal,code,route}));
}
