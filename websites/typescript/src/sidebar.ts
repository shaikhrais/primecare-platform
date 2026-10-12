export function bindSidebar(root:HTMLElement):void {
 const sidebar=root.querySelector<HTMLElement>('[data-cy="app-sidebar"]');
 const toggle=root.querySelector<HTMLButtonElement>('[data-cy="sidebar-toggle"]');
 const close=root.querySelector<HTMLButtonElement>('[data-cy="sidebar-close"]');
 if(!sidebar||!toggle)return;
 const setOpen=(open:boolean)=>{sidebar.classList.toggle('open',open);toggle.setAttribute('aria-expanded',String(open));if(open)close?.focus();else toggle.focus();};
 toggle.addEventListener('click',()=>setOpen(!sidebar.classList.contains('open')));
 close?.addEventListener('click',()=>setOpen(false));
 sidebar.addEventListener('keydown',event=>{if(event.key==='Escape')setOpen(false);});
 sidebar.querySelectorAll('a').forEach(link=>link.addEventListener('click',()=>{if(sidebar.classList.contains('open'))setOpen(false);}));
}
