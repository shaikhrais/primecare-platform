const bound=new WeakSet<HTMLElement>();
export function bindSidebar(root:HTMLElement):void {
 const sidebar=root.querySelector<HTMLElement>('[data-cy="app-sidebar"]');
 const toggle=root.querySelector<HTMLButtonElement>('[data-cy="sidebar-toggle"]');
 const close=root.querySelector<HTMLButtonElement>('[data-cy="sidebar-close"]');
 if(!sidebar||!toggle||bound.has(sidebar))return;bound.add(sidebar);
 const setOpen=(open:boolean,returnFocus=true)=>{sidebar.classList.toggle('open',open);toggle.setAttribute('aria-expanded',String(open));if(open)close?.focus();else if(returnFocus)toggle.focus();};
 toggle.addEventListener('click',()=>setOpen(!sidebar.classList.contains('open')));
 close?.addEventListener('click',()=>setOpen(false));
 sidebar.addEventListener('keydown',event=>{if(event.key==='Escape')setOpen(false);});
 sidebar.addEventListener('click',event=>{if((event.target as Element).closest('a')&&sidebar.classList.contains('open'))setOpen(false,sidebar.contains(document.activeElement));});
}
