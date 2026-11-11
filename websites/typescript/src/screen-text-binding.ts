import {liveScreenText,type Catalog} from './screen-text';
export type ScreenLocale='en'|'fr'|'es';
type Fallbacks=Record<string,Catalog['locales']>;
const owners=new WeakMap<HTMLElement,()=>void>();
const escape=(value:string)=>value.replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));
export function screenLocale(root:HTMLElement):ScreenLocale {
 const locale=root.ownerDocument.documentElement.lang.toLowerCase().split('-')[0];
 return locale==='fr'||locale==='es'?locale:'en';
}
/** Explicit text leaves only: never replace forms, their values, event handlers or HTML.
 * Fallback dictionaries remain usable when a catalog is not registered on the server. */
export function createScreenTextBinding(root:HTMLElement,gateway:string,fallbacks:Fallbacks,locale:()=>ScreenLocale){
 const store=liveScreenText(gateway);let stop:()=>void=()=>{};
 const text=(screen:string,key:string)=>store.text(screen,locale(),key,fallbacks[screen]?.[locale()]?.[key]??fallbacks[screen]?.en?.[key]??key);
 const markup=(screen:string,key:string)=>`<span data-screen-catalog="${escape(screen)}" data-screen-text="${escape(key)}">${escape(text(screen,key))}</span>`;
 const bind=(afterUpdate:()=>void=()=>{})=>{
  owners.get(root)?.();stop();
  const surface=root.firstElementChild;let active=true;let observer:MutationObserver|undefined;
  const current=()=>active&&root.isConnected&&root.firstElementChild===surface;
  const update=()=>{if(!current()){dispose();return;}root.ownerDocument.documentElement.lang=locale();
   for(const node of root.querySelectorAll<HTMLElement>('[data-screen-catalog][data-screen-text]')){
    const screen=node.dataset.screenCatalog!,key=node.dataset.screenText!;
    if(Object.hasOwn(fallbacks,screen)&&Object.hasOwn(fallbacks[screen].en,key))node.textContent=text(screen,key);
   }afterUpdate();
  };
  const unsubscribe=store.subscribe(update);
  const view=root.ownerDocument.defaultView;
  const pagehide=(event:PageTransitionEvent)=>{if(!event.persisted)dispose();};
  function dispose(){if(!active)return;active=false;unsubscribe();observer?.disconnect();view?.removeEventListener('pagehide',pagehide);if(owners.get(root)===dispose)owners.delete(root);}
  owners.set(root,dispose);stop=dispose;
  const Observer=view?.MutationObserver;
  if(Observer){observer=new Observer(()=>{if(!current())dispose();});observer.observe(root.ownerDocument,{childList:true,subtree:true});}
  view?.addEventListener('pagehide',pagehide);update();
  return dispose;
 };
 return {text,markup,bind,dispose:()=>stop()};
}
