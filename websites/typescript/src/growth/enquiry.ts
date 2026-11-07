import {requireScreenManager,showScreenConfigurationError} from '../../../../packages/primecare_ui/web/screen-manager';
import {resolveManagedRoute} from '../managed-routes';
import {mountPresentationLayout} from '../../../../packages/primecare_ui/web/layout-customizer';
import {createScreenTextBinding,screenLocale} from '../screen-text-binding';
import {registry} from '../../../../packages/shared/src/growth/contract';
import {EnquiryClient} from './enquiry-client';
import {esc,formValues} from './forms';
const owners=new WeakMap<HTMLElement,()=>void>();
export async function renderEnquiry(root:HTMLElement,gateway:string){
 owners.get(root)?.();
 const manager=requireScreenManager(root),entry=resolveManagedRoute(location.pathname,''),route=location.pathname+location.search;
 const events=root.ownerDocument.defaultView??window,resumes=new Set<()=>void>();
 let alive=true,suspended=false,generation=0,nodes=Array.from(root.childNodes),observer:MutationObserver|undefined,disposeLabels=()=>{};
 const release=()=>{for(const resolve of resumes)resolve();resumes.clear();};
 function dispose(){if(!alive)return;alive=false;suspended=false;generation++;release();observer?.disconnect();disposeLabels();events.removeEventListener('popstate',history);events.removeEventListener('hashchange',history);events.removeEventListener('pagehide',hide);events.removeEventListener('pageshow',show);if(owners.get(root)===dispose)owners.delete(root);}
 function owned(){if(!alive||owners.get(root)!==dispose)return false;const now=Array.from(root.childNodes);if(!root.isConnected||now.length!==nodes.length||now.some((node,i)=>node!==nodes[i])){dispose();return false;}return true;}
 function context(){if(!owned())return false;if(entry.adapter!=='enquiry'||location.pathname+location.search!==route){dispose();root.replaceChildren();return false;}return true;}
 function current(){if(suspended||!context())return false;try{manager.enter(entry.id,entry.route);}catch(error){if(owned()){dispose();showScreenConfigurationError(root,error);}return false;}return context();}
 const wait=()=>suspended&&alive?new Promise<void>(resolve=>resumes.add(resolve)):Promise.resolve();
 const history=()=>{if(!suspended)context();};
 const hide=(event:PageTransitionEvent)=>{if(event.persisted)suspended=true;else dispose();};
 const show=(event:PageTransitionEvent)=>{if(event.persisted&&suspended&&alive){suspended=false;current();release();}};
 owners.set(root,dispose);observer=new MutationObserver(()=>owned());observer.observe(root.ownerDocument,{childList:true,subtree:true});
 events.addEventListener('popstate',history);events.addEventListener('hashchange',history);events.addEventListener('pagehide',hide);events.addEventListener('pageshow',show);
 if(!current())return;
 let locale=screenLocale(root),config:any,busy=false,received=false;
 const client=new EnquiryClient(gateway,location.pathname.slice(registry.intakePolicy.route.length));
 const labels=createScreenTextBinding(root,gateway,{growth_enquiry:registry.locales},()=>locale);disposeLabels=()=>labels.dispose();
 // Consent terms and health/emergency guidance stay bound to the bundled contract.
 const t=(key:string)=>['enquiry_consent','enquiry_share','enquiry_note'].includes(key)?esc((registry.locales[locale] as Record<string,string>)[key]):labels.markup('growth_enquiry',key);
 mountPresentationLayout(root,registry.visual.theme);
 try{config=await client.request();await wait();if(!current())return;}catch{await wait();if(!current())return;generation++;root.innerHTML=`<main class="auth-shell" data-cy="screen-growth-public-enquiry"><section class="auth-card"><h1>${t('enquiry_title')}</h1><p role="alert" data-cy="enquiry-status">${t('enquiry_unavailable')}</p></section></main>`;nodes=Array.from(root.childNodes);labels.bind();return;}
 const draw=()=>{
  if(!current())return;const drawn=++generation;const active=()=>drawn===generation&&current();
  const old=root.querySelector<HTMLFormElement>('[data-cy=enquiry-form]'),values=old?formValues(old):{},consent=old?.querySelector<HTMLInputElement>('[name=consent]')?.checked??false,sharingConsent=old?.querySelector<HTMLInputElement>('[name=sharingConsent]')?.checked??false;
  root.innerHTML=`<main class="auth-shell" data-cy="screen-growth-public-enquiry"><section class="auth-card"><label>${t('language')}<select data-cy="enquiry-language">${['en','fr','es'].map(l=>`<option value="${l}" ${l===locale?'selected':''}>${l.toUpperCase()}</option>`).join('')}</select></label><h1>${esc(config.name)}</h1><p>${t(config.pipeline)}</p><p>${t('enquiry_note')}</p><p role="status" aria-live="polite" tabindex="-1" data-cy="enquiry-status">${received?t('enquiry_received'):''}</p>${received?'':`<form class="enquiry-form" data-cy="enquiry-form"><label>${t('name')}<input name="name" autocomplete="name" maxlength="150" required data-cy="enquiry-name" value="${esc(values.name)}"></label><p>${t('enquiry_contact')}</p><label>${t('email')}<input name="email" type="email" autocomplete="email" maxlength="254" data-cy="enquiry-email" value="${esc(values.email)}"></label><label>${t('phone')}<input name="phone" type="tel" autocomplete="tel" maxlength="40" data-cy="enquiry-phone" value="${esc(values.phone)}"></label>${config.routingMode==='territory'?`<label>${t('enquiry_postal')}<input name="postalCode" required autocomplete="postal-code" maxlength="7" data-cy="enquiry-postal" value="${esc(values.postalCode)}"></label><label>${t('enquiry_service')}<select name="service" data-cy="enquiry-service">${['psw','home_care'].map(k=>`<option data-screen-catalog="growth_enquiry" data-screen-text="${k}" value="${k}" ${values.service===k?'selected':''}>${esc(labels.text('growth_enquiry',k))}</option>`).join('')}</select></label><label class="enquiry-consent"><input type="checkbox" name="sharingConsent" required data-cy="enquiry-sharing-consent" ${sharingConsent?'checked':''}>${t('enquiry_share')}</label>`:''}<input hidden name="website" tabindex="-1" autocomplete="off" data-cy="enquiry-website" value=""><label class="enquiry-consent"><input type="checkbox" name="consent" required data-cy="enquiry-consent" ${consent?'checked':''}>${t('enquiry_consent')}</label><button data-cy="enquiry-submit">${t('enquiry_submit')}</button></form>`}</section></main>`;
  nodes=Array.from(root.childNodes);
  root.querySelector<HTMLSelectElement>('[data-cy=enquiry-language]')!.onchange=e=>{if(active()&&!busy){locale=(e.target as HTMLSelectElement).value as typeof locale;draw();}};
  labels.bind();const form=root.querySelector<HTMLFormElement>('[data-cy=enquiry-form]');if(!form)return;
  form.onsubmit=async e=>{e.preventDefault();if(!active()||busy||!root.contains(form))return;busy=true;const button=root.querySelector<HTMLButtonElement>('[data-cy=enquiry-submit]')!,language=root.querySelector<HTMLSelectElement>('[data-cy=enquiry-language]')!;button.disabled=true;language.disabled=true;
   try{const v=formValues(form);await client.request({name:v.name,email:v.email,phone:v.phone,website:v.website,consent:form.querySelector<HTMLInputElement>('[name=consent]')!.checked,consentVersion:config.consentVersion,...(config.routingMode==='territory'?{postalCode:v.postalCode,service:v.service,sharingConsent:form.querySelector<HTMLInputElement>('[name=sharingConsent]')!.checked,sharingConsentVersion:config.sharingConsentVersion}:{})});await wait();if(!active())return;received=true;draw();if(!current())return;root.querySelector<HTMLElement>('[data-cy=enquiry-status]')!.focus();}catch{await wait();if(!active())return;root.querySelector<HTMLElement>('[data-cy=enquiry-status]')!.textContent=labels.text('growth_enquiry','enquiry_error');button.disabled=false;language.disabled=false;}finally{busy=false;}
  };
 };
 draw();
}
