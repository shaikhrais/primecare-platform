import {requireScreenManager,showScreenConfigurationError} from '../../../packages/primecare_ui/web/screen-manager';
import {resolveManagedRoute} from './managed-routes';
import {liveScreenText} from './screen-text';
import {createScreenTextBinding} from './screen-text-binding';
import policy from '../../../packages/shared/src/auth-recovery.json';
import catalog from '../../../packages/primecare_ui/lib/src/localization/screens/auth.json';
import {BaseMediaLook,applyMediaTokens} from './media-look';
export class RecoveryError extends Error {constructor(readonly status:number){super('recovery_failed');}}
export async function recoverAccount(gateway:string,mode:'forgot'|'reset',body:Record<string,string>,send:typeof fetch=fetch):Promise<void>{
 const response=await send(gateway.replace(/\/+$/,'')+policy.endpoints[mode],{method:'POST',headers:{'content-type':'application/json'},cache:'no-store',body:JSON.stringify(body)});
 let data:any;try{data=await response.json();}catch{throw new RecoveryError(response.status);}
 if(!response.ok)throw new RecoveryError(response.status);
 if(mode==='forgot'?typeof data?.message!=='string'||!data.message.trim():data?.status!=='password_reset'||data.reauthenticationRequired!==true)throw new RecoveryError(502);
}
const owners=new WeakMap<HTMLElement,()=>void>();

export function renderAuthRecovery(root:HTMLElement,gateway:string,portalName:string,mode:'forgot'|'reset',language=(document.documentElement.lang||navigator.language).slice(0,2)):()=>void{
 owners.get(root)?.();
 const manager=requireScreenManager(root),entry=resolveManagedRoute(location.pathname,'au');
 try {if(entry.adapter!==mode)throw Error('Recovery route mismatch');manager.enter(entry.id,entry.route);}catch(error){showScreenConfigurationError(root,error);throw error;}
 const route=location.pathname+location.search;
 let startingSession:string|null;
 try{startingSession=sessionStorage.getItem('primecare_session');}catch(error){showScreenConfigurationError(root,error);throw error;}
 const events=root.ownerDocument.defaultView??window;
 let alive=true,suspended=false,nodes:Node[]=[],form:HTMLFormElement|undefined,observer:MutationObserver|undefined,stopLabels=()=>{};
 const resumes=new Set<()=>void>();
 const release=()=>{for(const resume of resumes)resume();resumes.clear();};
 const clear=()=>{for(const field of form?.querySelectorAll<HTMLInputElement>('input')??[])field.value='';};
 function dispose(){
  if(!alive)return;alive=false;suspended=false;clear();stopLabels();observer?.disconnect();release();
  events.removeEventListener('pagehide',hide);events.removeEventListener('pageshow',show);events.removeEventListener('popstate',history);events.removeEventListener('hashchange',history);
  if(owners.get(root)===dispose)owners.delete(root);
 }
 function owned(){
  if(!alive||owners.get(root)!==dispose)return false;
  const now=Array.from(root.childNodes);
  if(!root.isConnected||!form?.isConnected||!root.contains(form)||now.length!==nodes.length||now.some((node,i)=>node!==nodes[i])){dispose();return false;}
  return true;
 }
 function current(){
  if(suspended||!owned())return false;
  let sameSession=false;try{sameSession=sessionStorage.getItem('primecare_session')===startingSession;}catch{}
  if(location.pathname+location.search!==route||!sameSession){dispose();return false;}
  try{manager.enter(entry.id,entry.route);}catch(error){if(owned()){dispose();showScreenConfigurationError(root,error);}return false;}
  return owned();
 }
 const wait=()=>suspended&&alive?new Promise<void>(resolve=>resumes.add(resolve)):Promise.resolve();
 const history=()=>{if(!suspended)current();};
 const hide=(event:PageTransitionEvent)=>{if(event.persisted){suspended=true;stopLabels();}else dispose();};
 const show=(event:PageTransitionEvent)=>{if(event.persisted&&suspended&&alive){suspended=false;if(current())bindLabels();release();}};
 const locale=language==='fr'||language==='es'?language:'en',media=new BaseMediaLook(locale);applyMediaTokens();
 const recoveryQuery=new URLSearchParams();if(locale!=='en')recoveryQuery.set('locale',locale);recoveryQuery.set('enable-semantics','true');
 const esc=(s:string)=>s.replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));
 const labels=createScreenTextBinding(root,gateway,{auth:catalog.locales,password_recovery:policy.locales},()=>locale);
 const t=(key:keyof typeof catalog.locales.en)=>labels.markup('auth',key);const own=(key:keyof typeof policy.locales.en)=>labels.text('password_recovery',key);const ownLabel=(key:keyof typeof policy.locales.en)=>labels.markup('password_recovery',key);
 root.innerHTML=`<main class="auth-shell auth-recovery-shell" data-cy="screen-auth-recovery"><form class="auth-card" data-cy="recovery-form">${media.brand()}<p class="eyebrow">${esc(portalName)}</p><h1>${t(mode==='forgot'?'forgot_title':'reset_title')}</h1><p>${t(mode==='forgot'?'forgot_body':'reset_body')}</p><label>${t('email')}<input name="email" type="email" autocomplete="username" maxlength="254" required data-cy="recovery-email"></label>${mode==='reset'?`<p>${ownLabel('reset_guidance')}</p><label>${t('code')}<input name="code" autocomplete="one-time-code" minlength="12" maxlength="12" pattern="[A-Fa-f0-9]{12}" required data-cy="recovery-code"></label><label>${t('new_password')}<input name="newPassword" type="password" autocomplete="new-password" minlength="12" maxlength="72" required data-cy="recovery-password"></label><label>${t('confirm_password')}<input name="confirmation" type="password" autocomplete="new-password" minlength="12" maxlength="72" required data-cy="recovery-confirm"></label>`:''}<button type="submit" data-cy="recovery-submit">${t(mode==='forgot'?'recovery_action':'reset_action')}</button><output role="status" data-cy="recovery-status"></output>${mode==='forgot'?`<a data-cy="recovery-reset-link" href="${policy.routes.reset}?${recoveryQuery}">${ownLabel('reset_ready')}</a>`:''}<a data-cy="recovery-back" href="${policy.routes.login}?${recoveryQuery}">${t('back')}</a></form></main>`;
 form=root.querySelector<HTMLFormElement>('[data-cy=recovery-form]')!;
 const ownedForm=form,button=root.querySelector<HTMLButtonElement>('[data-cy=recovery-submit]')!,status=root.querySelector<HTMLOutputElement>('[data-cy=recovery-status]')!;
 nodes=Array.from(root.childNodes);owners.set(root,dispose);
 observer=new MutationObserver(()=>{owned();});observer.observe(root.ownerDocument,{childList:true,subtree:true});
 events.addEventListener('pagehide',hide);events.addEventListener('pageshow',show);events.addEventListener('popstate',history);events.addEventListener('hashchange',history);
 let busy=false,statusText:(()=>string)|null=null;
 const drawStatus=()=>{if(current()&&statusText)status.value=statusText();};
 const setStatus=(value:()=>string)=>{statusText=value;drawStatus();};
 // Own the complete label update too: the shared binding checks its surface only,
 // whereas recovery must revalidate transport authority before any UI effects.
 const drawLabels=()=>{
  if(!current())return;
  root.ownerDocument.documentElement.lang=locale;
  for(const node of root.querySelectorAll<HTMLElement>('[data-screen-catalog][data-screen-text]')){
   const screen=node.dataset.screenCatalog!,key=node.dataset.screenText!;
   const fallback=screen==='auth'?catalog.locales.en:screen==='password_recovery'?policy.locales.en:null;
   if(fallback&&Object.hasOwn(fallback,key))node.textContent=labels.text(screen,key);
  }
  drawStatus();
 };
 const bindLabels=()=>{stopLabels();stopLabels=liveScreenText(gateway).subscribe(drawLabels);drawLabels();};
 bindLabels();
 ownedForm.onsubmit=event=>{event.preventDefault();if(busy||!current())return;
 const fields=new FormData(ownedForm),email=String(fields.get('email')??'').trim(),password=String(fields.get('newPassword')??'');
 if(mode==='reset'&&(password!==fields.get('confirmation')||password.length<12||new TextEncoder().encode(password).length>72)){setStatus(()=>own('password_mismatch'));return;}
 busy=true;button.disabled=true;setStatus(()=>own('recovery_loading'));
 // The transport stays public and backward compatible. Revalidate immediately before dispatch.
 const send:typeof fetch=(input,init)=>{if(!current())return Promise.reject(Error('Retired recovery'));return fetch(input,init);};
 void (async()=>{
  let outcome:()=>void;
  try{
   await recoverAccount(gateway,mode,mode==='forgot'?{email}:{email,code:String(fields.get('code')??'').trim(),newPassword:password},send);
   outcome=()=>{if(mode==='reset')ownedForm.reset();setStatus(()=>mode==='forgot'?labels.text('auth','recovery_sent'):own('reset_success'));};
  }catch(error){
   outcome=()=>setStatus(()=>own(error instanceof RecoveryError&&error.status===503?'recovery_unavailable':error instanceof RecoveryError&&error.status===429?'recovery_limit':'recovery_error'));
  }
  // A second pagehide can happen before a released continuation runs. Keep the
  // outcome pending until a currently visible owner can commit it synchronously.
  while(alive){
   await wait();if(suspended)continue;if(!current())return;
   outcome();busy=false;button.disabled=false;
   for(const name of ['code','newPassword','confirmation']){const field=ownedForm.elements.namedItem(name);if(field instanceof HTMLInputElement)field.value='';}
   return;
  }
 })();
 };
 return dispose;
}
