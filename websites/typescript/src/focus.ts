/** Keep programmatic keyboard focus visible beneath the responsive, sticky shell header. */
export function focusInWorkspace(root:HTMLElement,target:HTMLElement|null):void{
 if(!target)return;
 target.focus({preventScroll:true});
 target.scrollIntoView({block:'nearest',inline:'nearest'});
 const shell=root.closest<HTMLElement>('[data-cy=app-shell]')??root;
 const topbar=shell.querySelector<HTMLElement>('[data-cy=app-topbar]');
 if(topbar&&getComputedStyle(topbar).position==='sticky'){
  const clearance=topbar.getBoundingClientRect().bottom+parseFloat(getComputedStyle(topbar).paddingBottom||'0');
  const top=target.getBoundingClientRect().top;
  if(top<clearance)window.scrollBy({top:top-clearance});
 }
}
