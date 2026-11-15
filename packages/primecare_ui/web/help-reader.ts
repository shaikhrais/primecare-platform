import {PrimeComponentFactory,catalogueRegistration,type CatalogueLocale} from './component-catalogue';
import {ThemeControlBase} from './theme-control-base';
import type {createHelpReaderSession,HelpReaderState} from '../../shared/src/help-reader/session';

type HelpReaderSession=ReturnType<typeof createHelpReaderSession>;
const actionNames=['load','search','changeLocale','previousPage','nextPage','backToList','retry','openArticle','subscribe'] as const;
type SessionActions=Pick<HelpReaderSession,typeof actionNames[number]>;
type SessionObservations={state:()=>HelpReaderState;canNext:()=>boolean;canPrevious:()=>boolean;canRetry:()=>boolean};
const bindingKinds={start:'prime_button',search:'prime_text_field',locale:'prime_dropdown_web',previous:'prime_button',next:'prime_button',back:'prime_button',retry:'prime_button',article:'prime_card',open:'prime_button',idle:'prime_card',loading:'prime_card',empty:'prime_card',error:'prime_card',retired:'prime_card'} as const;
export type HelpReaderBindings=Readonly<Record<keyof typeof bindingKinds,string>>;
export type HelpReaderViewOptions={
 session:HelpReaderSession;scope:string;metadata:unknown;bindings:HelpReaderBindings;
 localeNames:(locale:CatalogueLocale)=>Readonly<Record<CatalogueLocale,string>>;
};
const owners=new WeakMap<HTMLElement,HelpReaderView>();
const data=(raw:unknown,key:string):unknown=>{if(!raw||typeof raw!=='object')throw Error('Existing Help bindings required');const field=Object.getOwnPropertyDescriptor(raw,key);if(!field||!Object.hasOwn(field,'value'))throw Error('Existing Help bindings required');return field.value;};
const label=(value:unknown):value is string=>typeof value==='string'&&value.trim().length>0&&value.length<=4096&&!/[\u0000-\u0008\u000b\u000c\u000e-\u001f\u007f]/.test(value);

/** Unmounted presentation for a borrowed session. Supplied exports must come from
 * the host's existing verified controls/text. This factory grants no authority,
 * creates no route, starts no read and never disposes the caller's session.
 */
export class HelpReaderView extends ThemeControlBase {
 private readonly actions:SessionActions;
 private readonly observations:SessionObservations;
 private readonly scope:string;
 private readonly metadata:ReturnType<typeof catalogueRegistration>['metadata'];
 private readonly bindings:HelpReaderBindings;
 private readonly names:Readonly<Record<CatalogueLocale,Readonly<Record<CatalogueLocale,string>>>>;
 private off:()=>void=()=>{};
 private kit:PrimeComponentFactory|undefined;
 private element:HTMLElement|undefined;
 private renderAbort=new AbortController();
 private drawing=false;private dirty=false;
 private focus: {id:string;start:number|null;end:number|null}|undefined;
 private destination:'content'|'search'|undefined;

 constructor(root:HTMLElement,options:HelpReaderViewOptions){
  super(root);
  if(owners.has(root)||[root.ownerDocument.body,root.ownerDocument.documentElement].includes(root))throw Error('Distinct scoped Help slot required');
  const session=options.session,actions:Record<string,Function>={},observations:Record<string,Function>={};
  for(const name of actionNames){const method=data(session,name);if(typeof method!=='function')throw Error('Captured Help session required');actions[name]=method.bind(session);}
  for(const name of ['state','canNext','canPrevious','canRetry']){const getter=Object.getOwnPropertyDescriptor(session,name)?.get;if(typeof getter!=='function')throw Error('Captured Help session required');observations[name]=getter.bind(session);}
  this.actions=Object.freeze(actions) as SessionActions;this.observations=Object.freeze(observations) as SessionObservations;this.scope=options.scope;
  if(typeof this.scope!=='string'||!this.scope.trim()||this.scope.length>1024)throw Error('Matching Help scope required');
  this.metadata=catalogueRegistration('en',options.metadata).metadata;
  const bindings={} as Record<keyof typeof bindingKinds,string>;
  for(const name of Object.keys(bindingKinds) as (keyof typeof bindingKinds)[]){
   const key=data(options.bindings,name);
   if(typeof key!=='string'||!this.metadata.controls.some(control=>control.key===key&&control.componentCode===bindingKinds[name]))throw Error('Existing Help component kind required');
   bindings[name]=key;
  }
  this.bindings=Object.freeze(bindings);
  const names={} as Record<CatalogueLocale,Readonly<Record<CatalogueLocale,string>>>;
  const localeNames=options.localeNames;
  if(typeof localeNames!=='function')throw Error('Existing localized locale names required');
  for(const language of ['en','fr','es'] as const){
   const raw=localeNames(language),snapshot={} as Record<CatalogueLocale,string>;
   if(!raw||typeof raw!=='object'||Reflect.ownKeys(raw).length!==3)throw Error('Existing localized locale names required');
   for(const key of ['en','fr','es'] as const){const value=data(raw,key);if(!label(value))throw Error('Existing localized locale names required');snapshot[key]=value;}
   names[language]=Object.freeze(snapshot);
  }
  this.names=Object.freeze(names);
  // Export/provider inspection can synchronously acquire this root elsewhere.
  if(owners.has(root))throw Error('Distinct scoped Help slot required');
  owners.set(root,this);
  const previousChildren=[...root.childNodes],previousMarker=root.getAttribute('data-pc-catalogue');
  try{
   this.off=this.actions.subscribe(()=>this.render());
   this.render();
  }catch(error){
   try{this.cleanupControlResources([()=>this.endControlScope(),()=>this.off(),()=>this.renderAbort.abort(),()=>this.kit?.dispose(),()=>{if(!owners.has(root)||owners.get(root)===this)root.replaceChildren(...previousChildren);},()=>{if(!owners.has(root)||owners.get(root)===this){if(previousMarker===null)root.removeAttribute('data-pc-catalogue');else root.setAttribute('data-pc-catalogue',previousMarker);}},()=>{if(owners.get(root)===this)owners.delete(root);}]);}catch{}
   throw error;
  }
 }

 private current(state:HelpReaderState){
  if(this.dead||owners.get(this.root)!==this)return false;
  let current:HelpReaderState;
  try{current=this.observations.state();}catch{try{this.dispose();}catch{}return false;}
  return !this.dead&&owners.get(this.root)===this&&current===state;
 }
 private action(state:HelpReaderState,run:()=>Promise<void>,destination?:'content'|'search'){
  return async()=>{
   if(!this.current(state)||['loading','retired','disposed'].includes(state.phase))return;
   if(destination)this.destination=destination;
   await run();
  };
 }
 private render(){
  if(this.dead||owners.get(this.root)!==this)return;
  this.dirty=true;if(this.drawing)return;
  this.drawing=true;
  try{while(this.dirty&&!this.dead){this.dirty=false;this.draw(this.observations.state());}}
  catch(error){try{this.dispose();}catch{}throw error;}
  finally{this.drawing=false;}
 }
 private draw(state:HelpReaderState){
  if(!this.current(state))return;
  const doc=this.root.ownerDocument,active=doc.activeElement;
  const ownedFocus=!!active&&this.root.contains(active);
  if(ownedFocus&&active.id){const field=active as HTMLElement;const selectable=field.tagName==='INPUT' || field.tagName==='TEXTAREA';this.focus={id:active.id,start:selectable?(field as HTMLInputElement).selectionStart:null,end:selectable?(field as HTMLInputElement).selectionEnd:null};}
  else if(active&&active!==doc.body&&active!==doc.documentElement)this.focus=undefined;
  this.renderAbort.abort();this.renderAbort=new AbortController();
  const previous=this.kit;this.kit=undefined;previous?.dispose();
  if(!this.current(state))return;
  const kit=this.kit=new PrimeComponentFactory(this.root,this.scope,state.locale,this.metadata);
  const b=this.bindings,busy=state.phase==='loading',closed=['retired','disposed'].includes(state.phase);
  const box=doc.createElement('div');box.style.display='grid';box.style.gap='var(--spacing-md)';box.style.minInlineSize='0';
  const button=(key:string,run?:()=>Promise<void>,suffix='',destination?:'content'|'search')=>kit.button(key,run?this.action(state,run,destination):undefined,{disabled:busy||closed||!run,suffix,feedback:false});
  const status=(kind:'loading'|'empty'|'error',key:string)=>{const node=kit.state(kind,undefined,key);node.setAttribute('aria-live','polite');return node;};
  let search:HTMLInputElement|undefined,detail:HTMLElement|undefined;
  if(closed){const node=kit.card(b.retired,[],'status');node.textContent=kit.text(b.retired);box.append(node);this.focus=undefined;this.destination=undefined;}
  else{
   const locales=this.names[state.locale],choices=(['en','fr','es'] as const).map(value=>({value,label:locales[value]}));
   const row=kit.select(b.locale,choices,value=>{if(['en','fr','es'].includes(value))void this.action(state,()=>this.actions.changeLocale(value as CatalogueLocale),'search')().catch(()=>{});},busy);
   const localeSelect=row.querySelector('select');
   if(!localeSelect){kit.dispose();throw Error('Registered Help locale control missing');}
   localeSelect.value=state.locale;
   const field=kit.field(b.search,{value:state.query,disabled:busy,kind:'input'});search=field.input as HTMLInputElement;search.type='search';search.maxLength=100;
   search.addEventListener('keydown',event=>{if(event.key==='Enter'){event.preventDefault();if(!this.root.contains(field.element)||!field.element.contains(field.input)||field.input.disabled)return;void this.action(state,()=>this.actions.search(field.input.value),'search')().catch(()=>{});}},{signal:this.renderAbort.signal});
   box.append(row,field.element);
   if(state.phase==='idle'){const node=kit.card(b.idle,[],'status');node.textContent=kit.text(b.idle);box.append(node,button(b.start,()=>this.actions.load(),'','search'));}
   if(busy)box.append(status('loading',b.loading));
   if(state.phase==='empty')box.append(status('empty',b.empty));
   if(state.phase==='error'){box.append(status('error',b.error));if(this.observations.canRetry())box.append(button(b.retry,()=>this.actions.retry()));box.append(button(b.back,()=>this.actions.backToList(),'','search'));}
   if(state.phase==='list')state.items.forEach((article,index)=>{
    const open=button(b.open,()=>this.actions.openArticle(article.id),'-article-'+index,'content');open.textContent=article.title;
    const category=doc.createElement('p'),summary=doc.createElement('p');category.textContent=article.category;summary.textContent=article.summary;
    box.append(kit.card(b.article,[open,category,summary],undefined,'-article-'+index));
   });
   if(state.phase==='detail'&&state.article){
    const title=doc.createElement('h2'),category=doc.createElement('p'),body=doc.createElement('p');title.textContent=state.article.title;category.textContent=state.article.category;body.textContent=state.article.body;body.style.whiteSpace='pre-wrap';
    detail=kit.card(b.article,[title,category,body]);detail.tabIndex=-1;
    box.append(button(b.back,()=>this.actions.backToList(),'','search'),detail);
   }
   if(state.phase==='list'||state.phase==='empty'){
    const pages=doc.createElement('div');pages.setAttribute('role','group');pages.style.display='flex';pages.style.flexWrap='wrap';pages.style.gap='var(--spacing-sm)';
    pages.append(button(b.previous,this.observations.canPrevious()?()=>this.actions.previousPage():undefined),button(b.next,this.observations.canNext()?()=>this.actions.nextPage():undefined));box.append(pages);
   }
  }
  if(!this.current(state)||this.kit!==kit){kit.dispose();return;}
  this.root.replaceChildren(box);
  this.element=box;
  if(!busy&&!closed){
   if(ownedFocus||!active||active===doc.body||active===doc.documentElement){
    const target=this.destination==='content'?detail:this.destination==='search'?search:this.focus?[...this.root.querySelectorAll<HTMLElement>('[id]')].find(node=>node.id===this.focus?.id):undefined;
    if(target&&this.root.contains(target)&&!target.hasAttribute('disabled')&&!target.closest('[inert]')){target.focus();if(target===search&&this.focus?.id===target.id&&this.focus.start!==null&&this.focus.end!==null)search?.setSelectionRange(this.focus.start,this.focus.end);}
   }
   this.destination=undefined;
  }
 }
 dispose(){this.disposeControlScope([()=>this.off(),()=>this.renderAbort.abort(),()=>this.kit?.dispose(),()=>{if(owners.get(this.root)===this&&this.element?.parentNode===this.root)this.element.remove();},()=>{if(owners.get(this.root)===this)owners.delete(this.root);},()=>{this.focus=undefined;this.destination=undefined;this.element=undefined;}]);}
}
