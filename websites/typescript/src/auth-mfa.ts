import catalog from '../../../packages/shared/src/auth-mfa.json';
export type MfaChallenge = {challenge:string;purpose:'enroll'|'verify';setupKey?:string};
/** Present a password-verified challenge in memory only. No seed/token storage. */
export function requestMfa(parent:HTMLElement,challenge:MfaChallenge,locale:'en'|'fr'|'es',verify:(code:string)=>Promise<string>):Promise<string> {
 const text=catalog.locales[locale];
 const form=document.createElement('form');form.className='auth-card';form.dataset.cy='mfa-form';form.setAttribute('aria-label',text.title);
 const heading=document.createElement('h2');heading.textContent=text.title;form.append(heading);
 if(challenge.purpose==='enroll') {
  const instruction=document.createElement('p');instruction.textContent=text.setup;form.append(instruction);
  const seed=document.createElement('code');seed.dataset.cy='mfa-seed';seed.textContent=challenge.setupKey??'';form.append(seed);
 }
 const label=document.createElement('label');label.textContent=text.code;
 const input=document.createElement('input');input.dataset.cy='mfa-code';input.name='code';input.required=true;input.pattern='[0-9]{6}';input.maxLength=6;input.inputMode='numeric';input.autocomplete='one-time-code';label.append(input);form.append(label);
 const submit=document.createElement('button');submit.type='submit';submit.dataset.cy='mfa-submit';submit.textContent=text.submit;form.append(submit);
 const cancel=document.createElement('button');cancel.type='button';cancel.dataset.cy='mfa-cancel';cancel.textContent=text.cancel;form.append(cancel);
 const status=document.createElement('output');status.dataset.cy='mfa-status';status.setAttribute('aria-live','polite');form.append(status);parent.append(form);input.focus();
 return new Promise((resolve,reject)=>{
  let busy=false;
  const clean=()=>{input.value='';form.remove();};
  cancel.onclick=()=>{if(busy)return;clean();reject(Error('MFA cancelled'));};
  form.onsubmit=async event=>{event.preventDefault();if(busy||!form.reportValidity())return;busy=true;submit.disabled=true;cancel.disabled=true;status.textContent=text.loading;
   try{const token=await verify(input.value);clean();resolve(token);}catch{input.value='';status.textContent=text.error;input.focus();}finally{busy=false;submit.disabled=false;cancel.disabled=false;}
  };
 });
}
