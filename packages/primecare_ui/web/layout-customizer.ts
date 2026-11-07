import {mountWorkspaceCustomizer,clearWorkspaceCustomizer,type WorkspaceCustomizerOptions} from './workspace-customizer';
import {shellIcon} from './icons';
import {PersonalThemeLibrary} from './theme-library';
import {mountThemeCenter} from './theme-center';
import {BaseLayoutManager} from './layout-manager';
export type ThemeCenterLocale='en'|'fr'|'es';
const managers=new WeakMap<HTMLElement,{scope:string|null;locale:ThemeCenterLocale;manager:BaseLayoutManager;library:PersonalThemeLibrary|null;abort?:AbortController;observer?:MutationObserver;owns?:()=>boolean}>();
/** Default-only ownership for public/raw renderers. The account customizer replaces this
 * entry only after the renderer supplies its verified profile scope. No device-wide
 * personal preferences are loaded, and a second layout manager is never installed. */
export function mountPresentationLayout(root:HTMLElement,defaultTheme:Record<string,string>={}):BaseLayoutManager {
 let entry=managers.get(root);
 if(!entry){entry={scope:null,locale:'en',manager:new BaseLayoutManager(root,null,()=>root.querySelector<HTMLElement>('.app-shell')??root),library:null};managers.set(root,entry);}
 if(entry.scope===null)entry.manager.setDefaultTheme(defaultTheme);else entry.manager.attach();
 return entry.manager;
}
/** End account-bound callbacks before a root, actor or appearance host is replaced. */
export function clearLayoutCustomizer(root:HTMLElement,expectedOwner?:()=>boolean):void {
 const entry=managers.get(root);if(!entry||expectedOwner&&entry.owns!==expectedOwner)return;
 entry.abort?.abort();entry.observer?.disconnect();managers.delete(root);clearWorkspaceCustomizer(root);
 for(const selector of ['[data-cy=appearance-open]','[data-cy=appearance-dialog]'])root.querySelector(selector)?.remove();
 entry.manager.dispose();
}
const labels={en:['Appearance','Theme and layout','Theme','Portal default','Light','Dark','Accent (optional #RRGGBB)','Sidebar','Left','Right','Navigation width','Expanded','Compact','Spacing','Comfortable','Content width (%)','Undo','Redo','Reset','Save','Export XML','Import XML','Close','Changes are live. Save keeps this profile for your account on this browser.','Saved on this browser.','Unable to apply or save this profile.'],fr:['Apparence','Thème et disposition','Thème','Valeur du portail','Clair','Sombre','Accent (facultatif #RRGGBB)','Barre latérale','Gauche','Droite','Largeur du menu','Développé','Compact','Espacement','Confortable','Largeur du contenu (%)','Annuler','Rétablir','Réinitialiser','Enregistrer','Exporter XML','Importer XML','Fermer','Les changements sont immédiats. Enregistrer conserve ce profil pour votre compte dans ce navigateur.','Enregistré dans ce navigateur.','Impossible d’appliquer ou d’enregistrer ce profil.'],es:['Apariencia','Tema y diseño','Tema','Valor del portal','Claro','Oscuro','Color (opcional #RRGGBB)','Barra lateral','Izquierda','Derecha','Ancho del menú','Expandido','Compacto','Espaciado','Cómodo','Ancho del contenido (%)','Deshacer','Rehacer','Restablecer','Guardar','Exportar XML','Importar XML','Cerrar','Los cambios son inmediatos. Guardar conserva este perfil para su cuenta en este navegador.','Guardado en este navegador.','No se pudo aplicar o guardar este perfil.']};
export function mountLayoutCustomizer(root:HTMLElement,scope:string,locale:ThemeCenterLocale,defaultTheme:Record<string,string>={},workspaceOptions?:WorkspaceCustomizerOptions,presentationCurrent?:()=>boolean):void {
 let entry=managers.get(root);if(entry&&entry.scope!==scope){clearLayoutCustomizer(root);entry=undefined;}if(!entry||entry.scope!==scope){entry={scope,locale,manager:new BaseLayoutManager(root,'primecare-layout:v1:'+encodeURIComponent(scope)),library:new PersonalThemeLibrary('primecare-themes:v1:'+encodeURIComponent(scope))};entry.manager.setPersonalTheme(entry.library!.active);managers.set(root,entry);}entry.owns=presentationCurrent;const manager=entry.manager;manager.setDefaultTheme(defaultTheme);manager.attach();
 if(entry.locale!==locale){entry.abort?.abort();entry.observer?.disconnect();root.querySelector('[data-cy=appearance-open]')?.remove();root.querySelector('[data-cy=appearance-dialog]')?.remove();entry.locale=locale;}
 if(root.querySelector('[data-cy=appearance-open]')){if(workspaceOptions)mountWorkspaceCustomizer(root,root.querySelector<HTMLDialogElement>('[data-cy=appearance-dialog]')!,scope,locale,workspaceOptions);return;}
 entry.abort?.abort();entry.observer?.disconnect();
 const abort=new AbortController();entry.abort=abort;
 // A tenant/language control refresh removes the opener, but the root-level dialog survives.
 root.querySelector('[data-cy=appearance-dialog]')?.remove();
 const text=labels[locale];const opener=document.createElement('button');opener.type='button';opener.dataset.cy='appearance-open';opener.textContent={en:'Theme Center',fr:'Centre des thèmes',es:'Centro de temas'}[locale];opener.insertAdjacentHTML('afterbegin',shellIcon('palette'));opener.setAttribute('aria-haspopup','dialog');(root.querySelector('[data-cy=shell-utility-actions]')??root.querySelector('.topbar'))!.append(opener);
 const dialog=document.createElement('dialog');dialog.className='layout-customizer';dialog.dataset.cy='appearance-dialog';dialog.setAttribute('aria-labelledby','appearance-title');
 dialog.innerHTML=`<h2 id="appearance-title">${text[1]}</h2><p>${text[23]}</p><form method="dialog"><label>${text[2]}<select data-cy="appearance-theme"><option value="default">${text[3]}</option><option value="light">${text[4]}</option><option value="dark">${text[5]}</option></select></label><label>${text[6]}<input data-cy="appearance-accent" maxlength="7" pattern="#[0-9a-fA-F]{6}"></label><label>${text[7]}<select data-cy="appearance-sidebar"><option value="left">${text[8]}</option><option value="right">${text[9]}</option></select></label><label>${text[10]}<select data-cy="appearance-navigation"><option value="expanded">${text[11]}</option><option value="compact">${text[12]}</option></select></label><label>${text[13]}<select data-cy="appearance-density"><option value="comfortable">${text[14]}</option><option value="compact">${text[12]}</option></select></label><label>${text[15]}<input type="range" data-cy="appearance-width" min="75" max="100" step="5"></label><div class="quick-links">${['undo','redo','reset','save','export'].map((id,i)=>`<button type="button" data-cy="appearance-${id}">${text[16+i]}</button>`).join('')}</div><label>${text[21]}<input type="file" accept=".xml,application/xml,text/xml" data-cy="appearance-import"></label><output role="status" data-cy="appearance-status"></output><button type="submit" data-cy="appearance-close">${text[22]}</button></form>`;
 root.append(dialog);
 const isCurrent=()=>!abort.signal.aborted&&managers.get(root)===entry&&root.isConnected&&root.contains(dialog)&&root.contains(opener)&&(!entry.owns||entry.owns());
 const canEdit=()=>isCurrent()&&(!entry.owns||dialog.open);let revision=0;const revisionNow=()=>entry.owns?revision:0;for(const event of ['close','cancel'])dialog.addEventListener(event,()=>{revision++;},{signal:abort.signal});
 entry.observer=new MutationObserver(()=>{if(!isCurrent()&&managers.get(root)===entry)clearLayoutCustomizer(root);});entry.observer.observe(root.ownerDocument,{childList:true,subtree:true});
 root.ownerDocument.defaultView?.addEventListener('pagehide',event=>{if(!event.persisted&&managers.get(root)===entry)clearLayoutCustomizer(root);},{signal:abort.signal});
 mountThemeCenter(dialog,manager,entry.library!,locale,canEdit,revisionNow);const element=(id:string)=>dialog.querySelector<HTMLInputElement|HTMLSelectElement>(`[data-cy=appearance-${id}]`)!;const output=dialog.querySelector<HTMLOutputElement>('[data-cy=appearance-status]')!;
 const sync=()=>{const p=manager.current;for(const [key,value] of Object.entries({theme:p.theme,accent:p.accent,sidebar:p.sidebar,navigation:p.navigation,density:p.density,width:p.contentWidth}))element(key).value=String(value);dialog.querySelector<HTMLButtonElement>('[data-cy=appearance-undo]')!.disabled=!manager.canUndo;dialog.querySelector<HTMLButtonElement>('[data-cy=appearance-redo]')!.disabled=!manager.canRedo;};
 const run=(work:()=>void)=>{if(!canEdit())return;try{work();output.value='';sync();}catch{output.value=text[25];}};
 opener.onclick=()=>{if(!isCurrent())return;sync();dialog.showModal();};dialog.addEventListener('close',()=>{if(isCurrent())opener.focus();},{signal:abort.signal});
 for(const field of ['theme','accent','sidebar','navigation','density','width'])element(field).addEventListener('change',()=>run(()=>manager.change({...manager.current,theme:element('theme').value,accent:element('accent').value,sidebar:element('sidebar').value,navigation:element('navigation').value,density:element('density').value,contentWidth:Number(element('width').value)})));
 for(const id of ['undo','redo','reset'] as const)dialog.querySelector<HTMLButtonElement>(`[data-cy=appearance-${id}]`)!.onclick=()=>run(()=>manager[id]());
 dialog.querySelector<HTMLButtonElement>('[data-cy=appearance-save]')!.onclick=()=>{run(()=>manager.save());if(!output.value)output.value=text[24];};
 dialog.querySelector<HTMLButtonElement>('[data-cy=appearance-export]')!.onclick=()=>run(()=>{const url=URL.createObjectURL(new Blob([manager.exportXml()],{type:'application/xml'}));const link=document.createElement('a');link.href=url;link.download='PrimeCare_Layout.xml';link.click();setTimeout(()=>URL.revokeObjectURL(url),1000);});
 if(workspaceOptions)mountWorkspaceCustomizer(root,dialog,scope,locale,workspaceOptions);
 let importSequence=0;element('import').onchange=async()=>{const sequence=++importSequence,started=revisionNow();try{if(!canEdit())return;const file=(element('import') as HTMLInputElement).files?.[0];if(!file||file.size>16384)throw Error();const xml=await file.text();if(!canEdit()||started!==revisionNow()||sequence!==importSequence)return;manager.importXml(xml);output.value='';sync();}catch{if(canEdit()&&started===revisionNow()&&sequence===importSequence)output.value=text[25];}finally{if(canEdit()&&started===revisionNow()&&sequence===importSequence)element('import').value='';}};
}
