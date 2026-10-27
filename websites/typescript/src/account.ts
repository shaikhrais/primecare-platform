import {smsVerificationMarkup,bindSmsVerification} from './sms-verification-panel';
import {voicePairingMarkup,bindVoicePairing} from './voice-pairing-panel';
import {sessionsMarkup,bindSessions} from './sessions-panel';
const sessionBindings=new WeakMap<HTMLElement,()=>void>();
import {AccountClient,AccountRequestError} from './account-client';
/** Shared current-account form; labels are escaped by each caller. */
export function accountMarkup(label:(key:string)=>string):string {
 return smsVerificationMarkup()+`<section class="section"><h2>${label('change_password')}</h2><form data-cy="change-password-form"><label>${label('current_password')}<input required type="password" name="currentPassword" autocomplete="current-password" data-cy="current-password"></label><label>${label('new_password')}<input required minlength="12" type="password" name="newPassword" autocomplete="new-password" data-cy="new-password"></label><button type="submit" data-cy="change-password-submit">${label('change_password')}</button><output role="status" data-cy="change-password-status"></output></form></section>`+sessionsMarkup()+voicePairingMarkup();
}
export function bindAccount(root:HTMLElement,gateway:string,token:string,failed:string,unavailable:string):void {
 sessionBindings.get(root)?.();sessionBindings.delete(root);
 const form=root.querySelector<HTMLFormElement>('[data-cy=change-password-form]');if(!form)return;
 const closeSessions=bindSessions(root,gateway,token),closePairing=bindVoicePairing(root,gateway,token),closeSms=bindSmsVerification(root,gateway,token);
 sessionBindings.set(root,()=>{closeSessions();closePairing();closeSms();});
 const client=new AccountClient(gateway,token);let busy=false;
 form.onsubmit=async event=>{event.preventDefault();if(busy)return;busy=true;const values=new FormData(form);const output=form.querySelector<HTMLOutputElement>('output')!;const button=form.querySelector<HTMLButtonElement>('button')!;button.disabled=true;
 try{await client.changePassword(String(values.get('currentPassword')??''),String(values.get('newPassword')??''));
  if(sessionStorage.getItem('primecare_session')!==token)throw new AccountRequestError(409);
  sessionStorage.removeItem('primecare_session');
  const query=new URLSearchParams();const locale=document.documentElement.lang;if(locale==='fr'||locale==='es')query.set('locale',locale);query.set('enable-semantics','true');
  location.assign('/login?'+query);
 }catch(error){output.value=error instanceof AccountRequestError&&error.status<500?failed:unavailable;}finally{busy=false;button.disabled=false;}};
}
