import catalog from '../../../packages/shared/src/account-mutations.json';
import {AccountMutationsClient,creationActor} from './account-mutations-client';
import type {AccountRow} from './tenant-accounts-client';
const escape=(v:unknown)=>String(v??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));
const id=(key:keyof typeof catalog.controls)=>catalog.controls[key].testId;
const labels=()=>catalog.locales[document.documentElement.lang==='fr'?'fr':document.documentElement.lang==='es'?'es':'en'];
export const mutationActorForScreen=(code:string,role:string)=>creationActor(role)?.screenCode===code;
export function accountCreationMarkup(){return '<section class="section operations-board" data-cy="'+id('createRoot')+'"></section>';}
export function bindAccountCreation(root:HTMLElement,gateway:string,token:string,role:string,roleLabel:(v:string)=>string):()=>void{
 const actor=creationActor(role),panel=root.querySelector<HTMLElement>('[data-cy="'+id('createRoot')+'"]');if(!actor||!panel)return()=>{};
 const t=(key:keyof typeof catalog.locales.en)=>escape(labels()[key]);let disposed=false,busy=false;
 panel.innerHTML='<h2>'+t('create')+'</h2><form data-cy="'+id('createForm')+'"><label>'+t('email')+'<input type="email" required maxlength="254" autocomplete="off" data-cy="'+id('email')+'"></label><label>'+t('password')+'<input type="password" required minlength="12" autocomplete="new-password" data-cy="'+id('password')+'"></label><label>'+t('role')+'<select required data-cy="'+id('createRole')+'"><option value="" disabled selected>'+t('role')+'</option>'+actor.targets.map(value=>'<option value="'+escape(value)+'">'+escape(roleLabel(value))+'</option>').join('')+'</select></label><button type="submit" data-cy="'+id('createSubmit')+'">'+t('create')+'</button><output role="status" aria-live="polite" data-cy="'+id('createStatus')+'"></output></form>';
 const form=panel.querySelector<HTMLFormElement>('form')!,client=new AccountMutationsClient(gateway,token,role),field=(key:'email'|'password'|'createRole')=>panel.querySelector<HTMLInputElement|HTMLSelectElement>('[data-cy="'+id(key)+'"]')!,output=panel.querySelector<HTMLOutputElement>('output')!,button=panel.querySelector<HTMLButtonElement>('button')!;
 form.onsubmit=async e=>{e.preventDefault();if(busy||disposed)return;busy=true;button.disabled=true;output.value=labels().busy;const email=field('email').value,password=field('password').value,targetRole=field('createRole').value;
 try{const created=await client.create(email,password,targetRole);if(disposed)return;field('password').value='';field('email').value='';output.value=labels().created+': '+created.email;root.dispatchEvent(new CustomEvent('tenant-account-created',{detail:{email:created.email}}));}
 catch{if(!disposed){field('password').value='';output.value=labels().failed;}}
 finally{if(!disposed){busy=false;button.disabled=false;}}};
 return()=>{disposed=true;form.onsubmit=null;field('password').value='';};
}
export function accountMutationMarkup(){return '<section class="section" data-cy="'+id('manageRoot')+'"></section>';}
export function bindAccountMutation(root:HTMLElement,gateway:string,token:string,actorRole:string,target:AccountRow,roles:string[],roleLabel:(v:string)=>string,changed:()=>void):()=>void{
 const panel=root.querySelector<HTMLElement>('[data-cy="'+id('manageRoot')+'"]');if(!panel)return()=>{};
 const t=(key:keyof typeof catalog.locales.en)=>escape(labels()[key]);let disposed=false,busy=false,confirming=false;
 if(!target.canModify){panel.textContent=labels().protected;return()=>{};}
 panel.innerHTML='<form><label>'+t('role')+'<select required data-cy="'+id('manageRole')+'"><option value="" disabled '+(!roles.includes(target.roles??'')?'selected':'')+'>'+t('role')+'</option>'+roles.map(role=>'<option value="'+escape(role)+'" '+(role===target.roles?'selected':'')+'>'+escape(roleLabel(role))+'</option>').join('')+'</select></label><label>'+t('status')+'<select required data-cy="'+id('manageStatus')+'"><option value="" disabled '+(!['active','inactive'].includes(target.status??'')?'selected':'')+'>'+t('status')+'</option>'+(['active','inactive'] as const).map(status=>'<option value="'+status+'" '+(status===target.status?'selected':'')+'>'+t(status)+'</option>').join('')+'</select></label><button type="submit" data-cy="'+id('save')+'">'+t('save')+'</button></form><button type="button" data-cy="'+id('revoke')+'">'+t('revoke')+'</button><div role="group" aria-label="'+t('confirmation')+'" data-cy="'+id('confirmation')+'" hidden><p>'+t('confirmation')+'</p><button type="button" data-cy="'+id('confirm')+'">'+t('confirm')+'</button><button type="button" data-cy="'+id('cancel')+'">'+t('cancel')+'</button></div><output role="status" aria-live="polite" data-cy="'+id('operationStatus')+'"></output>';
 const client=new AccountMutationsClient(gateway,token,actorRole),output=panel.querySelector<HTMLOutputElement>('output')!,form=panel.querySelector<HTMLFormElement>('form')!,confirmation=panel.querySelector<HTMLElement>('[data-cy="'+id('confirmation')+'"]')!;
 const button=(key:'revoke'|'confirm'|'cancel')=>panel.querySelector<HTMLButtonElement>('[data-cy="'+id(key)+'"]')!;
 const execute=async(action:()=>Promise<unknown>,message:'saved'|'revoked')=>{if(busy||disposed)return;busy=true;panel.setAttribute('aria-busy','true');panel.querySelectorAll<HTMLButtonElement|HTMLSelectElement>('button,select').forEach(x=>x.disabled=true);output.value=labels().busy;
 try{await action();if(disposed)return;confirmation.hidden=true;confirming=false;output.value=labels()[message];changed();}
 catch{if(!disposed)output.value=labels().failed;}
 finally{if(!disposed){busy=false;panel.setAttribute('aria-busy','false');panel.querySelectorAll<HTMLButtonElement|HTMLSelectElement>('button,select').forEach(x=>x.disabled=false);}}};
 form.onsubmit=e=>{e.preventDefault();void execute(()=>client.save(target,panel.querySelector<HTMLSelectElement>('[data-cy="'+id('manageRole')+'"]')!.value,panel.querySelector<HTMLSelectElement>('[data-cy="'+id('manageStatus')+'"]')!.value),'saved');};
 button('revoke').onclick=()=>{if(busy)return;confirming=true;confirmation.hidden=false;button('confirm').focus();};button('cancel').onclick=()=>{if(busy)return;confirming=false;confirmation.hidden=true;button('revoke').focus();};button('confirm').onclick=()=>{if(confirming)void execute(()=>client.revoke(target),'revoked');};
 return()=>{disposed=true;form.onsubmit=null;};
}
