import {ThemeControlBase} from './theme-control-base';
import metadata from '../catalogs/client-invoices.registration.json';
import {ClientInvoices} from '../../shared/src/client-invoices/client';
export {ClientInvoices};
const owners=new WeakMap<HTMLElement,PrimeClientInvoices>();
type Action='refresh'|'previous'|'next';
/** Registered read-only rendering; exact amounts remain server strings, never sums or payments. */
export class PrimeClientInvoices extends ThemeControlBase{
 private off=()=>{};
 private panel:HTMLElement;
 private content:HTMLElement;
 private status:HTMLParagraphElement;
 private buttons={} as Record<Action,HTMLButtonElement>;
 private offset=0;
 private announcement:ReturnType<typeof setTimeout>|null=null;
 constructor(root:HTMLElement,readonly client:ClientInvoices,private locale:'en'|'fr'|'es',private isCurrent:()=>boolean){
  super(root);
  if(owners.has(root)||[root.ownerDocument.body,root.ownerDocument.documentElement].includes(root)||metadata.kind!=='verified_metadata_export'||metadata.host.screenId!==665||metadata.api.id!==16432||metadata.api.method!=='GET'||metadata.api.path!=='/v1/client/invoices'||metadata.api.permission!=='authenticated_client_profile_owner'||!metadata.source.jobId||!Object.hasOwn(metadata.locales,locale))throw Error('registered_invoice_slot_required');
  const previousChildren=Array.from(root.childNodes),previousMarker=root.getAttribute('data-pc-client-invoices'),doc=root.ownerDocument,words=metadata.locales[locale];
  let createdStyle:HTMLStyleElement|undefined;
  try{
  owners.set(root,this);root.dataset.pcClientInvoices='';
  if(!doc.querySelector('[data-pc-client-invoices-style]')){
   const style=doc.createElement('style');createdStyle=style;style.dataset.pcClientInvoicesStyle='';
   style.textContent='[data-pc-client-invoices]{font:inherit;color:var(--color-text);background:var(--color-surface);max-inline-size:100%;min-inline-size:0}[data-pc-client-invoices] button{font:inherit;min-block-size:var(--control-min-height);padding:var(--spacing-sm);color:inherit;background:var(--color-surface);border:var(--border-width) solid var(--color-border);border-radius:var(--radius-md)}[data-pc-client-invoices] button[aria-disabled=true]{cursor:wait}[data-pc-client-invoices] .table-scroll{max-inline-size:100%;overflow:auto}[data-pc-client-invoices] th,[data-pc-client-invoices] td{padding:var(--spacing-sm);overflow-wrap:anywhere;text-align:start}[data-pc-client-invoices] :focus-visible{outline:var(--border-width) solid var(--color-primary);outline-offset:var(--spacing-sm)}';
   doc.head.append(style);
  }
  this.panel=this.control('section','panel');
  const title=doc.createElement('h2');title.id='client-invoices-title';title.textContent=words.title;
  this.content=doc.createElement('div');
  for(const key of ['refresh','previous','next'] as const){
   const button=this.control('button',key);button.type='button';button.textContent=words[key];this.buttons[key]=button;
   button.addEventListener('click',()=>{
    if(this.dead)return;if(!this.isCurrent()){this.dispose();return;}
    if(button.disabled||button.getAttribute('aria-disabled')==='true'||this.client.current.status==='loading')return;
    const offset=key==='previous'?Math.max(0,this.offset-25):key==='next'?this.offset+25:this.offset;
    void this.client.load(offset);
   },{signal:this.abort.signal});
  }
  this.panel.append(title,...Object.values(this.buttons),this.content);
  // Keep the established live region outside aria-busy so loading can be announced.
  this.status=this.control('p','status');this.status.setAttribute('role','status');
  this.status.setAttribute('aria-live','polite');this.status.setAttribute('aria-atomic','true');
  root.replaceChildren(this.panel,this.status);
  let initial=true,initialFailure:{error:unknown}|undefined;
  this.off=client.subscribe(()=>{try{this.render();}catch(error){if(initial)initialFailure={error};else throw error;}});
  initial=false;
  if(initialFailure)throw initialFailure.error;
  }catch(error){
   // A failed view does not own the caller's client or the host's previous nodes.
   this.endControlScope();
   if(this.announcement!==null){clearTimeout(this.announcement);this.announcement=null;}
   try{this.off();}catch{}
   if(owners.get(root)===this){
    owners.delete(root);
    try{root.replaceChildren(...previousChildren);}catch{}
    try{if(previousMarker===null)root.removeAttribute('data-pc-client-invoices');else root.setAttribute('data-pc-client-invoices',previousMarker);}catch{}
   }
   try{createdStyle?.remove();}catch{}
   throw error;
  }
 }
 private control<K extends keyof HTMLElementTagNameMap>(tag:K,key:string){
  const spec=metadata.controls.find(c=>c.key===key);if(!spec?.controlId)throw Error('missing_registered_invoice_control');
  const node=this.root.ownerDocument.createElement(tag);node.dataset.cy=spec.testId;node.dataset.controlId=String(spec.controlId);return node;
 }
 private announce(message:string){
  if(this.announcement!==null)clearTimeout(this.announcement);
  // Establish an initially empty region before changing its message in a later task.
  this.announcement=setTimeout(()=>{
   this.announcement=null;
   if(this.dead)return;if(!this.isCurrent()||!this.root.contains(this.status)){this.dispose();return;}
   this.status.textContent=message;
  },0);
 }
 render(){
  if(this.dead)return;if(!this.isCurrent()||!this.root.isConnected){this.dispose();return;}
  const doc=this.root.ownerDocument,focused=doc.activeElement,state=this.client.current,words=metadata.locales[this.locale];
  const busy=state.status==='loading',page=state.page;
  if(page)this.offset=page.pagination.offset;
  this.panel.setAttribute('aria-busy',String(busy));
  // Preserve the focused control during a request; aria-disabled and the handler
  // block repeat actions without removing it from the keyboard's position.
  if(!busy){
   this.buttons.previous.disabled=!page||page.pagination.offset===0;
   this.buttons.next.disabled=!page||!page.pagination.hasMore||page.pagination.offset+25>100000;
  }
  for(const button of Object.values(this.buttons))button.setAttribute('aria-disabled',String(busy||button.disabled));
  this.content.replaceChildren();
  if(page?.invoices.length){
   const box=doc.createElement('div');box.className='table-scroll';box.tabIndex=0;box.setAttribute('role','region');box.setAttribute('aria-labelledby','client-invoices-title');
   const table=doc.createElement('table');table.setAttribute('aria-labelledby','client-invoices-title');
   const head=doc.createElement('thead'),tr=doc.createElement('tr'),body=doc.createElement('tbody');
   const fields=['id','status','currency','subtotal','tax','total','created_at','updated_at'] as const;
   for(const key of fields){const th=doc.createElement('th');th.setAttribute('scope','col');th.textContent=words[key];tr.append(th);}head.append(tr);
   for(const invoice of page.invoices){
    const row=doc.createElement('tr');row.dataset.cy='client-invoice-row';
    for(const key of fields){
     const cell=doc.createElement(key==='id'?'th':'td');if(key==='id')cell.setAttribute('scope','row');const value=invoice[key];
     if((key==='created_at'||key==='updated_at')&&value!==null){
      const time=doc.createElement('time');time.setAttribute('datetime',value);time.textContent=new Intl.DateTimeFormat(this.locale,{dateStyle:'medium',timeStyle:'short',timeZone:'UTC'}).format(new Date(value))+' UTC';cell.append(time);
     }else cell.textContent=value===null?words.missing:value;
     row.append(cell);
    }body.append(row);
   }table.append(head,body);box.append(table);this.content.append(box);
  }
  const message=state.status==='idle'?'':state.status==='error'?words.error:busy?words.loading:page?.invoices.length?words.page+' '+(page.pagination.offset/25+1)+' '+words.of+' '+Math.max(1,Math.ceil(page.pagination.total/25)):words.empty;
  this.announce(message);
  if(!busy&&Object.values(this.buttons).some(button=>button===focused&&button.disabled))this.buttons.refresh.focus({preventScroll:true});
 }
 dispose(){
  if(!this.endControlScope())return;
  if(this.announcement!==null){clearTimeout(this.announcement);this.announcement=null;}
  this.off();this.client.dispose();
  if(owners.get(this.root)===this){owners.delete(this.root);this.root.replaceChildren();this.root.removeAttribute('data-pc-client-invoices');}
 }
}
