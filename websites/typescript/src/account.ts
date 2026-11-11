import {smsVerificationMarkup,bindSmsVerification} from './sms-verification-panel';
import {voicePairingMarkup,bindVoicePairing} from './voice-pairing-panel';
import {sessionsMarkup,bindSessions} from './sessions-panel';
const sessionBindings=new WeakMap<HTMLElement,()=>void>();
import {AccountClient,AccountRequestError} from './account-client';
/** Shared current-account form; labels are escaped by each caller. */
export function accountMarkup(label:(key:string)=>string):string {
 return `<div class="account-settings" data-cy="account-settings"><header class="account-intro"><span class="account-eyebrow">YOUR ACCOUNT</span><h2>Security &amp; access</h2><p>Manage your phone, password, and signed-in devices.</p></header><div class="account-card-grid">`+smsVerificationMarkup()+`<section class="section"><h2>${label('change_password')}</h2><form data-cy="change-password-form"><label>${label('current_password')}<input required type="password" name="currentPassword" autocomplete="current-password" data-cy="current-password"></label><label>${label('new_password')}<input required minlength="12" type="password" name="newPassword" autocomplete="new-password" data-cy="new-password"></label><button type="submit" data-cy="change-password-submit">${label('change_password')}</button><output role="status" data-cy="change-password-status"></output></form></section>`+sessionsMarkup()+voicePairingMarkup()+'</div></div>';
}
export function bindAccount(root:HTMLElement,gateway:string,token:string,failed:string,unavailable:string,isCurrent:()=>boolean=()=>true):()=>void {
 sessionBindings.get(root)?.();sessionBindings.delete(root);
 const form=root.querySelector<HTMLFormElement>('[data-cy=change-password-form]');if(!form)return()=>{};
 let disposed=false;const current=()=>!disposed&&isCurrent();
 if(!current())return()=>{};
 const closeSessions=bindSessions(root,gateway,token),closePairing=bindVoicePairing(root,gateway,token),closeSms=bindSmsVerification(root,gateway,token);
 const dispose=()=>{if(disposed)return;disposed=true;form.onsubmit=null;closeSessions();closePairing();closeSms();if(sessionBindings.get(root)===dispose)sessionBindings.delete(root);};
 sessionBindings.set(root,dispose);
 const client=new AccountClient(gateway,token);let busy=false;
 form.onsubmit=async event=>{event.preventDefault();if(busy||!current())return;busy=true;const values=new FormData(form);const output=form.querySelector<HTMLOutputElement>('output')!;const button=form.querySelector<HTMLButtonElement>('button')!;button.disabled=true;let finalizing=false;
 try{await client.changePassword(String(values.get('currentPassword')??''),String(values.get('newPassword')??''));
  if(!current())return;
  if(sessionStorage.getItem('primecare_session')!==token)throw new AccountRequestError(409);
  const query=new URLSearchParams();const locale=document.documentElement.lang;if(locale==='fr'||locale==='es')query.set('locale',locale);query.set('enable-semantics','true');
  // This phase is synchronous and follows the last owner/session check. Do not
  // revalidate a session we intentionally removed, including on a local failure.
  finalizing=true;sessionStorage.removeItem('primecare_session');location.assign('/login?'+query);dispose();
 }catch(error){if(finalizing?!disposed:current())output.value=error instanceof AccountRequestError&&error.status<500?failed:unavailable;}finally{if(finalizing?!disposed:current()){busy=false;button.disabled=false;}}};
 return dispose;
}
