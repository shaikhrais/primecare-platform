/** Shared original geometry. Historical Tabler notice is retained in docs/appearance. */
import {primeCareIcon,primeCareIconPaths,primeCareAssetAliases,type PrimeCareIconName} from "./original-assets";
import {originalAssetInfo} from './original-asset-view';
export const shellIconNames=Object.freeze(["refresh", "building", "building-plus", "layout-dashboard", "users", "clipboard-check", "database", "shield-check", "chart-bar", "map-2", "rocket", "school", "settings", "search", "menu-2", "x", "dots-vertical", "chevron-down", "logout", "user-circle", "phone", "robot", "file-text", "adjustments-horizontal", "palette"] as const);
export type ShellIcon=typeof shellIconNames[number];
/** Icons remain decorative; the enclosing control supplies its accessible name. */
export function shellIcon(name:ShellIcon,options:{rtl?:boolean}={}):string{
  if(!shellIconNames.includes(name))throw Error("Unknown shell icon");
  const canonical=(Object.hasOwn(primeCareIconPaths,name)?name:primeCareAssetAliases[name as keyof typeof primeCareAssetAliases]) as PrimeCareIconName;
  const svg=primeCareIcon(canonical).replace("<svg ","<svg class=\"media-icon shell-icon\" ");
  if(!options.rtl)return svg;
  const asset=originalAssetInfo(canonical);
  if(!asset.rtlMirror)return svg;
  const mirrorX=2*asset.viewBox[0]+asset.viewBox[2];
  return svg.replace('>',`><g transform="translate(${mirrorX} 0) scale(-1 1)">`).replace('</svg>','</g></svg>');
}
const destinations:Record<string,ShellIcon>={appearance:'palette',launch:'rocket',documents:'file-text',support:'users',organizations:'building',tenants:'layout-dashboard','tenant-selection':'building',onboarding:'shield-check',accounts:'users',masters:'database',audit:'clipboard-check',reports:'chart-bar',territories:'map-2',operations:'adjustments-horizontal',bundle:'rocket',growth:'chart-bar',training:'school',text:'file-text',account:'user-circle',vapi:'robot',calls:'phone',look:'palette'};
export function navigationIcon(destination:string,options:{rtl?:boolean}={}):string{return shellIcon(Object.hasOwn(destinations,destination)?destinations[destination]:'layout-dashboard',options);}
