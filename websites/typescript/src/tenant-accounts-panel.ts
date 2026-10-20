import catalog from '../../../packages/shared/src/tenant-account-reads.json';
import {TenantAccountsClient,type ReadMode} from './tenant-accounts-client';
import {TenantAccountsController} from './tenant-accounts-controller';
const escape=(v:unknown)=>String(v??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));
const id=(key:keyof typeof catalog.controls)=>catalog.controls[key].testId;
export const tenantAccountsScreen=catalog.screenCode;
export function tenantAccountsMarkup(){return '<section class="section operations-board" data-cy="'+id('root')+'"></section>';}
export function bindTenantAccounts(root:HTMLElement,gateway:string,token:string):()=>void{
 const panel=root.querySelector<HTMLElement>('[data-cy="'+id('root')+'"]');if(!panel)return()=>{};
 const locale=document.documentElement.lang==='fr'?'fr':document.documentElement.lang==='es'?'es':'en';
 const t=(key:keyof typeof catalog.locales.en)=>escape(catalog.locales[locale][key]);
 const c=new TenantAccountsController(new TenantAccountsClient(gateway,token));let focus:string|null=null;
 const stop=c.subscribe(s=>{
  const active=document.activeElement instanceof HTMLElement?document.activeElement:null;if(active&&panel.contains(active))focus=active.getAttribute('data-cy');
  const disabled=s.busy?'disabled':'';
  const button=(key:keyof typeof catalog.controls,label:keyof typeof catalog.locales.en,extra='',suffix='')=>'<button type="button" data-cy="'+id(key)+suffix+'" '+extra+' '+disabled+'>'+t(label)+'</button>';
  const rows=s.accounts.users.map(u=>'<tr data-cy="'+id('table')+'-row-'+escape(u.id)+'" data-account-id="'+escape(u.id)+'"><th scope="row">'+escape(u.email)+'</th><td>'+escape(u.roles)+'</td><td>'+escape(u.status)+'</td><td>'+(['details','sessions','managementAudit','creationAudit'] as const).map(mode=>button(mode,mode,'data-account-id="'+escape(u.id)+'" aria-label="'+t(mode)+' '+escape(u.email)+'"','-'+escape(u.id))).join('')+'</td></tr>').join('');
  const detailColumns=s.mode==='details'?['email','role','status']:s.mode==='sessions'?['created','expires']:s.mode==='managementAudit'?['created','action','role','status','sessions','actor','target']:['created','action','actor','target'];
  const detailRows=s.detail.rows.map((r,n)=>{const values=s.mode==='details'?[r.email,r.roles,r.status]:s.mode==='sessions'?[r.created_at,r.expires_at]:s.mode==='managementAudit'?[r.created_at,r.action,...['role','status','sessionCount'].map(key=>String((r.previous as Record<string,unknown>)[key]??'')+' → '+String((r.current as Record<string,unknown>)[key]??'')),r.actorUserId,r.targetUserId]:[r.created_at,r.action,r.actorUserId,r.targetUserId];return '<tr data-cy="'+id('detailTable')+'-row-'+n+'">'+values.map(v=>'<td>'+escape(v)+'</td>').join('')+'</tr>';}).join('');
  panel.setAttribute('aria-busy',String(s.busy));panel.innerHTML='<h2>'+t('title')+'</h2><output role="status" aria-live="polite" data-cy="'+id('status')+'">'+(s.error?t(s.error):s.busy?t('loading'):'')+'</output><form><label>'+t('search')+'<input type="search" maxlength="200" data-cy="'+id('search')+'" value="'+escape(s.search)+'" '+disabled+'></label><button type="submit" data-cy="'+id('searchSubmit')+'" '+disabled+'>'+t('search')+'</button></form>'+button('refresh','refresh')+'<div class="table-scroll"><table data-cy="'+id('table')+'" aria-label="'+t('title')+'"><thead><tr>'+(['email','role','status','action'] as const).map(k=>'<th scope="col">'+t(k)+'</th>').join('')+'</tr></thead><tbody>'+rows+'</tbody></table></div>'+(!rows&&!s.busy&&!s.error?'<p>'+t('empty')+'</p>':'')+'<div class="operations-controls">'+button('previous','previous',s.accounts.pagination.offset===0?'disabled':'')+'<output data-cy="'+id('pagination')+'">'+t('total')+': '+s.accounts.pagination.total+'</output>'+button('next','next',!s.accounts.pagination.hasMore?'disabled':'')+'</div><section data-cy="'+id('detailPanel')+'"><h3>'+t(s.mode)+'</h3><output role="status" data-cy="'+id('detailStatus')+'">'+(!s.selected?t('select'):!detailRows&&!s.busy?t('empty'):'')+'</output><div class="table-scroll"><table data-cy="'+id('detailTable')+'" aria-label="'+t(s.mode)+'"><thead><tr>'+detailColumns.map(k=>'<th scope="col">'+t(k as keyof typeof catalog.locales.en)+'</th>').join('')+'</tr></thead><tbody>'+detailRows+'</tbody></table></div>'+button('detailPrevious','previous',!s.detail.pagination||s.detail.pagination.offset===0?'disabled':'')+'<output data-cy="'+id('detailPagination')+'">'+(s.detail.pagination?t('total')+': '+s.detail.pagination.total:'')+'</output>'+button('detailNext','next',!s.detail.pagination?.hasMore?'disabled':'')+'</section>';
  const on=(key:keyof typeof catalog.controls,fn:()=>unknown)=>{panel.querySelector<HTMLButtonElement>('[data-cy="'+id(key)+'"]')!.onclick=()=>void fn();};
  panel.querySelector('form')!.onsubmit=e=>{e.preventDefault();void c.load(panel.querySelector<HTMLInputElement>('[data-cy="'+id('search')+'"]')!.value);};
  on('refresh',()=>c.load());on('previous',()=>c.previous());on('next',()=>c.next());on('detailPrevious',()=>c.detailPage(-1));on('detailNext',()=>c.detailPage(1));
  for(const mode of ['details','sessions','managementAudit','creationAudit'] as ReadMode[])panel.querySelectorAll<HTMLButtonElement>('[data-cy^="'+id(mode)+'-"]').forEach(b=>b.onclick=()=>void c.open(mode,b.dataset.accountId!));
  if(!s.busy&&focus)panel.querySelector<HTMLElement>('[data-cy="'+focus+'"]')?.focus();
 });
 void c.load();return()=>{stop();c.dispose();};
}
