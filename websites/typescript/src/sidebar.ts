const bound=new WeakSet<HTMLElement>();
export function bindSidebar(root:HTMLElement):void {
 const sidebar=root.querySelector<HTMLElement>('[data-cy="app-sidebar"]');
 const toggle=root.querySelector<HTMLButtonElement>('[data-cy="sidebar-toggle"]');
 const close=root.querySelector<HTMLButtonElement>('[data-cy="sidebar-close"]');
 if(!sidebar||!toggle||bound.has(sidebar))return;bound.add(sidebar);
 const shade=document.createElement('button');shade.type='button';shade.className='sidebar-backdrop';shade.dataset.cy='sidebar-backdrop';shade.tabIndex=-1;shade.setAttribute('aria-label',close?.getAttribute('aria-label')??'Close navigation');sidebar.parentElement!.append(shade);
 const setOpen=(open:boolean,returnFocus=true)=>{sidebar.classList.toggle('open',open);toggle.setAttribute('aria-expanded',String(open));if(open)close?.focus();else if(returnFocus)toggle.focus();};
 toggle.addEventListener('click',()=>setOpen(!sidebar.classList.contains('open')));
 close?.addEventListener('click',()=>setOpen(false));shade.onclick=()=>setOpen(false);
 sidebar.addEventListener('keydown',event=>{if(event.key!=='Tab'||!sidebar.classList.contains('open')||!matchMedia('(max-width:1024px)').matches)return;const items=[...sidebar.querySelectorAll<HTMLElement>('a[href],button,summary,select,input')].filter(e=>e.getClientRects().length&&!e.hasAttribute('disabled'));const first=items[0],last=items.at(-1);if(event.shiftKey&&document.activeElement===first){event.preventDefault();last?.focus();}else if(!event.shiftKey&&document.activeElement===last){event.preventDefault();first?.focus();}});
 sidebar.addEventListener('keydown',event=>{if(event.key==='Escape')setOpen(false);});
 sidebar.addEventListener('click',event=>{if((event.target as Element).closest('a')&&sidebar.classList.contains('open'))setOpen(false,sidebar.contains(document.activeElement));});
}
