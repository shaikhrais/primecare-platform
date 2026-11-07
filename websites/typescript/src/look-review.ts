import {requireScreenManager,showScreenConfigurationError} from '../../../packages/primecare_ui/web/screen-manager';
import {clearLayoutCustomizer} from '../../../packages/primecare_ui/web/layout-customizer';
import {resolveManagedRoute} from './managed-routes';
import {FormDraft} from './form-draft';
import {DashboardMediaLook} from './media-look';
import {registry} from '../../../packages/shared/src/look/manager';
import daylight from '../../../packages/shared/src/growth/registry.json';
import {renderShell,bindShell} from './shell';
import {escapeHtml as esc} from './workspace';
/** Presentation-only client. Review state and eligibility come from the API. */
export class LookReviewClient {
 private retry=new Map<string,string>();
 constructor(private gateway:string,private token:string,private owner?:{current:()=>boolean;wait:()=>Promise<void>}){}
 private session(){if(this.owner&&!this.owner.current())throw Error('presentation_changed');if(sessionStorage.getItem('primecare_session')!==this.token)throw Error('account_changed');}
 private async readForSession<T>(read:()=>Promise<T>):Promise<T>{this.session();try{return await read();}finally{await this.owner?.wait();this.session();}}
 async request(path='',method='GET',body?:unknown){
  this.session();const serialized=body===undefined?undefined:JSON.stringify(body),hash=serialized?Array.from(new Uint8Array(await this.readForSession(()=>crypto.subtle.digest('SHA-256',new TextEncoder().encode(serialized))))).join('-'):'',key=method+path+hash;
  this.session();
  if(serialized&&!this.retry.has(key))this.retry.set(key,crypto.randomUUID());
  const r=await this.readForSession(()=>fetch(this.gateway+registry.endpoint+path,{method,cache:'no-store',headers:{authorization:'Bearer '+this.token,...(serialized?{'content-type':'application/json','idempotency-key':this.retry.get(key)!}: {})},...(serialized?{body:serialized}: {})}));
  this.session();
  const data=await this.readForSession(()=>r.json());
  this.session();
  if(r.status===401){sessionStorage.removeItem('primecare_session');location.assign('/login?enable-semantics=true');}
  if(!r.ok)throw Object.assign(Error(data.error),{status:r.status});this.retry.delete(key);return data;
 }
 async image(id:string){
  const r=await this.readForSession(()=>fetch(this.gateway+registry.endpoint+'/reviews/'+id+'/image',{cache:'no-store',headers:{authorization:'Bearer '+this.token}}));
  this.session();if(!r.ok||r.headers.get('content-type')!=='image/png')throw Error('image_unavailable');
  const blob=await this.readForSession(()=>r.blob());this.session();return blob;
 }
}
const lookReviewOwners=new WeakMap<HTMLElement,()=>void>();
export async function renderLookReview(root:HTMLElement,gateway:string){
 lookReviewOwners.get(root)?.();
 const entry=resolveManagedRoute('/appearance-review',''),route=location.pathname+location.search;
 let token:string|null=null,manager:ReturnType<typeof requireScreenManager>|undefined;
 let locale:'en'|'fr'|'es'=document.documentElement.lang==='fr'?'fr':document.documentElement.lang==='es'?'es':'en',data:any,notice='',busy=false,urls:string[]=[];
 const submissionDraft=new FormDraft(),humanDrafts=new Map<string,FormDraft>();let generation=0,loadVersion=0,alive=true,suspended=false;
 let frame=root.firstElementChild,main=root.querySelector('main'),children=Array.from(main?.childNodes??[]),shellLease:(()=>boolean)|undefined;
 const readyEvidence=new Set<string>();let updateEvidenceControls=()=>{};let ownerObserver:MutationObserver|undefined;
 const host=root.ownerDocument?.defaultView,resumes=new Set<()=>void>();
 const release=()=>{for(const resume of resumes)resume();resumes.clear();};
 const wait=()=>suspended&&alive?new Promise<void>(resume=>resumes.add(resume)):Promise.resolve();
 const onPageHide=(event:PageTransitionEvent)=>{if(event.persisted)suspended=true;else dispose();};
 const onPageShow=(event:PageTransitionEvent)=>{if(event.persisted&&suspended&&alive){suspended=false;current();release();}};
 const onContext=()=>{if(!suspended)current();};
 const listeners:[string,EventListener][]=[['pagehide',onPageHide as EventListener],['pageshow',onPageShow as EventListener],['popstate',onContext],['hashchange',onContext],['storage',onContext]];
 const releaseImage=(url:string)=>{if(urls.includes(url)){URL.revokeObjectURL(url);urls=urls.filter(value=>value!==url);}};
 const clearEvidence=()=>{urls.forEach(url=>URL.revokeObjectURL(url));urls=[];readyEvidence.clear();};
 const clearShell=()=>{if(shellLease)clearLayoutCustomizer(root,shellLease);shellLease=undefined;};
 function dispose(){if(!alive)return;alive=false;generation++;loadVersion++;release();ownerObserver?.disconnect();for(const[name,fn]of listeners)host?.removeEventListener(name,fn);clearShell();clearEvidence();submissionDraft.clear();humanDrafts.clear();data=undefined;updateEvidenceControls=()=>{};if(lookReviewOwners.get(root)===dispose)lookReviewOwners.delete(root);}
 function owned(){
  if(!alive||lookReviewOwners.get(root)!==dispose)return false;
  const now=Array.from(main?.childNodes??[]);
  if(root.firstElementChild!==frame||root.querySelector('main')!==main||now.length!==children.length||now.some((node,i)=>node!==children[i])){dispose();return false;}
  if(!root.isConnected){dispose();root.replaceChildren();return false;}return true;
 }
 function context(navigate=true){
  if(!owned())return false;
  if(location.pathname!==entry.route||location.pathname+location.search!==route){dispose();root.replaceChildren();return false;}
  let matching=false;try{matching=sessionStorage.getItem('primecare_session')===token;}catch{}
  if(matching)return true;const visible=root.isConnected;dispose();root.replaceChildren();if(visible&&navigate)location.reload();return false;
 }
 function current(navigate=true){
  if(suspended||!context(navigate))return false;
  try{manager!.enter(entry.id,entry.route);}catch(error){if(context(navigate)){dispose();showScreenConfigurationError(root,error);}return false;}
  // Connections are synchronous but can replace the root, route or session.
  return context(navigate);
 }
 function adopt(){frame=root.firstElementChild;main=root.querySelector('main');children=Array.from(main?.childNodes??[]);}
 lookReviewOwners.set(root,dispose);
 try{manager=requireScreenManager(root);}catch{dispose();return;}
 try{token=sessionStorage.getItem('primecare_session');}catch(error){if(owned()){dispose();showScreenConfigurationError(root,error);}return;}
 if(!current())return;
 if(!token){dispose();root.replaceChildren();location.assign('/login?enable-semantics=true');return;}
 root.replaceChildren();adopt();
 const client=new LookReviewClient(gateway,token,{current:()=>current(false),wait});
 if(typeof MutationObserver!=='undefined'&&root.ownerDocument){ownerObserver=new MutationObserver(()=>{if(!suspended)current();});ownerObserver.observe(root.ownerDocument,{childList:true,subtree:true});}
 for(const[name,fn]of listeners)host?.addEventListener(name,fn);
 const evidenceKey=(r:any)=>r.id+':'+r.version+':'+r.image_digest;
 const captureDrafts=()=>{if(!current())return false;const form=root.querySelector<HTMLFormElement>('[data-cy=look-form]');if(form)submissionDraft.capture(form);root.querySelectorAll<HTMLFormElement>('[data-human]').forEach(form=>{const row=data?.rows.find((r:any)=>r.id===form.dataset.human);if(!row)return;const key=evidenceKey(row),draft=humanDrafts.get(key)??new FormDraft();draft.capture(form);humanDrafts.set(key,draft);});return true;};
 const t=(key:string)=>esc((registry.locales[locale] as Record<string,string>)[key]??key);
 const draw=()=>{if(!current())return;const drawVersion=++generation;const interactive=()=>drawVersion===generation&&!busy&&current();clearShell();clearEvidence();const activeKeys=new Set<string>(data.rows.map(evidenceKey));for(const key of humanDrafts.keys())if(!activeKeys.has(key))humanDrafts.delete(key);const media=new DashboardMediaLook(locale);const raw=(key:string)=>(registry.locales[locale] as Record<string,string>)[key]??key;renderShell(root,{home:'/?enable-semantics=true',role:esc(data.identity.role),menuLabel:t('title'),navigation:`<a data-cy="look-nav" href="/appearance-review?enable-semantics=true">${media.navigationIcon('look')}${t('title')}</a>`,controls:`<label>${t('language')}<select data-cy="look-language">${['en','fr','es'].map(l=>`<option ${l===locale?'selected':''}>${l}</option>`).join('')}</select></label><button data-cy="look-refresh">${t('refresh')}</button><a href="/?enable-semantics=true">${t('back')}</a>`,content:`<section class="look-review-panel" data-cy="look-review">${media.heading(raw('title'),raw('note'),'check')}${media.reviewProcess()}${!data.providerReady?`<p>${t('provider_not_connected')}</p>`:''}<p role="status" data-cy="look-status">${notice?t(notice):''}</p><form class="growth-form" data-cy="look-form"><label>${t('screen')}<select name="screen" data-cy="look-screen">${data.screens.map((s:any)=>`<option value="${esc(s.code)}">${esc(s.name)} · ${esc(s.route)}</option>`).join('')}</select></label><label>${t('platform')}<select name="platform" data-cy="look-platform">${registry.platforms.map(p=>`<option>${p}</option>`).join('')}</select></label>${[['width','width','number','320'],['height','height','number','800'],['scale','scale','number','1'],['build','build','text',''],['theme','theme','text',''],['layout','layout_revision','text','']].map(([name,label,type,value])=>`<label>${t(label)}<input data-cy="look-${name}" name="${name}" type="${type}" required value="${value}" maxlength="100" ${type==='number'?'step="any" min="1"':''}></label>`).join('')}<label>${t('image')}<input type="file" name="image" accept="image/png" required data-cy="look-image"></label><label><input type="checkbox" required name="redacted" data-cy="look-redacted">${t('redacted')}</label><button data-cy="look-submit" ${data.canSubmit?'':'disabled'}>${t('submit')}</button></form>${data.rows.map((r:any)=>`<article class="section" data-cy="look-review-${esc(r.id)}"><h2>${esc(data.screens.find((s:any)=>s.code===r.screen)?.name??r.screen)} · ${esc(r.platform)} · ${r.width} × ${r.height} · ${esc(r.locale)}</h2><p>${esc(r.build)} / ${esc(r.theme)} / ${esc(r.layout)} · v${r.version}</p>${media.reviewState(r.state,raw(r.state),r.id)}${r.policyCurrent?'':`<p>${t('policy_changed')}</p>`}<p>${t('coverage')}: ${r.coverage.approved}/${r.coverage.required}</p><div class="look-evidence-layout"><div class="look-evidence-preview"><img data-cy="look-proof-${esc(r.id)}" alt="${t('image')}" hidden><p role="status" data-cy="look-image-status-${esc(r.id)}" data-state="loading">${t('image_loading')}</p><button type="button" data-cy="look-image-retry-${esc(r.id)}" hidden>${t('retry_image')}</button></div>${r.ai_report?.error?`<p role="alert" data-cy="look-ai-error-${esc(r.id)}">${t(['insufficient_quota','credit_balance_exhausted','organization_spend_limit_exceeded','project_spend_limit_exceeded','organization_usage_limit_exceeded'].includes(r.ai_report.providerCode)?'quota_exceeded':r.ai_report.reason==='provider_http_429'?'rate_limited_ai':'ai_service_failed')}</p>`:''}${r.ai_report?.scores?`<div class="look-assessment"><p>${esc(r.ai_report.model)} · ${esc(r.ai_report.summary)}</p><ul class="media-score-list">${registry.criteria.map(k=>media.score(k,raw(k),r.ai_report.scores[k],r.id)).join('')}</ul><ul>${r.ai_report.findings.map((f:any)=>`<li>${t(f.criterion)} · ${esc(f.severity)} · ${esc(f.fix)}</li>`).join('')}</ul></div>`:''}</div>${r.canRunAI?`<button data-ai="${esc(r.id)}" data-cy="look-ai-${esc(r.id)}" ${data.providerReady?'':'disabled'}>${t('ai')}</button>`:''}${r.humanActions.length?`<form class="growth-form" data-human="${esc(r.id)}" data-cy="look-human-form-${esc(r.id)}"><label>${t('human')}<select name="decision" data-cy="look-decision-${esc(r.id)}">${r.humanActions.map((a:string)=>`<option value="${a}">${t(a)}</option>`).join('')}</select></label><label>${t('evidence')}<input name="evidence" maxlength="1500" required data-cy="look-evidence-${esc(r.id)}"></label><label><input name="reviewed" type="checkbox" required disabled data-cy="look-inspected-${esc(r.id)}">${t('inspected')}</label><button disabled data-cy="look-human-${esc(r.id)}">${t('save')}</button></form>`:''}${r.human_actor_id?`<p>${esc(r.human_actor_id)} · ${esc(r.human_evidence)}</p>`:''}</article>`).join('')||media.emptyReview()}</section>`});adopt();const lease=()=>drawVersion===generation&&current();shellLease=lease;bindShell(root,(registry.locales[locale] as any).title,locale,(registry.locales[locale] as any).note,()=>[],data.identity.role+':'+data.identity.userId,daylight.visual.theme,undefined,lease);if(!current())return;
 root.querySelector<HTMLSelectElement>('[data-cy=look-language]')!.onchange=e=>{if(!interactive()||!captureDrafts())return;locale=(e.currentTarget as HTMLSelectElement).value as typeof locale;draw();if(current())root.querySelector<HTMLSelectElement>('[data-cy=look-language]')?.focus({preventScroll:true});};root.querySelector('[data-cy=look-refresh]')!.addEventListener('click',()=>{if(interactive())void load();});
 const form=root.querySelector<HTMLFormElement>('[data-cy=look-form]')!;submissionDraft.restore(form);form.onsubmit=e=>{e.preventDefault();if(!interactive())return;const v=Object.fromEntries(new FormData(form)),file=v.image as File,redacted=form.querySelector<HTMLInputElement>('[name=redacted]')!.checked;void mutate(async()=>{if(file.size>registry.maxImageBytes)throw Error();const bytes=new Uint8Array(await file.arrayBuffer());await wait();if(!current())return;let binary='';for(const b of bytes)binary+=String.fromCharCode(b);await client.request('/reviews','POST',{...v,width:Number(v.width),height:Number(v.height),scale:Number(v.scale),locale,image:btoa(binary),redacted});},true);};
 root.querySelectorAll<HTMLButtonElement>('[data-ai]').forEach(button=>button.onclick=()=>{if(!interactive())return;const r=data.rows.find((r:any)=>r.id===button.dataset.ai);void mutate(()=>client.request('/reviews/'+r.id+'/ai','POST',{version:r.version}));});root.querySelectorAll<HTMLFormElement>('[data-human]').forEach(form=>form.onsubmit=e=>{e.preventDefault();if(!interactive())return;const r=data.rows.find((r:any)=>r.id===form.dataset.human);if(!readyEvidence.has(evidenceKey(r)))return;const v=Object.fromEntries(new FormData(form));void mutate(()=>client.request('/reviews/'+r.id+'/human','POST',{...v,version:r.version,imageDigest:r.image_digest,reviewed:form.querySelector<HTMLInputElement>('[name=reviewed]')!.checked}));});
 root.querySelectorAll<HTMLFormElement>('[data-human]').forEach(form=>{const r=data.rows.find((r:any)=>r.id===form.dataset.human);humanDrafts.get(evidenceKey(r))?.restore(form);});
 updateEvidenceControls=()=>{if(!current())return;for(const r of data.rows){const form=root.querySelector<HTMLFormElement>(`[data-cy="look-human-form-${r.id}"]`);if(!form)continue;const disabled=busy||!readyEvidence.has(evidenceKey(r));form.querySelector<HTMLInputElement>('[name=reviewed]')!.disabled=disabled;form.querySelector<HTMLButtonElement>('button')!.disabled=disabled;}};
 updateEvidenceControls();
 for(const r of data.rows){
  const image=root.querySelector<HTMLImageElement>(`[data-cy="look-proof-${r.id}"]`)!,status=root.querySelector<HTMLElement>(`[data-cy="look-image-status-${r.id}"]`)!,retry=root.querySelector<HTMLButtonElement>(`[data-cy="look-image-retry-${r.id}"]`)!;let attempt=0;
  const present=()=>drawVersion===generation&&image.isConnected&&current();
  const loadImage=async()=>{if(!present())return;const request=++attempt;let url:string|undefined;readyEvidence.delete(evidenceKey(r));updateEvidenceControls();retry.hidden=true;image.hidden=true;status.dataset.state='loading';status.textContent=raw('image_loading');
   try{const blob=await client.image(r.id);await wait();if(!present()||request!==attempt)return;const bytes=await blob.arrayBuffer();await wait();if(!present()||request!==attempt)return;const digest=Array.from(new Uint8Array(await crypto.subtle.digest('SHA-256',bytes))).map(b=>b.toString(16).padStart(2,'0')).join('');await wait();if(!present()||request!==attempt)return;if(digest!==r.image_digest)throw Error('image_digest_mismatch');url=URL.createObjectURL(blob);urls.push(url);image.src=url;await image.decode();await wait();if(!present()||request!==attempt){releaseImage(url);return;}image.hidden=false;status.dataset.state='ready';status.textContent=raw('image_loaded');readyEvidence.add(evidenceKey(r));updateEvidenceControls();}
   catch{await wait();if(url)releaseImage(url);if(!present()||request!==attempt)return;image.hidden=true;image.removeAttribute('src');status.dataset.state='error';status.textContent=raw('image_load_failed');retry.hidden=false;updateEvidenceControls();}
  };
  retry.onclick=()=>void loadImage();void loadImage();
 }

 };
 async function load(preserve=true){if(!current()||busy&&preserve)return;const version=++loadVersion;if(preserve&&!captureDrafts())return;try{const next=await client.request();await wait();if(!current()||version!==loadVersion)return;data=next;draw();}catch(error){await wait();if(!current((error as {status?:number}).status!==401)||version!==loadVersion)return;generation++;clearShell();clearEvidence();const status=(error as {status?:number}).status;root.innerHTML=`<main class="section" role="alert" data-cy="look-unavailable"><h1>${t('title')}</h1><p>${t(status===403?'forbidden':status===401?'signed_out':'unavailable')}</p><button type="button" data-cy="look-retry">${t('retry')}</button><a href="/platform/administration">${t('back_admin')}</a></main>`;adopt();root.querySelector('[data-cy=look-retry]')!.addEventListener('click',()=>{if(version===loadVersion&&current())void load();});}}
 async function mutate(action:()=>Promise<any>,clearSubmission=false){if(!current()||busy||!captureDrafts())return;busy=true;loadVersion++;root.querySelectorAll<HTMLButtonElement>('button').forEach(b=>b.disabled=true);try{await action();await wait();if(!current())return;if(clearSubmission)submissionDraft.clear();notice='saved';await load(false);}catch(error){await wait();if(!current((error as {status?:number}).status!==401))return;notice='error';draw();}finally{busy=false;if(current())updateEvidenceControls();}}
 await load();
}

