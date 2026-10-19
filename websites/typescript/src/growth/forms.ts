import {registry} from '../../../../packages/shared/src/growth/contract';
export const esc=(v:unknown)=>String(v??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));
export type T=(key:string)=>string;
export function growthForms(t:T,data:any){
 let prefix='campaign';
 const field=(key:string,type='text',required=true,max=150)=>`<label>${t(key)}<input data-cy="growth-${prefix}-${key}" name="${key}" type="${type}" ${required?'required':''} ${prefix==='campaign'&&['budget','spend'].includes(key)&&!data.capabilities.manageCampaignMoney?'readonly':''} ${type==='number'?'min="0" max="1000000" step="0.01" value="0"':`maxlength="${max}"`}></label>`;
 const select=(key:string,values:string[],optional=false)=>`<label>${t(key)}<select name="${key}" data-cy="growth-${prefix}-${key}">${optional?`<option value="">${t('none')}</option>`:''}${values.map(v=>`<option value="${esc(v)}">${t(v)}</option>`).join('')}</select></label>`;
 const owners=`<option value="">${t('unassigned')}</option>`+data.owners.map((v:any)=>`<option value="${esc(v.id)}" ${v.id===data.identity.userId?'selected':''}>${esc(v.email)}</option>`).join('');
 const owner=(required=false)=>`<label>${t('owner')}<select name="ownerId" ${required?'required':''} data-cy="growth-${prefix}-owner">${owners}</select></label>`;
 const submit=(entity:string)=>`<button type="submit" data-cy="growth-${entity}-save">${t('save')}</button>`;
 const campaignOptions=`<option value="">${t('none')}</option>`+data.campaigns.map((c:any)=>`<option value="${esc(c.id)}">${esc(c.name)}</option>`).join('');
 const campaigns=`<form data-cy="growth-campaign-form" class="growth-form"><h3>${t('add_campaign')}</h3>${field('name')}${select('source',data.allowedSources??registry.sources)}${field('reference','text',true,500)}${data.capabilities.manageCampaignMoney?'':`<p>${t('owner_money_note')}</p>`}${field('budget','number')}${field('spend','number')}${submit('campaign')}</form>`;
 prefix='lead';
 const leads=`<form data-cy="growth-lead-form" class="growth-form"><h3>${t('add_lead')}</h3>${select('pipeline',['tenant','client'])}${field('name')}${field('email','email',false,254)}${field('phone','tel',false,40)}${select('source',data.allowedSources??registry.sources)}${field('reference','text',true,500)}${select('contact_basis',['not_requested','requested','business_prospect'])}<label>${t('campaign')}<select name="campaignId" data-cy="growth-lead-campaign">${campaignOptions}</select></label>${owner()}${field('due','datetime-local',false)}${submit('lead')}</form>`;
 prefix='task';
 const tasks=`<form data-cy="growth-task-form" class="growth-form"><h3>${t('add_task')}</h3>${field('description','text',true,200)}${owner(true)}${field('due','datetime-local')}${submit('task')}</form>`;
 const targets=['tenant','client'].map(p=>`<fieldset><legend>${t(p)}</legend>${(registry.pipelines as Record<string,string[]>)[p].map((stage,i)=>`<label>${t(stage)} · ${t('target')}<input data-cy="growth-target-${p}-${i}" name="${p}_${i}" type="number" min="0" max="1000000" step="1" required value="${Number(data.plan.targets[p][i])}"></label>`).join('')}</fieldset>`).join('');
 const plan=data.canEditPlan?`<form data-cy="growth-plan-form" class="growth-form"><h3>${t('plan')}</h3><label>${t('start')}<input name="start" data-cy="growth-start" type="date" value="${esc(data.plan.start)}" required></label><label>${t('end')}<input name="end" data-cy="growth-end" type="date" value="${esc(data.plan.end)}" required></label>${targets}${submit('plan')}</form>`:'';
 return {campaigns,leads,tasks,plan};
}
export function formValues(form:HTMLFormElement){return Object.fromEntries(new FormData(form).entries()) as Record<string,string>;}
export const due=(s:string)=>s?new Date(s).toISOString():null;
export function money(s:string){const n=Number(s);if(!Number.isFinite(n)||n<0||Math.abs(n*100-Math.round(n*100))>0.000001)throw Error('invalid_request');return Math.round(n*100);}
