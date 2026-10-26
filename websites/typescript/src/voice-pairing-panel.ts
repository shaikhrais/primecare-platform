import {mountVoiceOtpPanel,type VoiceOtpAppSession} from '../../../packages/shared/src/communications/voice-otp-app.mjs';

export function voicePairingMarkup():string {
 return '<section class="section operations-board" data-cy="voice-pairing"><h2>Verify your current call</h2><p>Keep your call connected. Use the call reference and pairing code provided by the secure call instructions. Enter SMS codes here only; never speak them to the AI.</p><form data-cy="voice-pairing-open"><label>Call reference<input name="callSid" required pattern="CA[a-fA-F0-9]{32}" maxlength="34" autocomplete="off" spellcheck="false"></label><button type="submit">Continue verification</button></form><div data-cy="voice-pairing-flow"></div><button type="button" data-cy="voice-pairing-close" hidden>Close verification</button><p role="status" data-cy="voice-pairing-status"></p></section>';
}
/** Uses the registered native bearer boundary; codes never enter URL/storage or AI prompts. */
export function bindVoicePairing(root:HTMLElement,gateway:string,token:string):()=>void {
 const panel=root.querySelector<HTMLElement>('[data-cy=voice-pairing]');if(!panel)return()=>{};
 const form=panel.querySelector<HTMLFormElement>('form')!,flow=panel.querySelector<HTMLElement>('[data-cy=voice-pairing-flow]')!,close=panel.querySelector<HTMLButtonElement>('[data-cy=voice-pairing-close]')!,status=panel.querySelector<HTMLElement>('[data-cy=voice-pairing-status]')!;
 let session:VoiceOtpAppSession|undefined,disposed=false;
 const current=()=>!disposed&&sessionStorage.getItem('primecare_session')===token?token:null;
 const request=async(path:string,input:unknown)=>{
  if(!current())throw Error('Session changed');
  const response=await fetch(gateway.replace(/\/+$/,'')+'/v1/voice/otp/'+path,{method:'POST',credentials:'omit',redirect:'error',headers:{authorization:'Bearer '+token,'content-type':'application/json'},body:JSON.stringify(input)});
  if(!current()||!response.ok)throw Error('Verification unavailable');
  const result:unknown=await response.json();if(!current())throw Error('Session changed');return result as Record<string,unknown>;
 };
 const reset=()=>{session?.close();session=undefined;flow.replaceChildren();form.reset();form.hidden=false;close.hidden=true;};
 const onSubmit=(event:SubmitEvent)=>{
  event.preventDefault();if(!current()||session)return;
  const input=form.elements.namedItem('callSid') as HTMLInputElement,callSid=input.value;input.value='';status.textContent='';
  try{session=mountVoiceOtpPanel({element:flow,callSid,currentScope:current,transport:{start:async value=>{const result=await request('start',value);if(result.verificationRequested!==true)throw Error('Invalid receipt');return {verificationRequested:true};},check:async value=>{const result=await request('check',value);if(typeof result.verified!=='boolean')throw Error('Invalid receipt');return {verified:result.verified};}}});form.hidden=true;close.hidden=false;}
  catch{reset();status.textContent='Verification is unavailable. Contact reception.';}
 };
 const onClose=()=>{reset();status.textContent='Verification closed.';};
 const onSession=()=>{if(!current()){reset();status.textContent='Your session changed. Sign in again to verify a call.';}};
 form.addEventListener('submit',onSubmit);close.addEventListener('click',onClose);window.addEventListener('storage',onSession);window.addEventListener('pagehide',onClose);
 return()=>{disposed=true;reset();form.removeEventListener('submit',onSubmit);close.removeEventListener('click',onClose);window.removeEventListener('storage',onSession);window.removeEventListener('pagehide',onClose);};
}
