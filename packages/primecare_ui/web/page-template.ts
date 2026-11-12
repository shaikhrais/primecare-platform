import {ThemeControlBase} from './theme-control-base';
import {buildPageRoutes,resolvePageRoute,type RegisteredPageRoute,type PageAuthority} from '../../domain/src/page_template';
import {pageTemplateStyles} from './page-template-styles';
import {PageWorkspaceChrome} from './page-workspace-chrome';
export * from '../../domain/src/page_template';
export {PageWorkspaceChrome};
export type PageSlots={content:HTMLElement;header?:HTMLElement;actions?:HTMLElement;left?:HTMLElement;right?:HTMLElement};
export type PageLabels={breadcrumbs:string;openLeft:string;closeLeft:string;openRight:string;closeRight:string};
export type PageOptions={scope:string;routes:unknown;authority:PageAuthority;currentRoute:string;labels:PageLabels;onNavigate:(route:string)=>void;chrome?:PageWorkspaceChrome};
type Side='left'|'right';
/** Exclusive, optional page host. Supplied business slots remain owned and authorized by the caller. */
export class PageTemplateView extends ThemeControlBase {
 private options!:PageOptions;private route?:RegisteredPageRoute;private slots!:PageSlots;
 private open={left:false,right:false};private events=new AbortController();
 private sides={} as Record<Side,HTMLElement>;private controls={} as Record<Side,HTMLButtonElement>;
 private dialogs={} as Record<Side,HTMLDialogElement>;private body!:HTMLElement;private content!:HTMLElement;
 private narrow:boolean;private epoch=0;private title:string;private changedTitle?:string;
 constructor(root:HTMLElement,slots:PageSlots,options:PageOptions){
  super(root);
  if(root.hasAttribute('data-pc-page'))throw Error('Page already managed');this.title=root.ownerDocument.title;this.narrow=this.window.innerWidth<=1024;
  const doc=root.ownerDocument;if(!doc.querySelector('[data-pc-page-styles]')){const s=doc.createElement('style');s.dataset.pcPageStyles='';s.textContent=pageTemplateStyles;doc.head.append(s);}
  try{this.window.addEventListener('resize',this.resize,{signal:this.abort.signal});this.update(options,slots);}
  catch(error){this.events.abort();this.endControlScope();throw error;}
 }
 private get window(){return this.root.ownerDocument.defaultView!;}
 private temporary(side:Side){const mode=this.route!.layout[side].mode;return mode==='temporary'||mode==='responsive'&&this.narrow;}
 private element<K extends keyof HTMLElementTagNameMap>(tag:K,attr?:string){const el=this.root.ownerDocument.createElement(tag);if(attr)el.setAttribute(attr,'');return el;}
 private revokeLinks(){for(const a of this.root.querySelectorAll('[data-pc-page-breadcrumbs] a'))a.removeAttribute('href');}
 private clear(){this.epoch++;this.closeDialogs();this.revokeLinks();this.events.abort();this.events=new AbortController();this.root.replaceChildren();this.root.removeAttribute('data-pc-page');this.route=undefined;this.options?.chrome?.apply({navigation:true,toolbar:true,footer:true});if(this.changedTitle===this.root.ownerDocument.title)this.root.ownerDocument.title=this.title;this.changedTitle=undefined;}
 update(options:PageOptions,slots:PageSlots=this.slots):void{
  if(this.dead)throw Error('Page disposed');
  try{
   if(!options.scope.trim()||Object.values(options.labels).some(s=>typeof s!=='string'||!s.trim()))throw Error('Page scope and registered labels required');
   const routes=buildPageRoutes(options.routes,options.authority),route=resolvePageRoute(routes,options.currentRoute);
   const identity=(p:RegisteredPageRoute|undefined)=>p?`${p.id}:${p.route}`:'';
   const changed=this.options&&(options.scope!==this.options.scope||identity(route)!==identity(this.route));
   if(changed&&route&&this.slots&&slots?.content===this.slots.content)throw Error('A different route or actor requires a fresh authorized content slot');
   const elements=Object.values(slots??{});if(!slots?.content||new Set(elements).size!==elements.length||elements.some(el=>el===this.root||elements.some(other=>other!==el&&other.contains(el))))throw Error('Distinct page slots required');
   const same=!!this.route&&!changed;const previousTemporary={left:this.route?this.temporary('left'):false,right:this.route?this.temporary('right'):false};const oldScroll={page:this.root.scrollTop,content:this.content?.scrollTop??0};
   this.closeDialogs();this.revokeLinks();this.events.abort();this.events=new AbortController();this.epoch++;
   if(this.options?.chrome!==options.chrome)this.options?.chrome?.apply({navigation:true,toolbar:true,footer:true});
   this.options=options;this.slots=slots;this.route=route;
   if(!route){this.clear();return;}
   if(!same)this.open={left:route.layout.left.open&&!this.temporary('left'),right:route.layout.right.open&&!this.temporary('right')};else for(const side of ['left','right'] as const)if(this.temporary(side)&&!previousTemporary[side])this.open[side]=false;
   this.render();if(same){this.root.scrollTop=oldScroll.page;this.content.scrollTop=oldScroll.content;}else{this.root.scrollTop=0;this.content.scrollTop=0;if(route.layout.scroll==='normal')this.window.scrollTo(0,0);this.root.querySelector<HTMLElement>('[data-pc-page-heading]')?.focus({preventScroll:true});}
  }catch(error){this.clear();throw error;}
 }
 private render(){
  const route=this.route!,doc=this.root.ownerDocument,active=doc.activeElement as HTMLElement|null;
  const header=this.element('header','data-pc-page-header'),heading=this.element('div'),h=this.element('h1','data-pc-page-heading');h.textContent=route.title;h.tabIndex=-1;
  const crumbs=this.element('nav','data-pc-page-breadcrumbs');crumbs.setAttribute('aria-label',this.options.labels.breadcrumbs);const list=this.element('ol');crumbs.append(list);
  const epoch=this.epoch;
  for(const crumb of route.breadcrumbs){const li=this.element('li');if(crumb.route){const a=this.element('a');a.textContent=crumb.label;a.href=crumb.route;a.addEventListener('click',e=>{e.preventDefault();if(!this.dead&&epoch===this.epoch&&this.route?.breadcrumbs.some(c=>c.id===crumb.id&&c.route===crumb.route))this.options.onNavigate(crumb.route!);},{signal:this.events.signal});li.append(a);}else{li.textContent=crumb.label;li.setAttribute('aria-current','page');}list.append(li);}
  heading.append(h,crumbs);if(this.slots.header)heading.append(this.slots.header);const actions=this.element('div','data-pc-page-controls');if(this.slots.actions)actions.append(this.slots.actions);header.append(heading,actions);
  this.body=this.element('div','data-pc-page-row');const center=this.element('section','data-pc-page-center');this.content=this.element('div','data-pc-page-content');this.content.append(this.slots.content);center.append(this.content);
  for(const side of ['left','right'] as const){
   const config=route.layout[side],host=this.element('aside','data-pc-page-side');host.dataset.pcPageSide=side;host.style.width=config.width+'px';this.sides[side]=host;if(this.slots[side])host.append(this.slots[side]!);
   const button=this.element('button');button.type='button';button.dataset.pageToggle=side;button.hidden=!this.slots[side]||config.mode==='none';button.addEventListener('click',()=>this.toggle(side),{signal:this.events.signal});this.controls[side]=button;actions.append(button);
  }
  this.body.append(this.sides.left,center,this.sides.right);this.root.replaceChildren(header,this.body);this.root.dataset.pcPage='';this.root.dataset.template=route.layout.template;this.root.dataset.scroll=route.layout.scroll;
  this.root.style.setProperty('--pc-page-direction',this.window.getComputedStyle(this.root).direction);this.options.chrome?.apply(route.layout.chrome);doc.title=route.title;this.changedTitle=route.title;
  for(const side of ['left','right'] as const)this.place(side);
  if(active?.isConnected&&!active.closest('[hidden]'))active.focus({preventScroll:true});
 }
 private place(side:Side){
  if(!this.route)return;const config=this.route.layout[side],visible=!!this.slots[side]&&config.mode!=='none'&&this.open[side],button=this.controls[side];
  button.textContent=this.options.labels[(visible?'close':'open')+(side==='left'?'Left':'Right') as keyof PageLabels];button.setAttribute('aria-expanded',String(visible));
  this.sides[side].hidden=!visible||this.temporary(side);
  if(visible&&this.temporary(side))this.showDialog(side);
 }
 toggle(side:Side):void{if(this.dead||!this.route||!this.slots[side]||this.route.layout[side].mode==='none')return;this.open[side]=!this.open[side];if(!this.open[side])this.closeDialog(side);this.place(side);}
 private showDialog(side:Side){
  if(this.dialogs[side])return;const other=side==='left'?'right':'left';if(this.dialogs[other]){this.open[other]=false;this.closeDialog(other);this.place(other);}
  const dialog=this.element('dialog');dialog.dataset.pcPageDialog=side;dialog.style.width=this.route!.layout[side].width+'px';dialog.setAttribute('aria-label',this.options.labels[side==='left'?'closeLeft':'closeRight']);
  const close=this.element('button');close.type='button';close.textContent=this.options.labels[side==='left'?'closeLeft':'closeRight'];close.addEventListener('click',()=>this.toggle(side),{signal:this.events.signal});dialog.append(close,this.slots[side]!);this.root.ownerDocument.body.append(dialog);this.dialogs[side]=dialog;
  dialog.addEventListener('cancel',e=>{e.preventDefault();this.toggle(side);},{signal:this.events.signal});
  dialog.addEventListener('keydown',e=>{if(e.key!=='Tab')return;const targets=[...dialog.querySelectorAll<HTMLElement>('button:not(:disabled),a[href],input:not(:disabled),select:not(:disabled),textarea:not(:disabled),[tabindex="0"]')].filter(el=>el.getClientRects().length&&!el.closest('[hidden],[inert]'));const first=targets[0],last=targets.at(-1);if(e.shiftKey&&this.root.ownerDocument.activeElement===first){e.preventDefault();last?.focus();}else if(!e.shiftKey&&this.root.ownerDocument.activeElement===last){e.preventDefault();first?.focus();}},{signal:this.events.signal});dialog.showModal();close.focus();
 }
 private closeDialog(side:Side){const dialog=this.dialogs[side];if(!dialog)return;const slot=this.slots[side];if(slot)this.sides[side]?.append(slot);dialog.close();dialog.remove();delete this.dialogs[side];this.controls[side]?.focus({preventScroll:true});}
 private closeDialogs(){for(const side of ['left','right'] as const)this.closeDialog(side);}
 private resize=()=>{if(!this.route||this.dead)return;const narrow=this.window.innerWidth<=1024;if(narrow!==this.narrow){this.closeDialogs();this.narrow=narrow;for(const side of ['left','right'] as const){if(this.temporary(side))this.open[side]=false;this.place(side);}}};
 dispose():void{if(this.dead)return;this.clear();this.endControlScope();}
}
