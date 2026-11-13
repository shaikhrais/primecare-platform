import {ThemeControlBase} from './theme-control-base';
import metadata from '../catalogs/client-invoices.registration.json';
import {ClientInvoices} from '../../shared/src/client-invoices/client';
export {ClientInvoices};
const owners=new WeakMap<HTMLElement,PrimeClientInvoices>();
/** Registered read-only rendering; exact amounts remain server strings, never sums or payments. */
export class PrimeClientInvoices extends ThemeControlBase{
 private off=()=>{};private renderAbort=new AbortController();private focusKey:string|null=null;
 constructor(root:HTMLElement,readonly client:ClientInvoices,private locale:'en'|'fr'|'es',private isCurrent:()=>boolean){
  super(root);
  if(owners.has(root)||[root.ownerDocument.body,root.ownerDocument.documentElement].includes(root)||metadata.kind!=='verified_metadata_export'||metadata.host.screenId!==665||metadata.api.id!==16432||metadata.api.method!=='GET'||metadata.api.path!=='/v1/client/invoices'||metadata.api.permission!=='authenticated_client_profile_owner'||!metadata.source.jobId)throw Error('registered_invoice_slot_required');
  owners.set(root,this);root.dataset.pcClientInvoices='';
  const doc=root.ownerDocument;if(!doc.querySelector('[data-pc-client-invoices-style]')){const style=doc.createElement('style');style.dataset.pcClientInvoicesStyle='';style.textContent='[data-pc-client-invoices]{font:inherit;color:var(--color-text);background:var(--color-surface);max-inline-size:100%}[data-pc-client-invoices] button{font:inherit;min-block-size:var(--control-min-height);padding:var(--spacing-sm);color:inherit;background:var(--color-surface);border:var(--border-width) solid var(--color-border);border-radius:var(--radius-md)}[data-pc-client-invoices] .table-scroll{max-inline-size:100%;overflow:auto}[data-pc-client-invoices] th,[data-pc-client-invoices] td{padding:var(--spacing-sm);overflow-wrap:anywhere;text-align:start}[data-pc-client-invoices] :focus-visible{outline:var(--border-width) solid var(--color-primary);outline-offset:var(--spacing-sm)}';doc.head.append(style);}
  try{this.off=client.subscribe(()=>this.render());}catch(error){this.dispose();throw error;}
 }
 private control<K extends keyof HTMLElementTagNameMap>(tag:K,key:string){const spec=metadata.controls.find(c=>c.key===key);if(!spec?.controlId)throw Error('missing_registered_invoice_control');const node=this.root.ownerDocument.createElement(tag);node.dataset.cy=spec.testId;node.dataset.controlId=String(spec.controlId);return node;}
 render(){
  if(this.dead)return;if(!this.isCurrent()||!this.root.isConnected){this.dispose();return;}
  const doc=this.root.ownerDocument,focus=doc.activeElement as HTMLElement|null,restore=!!focus&&this.root.contains(focus);if(restore&&focus?.dataset.cy&&focus.dataset.cy!=='client-invoices-status')this.focusKey=focus.dataset.cy.replace('client-invoices-','');
  this.renderAbort.abort();this.renderAbort=new AbortController();const state=this.client.current,words=metadata.locales[this.locale],busy=state.status==='loading',page=state.page;
  const panel=this.control('section','panel');panel.setAttribute('aria-busy',String(busy));const title=doc.createElement('h2');title.id='client-invoices-title';title.textContent=words.title;panel.append(title);
  const status=this.control('p','status');status.setAttribute('role',state.status==='error'?'alert':'status');status.tabIndex=-1;status.textContent=state.status==='error'?words.error:busy?words.loading:page?.invoices.length?words.page+' '+(page.pagination.offset/25+1)+' '+words.of+' '+Math.max(1,Math.ceil(page.pagination.total/25)):words.empty;panel.append(status);
  const action=(key:'refresh'|'previous'|'next',offset:number,disabled:boolean)=>{const b=this.control('button',key);b.type='button';b.textContent=words[key];b.disabled=busy||disabled;b.addEventListener('click',()=>{if(this.dead)return;if(!this.isCurrent()){this.dispose();return;}if(b.disabled)return;this.focusKey=key;void this.client.load(offset);},{signal:this.renderAbort.signal});return b;};
  panel.append(action('refresh',page?.pagination.offset??0,false),action('previous',Math.max(0,(page?.pagination.offset??0)-25),!page||page.pagination.offset===0),action('next',(page?.pagination.offset??0)+25,!page||!page.pagination.hasMore||page.pagination.offset+25>100000));
  if(page?.invoices.length){const box=doc.createElement('div');box.className='table-scroll';const table=doc.createElement('table');table.setAttribute('aria-labelledby',title.id);const head=doc.createElement('thead'),tr=doc.createElement('tr'),body=doc.createElement('tbody');
   const fields=['id','status','currency','subtotal','tax','total','created_at','updated_at'] as const;
   for(const key of fields){const th=doc.createElement('th');th.setAttribute('scope','col');th.textContent=words[key];tr.append(th);}head.append(tr);
   for(const invoice of page.invoices){const row=doc.createElement('tr');row.dataset.cy='client-invoice-row';for(const key of fields){const cell=doc.createElement(key==='id'?'th':'td');if(key==='id')cell.setAttribute('scope','row');const value=invoice[key];if((key==='created_at'||key==='updated_at')&&value!==null){const time=doc.createElement('time');time.setAttribute('datetime',value);time.textContent=new Intl.DateTimeFormat(this.locale,{dateStyle:'medium',timeStyle:'short',timeZone:'UTC'}).format(new Date(value))+' UTC';cell.append(time);}else cell.textContent=value===null?words.missing:value;row.append(cell);}body.append(row);}table.append(head,body);box.append(table);panel.append(box);
  }
  this.root.replaceChildren(panel);
  if(restore){const button=this.focusKey?this.root.querySelector<HTMLButtonElement>('[data-cy="client-invoices-'+this.focusKey+'"]'):null;if(!busy&&button&&!button.disabled)button.focus({preventScroll:true});else if(busy)status.focus({preventScroll:true});else this.root.querySelector<HTMLButtonElement>('[data-cy="client-invoices-refresh"]')?.focus({preventScroll:true});}
 }
 dispose(){if(!this.endControlScope())return;this.renderAbort.abort();this.off();this.client.dispose();if(owners.get(this.root)===this){owners.delete(this.root);this.root.replaceChildren();this.root.removeAttribute('data-pc-client-invoices');}}
}
