import {cleanupOwnedResources} from './theme-control-base';
import {buildWorkspaceNavigation,flattenWorkspaceNavigation,activeWorkspaceDestination,type NavigationAuthority,type NavigationFamily,type NavigationMode,type WorkspaceNavigationNode} from '../../domain/src/workspace_navigation';
import type {WorkspaceLayout} from '../../domain/src/workspace_layout';
import {workspaceNavigationStyles} from './workspace-navigation-styles';
export {buildWorkspaceNavigation,activeWorkspaceDestination,navigationPreset} from '../../domain/src/workspace_navigation';
export type {NavigationAuthority,NavigationFamily,NavigationMode,WorkspaceNavigationNode};
export type WorkspaceNavigationOptions={scope:string;items:unknown;authority:NavigationAuthority;currentRoute:string;family:NavigationFamily;mode?:NavigationMode;pinned?:boolean;labels:{navigation:string;open:string;close:string;pin:string;unpin:string};onNavigate:(route:string)=>void;renderIcon?:(id:string)=>Element;frame?:{element:HTMLElement;profile:()=>WorkspaceLayout}};
let sequence=0;
const navigationOwners=new WeakSet<HTMLElement>();
/** Optional, data-bound navigation factory. No production shell opts in here. */
export class WorkspaceNavigationView {
 private options!:WorkspaceNavigationOptions;
 private nodes:readonly WorkspaceNavigationNode[]=[];
 private expanded=new Set<string>();
 private selected?:string;
 private pinned=true;
 private drawer=false;
 private disposed=false;
 private epoch=0;private updates=0;
 private prefix='primecare-navigation-'+(++sequence)+'-';
 private events=new AbortController();
 private renderEvents=new AbortController();
 private observer:MutationObserver|undefined;
 private portal:HTMLDivElement;
 constructor(private host:HTMLElement,options:WorkspaceNavigationOptions){
  if(!host.isConnected)throw Error('Mount navigation in a connected host');
  if(navigationOwners.has(host))throw Error('Navigation already managed');
  this.portal=host.ownerDocument.createElement('div');this.portal.dataset.workspaceNavigation='';this.portal.dataset.workspaceNavigationPortal='';Object.assign(this.portal.style,{position:'fixed',inset:'0',pointerEvents:'none',zIndex:'100',background:'transparent'});host.ownerDocument.body.append(this.portal);
  navigationOwners.add(host);
  try{this.update(options);
  const doc=host.ownerDocument,win=doc.defaultView!,signal=this.events.signal;
  if(!doc.querySelector('[data-workspace-navigation-styles]')){const style=doc.createElement('style');style.dataset.workspaceNavigationStyles='';style.textContent=workspaceNavigationStyles;doc.head.append(style);}
  doc.addEventListener('pointerdown',event=>{if(event.target instanceof Node&&!host.contains(event.target)&&!this.portal.contains(event.target)){if(this.options.family!=='vertical'||this.drawer){this.expanded.clear();this.drawer=false;this.render();}}},{signal});
  options.frame?.element.addEventListener('primecare:workspace-layout',()=>this.syncExpansion(),{signal});
  host.addEventListener('keydown',this.keydown,{signal});this.portal.addEventListener('keydown',this.keydown,{signal});
  host.addEventListener('pointerenter',()=>{this.syncExpansion();},{signal});
  host.addEventListener('pointerleave',()=>{this.syncExpansion();},{signal});
  host.addEventListener('focusin',()=>this.syncExpansion(),{signal});
  host.addEventListener('focusout',()=>queueMicrotask(()=>{if(!this.disposed)this.syncExpansion();}),{signal});
  win.addEventListener('pointermove',()=>{if(this.options.family==='vertical'&&this.options.mode==='folded')this.syncExpansion();},{signal,passive:true});
  win.addEventListener('resize',()=>{if(!this.narrow)this.drawer=false;this.render();},{signal});
  win.addEventListener('pagehide',event=>{if(!event.persisted)this.dispose();},{signal});
  this.observer=new MutationObserver(()=>{if(!host.isConnected)this.dispose();});this.observer.observe(doc,{childList:true,subtree:true});
  }catch(error){try{this.dispose();}catch{}throw error;}
 }
 get presentation(){return {family:this.options.family,mode:this.options.mode??'expanded',pinned:this.pinned};}
 private get narrow(){return this.host.ownerDocument.defaultView!.matchMedia('(max-width:1024px)').matches;}
 update(next:WorkspaceNavigationOptions):void{
  if(this.disposed)throw Error('Navigation disposed');const update=++this.updates;
  try{this.applyOptions(next);}catch(error){
   if(this.disposed||update!==this.updates)throw error;
   this.nodes=[];this.expanded.clear();this.selected=undefined;this.drawer=false;this.epoch++;this.renderEvents.abort();
   for(const link of [...this.host.querySelectorAll('a'),...this.portal.querySelectorAll('a')])link.removeAttribute('href');
   this.host.replaceChildren();this.portal.replaceChildren();this.portal.hidden=true;throw error;
  }
 }
 private applyOptions(next:WorkspaceNavigationOptions):void{
  if(this.disposed)throw Error('Navigation disposed');
  if(!next.scope.trim()||!['vertical','horizontal-header','horizontal-footer'].includes(next.family)||!['expanded','folded','rail'].includes(next.mode??'expanded')||Object.values(next.labels).some(v=>typeof v!=='string'||!v.trim()))throw Error('Invalid navigation presentation');
  if(this.options&&this.options.frame?.element!==next.frame?.element)throw Error('Remount when replacing the workspace frame');
  const nodes=buildWorkspaceNavigation(next.items,next.authority);activeWorkspaceDestination(nodes,next.currentRoute);
  const changed=this.options?.scope!==next.scope,routeChanged=this.options?.currentRoute!==next.currentRoute;
  this.options={...next,labels:{...next.labels}};this.nodes=nodes;
  const groups=flattenWorkspaceNavigation(nodes).filter(n=>n.kind==='group'&&!n.disabled).map(n=>n.id);
  this.expanded=changed?new Set():new Set([...this.expanded].filter(id=>groups.includes(id)));
  if(changed){this.pinned=next.pinned??true;this.selected=undefined;this.drawer=false;}
  else if(next.pinned!==undefined)this.pinned=next.pinned;
  if(routeChanged)this.selected=undefined;
  const active=activeWorkspaceDestination(nodes,next.currentRoute);
  const contains=(n:WorkspaceNavigationNode):boolean=>n.id===active||n.children.some(contains);
  if(!nodes.some(n=>n.id===this.selected&&!n.disabled))this.selected=nodes.find(n=>n.kind==='group'&&!n.disabled&&contains(n))?.id??nodes.find(n=>n.kind==='group'&&!n.disabled)?.id;
  this.render();
 }
 private syncExpansion(){if(this.disposed)return;const expanded=this.pinned||this.host.matches(':hover')||this.host.contains(this.host.ownerDocument.activeElement);this.host.dataset.expanded=String(expanded);const frame=this.options.frame;if(frame)frame.element.style.setProperty('--pc-nav-width',(this.options.family==='vertical'&&this.options.mode==='folded'&&!expanded&&!this.narrow?64:frame.profile().navigationWidth)+'px');}
 private button(label:string,work:()=>void):HTMLButtonElement{
  const epoch=this.epoch,b=this.host.ownerDocument.createElement('button');b.type='button';b.textContent=label;b.addEventListener('click',()=>{if(!this.disposed&&epoch===this.epoch)work();},{signal:this.renderEvents.signal});return b;
 }
 private content(element:HTMLElement,node:WorkspaceNavigationNode){
  if(node.icon&&this.options.renderIcon){const icon=this.options.renderIcon(node.icon);icon.setAttribute('aria-hidden','true');element.append(icon);}
  const copy=this.host.ownerDocument.createElement('span');copy.dataset.navCopy='';const label=this.host.ownerDocument.createElement('span');label.textContent=node.label;copy.append(label);
  if(node.subtitle){const subtitle=this.host.ownerDocument.createElement('small');subtitle.textContent=node.subtitle;copy.append(subtitle);}element.append(copy);
  if(node.badge){const badge=this.host.ownerDocument.createElement('span');badge.dataset.navBadge='';badge.textContent=node.badge;element.append(badge);}
  element.setAttribute('aria-label',node.label+(node.subtitle?'. '+node.subtitle:'')+(node.badge?'. '+node.badge:''));element.dataset.navigationId=node.id;element.title=node.label;
 }
 private render(){
  if(this.disposed)return;
  const focused=(this.host.contains(this.host.ownerDocument.activeElement)||this.portal.contains(this.host.ownerDocument.activeElement))?(this.host.ownerDocument.activeElement as HTMLElement).dataset.navigationId:undefined;
  // Revoke the old DOM's callbacks and destinations before detaching it.
  for(const link of [...this.host.querySelectorAll('a'),...this.portal.querySelectorAll('a')])link.removeAttribute('href');this.portal.replaceChildren();this.renderEvents.abort();this.renderEvents=new AbortController();this.epoch++;
  const doc=this.host.ownerDocument,epoch=this.epoch,active=activeWorkspaceDestination(this.nodes,this.options.currentRoute),root=doc.createElement('nav');root.setAttribute('aria-label',this.options.labels.navigation);
  this.host.dataset.workspaceNavigation='';this.host.dataset.family=this.options.family;this.host.dataset.mode=this.options.mode??'expanded';this.host.dataset.drawerOpen=String(this.drawer);
  const open=this.button(this.options.labels.open,()=>{this.drawer=true;this.render();rootFocus();});open.dataset.navOpen='';open.dataset.cy='workspace-navigation-open';open.setAttribute('aria-expanded',String(this.drawer));
  const close=this.button(this.options.labels.close,()=>{this.drawer=false;this.render();this.host.querySelector<HTMLButtonElement>('[data-nav-open]')?.focus();});close.dataset.navClose='';close.dataset.cy='workspace-navigation-close';
  const backdrop=this.button(this.options.labels.close,()=>{this.drawer=false;this.render();this.host.querySelector<HTMLButtonElement>('[data-nav-open]')?.focus();});backdrop.dataset.navBackdrop='';backdrop.tabIndex=-1;
  const rootFocus=()=>this.host.querySelector<HTMLButtonElement>('[data-nav-close]')?.focus();
  root.append(close);
  if(this.options.family==='vertical'&&this.options.mode==='folded'){
   const pin=this.button(this.pinned?this.options.labels.unpin:this.options.labels.pin,()=>{this.pinned=!this.pinned;this.render();this.host.querySelector<HTMLButtonElement>('[data-nav-pin]')?.focus();});pin.dataset.navPin='';pin.dataset.cy='workspace-navigation-pin';pin.setAttribute('aria-pressed',String(this.pinned));root.append(pin);
  }
  const list=(nodes:readonly WorkspaceNavigationNode[]):HTMLUListElement=>{
   const ul=doc.createElement('ul');for(const node of nodes){const li=doc.createElement('li');ul.append(li);
    if(node.kind==='item'){
     const action=node.disabled?this.button(node.label,()=>{}):doc.createElement('a');this.content(action,node);
     if(action instanceof HTMLAnchorElement){action.href=node.route!;if(node.id===active)action.setAttribute('aria-current','page');action.addEventListener('click',event=>{
      if(event.ctrlKey||event.metaKey||event.shiftKey||event.altKey)return;event.preventDefault();
      const current=flattenWorkspaceNavigation(this.nodes).find(n=>n.id===node.id);
      if(this.disposed||epoch!==this.epoch||!current?.route||current.disabled)return;
      this.drawer=false;this.expanded.clear();this.render();this.options.onNavigate(current.route);
     },{signal:this.renderEvents.signal});}else{action.disabled=true;action.setAttribute('aria-disabled','true');}
     action.dataset.cy='workspace-navigation-item';li.append(action);
    }else{
     const toggle=this.button('',()=>{if(this.expanded.has(node.id))this.expanded.delete(node.id);else this.expanded.add(node.id);this.render();this.nodeElement(node.id)?.focus();});this.content(toggle,node);toggle.disabled=node.disabled;toggle.dataset.cy='workspace-navigation-group';toggle.dataset.navGroup='';toggle.setAttribute('aria-expanded',String(this.expanded.has(node.id)));toggle.setAttribute('aria-controls',this.prefix+node.id);
     const children=list(node.children);children.dataset.navChildren='';children.dataset.parentId=node.id;children.id=this.prefix+node.id;children.hidden=!this.expanded.has(node.id);li.append(toggle,children);
    }
   }return ul;
  };
  if(this.options.family==='vertical'&&this.options.mode==='rail'){
   const tabs=doc.createElement('div');tabs.setAttribute('role','tablist');tabs.setAttribute('aria-label',this.options.labels.navigation);tabs.setAttribute('aria-orientation','vertical');
   for(const node of this.nodes.filter(n=>n.kind==='group')){const tab=this.button('',()=>{this.selected=node.id;this.render();this.nodeElement(node.id)?.focus();});this.content(tab,node);tab.disabled=node.disabled;tab.setAttribute('role','tab');tab.id=this.prefix+'tab-'+node.id;tab.setAttribute('aria-selected',String(this.selected===node.id));tab.setAttribute('aria-controls',this.prefix+'rail-panel');tab.tabIndex=this.selected===node.id?0:-1;tabs.append(tab);}root.append(tabs);
   const panel=doc.createElement('div');panel.id=this.prefix+'rail-panel';panel.setAttribute('role','tabpanel');const selected=this.nodes.find(n=>n.id===this.selected&&!n.disabled);if(selected){panel.setAttribute('aria-labelledby',this.prefix+'tab-'+selected.id);panel.append(list(selected.children));}root.append(panel,list(this.nodes.filter(n=>n.kind==='item')));
  }else root.append(list(this.nodes));
  if(this.disposed||epoch!==this.epoch)return;
  this.host.replaceChildren(open,backdrop,root);this.syncExpansion();
  if(this.disposed||epoch!==this.epoch)return;
  this.portal.hidden=false;this.portal.dataset.family=this.options.family;this.portal.dir=getComputedStyle(this.host).direction;
  if(!this.narrow&&this.options.family!=='vertical')for(const panel of root.querySelectorAll<HTMLElement>('nav > ul > li > [data-nav-children]')){
   if(panel.hidden)continue;const trigger=panel.previousElementSibling!.getBoundingClientRect(),win=doc.defaultView!;
   this.portal.append(panel);Object.assign(panel.style,{position:'fixed',pointerEvents:'auto',insetInlineStart:'auto',insetInlineEnd:'auto',top:this.options.family==='horizontal-footer'?'auto':trigger.bottom+'px',bottom:this.options.family==='horizontal-footer'?win.innerHeight-trigger.top+'px':'auto'});
   panel.style.maxHeight=Math.max(44,this.options.family==='horizontal-footer'?trigger.top-8:win.innerHeight-trigger.bottom-8)+'px';
   const width=panel.getBoundingClientRect().width,left=this.portal.dir==='rtl'?trigger.right-width:trigger.left;
   panel.style.left=Math.max(8,Math.min(left,win.innerWidth-width-8))+'px';
  }
  this.portal.hidden=!this.portal.children.length;
  const target=focused?this.nodeElement(focused):null;if(target?.getClientRects().length)target.focus({preventScroll:true});else if(focused&&this.narrow)this.host.querySelector<HTMLButtonElement>('[data-nav-open]')?.focus();
 }
 private nodeElement(id:string){return [...this.host.querySelectorAll<HTMLElement>('[data-navigation-id]'),...this.portal.querySelectorAll<HTMLElement>('[data-navigation-id]')].find(e=>e.dataset.navigationId===id);}
 private keydown=(event:KeyboardEvent)=>{
  const el=event.target as HTMLElement;if(!this.host.contains(el)&&!this.portal.contains(el))return;
  const nav=this.host.querySelector('nav')!,visible=(root:Element)=>[...root.querySelectorAll<HTMLElement>('a[href],button:not(:disabled)')].filter(e=>e.getClientRects().length);
  const id=el.dataset.navigationId,group=el.hasAttribute('data-nav-group'),parent=el.closest<HTMLElement>('[data-nav-children]');
  const rtl=getComputedStyle(this.host).direction==='rtl',forward=rtl?'ArrowLeft':'ArrowRight',back=rtl?'ArrowRight':'ArrowLeft';
  const handled=()=>{event.preventDefault();event.stopPropagation();};
  if(event.key==='Tab'&&this.narrow&&this.drawer){const items=visible(nav),first=items[0],last=items.at(-1);if(event.shiftKey&&el===first){handled();last?.focus();}else if(!event.shiftKey&&el===last){handled();first?.focus();}return;}
  if(event.key==='Tab'&&!this.narrow){
   const rootPanel=[...this.portal.children].find(panel=>panel.contains(el)) as HTMLElement|undefined;
   if(group&&id&&this.expanded.has(id)&&!event.shiftKey){const panel=this.host.ownerDocument.getElementById(this.prefix+id);const first=panel?visible(panel)[0]:null;if(first){handled();first.focus();return;}}
   if(rootPanel){const items=visible(rootPanel),first=items[0],last=items.at(-1),rootId=rootPanel.dataset.parentId!;
    if(event.shiftKey&&el===first||!event.shiftKey&&el===last){handled();this.expanded.delete(rootId);this.render();
     if(event.shiftKey)this.nodeElement(rootId)?.focus();else{const roots=visible(this.host.querySelector('nav')!).filter(e=>e.dataset.navigationId&&!e.closest('[data-nav-children]')),i=roots.findIndex(e=>e.dataset.navigationId===rootId);roots[(i+1)%roots.length]?.focus();}return;}
   }
  }
  if(event.key==='Escape'){
   if(parent?.dataset.parentId){handled();this.expanded.delete(parent.dataset.parentId);this.render();this.nodeElement(parent.dataset.parentId)?.focus();}
   else if(group&&id&&this.expanded.has(id)){handled();this.expanded.delete(id);this.render();this.nodeElement(id)?.focus();}
   else if(this.drawer){handled();this.drawer=false;this.render();this.host.querySelector<HTMLButtonElement>('[data-nav-open]')?.focus();}
   return;
  }
  if(el.getAttribute('role')==='tab'&&['ArrowUp','ArrowDown',forward,back,'Home','End'].includes(event.key)){
   const items=[...nav.querySelectorAll<HTMLButtonElement>('[role=tab]:not(:disabled)')];let index=items.indexOf(el as HTMLButtonElement);
   index=event.key==='Home'?0:event.key==='End'?items.length-1:(index+(['ArrowDown',forward].includes(event.key)?1:-1)+items.length)%items.length;
   if(items[index]){handled();this.selected=items[index].dataset.navigationId;this.render();this.nodeElement(this.selected!)?.focus();}return;
  }
  if(group&&id&&(event.key===forward||(this.options.family!=='vertical'&&!parent&&['ArrowDown','ArrowUp'].includes(event.key)))){
   handled();this.expanded.add(id);this.render();const children=this.host.ownerDocument.getElementById(this.prefix+id);const items=children?visible(children):[];(event.key==='ArrowUp'?items.at(-1):items[0])?.focus();return;
  }
  if(event.key===back&&(parent||group&&id&&this.expanded.has(id))){handled();const closeId=parent?.dataset.parentId??id!;this.expanded.delete(closeId);this.render();this.nodeElement(closeId)?.focus();return;}
  const horizontal=this.options.family!=='vertical'&&!parent&&!this.narrow;
  const prev=horizontal?back:'ArrowUp',next=horizontal?forward:'ArrowDown';
  if([prev,next,'Home','End'].includes(event.key)){
   const items=horizontal?visible(nav).filter(e=>!e.closest('[data-nav-children]')):visible(this.portal.contains(el)?this.portal:nav);const i=items.indexOf(el);
   if(i<0||!items.length)return;handled();items[event.key==='Home'?0:event.key==='End'?items.length-1:(i+(event.key===next?1:-1)+items.length)%items.length]?.focus();
  }
 };
 dispose(){if(this.disposed)return;this.disposed=true;this.epoch++;cleanupOwnedResources([()=>this.events.abort(),()=>this.renderEvents.abort(),()=>this.observer?.disconnect(),...[...this.host.querySelectorAll('a'),...this.portal.querySelectorAll('a')].map(link=>()=>link.removeAttribute('href')),()=>this.portal.remove(),()=>this.host.replaceChildren(),()=>{if(this.options?.frame)this.options.frame.element.style.setProperty('--pc-nav-width',this.options.frame.profile().navigationWidth+'px');},...['workspaceNavigation','family','mode','expanded','drawerOpen'].map(name=>()=>{delete this.host.dataset[name];}),()=>{this.nodes=[];this.expanded.clear();this.selected=undefined;},()=>{navigationOwners.delete(this.host);}]);}
}
