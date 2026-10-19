import {registry} from '../../../../packages/shared/src/growth/contract';
import {esc,formValues,type T} from './forms';
import type {GrowthClient} from './client';

export function marketingStatementView(t:T,b:any,report:any,month:string|undefined,locale:string){
 if(!b?.canBusiness||!b.marketing)return '';
 const selected=month??b.marketing.period.start.slice(0,7),visible=report?.locale===locale&&report?.requestedMonth===selected;
 return `<h3>${t('marketing_statement')}</h3><p>${t('marketing_statement_note')}</p><form class="growth-form" data-cy="growth-marketing-statement-form"><label>${t('marketing_month')}<input name="month" type="month" required min="${esc(registry.centralMarketingPolicy.statement.minMonth)}" max="${esc(b.marketing.period.start.slice(0,7))}" value="${esc(selected)}" data-cy="growth-marketing-statement-month"></label><button data-cy="growth-marketing-statement-run">${t('marketing_statement_run')}</button><button type="button" data-cy="growth-marketing-statement-pdf">${t('marketing_statement_pdf')}</button></form><div data-cy="growth-marketing-statement-output">${visible?`<p>${esc(report.generatedAt)} · ${esc(report.scope)}</p><div class="table-scroll" tabindex="0" role="region" aria-label="${t('marketing_statement')}"><table data-cy="growth-marketing-statement-table"><caption>${esc(report.title)}</caption><thead><tr>${report.columns.map((c:any)=>`<th scope="col">${esc(c.label)}</th>`).join('')}</tr></thead><tbody>${report.rows.filter((r:any)=>r.kind==='amount').map((r:any)=>`<tr>${report.columns.map((c:any)=>`<td>${esc(r[c.key])}</td>`).join('')}</tr>`).join('')}</tbody></table></div>${report.rows.filter((r:any)=>r.kind==='note').map((r:any)=>`<p><strong>${esc(r.item)}</strong> ${esc(r.value)}</p>`).join('')}`:''}</div>`;
}

export function bindMarketingStatement(root:HTMLElement,client:GrowthClient,mutate:(action:()=>Promise<any>)=>Promise<void>,locale:string,setReport:(v:any)=>void,setMonth:(v:string)=>void){
 const form=root.querySelector<HTMLFormElement>('[data-cy=growth-marketing-statement-form]');if(!form)return;
 const options=()=>{const {month}=formValues(form);setMonth(month);return {month,locale};};
 form.onchange=()=>{setMonth(formValues(form).month);setReport(null);root.querySelector('[data-cy=growth-marketing-statement-output]')?.replaceChildren();};
 form.onsubmit=e=>{e.preventDefault();const v=options();void mutate(async()=>setReport({...await client.request('/marketing-statement?'+new URLSearchParams(v)),requestedMonth:v.month}));};
 root.querySelector<HTMLButtonElement>('[data-cy=growth-marketing-statement-pdf]')!.onclick=()=>{if(!form.reportValidity())return;const v=options();void mutate(async()=>{const blob=await client.blob('/marketing-statement/pdf?'+new URLSearchParams(v)),url=URL.createObjectURL(blob),a=document.createElement('a');a.href=url;a.download='marketing-statement-'+v.month+'.pdf';a.click();setTimeout(()=>URL.revokeObjectURL(url),1000);});};
}
