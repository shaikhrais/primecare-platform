import {navigationIcon} from './icons';
import registry from '../../shared/src/media/registry.json';
export type MediaLocale = keyof typeof registry.locales;
export type MediaIcon = keyof typeof registry.icons;
type ImageOptions = {alt?:string;priority?:boolean;className?:string;testId?:string;sizes?:string};
const escape = (v:string) => v.replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));

/** Common visual base: components inherit catalog assets, semantics and image delivery. */
export class BaseMediaLook {
  constructor(readonly locale:MediaLocale='en') {}
  text(key:keyof typeof registry.locales.en):string { return escape(registry.locales[this.locale][key]); }
  icon(name:MediaIcon,testId?:string):string {
    return `<svg class="media-icon" ${testId?`data-cy="${escape(testId)}"`:''} viewBox="0 0 24 24" aria-hidden="true" focusable="false" fill="none" stroke="currentColor" stroke-width="var(--media-stroke)" stroke-linecap="round" stroke-linejoin="round">${registry.icons[name]}</svg>`;
  }
  image(name:keyof typeof registry.assets,options:ImageOptions={}):string {
    const a=registry.assets[name];
    return `<picture><source type="image/webp" srcset="${escape(a.srcset)}" sizes="${escape(options.sizes??'(max-width: 600px) 100vw, 50vw')}"><img class="${escape(options.className??'media-image')}" data-cy="${escape(options.testId??'media-'+name+'-image')}" src="${escape(a.fallback)}" width="${a.width}" height="${a.height}" alt="${escape(options.alt??'')}" ${options.priority?'fetchpriority="high"':'loading="lazy"'} decoding="async"></picture>`;
  }
  brand():string { return `<span class="media-brand" data-cy="media-brand">${this.icon('heart')}</span>`; }
}

/** Entry pages inherit the same base as the authenticated shell and growth images. */
export class EntryMediaLook extends BaseMediaLook {
  render():string {
    return `<section class="media-entry" data-cy="media-entry"><div class="media-entry-copy"><p class="eyebrow">PrimeCare</p><h2>${this.text('headline')}</h2><p>${this.text('intro')}</p><ul class="media-topics" data-cy="media-entry-topics"><li>${this.icon('heart')}${this.text('care')}</li><li>${this.icon('people')}${this.text('team')}</li><li>${this.icon('calendar')}${this.text('operations')}</li></ul></div>${this.image('care',{priority:true,sizes:'(max-width: 1024px) 100vw, 55vw'})}</section>`;
  }
}

/** Operational pages inherit compact cues instead of decorative hero images. */
export class DashboardMediaLook extends BaseMediaLook {
  navigationIcon(key:string):string {
    return navigationIcon(key);
  }
  roleLabel(code:string):string{return (registry.roles as Record<string,string>)[code]??code;}
  sectionIcon(type:string):string{return this.icon((registry.sectionIcons as Record<string,MediaIcon>)[type]??'home');}
  heading(title:string,description:string,icon:MediaIcon,titleTestId?:string):string {
    return `<header class="media-page-heading" data-cy="media-page-heading"><span class="media-heading-icon">${this.icon(icon)}</span><div><h1 tabindex="-1" ${titleTestId?`data-cy="${escape(titleTestId)}"`:''}>${escape(title)}</h1><p>${escape(description)}</p></div></header>`;
  }
  reviewProcess():string {
    return `<ol class="media-review-process" data-cy="media-review-process" aria-label="${this.text('review_process')}">${(['step_evidence','step_ai','step_human'] as const).map((key,index)=>`<li><span class="media-step-number" aria-hidden="true">${index+1}</span><span>${this.text(key)}</span></li>`).join('')}</ol>`;
  }
  reviewState(state:string,label:string,id:string):string {
    const icon=(registry.states as Record<string,MediaIcon>)[state]??'flag';
    return `<span class="media-review-state" data-cy="look-state-${escape(id)}" data-state="${escape(state)}">${this.icon(icon)}${escape(label)}</span>`;
  }
  score(criterion:string,label:string,value:number,id:string):string {
    return `<li class="media-score"><div><span>${escape(label)}</span><strong>${escape(String(value))}/100</strong></div><meter min="0" max="100" value="${escape(String(value))}" data-cy="look-score-${escape(id)}-${escape(criterion)}" aria-label="${escape(label+': '+value+'/100')}">${escape(String(value))}/100</meter></li>`;
  }
  emptyReview():string {
    return `<div class="media-empty" data-cy="media-empty-review">${this.icon('check')}<h2>${this.text('review_empty_title')}</h2><p>${this.text('review_empty_body')}</p></div>`;
  }
}

/** Use portal-provided design tokens; registry values are a fallback for isolated renderers. */
export function applyMediaTokens():void {
  const style=getComputedStyle(document.documentElement);
  for(const [key,value] of Object.entries(registry.tokens)) {
    const variable='--media-'+key.replaceAll('_','-');
    if(!style.getPropertyValue(variable).trim())document.documentElement.style.setProperty(variable,value);
  }
}
