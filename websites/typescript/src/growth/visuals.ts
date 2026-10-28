import {focusInWorkspace} from '../focus';
import {BaseMediaLook} from '../media-look';
import {registry} from '../../../../packages/shared/src/growth/contract';
import {esc,type T} from './forms';
export function icon(name:keyof typeof registry.visual.icons,id?:string){return new BaseMediaLook().icon(name,id?'growth-icon-'+id:undefined);}
export function hero(t:T,data:any){return `<section class="growth-hero" data-cy="growth-hero"><div class="growth-hero-copy"><p class="eyebrow">${t(data.scopeKey??'scope')}</p><h1>${t('title')}</h1><p class="growth-intro">${t('hero_description')}</p><span class="growth-period">${icon('calendar')} ${esc(data.plan.start)} — ${esc(data.plan.end)} UTC</span></div>${new BaseMediaLook().image('care',{className:'growth-hero-image',testId:'growth-care-image',alt:t('care_image_alt'),priority:true})}</section>`;}
export function marketingImage(t:T){return `<div class="growth-marketing-banner"><div><p class="growth-intro">${t('marketing_intro')}</p></div>${new BaseMediaLook().image('team',{testId:'growth-marketing-image',alt:t('marketing_image_alt')})}</div>`;}
export function sectionNavigation(t:T,data:any){
 const c=data.capabilities,visible:Record<string,boolean>={performance:data.canReport,intake:data.canManageIntake,business_ops:!!data.business?.canBusiness,plan:data.canEditPlan,summary:c.viewLeads,leads:c.viewLeads,campaigns:c.viewCampaigns,tasks:true,calls:c.recordCall,appointments:c.createAppointment||c.editAppointment,team:!data.scopeKey};
 return registry.visual.navigation.filter(item=>visible[item.key]).map(item=>{const target=item.key==='business_ops'?'business':item.key;return `<a data-cy="growth-nav-${esc(item.key)}" data-growth-target="${esc(target)}" href="/growth?enable-semantics=true#growth-${esc(target)}">${icon(item.icon as keyof typeof registry.visual.icons,'nav-'+item.key)}${t(item.key)}</a>`;}).join('');
}
export function bindSectionNavigation(root:HTMLElement){
 root.querySelectorAll<HTMLAnchorElement>('[data-growth-target]').forEach(link=>{const key=link.dataset.growthTarget!,section=root.querySelector<HTMLElement>(`[data-cy="growth-${key}"]`);if(!section)return;section.id='growth-'+key;section.tabIndex=-1;link.onclick=e=>{e.preventDefault();focusInWorkspace(root,section);};});
}
