import {renderShell,bindShell} from './shell';
import {MaintenanceClient} from './maintenance-client';
import catalog from '../../../packages/shared/src/maintenance.json';
const escape=(value:unknown)=>String(value??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));

export async function renderMaintenance(root:HTMLElement,gateway:string){
 const locale=document.documentElement.lang,token=sessionStorage.getItem('primecare_session');
 const client=new MaintenanceClient(gateway,token??'',locale),c=client.controls,t=(key:keyof typeof catalog.locales.en)=>escape(client.text(key)),m=(value:unknown)=>escape(client.message(value));
 if(!token){location.assign(client.route('login'));return;}
 root.innerHTML=`<main class="auth-shell" data-cy="${c.screen}"><p role="status">${t('loading')}</p></main>`;
 try{
  const identity=await client.identify(),data=await client.read();
  renderShell(root,{home:client.route('portal'),role:escape(identity.roles),navigation:`<a href="${client.route('configuration')}">${t('title')}</a><a href="${client.route('account')}">${t('account')}</a>`,controls:`<a href="${client.route('account')}">${t('account')}</a><a href="${client.route('portal')}">${t('portal')}</a><button id="signout" data-cy="${c.signout}">${t('signout')}</button>`,mainAttributes:`class="maintenance" data-cy="${c.screen}"`,content:`<h1>${t('title')}</h1><p>${t('intro')}</p>
   <output data-cy="${c.status}" aria-live="polite"></output><button type="button" data-cy="${c.refresh}">${t('refresh')}</button>
   <section class="section" data-cy="${c.pending}"><h2>${t('pendingTitle')}</h2><p>${data.emailReady?t('ready'):t('notReady')}</p><ol>${data.pending.map(task=>`<li>${m(task)}</li>`).join('')}</ol></section>
   <form class="section" data-cy="${c.settings}"><h2>${t('delivery')}</h2><p>${t('provider')}</p><label>${t('sender')}<input name="sender" data-cy="${c.sender}" type="email" maxlength="254" required value="${escape(data.sender)}"></label>
   <h2>${t('templates')}</h2><p>${t('templateHelp')}</p>${Object.entries(data.templates).map(([id,value])=>`<details><summary>${escape(client.templateName(id))} · ${t('required')}: ${escape(value.required.join(', '))}</summary>${(['subject','title','body'] as const).map(field=>`<label>${t(field==='title'?'templateTitle':field)}${field==='body'?`<textarea data-template="${escape(id)}" data-field="${field}" data-cy="${client.templateControl(id,field)}" rows="4" required maxlength="4000">${escape(value[field])}</textarea>`:`<input data-template="${escape(id)}" data-field="${field}" data-cy="${client.templateControl(id,field)}" required maxlength="200" value="${escape(value[field])}">`}</label>`).join('')}</details>`).join('')}
   <button data-cy="${c.save}" type="submit" ${data.settingsReady?'':'disabled'}>${t('save')}</button><button data-cy="${c.testEmail}" type="button">${t('testEmail')}</button></form>
   <section class="section" data-cy="${c.deployment}"><h2>${t('deployment')}</h2>${data.externalConfiguration.map(item=>`<h3>${m(item.name)}</h3><p>${m(item.value)}</p><p>${m(item.instructions)}</p>`).join('')}</section>
   ${client.canCreateMaintenance?`<form class="section" data-cy="${c.createAccount}"><h2>${t('createTitle')}</h2><p>${t('createHelp')}</p><label>${t('accountEmail')}<input name="email" data-cy="${c.accountEmail}" type="email" required maxlength="254"></label><label>${t('accountPassword')}<input name="password" data-cy="${c.accountPassword}" type="password" minlength="12" required autocomplete="new-password"></label><button data-cy="${c.createSubmit}">${t('createSubmit')}</button></form>`:''}
   <section class="section" data-cy="${c.audit}"><h2>${t('audit')}</h2><ul>${data.audit.length?data.audit.map(item=>`<li>${m(item.action)} · ${escape(item.created_at)}</li>`).join(''):`<li>${t('emptyAudit')}</li>`}</ul></section>`});
  const cy=(id:string)=>root.querySelector<HTMLElement>('[data-cy="'+id+'"]')!;
  bindShell(root,client.text('title'),client.locale,client.text('tasks'),()=>[{title:client.text('title'),detail:client.text('settingsDetail'),open:()=>cy(c.settings).scrollIntoView()},{title:client.text('account'),detail:client.text('account'),open:()=>location.assign(client.route('account'))}],identity.roles+':'+identity.userId);
  const status=cy(c.status) as HTMLOutputElement;
  const action=async(button:HTMLButtonElement,operation:()=>Promise<Record<string,unknown>>)=>{
   const buttons=[...root.querySelectorAll<HTMLButtonElement>('button')];buttons.forEach(item=>item.disabled=true);
   try{const result=await operation();root.querySelectorAll<HTMLInputElement>('input[type=password]').forEach(input=>input.value='');await renderMaintenance(root,gateway);const refreshed=root.querySelector<HTMLOutputElement>('[data-cy="'+c.status+'"]');if(refreshed)refreshed.value=result.message?client.message(result.message):client.text('created');}
   catch(error){status.value=error instanceof Error?error.message:client.text('failed');}
   finally{buttons.forEach(item=>item.disabled=false);if(!data.settingsReady)(cy(c.save) as HTMLButtonElement).disabled=true;}
  };
  cy(c.refresh).addEventListener('click',()=>void renderMaintenance(root,gateway));
  cy(c.settings).addEventListener('submit',event=>{event.preventDefault();const form=event.currentTarget as HTMLFormElement,values=new FormData(form),templates:Record<string,Record<string,string>>={};form.querySelectorAll<HTMLInputElement|HTMLTextAreaElement>('[data-template]').forEach(field=>{const id=field.dataset.template!;templates[id]??={};templates[id][field.dataset.field!]=field.value;});void action(cy(c.save) as HTMLButtonElement,()=>client.save({sender:values.get('sender'),revision:data.revision,templates}));});
  cy(c.testEmail).addEventListener('click',()=>void action(cy(c.testEmail) as HTMLButtonElement,()=>client.testEmail()));
  root.querySelector('[data-cy="'+c.createAccount+'"]')?.addEventListener('submit',event=>{event.preventDefault();const values=new FormData(event.currentTarget as HTMLFormElement);void action(cy(c.createSubmit) as HTMLButtonElement,()=>client.createAccount(values.get('email'),values.get('password')));});
  cy(c.signout).addEventListener('click',async()=>{try{await client.logout();location.assign(client.route('login'));}catch{status.value=client.text('failed');}});
 }catch(error){root.innerHTML=`<main class="auth-shell" data-cy="${c.screen}"><section class="auth-card"><h1>${t('unavailable')}</h1><p role="alert">${escape(error instanceof Error?error.message:client.text('cannotConnect'))}</p><button type="button" data-cy="${c.refresh}">${t('refresh')}</button><a href="${client.route('login')}">${t('signin')}</a></section></main>`;root.querySelector('[data-cy="'+c.refresh+'"]')?.addEventListener('click',()=>void renderMaintenance(root,gateway));}
}
