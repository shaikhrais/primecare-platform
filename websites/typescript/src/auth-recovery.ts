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
export function renderAuthRecovery(root:HTMLElement,gateway:string,portalName:string,mode:'forgot'|'reset',language=(document.documentElement.lang||navigator.language).slice(0,2)):void{
 const locale=language==='fr'||language==='es'?language:'en',media=new BaseMediaLook(locale);applyMediaTokens();
 const recoveryQuery=new URLSearchParams();if(locale!=='en')recoveryQuery.set('locale',locale);recoveryQuery.set('enable-semantics','true');
 const esc=(s:string)=>s.replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));
 const t=(key:keyof typeof catalog.locales.en)=>esc(catalog.locales[locale][key]);const own=(key:keyof typeof policy.locales.en)=>policy.locales[locale][key];
 root.innerHTML=`<main class="auth-shell auth-recovery-shell" data-cy="screen-auth-recovery"><form class="auth-card" data-cy="recovery-form">${media.brand()}<p class="eyebrow">${esc(portalName)}</p><h1>${t(mode==='forgot'?'forgot_title':'reset_title')}</h1><p>${t(mode==='forgot'?'forgot_body':'reset_body')}</p><label>${t('email')}<input name="email" type="email" autocomplete="username" maxlength="254" required data-cy="recovery-email"></label>${mode==='reset'?`<p>${esc(own('reset_guidance'))}</p><label>${t('code')}<input name="code" autocomplete="one-time-code" minlength="12" maxlength="12" pattern="[A-Fa-f0-9]{12}" required data-cy="recovery-code"></label><label>${t('new_password')}<input name="newPassword" type="password" autocomplete="new-password" minlength="12" maxlength="72" required data-cy="recovery-password"></label><label>${t('confirm_password')}<input name="confirmation" type="password" autocomplete="new-password" minlength="12" maxlength="72" required data-cy="recovery-confirm"></label>`:''}<button type="submit" data-cy="recovery-submit">${t(mode==='forgot'?'recovery_action':'reset_action')}</button><output role="status" data-cy="recovery-status"></output>${mode==='forgot'?`<a data-cy="recovery-reset-link" href="${policy.routes.reset}?${recoveryQuery}">${esc(own('reset_ready'))}</a>`:''}<a data-cy="recovery-back" href="${policy.routes.login}?${recoveryQuery}">${t('back')}</a></form></main>`;
 const form=root.querySelector<HTMLFormElement>('[data-cy=recovery-form]')!,button=root.querySelector<HTMLButtonElement>('[data-cy=recovery-submit]')!,status=root.querySelector<HTMLOutputElement>('[data-cy=recovery-status]')!;let busy=false;
 form.onsubmit=event=>{event.preventDefault();if(busy)return;const fields=new FormData(form),email=String(fields.get('email')??'').trim(),password=String(fields.get('newPassword')??'');
 if(mode==='reset'&&(password!==fields.get('confirmation')||password.length<12||new TextEncoder().encode(password).length>72)){status.value=own('password_mismatch');return;}
 busy=true;button.disabled=true;status.value=own('recovery_loading');
 void recoverAccount(gateway,mode,mode==='forgot'?{email}:{email,code:String(fields.get('code')??'').trim(),newPassword:password}).then(()=>{if(mode==='reset')form.reset();status.value=mode==='forgot'?catalog.locales[locale].recovery_sent:own('reset_success');}).catch(error=>{status.value=own(error instanceof RecoveryError&&error.status===503?'recovery_unavailable':error instanceof RecoveryError&&error.status===429?'recovery_limit':'recovery_error');}).finally(()=>{busy=false;button.disabled=false;for(const name of ['code','newPassword','confirmation']){const field=form.elements.namedItem(name);if(field instanceof HTMLInputElement)field.value='';}});
 };
}
