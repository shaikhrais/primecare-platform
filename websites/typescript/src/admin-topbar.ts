import {shellIcon} from './shell-icons';
const bound=new WeakSet<HTMLElement>();
/** Restyle existing authorized controls without replacing their search/menu handlers. */
export function matchApprovedAdminTopbar(root:HTMLElement,locale:string,overview:boolean):void {
 const words=locale==='fr'?{admin:'Administration',overview:'Vue d’ensemble',search:'Rechercher une opération…',account:'Menu du compte'}:locale==='es'?{admin:'Administración',overview:'Vista general',search:'Buscar operaciones…',account:'Menú de la cuenta'}:{admin:'Administration',overview:'Overview',search:'Search operations…',account:'Account menu'};
 const heading=root.querySelector<HTMLElement>('.topbar-title');
 if(heading){const title=overview?words.overview:root.querySelector<HTMLElement>('[aria-current=page][data-section]')?.textContent??root.querySelector('main h1')?.textContent??words.overview;heading.replaceChildren();const context=document.createElement('span');context.textContent=words.admin;const separator=document.createElement('span');separator.className='approved-topbar-separator';separator.textContent='/';separator.setAttribute('aria-hidden','true');const current=document.createElement('b');current.textContent=title;heading.append(context,separator,current);}
 const input=root.querySelector<HTMLInputElement>('[data-cy=universal-search]');if(input){input.placeholder=words.search;const label=input.closest('label');if(label&&!label.querySelector('kbd')){const shortcut=document.createElement('kbd');shortcut.textContent='⌘ K';shortcut.setAttribute('aria-hidden','true');label.append(shortcut);}}
 const summary=root.querySelector<HTMLElement>('[data-cy=shell-utilities]>summary');if(summary){summary.setAttribute('aria-label',words.account);summary.title=words.account;summary.innerHTML='<span class="approved-profile-avatar" aria-hidden="true">CA</span>'+shellIcon('chevron-down');}
 if(!bound.has(root)){bound.add(root);root.addEventListener('keydown',event=>{if(root.querySelector('.approved-code-admin')&&(event.ctrlKey||event.metaKey)&&event.key.toLowerCase()==='k'){event.preventDefault();root.querySelector<HTMLInputElement>('[data-cy=universal-search]')?.focus();}});}
}
