import {shellIcon} from './icons';
import media from '../../shared/src/media/registry.json';
import {mountLayoutCustomizer} from './layout-customizer';
import {BaseMediaLook,applyMediaTokens} from './media-look';
import {bindSidebar} from './sidebar';
import {mountNavigation,type NavigationLocale,type SearchEntry} from './navigation';
export type ShellContent={home:string;role:string;description?:string;navigation:string;controls:string;content:string;mainAttributes?:string;menuLabel?:string;hideChrome?:boolean};
/** One authenticated website layout for every role. HTML slots are built by escaped app renderers. */
export function shellMarkup(options:ShellContent):string {
 const look=new BaseMediaLook();
 return `<div class="app-shell${options.hideChrome?' shell-content-only':''}" data-cy="app-shell"><aside id="app-sidebar" data-cy="app-sidebar" ${options.hideChrome?'hidden':''}><button class="sidebar-close" data-cy="sidebar-close" aria-label="${look.text('nav_close')}">${shellIcon('x')}</button><a class="brand media-shell-brand" href="${options.home}">${new BaseMediaLook().brand()}<span>PrimeCare</span></a><p class="sidebar-role">${options.role}</p>${options.description?`<p class="sidebar-description">${options.description}</p>`:''}<nav aria-label="${look.text('nav_label')}">${options.navigation}</nav></aside><div class="workspace"><header class="topbar" data-cy="app-topbar" ${options.hideChrome?'hidden':''}><button class="menu" data-cy="sidebar-toggle" aria-controls="app-sidebar" aria-expanded="false" aria-label="${options.menuLabel??look.text('nav_open')}">${shellIcon('menu-2')}</button><div data-cy="global-navigation"></div><div class="shell-controls" data-cy="shell-controls">${options.controls}</div></header><main ${options.mainAttributes??''}>${options.content}</main></div></div>`;
}
const utilityRoots=new WeakSet<HTMLElement>();
const shells=new WeakMap<HTMLElement,ShellContent>();
export function renderShell(root:HTMLElement,options:ShellContent):void {
 applyMediaTokens();
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
 root.querySelector('[data-cy=app-shell]')!.classList.toggle('shell-content-only',options.hideChrome===true);
 root.querySelector<HTMLElement>('[data-cy=app-sidebar]')!.hidden=options.hideChrome===true;
 root.querySelector<HTMLElement>('[data-cy=app-topbar]')!.hidden=options.hideChrome===true;
 shells.set(root,options);
}
export function bindShell(root:HTMLElement,title:string,locale:NavigationLocale,scope:string,entries:()=>SearchEntry[],profileScope?:string,defaultTheme:Record<string,string>={}):void {
 if(!utilityRoots.has(root)){utilityRoots.add(root);root.addEventListener('keydown',event=>{if(event.key!=='Escape'||root.querySelector('dialog[open]'))return;const menu=root.querySelector<HTMLDetailsElement>('[data-cy=shell-utilities][open]');if(menu){event.preventDefault();menu.open=false;menu.querySelector<HTMLElement>('summary')?.focus();}});root.addEventListener('click',event=>{const menu=root.querySelector<HTMLDetailsElement>('[data-cy=shell-utilities][open]');if(menu&&event.target instanceof Node&&!menu.contains(event.target)&&!(event.target instanceof Element&&event.target.closest('dialog[open]')))menu.open=false;});}
 document.documentElement.lang=locale;
 const labels=media.locales[locale];
 root.querySelector('[data-cy=sidebar-toggle]')?.setAttribute('aria-label',labels.nav_open);
 root.querySelector('[data-cy=sidebar-close]')?.setAttribute('aria-label',labels.nav_close);
 root.querySelector('[data-cy=app-sidebar] nav')?.setAttribute('aria-label',labels.nav_label);
 applyMediaTokens();
 bindSidebar(root);
 mountNavigation(root.querySelector<HTMLElement>('[data-cy=global-navigation]')!,title,locale,scope,entries);
 if(profileScope)mountLayoutCustomizer(root,profileScope,locale,defaultTheme);
 for(const [selector,icon] of [['[data-cy=platform-account-link]','user-circle'],['[data-cy=platform-refresh]','refresh'],['[data-cy=platform-logout]','logout']] as const){const action=root.querySelector(selector);if(action&&!action.querySelector('svg'))action.insertAdjacentHTML('afterbegin',shellIcon(icon));}
}
