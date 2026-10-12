import {bindSidebar} from './sidebar';
import {mountNavigation,type NavigationLocale,type SearchEntry} from './navigation';
type ShellContent={home:string;role:string;description?:string;navigation:string;controls:string;content:string;mainAttributes?:string;menuLabel?:string};
/** One authenticated website layout for every role. HTML slots are built by escaped app renderers. */
export function shellMarkup(options:ShellContent):string {
 return `<div class="app-shell" data-cy="app-shell"><aside id="app-sidebar" data-cy="app-sidebar"><button class="sidebar-close" data-cy="sidebar-close" aria-label="Close navigation">×</button><a class="brand" href="${options.home}">PrimeCare</a><p>${options.role}</p>${options.description?`<p>${options.description}</p>`:''}<nav aria-label="Navigation">${options.navigation}</nav></aside><div class="workspace"><header class="topbar" data-cy="app-topbar"><button class="menu" data-cy="sidebar-toggle" aria-controls="app-sidebar" aria-expanded="false" aria-label="${options.menuLabel??'Open navigation'}">☰</button><div data-cy="global-navigation"></div><div class="shell-controls" data-cy="shell-controls">${options.controls}</div></header><main ${options.mainAttributes??''}>${options.content}</main></div></div>`;
}
const shells=new WeakMap<HTMLElement,ShellContent>();
export function renderShell(root:HTMLElement,options:ShellContent):void {
 const previous=shells.get(root);
 const main=root.querySelector<HTMLElement>('.workspace > main');
 if(!previous||!main||previous.role!==options.role||previous.home!==options.home){root.innerHTML=shellMarkup(options);}
 else {
  if(previous.navigation!==options.navigation)root.querySelector('aside nav')!.innerHTML=options.navigation;
  if(previous.controls!==options.controls)root.querySelector('[data-cy=shell-controls]')!.innerHTML=options.controls;
  for(const attribute of [...main.attributes])main.removeAttribute(attribute.name);
  const attributes=document.createElement('template');attributes.innerHTML='<main '+(options.mainAttributes??'')+'></main>';
  for(const attribute of attributes.content.firstElementChild!.attributes)main.setAttribute(attribute.name,attribute.value);
  main.innerHTML=options.content;
 }
 shells.set(root,options);
}
export function bindShell(root:HTMLElement,title:string,locale:NavigationLocale,scope:string,entries:()=>SearchEntry[]):void {
 bindSidebar(root);
 mountNavigation(root.querySelector<HTMLElement>('[data-cy=global-navigation]')!,title,locale,scope,entries);
}
