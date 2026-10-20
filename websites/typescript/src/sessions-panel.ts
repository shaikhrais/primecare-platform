import policy from '../../../packages/shared/src/account-sessions.json';
import {SessionsClient} from './sessions-client';
import {SessionsController} from './sessions-controller';
const escape=(value:unknown)=>String(value??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));
const id=(key:keyof typeof policy.controls)=>policy.controls[key].testId;
export function sessionsMarkup():string{return '<section class="section operations-board" data-cy="'+id('root')+'"></section>';}
/** Renders governed labels and controller state using existing card/table/button components. */
export function bindSessions(root:HTMLElement,gateway:string,token:string):()=>void{
 const panel=root.querySelector<HTMLElement>('[data-cy="'+id('root')+'"]');if(!panel)return()=>{};
 const locale=document.documentElement.lang==='fr'?'fr':document.documentElement.lang==='es'?'es':'en';
 const t=(key:keyof typeof policy.locales.en)=>escape(policy.locales[locale][key]);
 const controller=new SessionsController(new SessionsClient(gateway,token));let confirming=false;let focus:string|null=null;
 const unsub=controller.subscribe(state=>{
  const active=document.activeElement instanceof HTMLElement?document.activeElement.getAttribute('data-cy'):null;
  if(active&&panel.contains(document.activeElement))focus=active;
  const disabled=state.busy?'disabled':'';
  const rows=state.page.sessions.map((s,n)=>'<tr data-cy="'+id('table')+'-row-'+n+'"><td data-label="'+t('created')+'"><time datetime="'+escape(s.created_at)+'">'+escape(new Date(s.created_at).toLocaleString(locale))+'</time></td><td data-label="'+t('expires')+'"><time datetime="'+escape(s.expires_at)+'">'+escape(new Date(s.expires_at).toLocaleString(locale))+'</time></td><td>'+t(s.current?'current':'other')+'</td></tr>').join('');
  panel.setAttribute('aria-busy',String(state.busy!==null));panel.innerHTML='<h2>'+t('title')+'</h2><p>'+t('description')+'</p><div role="status" aria-live="polite" data-cy="'+id('status')+'">'+(state.message?t(state.message):'')+'</div><button type="button" data-cy="'+id('refresh')+'" '+disabled+'>'+t('refresh')+'</button><div class="table-scroll"><table aria-label="'+t('title')+'" data-cy="'+id('table')+'"><thead><tr><th scope="col">'+t('created')+'</th><th scope="col">'+t('expires')+'</th><th scope="col">'+t('current')+'</th></tr></thead><tbody>'+rows+'</tbody></table></div>'+(!rows&&!state.busy&&!state.message?'<p>'+t('empty')+'</p>':'')+'<div class="operations-controls"><button type="button" data-cy="'+id('previous')+'" '+(state.busy||state.page.pagination.offset===0?'disabled':'')+'>'+t('previous')+'</button><output data-cy="'+id('pagination')+'">'+t('total')+': '+state.page.pagination.total+'</output><button type="button" data-cy="'+id('next')+'" '+(state.busy||!state.page.pagination.hasMore?'disabled':'')+'>'+t('next')+'</button></div><button type="button" data-cy="'+id('revoke')+'" '+disabled+'>'+t('revoke')+'</button><div role="group" aria-label="'+t('confirmation')+'" data-cy="'+id('confirmation')+'" '+(state.confirming?'':'hidden')+'><p>'+t('confirmation')+'</p><div class="operations-actions"><button type="button" data-cy="'+id('confirm')+'" '+disabled+'>'+t('confirm')+'</button><button type="button" data-cy="'+id('cancel')+'" '+disabled+'>'+t('cancel')+'</button></div></div>';
  const button=(key:'refresh'|'previous'|'next'|'revoke'|'confirm'|'cancel',action:()=>unknown)=>{panel.querySelector<HTMLButtonElement>('[data-cy="'+id(key)+'"]')!.onclick=()=>{void action();};};
  button('refresh',()=>controller.load());button('previous',()=>controller.previous());button('next',()=>controller.next());button('revoke',()=>controller.requestRevoke());button('confirm',()=>controller.confirmRevoke());button('cancel',()=>controller.cancelRevoke());
  if(state.confirming&&!confirming)focus=id('confirm');else if(!state.confirming&&confirming)focus=id('revoke');
  confirming=state.confirming;
  if(!state.busy&&focus){const target=panel.querySelector<HTMLButtonElement>('[data-cy="'+focus+'"]');if(target&&!target.disabled)target.focus();}
 });
 void controller.load();
 return()=>{unsub();controller.dispose();};
}
