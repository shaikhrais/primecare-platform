/** Shared current-account form; labels are escaped by each caller. */
export function accountMarkup(label:(key:string)=>string):string {
 return `<section class="section"><form data-cy="change-password-form"><label>${label('current_password')}<input required type="password" name="currentPassword" autocomplete="current-password" data-cy="current-password"></label><label>${label('new_password')}<input required minlength="12" type="password" name="newPassword" autocomplete="new-password" data-cy="new-password"></label><button type="submit" data-cy="change-password-submit">${label('change_password')}</button><output role="status" data-cy="change-password-status"></output></form></section>`;
}
export function bindAccount(root:HTMLElement,gateway:string,token:string,failed:string,unavailable:string):void {
 const form=root.querySelector<HTMLFormElement>('[data-cy=change-password-form]');if(!form)return;
 form.onsubmit=async event=>{event.preventDefault();const values=new FormData(form);const output=form.querySelector<HTMLOutputElement>('output')!;const button=form.querySelector<HTMLButtonElement>('button')!;button.disabled=true;
 try{const response=await fetch(gateway.replace(/\/+$/,'')+'/v1/user/change-password',{method:'POST',headers:{authorization:'Bearer '+token,'content-type':'application/json'},body:JSON.stringify(Object.fromEntries(values))});const data=await response.json();if(response.ok){sessionStorage.removeItem('primecare_session');location.assign('/login?enable-semantics=true');}else output.value=data.error??failed;}catch{output.value=unavailable;}finally{button.disabled=false;}};
}
