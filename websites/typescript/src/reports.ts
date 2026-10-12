import {escapeHtml} from './workspace';
type Definition={id:string;title:string;canExport:boolean;canEmail:boolean;supportsFilters:boolean};
type Result={title:string;classification:string;generatedAt:string;scope:string;columns:{key:string;label:string}[];rows:Record<string,unknown>[]};
/** Shared browser adapter for the existing server-authorized reporting contract. */
export function reportPanel(gateway:string,endpoint:string,token:string,userId:string):HTMLElement {
 if(endpoint!=='/v1/governance/reports')throw new Error('Invalid reporting endpoint');
 const root=document.createElement('section');root.className='section';root.dataset.cy='shared-reports';
 let locale='en',reports:Definition[]=[],labels:Record<string,string>={},selected='',search='',readiness='all',result:Result|null=null,busy=false,notice='';
 let to='',subject='',message='',confirmed=false;
 const url=gateway.replace(/\/+$/,'')+endpoint;
 const label=(key:string)=>escapeHtml(labels[key]??key);
 const definition=()=>reports.find(r=>r.id===selected);
 const options=()=>({locale,search:definition()?.supportsFilters?search:'',readiness:definition()?.supportsFilters?readiness:'all'});
 const pendingKey=()=>`primecare-report-pending:${userId}:${selected}`;
 const pending=()=>!!sessionStorage.getItem(pendingKey());
 const headers=()=>({authorization:'Bearer '+token});
 function reset(){result=null;notice='';confirmed=false;}
 function draw(){const d=definition();root.innerHTML=`<h2>${label('title')}</h2>
 <div class="report-controls"><label>${label('language')}<select data-cy="report-language" ${busy?'disabled':''}>${['en','fr','es'].map(l=>`<option ${l===locale?'selected':''}>${l}</option>`).join('')}</select></label>
 <label>${label('report')}<select data-cy="report-select" ${busy?'disabled':''}>${reports.map(r=>`<option value="${escapeHtml(r.id)}" ${r.id===selected?'selected':''}>${escapeHtml(r.title)}</option>`).join('')}</select></label>
 <button data-cy="report-refresh" ${busy?'disabled':''}>${label('refresh')}</button></div>
 ${d?.supportsFilters?`<div class="report-controls"><label>${label('search')}<input data-cy="report-search" maxlength="100" value="${escapeHtml(search)}" ${busy?'disabled':''}></label><label>${label('readiness')}<select data-cy="report-readiness" ${busy?'disabled':''}>${['all','created','ready'].map(v=>`<option value="${v}" ${v===readiness?'selected':''}>${label(v)}</option>`).join('')}</select></label></div>`:''}
 <div class="report-controls"><button data-cy="report-generate" ${busy||!d?'disabled':''}>${label('generate')}</button>${d?.canExport?`<button data-cy="report-pdf" ${busy||!result?'disabled':''}>${label('pdf')}</button>`:''}</div>
 ${result?`<div data-cy="report-result"><p>${escapeHtml(result.title)} · ${escapeHtml(result.classification)}</p><p>${label('generated')}: ${escapeHtml(result.generatedAt)} · ${label('scope')}: ${escapeHtml(result.scope)}</p><div class="table-scroll"><table data-cy="report-preview"><thead><tr>${result.columns.map(c=>`<th>${escapeHtml(c.label)}</th>`).join('')}</tr></thead><tbody>${result.rows.slice(0,50).map(r=>`<tr>${result!.columns.map(c=>`<td>${escapeHtml(r[c.key])}</td>`).join('')}</tr>`).join('')}</tbody></table></div>${result.rows.length?'':`<p>${label('empty')}</p>`}</div>`:''}
 ${d?.canEmail?`<form data-cy="report-email-form"><label>${label('recipient')}<input type="email" required maxlength="254" data-cy="report-recipient" value="${escapeHtml(to)}" ${busy?'disabled':''}></label><label>${label('subject')}<input maxlength="150" data-cy="report-subject" value="${escapeHtml(subject)}" ${busy?'disabled':''}></label><label>${label('message')}<textarea maxlength="1000" data-cy="report-message" ${busy?'disabled':''}>${escapeHtml(message)}</textarea></label><label class="report-consent"><input type="checkbox" data-cy="report-confirm" ${confirmed?'checked':''} ${busy?'disabled':''}>${label('confirm')}</label><button type="submit" data-cy="report-email" ${busy||!result||!confirmed||pending()?'disabled':''}>${label('email')}</button></form>`:''}
 <output aria-live="polite" data-cy="report-status">${busy?label('working'):pending()?label('unknown'):escapeHtml(notice)}</output>`;
 const el=(id:string)=>root.querySelector<HTMLInputElement>(`[data-cy=${id}]`)!;
 el('report-language').onchange=()=>{locale=el('report-language').value;reset();void load();};
 el('report-select').onchange=()=>{selected=el('report-select').value;reset();draw();};
 el('report-refresh').onclick=()=>void load();
 if(d?.supportsFilters){el('report-search').oninput=()=>{search=el('report-search').value;reset();el('report-generate').disabled=busy;root.querySelector('[data-cy=report-result]')?.remove();for(const id of ['report-pdf','report-email']){const button=root.querySelector<HTMLButtonElement>(`[data-cy=${id}]`);if(button)button.disabled=true;}const checkbox=root.querySelector<HTMLInputElement>('[data-cy=report-confirm]');if(checkbox)checkbox.checked=false;};el('report-readiness').onchange=()=>{readiness=el('report-readiness').value;reset();draw();};}
 el('report-generate').onclick=()=>void action(async()=>{result=null;const r=await fetch(url+'/'+encodeURIComponent(selected)+'?'+new URLSearchParams(options()),{headers:headers(),cache:'no-store'});const data=await r.json();if(!r.ok||!Array.isArray(data.columns)||!Array.isArray(data.rows))throw new Error();result=data;});
 if(d?.canExport)el('report-pdf').onclick=()=>void action(async()=>{const r=await fetch(url+'/'+encodeURIComponent(selected)+'/pdf?'+new URLSearchParams(options()),{headers:headers(),cache:'no-store'});if(!r.ok)throw new Error();const bytes=new Uint8Array(await r.arrayBuffer());if(new TextDecoder().decode(bytes.slice(0,5))!=='%PDF-')throw new Error();const object=URL.createObjectURL(new Blob([bytes],{type:'application/pdf'}));const a=document.createElement('a');a.href=object;a.download=selected+'.pdf';a.click();setTimeout(()=>URL.revokeObjectURL(object),1000);});
 if(d?.canEmail){for(const [id,set] of [['report-recipient',(v:string)=>to=v],['report-subject',(v:string)=>subject=v],['report-message',(v:string)=>message=v]] as const){el(id).oninput=()=>{set(el(id).value);confirmed=false;el('report-confirm').checked=false;el('report-email').disabled=true;};}el('report-confirm').onchange=()=>{confirmed=el('report-confirm').checked;el('report-email').disabled=busy||!result||!confirmed||pending();};
 root.querySelector<HTMLFormElement>('[data-cy=report-email-form]')!.onsubmit=e=>{e.preventDefault();if(busy||!result||!confirmed||pending()||!d.canEmail)return;const key=crypto.randomUUID();sessionStorage.setItem(pendingKey(),key);void action(async()=>{const r=await fetch(url+'/'+encodeURIComponent(selected)+'/email',{method:'POST',headers:{...headers(),'content-type':'application/json','Idempotency-Key':key},body:JSON.stringify({...options(),to:to.trim(),subject,message,confirmed:true})});const data=await r.json();if(r.ok&&data.state==='accepted'){sessionStorage.removeItem(pendingKey());notice=labels.accepted;confirmed=false;}else if(r.status>=400&&r.status<500&&!['unknown','sending'].includes(data.state)){sessionStorage.removeItem(pendingKey());throw new Error();}else{notice=labels.unknown;}});};}
 }
 async function action(work:()=>Promise<void>){if(busy)return;busy=true;notice='';draw();try{await work();}catch{notice=labels.error??'Report request failed.';}finally{busy=false;draw();}}
 async function load(){reset();reports=[];await action(async()=>{const r=await fetch(url+'?locale='+locale,{headers:headers(),cache:'no-store'});const data=await r.json();if(!r.ok||!Array.isArray(data.reports)||!data.resources)throw new Error();reports=data.reports;labels=data.resources;selected=reports.some(d=>d.id===selected)?selected:reports[0]?.id??'';reset();});}
 void load();return root;
}
