export type SearchEntry={title:string;detail:string;open:()=>void};
export type NavigationLocale='en'|'fr'|'es';
const words={en:{search:'Search',placeholder:'Search screens, tasks and available records',empty:'No matches in this scope',scope:'Search scope',results:'Search results'},fr:{search:'Rechercher',placeholder:'Rechercher des pages, tâches et dossiers disponibles',empty:'Aucun résultat dans ce périmètre',scope:'Périmètre de recherche',results:'Résultats de recherche'},es:{search:'Buscar',placeholder:'Buscar pantallas, tareas y registros disponibles',empty:'Sin resultados en este ámbito',scope:'Ámbito de búsqueda',results:'Resultados de búsqueda'}};
const mounted=new WeakMap<HTMLElement,{update:(title:string,scope:string,entries:()=>SearchEntry[])=>void;locale:NavigationLocale}>();
/** Only consume data already authorized by the server for the current session. */
export function mountNavigation(host:HTMLElement,title:string,locale:NavigationLocale,scope:string,entries:()=>SearchEntry[]):void {
 const previous=mounted.get(host);if(previous?.locale===locale){previous.update(title,scope,entries);return;}
 let currentEntries=entries;
 const text=words[locale];host.className='global-navigation';
 const heading=document.createElement('strong');heading.className='topbar-title';heading.textContent=title;
 const box=document.createElement('div');box.className='global-search';
 const label=document.createElement('label');label.textContent=text.search;
 const input=document.createElement('input');input.type='search';input.maxLength=100;input.placeholder=text.placeholder;input.dataset.cy='universal-search';input.setAttribute('aria-controls','universal-search-results');input.setAttribute('aria-expanded','false');input.autocomplete='off';label.append(input);
 const panel=document.createElement('div');panel.id='universal-search-results';panel.dataset.cy='universal-search-results';panel.className='global-search-results';panel.hidden=true;
 const scopeLine=document.createElement('p');scopeLine.textContent=text.scope+': '+scope;scopeLine.className='search-scope';
 const status=document.createElement('p');status.setAttribute('role','status');
 const list=document.createElement('div');list.setAttribute('aria-label',text.results);
 panel.append(scopeLine,status,list);box.append(label,panel);host.replaceChildren(heading,box);
 const hide=()=>{panel.hidden=true;input.setAttribute('aria-expanded','false');};
 const draw=()=>{const query=input.value.trim().toLocaleLowerCase(locale);list.replaceChildren();if(!query){hide();return;}const matches=currentEntries().filter(e=>(e.title+' '+e.detail).toLocaleLowerCase(locale).includes(query));status.textContent=matches.length?String(matches.length)+(matches.length>20?' · 20':''):text.empty;for(const entry of matches.slice(0,20)){const button=document.createElement('button');button.type='button';button.dataset.cy='universal-search-result';const name=document.createElement('strong');name.textContent=entry.title;const detail=document.createElement('small');detail.textContent=entry.detail;button.append(name,detail);button.onclick=()=>{hide();input.value='';entry.open();};list.append(button);}if(window.matchMedia('(max-width:600px)').matches){const top=input.getBoundingClientRect().bottom+8;panel.style.top=top+'px';panel.style.maxHeight=Math.max(80,window.innerHeight-top-16)+'px';}panel.hidden=false;input.setAttribute('aria-expanded','true');};
 mounted.set(host,{locale,update:(title,scope,entries)=>{heading.textContent=title;scopeLine.textContent=text.scope+': '+scope;currentEntries=entries;input.value='';hide();}});
 input.addEventListener('input',draw);input.addEventListener('focus',()=>{if(input.value.trim())draw();});
 box.addEventListener('keydown',event=>{if(event.key==='Escape'){input.focus();hide();}if(event.key==='ArrowDown'&&event.target===input){event.preventDefault();list.querySelector<HTMLButtonElement>('button')?.focus();}});
 box.addEventListener('focusout',event=>{if(event.relatedTarget instanceof Node&&box.contains(event.relatedTarget))return;setTimeout(()=>{if(!box.contains(document.activeElement))hide();},0);});
}
