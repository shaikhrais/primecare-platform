import {shellIcon} from './shell-icons';
import media from '../../../packages/shared/src/media/registry.json';
export type SearchEntry={title:string;detail:string;open:()=>void};
export type NavigationLocale='en'|'fr'|'es';

const mounted=new WeakMap<HTMLElement,{update:(title:string,scope:string,entries:()=>SearchEntry[])=>void;locale:NavigationLocale}>();
/** Only consume data already authorized by the server for the current session. */
export function mountNavigation(host:HTMLElement,title:string,locale:NavigationLocale,scope:string,entries:()=>SearchEntry[]):void {
 const previous=mounted.get(host);if(previous?.locale===locale){previous.update(title,scope,entries);return;}
 let currentEntries=entries;
 const words=media.locales[locale],text={search:words.nav_search,placeholder:words.nav_placeholder,empty:words.nav_empty,scope:words.nav_scope,results:words.nav_results};host.className='global-navigation';
 const heading=document.createElement('strong');heading.className='topbar-title';heading.textContent=title;
 const box=document.createElement('div');box.className='global-search';
 const label=document.createElement('label');const accessibleLabel=document.createElement('span');accessibleLabel.className='visually-hidden';accessibleLabel.textContent=text.search;label.innerHTML=shellIcon('search');label.append(accessibleLabel);
 const input=document.createElement('input');input.type='search';input.maxLength=100;input.placeholder=text.placeholder;input.dataset.cy='universal-search';input.setAttribute('aria-controls','universal-search-results');input.autocomplete='off';label.append(input);
 const panel=document.createElement('div');panel.id='universal-search-results';panel.dataset.cy='universal-search-results';panel.className='global-search-results';panel.hidden=true;
 const scopeLine=document.createElement('p');scopeLine.textContent=text.scope+': '+scope;scopeLine.className='search-scope';
 const status=document.createElement('p');status.setAttribute('role','status');
 const list=document.createElement('div');list.setAttribute('role','group');list.setAttribute('aria-label',text.results);
 panel.append(scopeLine,status,list);box.append(label,panel);host.replaceChildren(heading,box);
 const hide=()=>{panel.hidden=true;};
 const draw=()=>{const query=input.value.trim().toLocaleLowerCase(locale);list.replaceChildren();if(!query){hide();return;}const matches=currentEntries().filter(e=>(e.title+' '+e.detail).toLocaleLowerCase(locale).includes(query));status.textContent=matches.length?String(matches.length)+(matches.length>20?' · 20':''):text.empty;for(const entry of matches.slice(0,20)){const button=document.createElement('button');button.type='button';button.dataset.cy='universal-search-result';const name=document.createElement('strong');name.textContent=entry.title;const detail=document.createElement('small');detail.textContent=entry.detail;button.append(name,detail);button.onclick=()=>{hide();input.value='';entry.open();};list.append(button);}if(window.matchMedia('(max-width:600px)').matches){const top=input.getBoundingClientRect().bottom+8;panel.style.top=top+'px';panel.style.maxHeight=Math.max(80,window.innerHeight-top-16)+'px';}panel.hidden=false;};
 mounted.set(host,{locale,update:(title,scope,entries)=>{heading.textContent=title;scopeLine.textContent=text.scope+': '+scope;currentEntries=entries;input.value='';hide();}});
 input.addEventListener('input',draw);input.addEventListener('focus',()=>{if(input.value.trim())draw();});
 box.addEventListener('keydown',event=>{if(event.key==='Escape'){input.focus();hide();}if(event.key==='ArrowDown'&&event.target===input){event.preventDefault();list.querySelector<HTMLButtonElement>('button')?.focus();}});
 box.addEventListener('focusout',event=>{if(event.relatedTarget instanceof Node&&box.contains(event.relatedTarget))return;setTimeout(()=>{if(!box.contains(document.activeElement))hide();},0);});
}
