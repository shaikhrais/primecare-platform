const escape=(v:unknown)=>String(v??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));
export async function renderMaintenance(root:HTMLElement,gateway:string) {
 const token=sessionStorage.getItem('primecare_session');
 if(!token){location.assign('/login?returnUrl=/maintenance/configuration');return;}
 const endpoint=gateway.replace(/\/+$/,'')+'/v1/auth/maintenance/configuration';
 const headers={'content-type':'application/json',authorization:'Bearer '+token};
 let status:HTMLOutputElement|null=null;
 const request=async(url:string,body?:unknown)=>{
  const r=await fetch(url,{method:body===undefined?'GET':'POST',headers,cache:'no-store',...(body===undefined?{}:{body:JSON.stringify(body)})});
  const data=await r.json() as Record<string,any>;
  if(!r.ok)throw new Error(typeof data.error==='string'?data.error:`HTTP ${r.status}`);
  return data;
 };
 root.innerHTML='<main class="auth-shell"><p role="status">Loading maintenance configuration…</p></main>';
 try {
  const identity=await request(gateway.replace(/\/+$/,'')+'/v1/auth/me');
  if(!['ceo','maintenance'].includes(identity.roles))throw new Error('CEO or maintenance access required.');
  const data=await request(endpoint);
  root.innerHTML=`<main class="maintenance"><header><p class="eyebrow">PrimeCare · IT maintenance</p><h1>Organization configuration</h1><a href="/">Portal</a> · <button id="signout">Sign out</button></header>
  <p>Manage settings for your organization. This account does not grant access to patient records or other organizations.</p><output id="maintenance-status" aria-live="polite"></output>
  <section class="section"><h2>Status and pending work</h2><p>${data.emailReady?'Email configuration is present. Inbox delivery still needs verification.':'Email setup is incomplete. Password recovery cannot send email yet.'}</p><ol>${data.pending.map((task:string)=>`<li>${escape(task)}</li>`).join('')}</ol></section>
  <form id="settings" class="section"><h2>Email delivery</h2><p>Provider: Cloudflare Email Service. No provider API key is required.</p>
  <label>Verified sender email<input name="sender" type="email" maxlength="254" required value="${escape(data.sender)}"></label>
  <h2>Shared email templates</h2><p>Edit plain text and keep every required {{placeholder}}. Only password recovery is currently connected to an event.</p>
  ${Object.entries(data.templates).map(([id,t]:[string,any])=>`<details><summary>${escape(id.replaceAll('_',' '))} · required: ${escape(t.required.join(', '))}</summary>${['subject','title','body'].map(field=>`<label>${field}${field==='body'?`<textarea data-template="${escape(id)}" data-field="${field}" rows="4" required maxlength="4000">${escape(t[field])}</textarea>`:`<input data-template="${escape(id)}" data-field="${field}" required maxlength="200" value="${escape(t[field])}">`}</label>`).join('')}</details>`).join('')}
  <button type="submit" ${data.settingsReady?'':'disabled'}>Save settings and templates</button><button type="button" id="test-email">Send test email to my signed-in account</button></form>
  <section class="section"><h2>Deployment configuration</h2>${data.externalConfiguration.map((item:any)=>`<h3>${escape(item.name)}</h3><p>${escape(item.value)}</p><p>${escape(item.instructions)}</p>`).join('')}</section>
  ${identity.roles==='ceo'?`<form id="create-account" class="section"><h2>Create IT maintenance account</h2><p>Create one named account per IT member. Share access through your approved IT process.</p><label>IT member email<input name="email" type="email" required maxlength="254"></label><label>Initial password<input name="password" type="password" minlength="12" required autocomplete="new-password"></label><button>Create maintenance account</button></form>`:''}
  <section class="section"><h2>Recent activity</h2><ul>${data.audit.length?data.audit.map((item:any)=>`<li>${escape(item.action)} · ${escape(item.created_at)}</li>`).join(''):'<li>No maintenance changes recorded.</li>'}</ul></section></main>`;
  status=root.querySelector('#maintenance-status');
  const action=async(button:HTMLButtonElement,operation:()=>Promise<Record<string,any>>)=>{
   const buttons=[...root.querySelectorAll<HTMLButtonElement>('button')];buttons.forEach(b=>b.disabled=true);
   try{const r=await operation();root.querySelectorAll<HTMLInputElement>('input[type=password]').forEach(i=>i.value='');if(status)status.value=r.message??'Maintenance account created. Share access through your approved IT process.';if(r.message?.startsWith('Settings saved')){await renderMaintenance(root,gateway);const refreshed=root.querySelector<HTMLOutputElement>('#maintenance-status');if(refreshed)refreshed.value=r.message;}}
   catch(e){if(status)status.value=e instanceof Error?e.message:'Request failed';}
   finally{buttons.forEach(b=>b.disabled=false);if(!data.settingsReady){const save=root.querySelector<HTMLButtonElement>('#settings button[type=submit]');if(save)save.disabled=true;}}
  };
  root.querySelector<HTMLFormElement>('#settings')!.addEventListener('submit',event=>{
   event.preventDefault();const form=event.currentTarget as HTMLFormElement;const values=new FormData(form);
   const templates:Record<string,Record<string,string>>={};root.querySelectorAll<HTMLInputElement|HTMLTextAreaElement>('[data-template]').forEach(field=>{const id=field.dataset.template!;templates[id]??={};templates[id][field.dataset.field!]=field.value;});
   void action(form.querySelector('button')!,()=>request(endpoint,{sender:values.get('sender'),revision:data.revision,templates}));
  });
  const test=root.querySelector<HTMLButtonElement>('#test-email')!;test.addEventListener('click',()=>void action(test,()=>request(endpoint+'/test-email',{})));
  root.querySelector<HTMLFormElement>('#create-account')?.addEventListener('submit',event=>{event.preventDefault();const form=event.currentTarget as HTMLFormElement;const v=new FormData(form);void action(form.querySelector('button')!,()=>request(gateway.replace(/\/+$/,'')+'/v1/auth/register',{email:v.get('email'),password:v.get('password'),role:'maintenance'}));});
  root.querySelector('#signout')!.addEventListener('click',async()=>{try{await request(gateway.replace(/\/+$/,'')+'/v1/auth/logout',{});}finally{sessionStorage.removeItem('primecare_session');location.assign('/login');}});
 }catch(e){root.innerHTML=`<main class="auth-shell"><section class="auth-card"><h1>Maintenance unavailable</h1><p role="alert">${escape(e instanceof Error?e.message:'Cannot connect')}</p><a href="/login?returnUrl=/maintenance/configuration">Sign in</a></section></main>`;}
}
