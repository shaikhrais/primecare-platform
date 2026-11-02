import registration from '../catalogs/theme-workspace.registration.json';
import {WorkspaceLayoutManager,defaultWorkspaceLayout,type WorkspaceHistory} from './workspace-layout';
import type {ThemeCenterLocale} from './layout-customizer';
/** Trusted host opt-in. Panel nodes must already be authorized and rendered by that host. */
export type WorkspaceCustomizerOptions={screenCode:'tenant_admin_command_center';panels:Record<string,HTMLElement>};
type Entry={scope:string;dialog?:HTMLDialogElement;manager?:WorkspaceLayoutManager;history?:WorkspaceHistory;wrapper?:HTMLElement;wrapperHidden?:boolean;handles:HTMLElement[];abort?:AbortController;observer?:MutationObserver};
const entries=new WeakMap<HTMLElement,Entry>();
export function prepareWorkspaceRender(root:HTMLElement):void {
 const e=entries.get(root);if(!e)return;
 e.history=e.manager?.history??e.history;e.abort?.abort();e.observer?.disconnect();e.manager?.dispose();e.manager=undefined;
 for(const handle of e.handles)handle.remove();e.handles=[];
 if(e.wrapper)e.wrapper.hidden=e.wrapperHidden??false;
}
export function clearWorkspaceCustomizer(root:HTMLElement):void {prepareWorkspaceRender(root);entries.delete(root);root.querySelector('[data-workspace-controls]')?.remove();for(const key of ['sidebar','width'])root.querySelector('[data-cy=appearance-'+key+']')?.closest('label')?.removeAttribute('hidden');}
export function mountWorkspaceCustomizer(root:HTMLElement,dialog:HTMLDialogElement,scope:string,locale:ThemeCenterLocale,options:WorkspaceCustomizerOptions):void {
 if(options.screenCode!==registration.host.screenCode)throw Error('Unregistered workspace host');
 let e=entries.get(root);if(e?.scope!==scope){clearWorkspaceCustomizer(root);e=undefined;}
 if(e?.manager){if(e.dialog===dialog)return;prepareWorkspaceRender(root);}
 e??={scope,handles:[]};entries.set(root,e);
 const shell=root.querySelector<HTMLElement>('[data-cy=app-shell]')!,wrapper=shell.querySelector<HTMLElement>('.workspace')!;
 const navigation=shell.querySelector<HTMLElement>('[data-cy=app-sidebar]')!,toolbar=shell.querySelector<HTMLElement>('[data-cy=app-topbar]')!,main=wrapper.querySelector<HTMLElement>('main')!;
 const footer=wrapper.querySelector<HTMLElement>('[data-cy=app-footer]')??undefined;
 const ids=Object.keys(options.panels),defaults=defaultWorkspaceLayout(ids);for(const p of Object.values(defaults.panels))p.dock='bottom';
 const resources=registration.resources as Record<string,Record<string,unknown>>;
 const text=(key:string)=>String(resources['themeWorkspace.'+key]?.[locale]??key);
 const control=(key:string)=>{const c=registration.controls.find(c=>!c.existingSelector&&c.key===key);if(!c)throw Error('Unregistered control');return c;};
 for(const panel of Object.values(options.panels))for(const kind of ['move','resize'] as const){const b=document.createElement('button');b.type='button';b.dataset.cy=control(kind).testId;b.setAttribute(kind==='move'?'data-layout-drag':'data-layout-resize','');b.textContent=text(kind);b.title=text('instructions');b.setAttribute('aria-label',text(kind)+'. '+text('instructions'));panel.prepend(b);e.handles.push(b);}
 const manager=new WorkspaceLayoutManager(shell,{navigation,toolbar,main,footer,panels:options.panels},'primecare-workspace:v1:'+encodeURIComponent(scope),undefined,defaults);
 e.manager=manager;e.dialog=dialog;e.wrapper=wrapper;e.wrapperHidden=wrapper.hidden;wrapper.hidden=true;
 if(e.history){try{manager.restoreHistory(e.history);}catch{e.history=undefined;}}
 const abort=new AbortController();e.abort=abort;
 // root replacement on logout must also release window listeners and detached DOM.
 e.observer=new MutationObserver(()=>{if(!root.contains(shell)||!root.isConnected)clearWorkspaceCustomizer(root);});e.observer.observe(root.ownerDocument,{childList:true,subtree:true});
 window.addEventListener('pagehide',event=>{if(!event.persisted)clearWorkspaceCustomizer(root);},{signal:abort.signal});
 dialog.querySelector('[data-workspace-controls]')?.remove();
 const group=document.createElement('fieldset');group.dataset.workspaceControls='';const legend=document.createElement('legend');legend.textContent=text('title');group.append(legend);
 const note=document.createElement('p');note.textContent=text('localOnly');group.append(note);
 const fields=new Map<string,HTMLInputElement|HTMLSelectElement>();
 for(const key of ['navigation','container','toolbar','toolbarStyle','footer','scroll','panel','dock','navigationWidth','maxWidth']){
  const c=control(key),label=document.createElement('label');label.append(text(key));let input:HTMLInputElement|HTMLSelectElement;
  if(c.allowedValues||key==='panel'){
   const select=document.createElement('select');input=select;
   const values=key==='panel'?ids:c.allowedValues!;
   for(const value of values){const option=document.createElement('option');option.value=value;option.textContent=key==='panel'?(options.panels[value].querySelector('h2,h3')?.textContent??value):text(key==='scroll'&&value==='content'?'contentScroll':value);select.append(option);}
  }else{input=document.createElement('input');input.type='number';input.min=key==='navigationWidth'?'160':'960';input.max=key==='navigationWidth'?'400':'1920';input.step='1';}
  input.dataset.cy=c.testId;input.disabled=key==='footer'&&!footer||(['panel','dock'].includes(key)&&!ids.length);label.append(input);group.append(label);fields.set(key,input);
 }
 const output=dialog.querySelector<HTMLOutputElement>('[data-cy=appearance-status]')!;
 const buttons=new Map<string,HTMLButtonElement>();
 const sync=()=>{const p=manager.current;for(const [key,input] of fields){if(key==='panel')continue;input.value=String(key==='dock'?p.panels[fields.get('panel')!.value]?.dock??'bottom':p[key as keyof typeof p]);}buttons.get('undo')!.disabled=!manager.canUndo;buttons.get('redo')!.disabled=!manager.canRedo;for(const handle of e!.handles)(handle as HTMLButtonElement).disabled=shell.dataset.narrow==='true';};
 const run=(work:()=>void,error='invalid')=>{try{work();output.value='';sync();}catch{output.value=text(error);sync();}};
 for(const [key,input] of fields)input.addEventListener('change',()=>{if(key==='panel'){sync();return;}run(()=>{if(key==='dock')manager.dockPanel(fields.get('panel')!.value,input.value as never);else manager.change({...manager.current,[key]:input instanceof HTMLInputElement?Number(input.value):input.value});});},{signal:abort.signal});
 for(const key of ['undo','redo','reset','save','export','close']){const b=document.createElement('button');b.type='button';b.dataset.cy=control(key).testId;b.textContent=text(key);buttons.set(key,b);group.append(b);b.addEventListener('click',()=>{if(key==='close'){dialog.close();return;}run(()=>{if(key==='save'){manager.save();}else if(key==='export'){const url=URL.createObjectURL(new Blob([manager.exportJson()],{type:'application/json'}));const link=document.createElement('a');link.href=url;link.download='PrimeCare_Workspace.json';link.click();setTimeout(()=>URL.revokeObjectURL(url),1000);}else manager[key as 'undo'|'redo'|'reset']();},key==='save'?'saveFailed':'invalid');if(key==='save'&&!output.value)output.value=text('savedLocal');},{signal:abort.signal});}
 const label=document.createElement('label');label.textContent=text('import');const file=document.createElement('input');file.type='file';file.accept='.json,application/json';file.dataset.cy=control('import').testId;label.append(file);group.append(label);
 file.addEventListener('change',async()=>{try{const f=file.files?.[0];if(!f||f.size>32768)throw Error();const source=await f.text();if(abort.signal.aborted)return;run(()=>manager.importJson(source));}catch{if(!abort.signal.aborted)output.value=text('invalid');}finally{file.value='';}},{signal:abort.signal});
 dialog.querySelector('form')!.prepend(group);
 // Advanced workspace controls own placement; the legacy XML profile retains colors/density.
 for(const key of ['sidebar','width'])dialog.querySelector<HTMLElement>('[data-cy=appearance-'+key+']')?.closest('label')?.setAttribute('hidden','');
 for(const c of registration.controls){const element=root.querySelector<HTMLElement>('[data-cy='+c.testId+']');if(element){element.dataset.controlId=String(c.controlId);element.dataset.implementationTag=c.key==='footer'&&!footer?'registered-unimplemented':'implemented-unverified';element.dataset.apiTag='local-only';element.dataset.testTag='isolated-browser';element.dataset.reviewTag='pending';}}
 shell.addEventListener('primecare:workspace-layout',sync,{signal:abort.signal});sync();
}
