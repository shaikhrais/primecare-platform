/** Keep programmatic keyboard focus visible beneath the responsive, sticky shell header. */
export function focusInWorkspace(root:HTMLElement,target:HTMLElement|null):void{
 if(!target)return;
 target.focus({preventScroll:true});
 target.scrollIntoView({block:'nearest',inline:'nearest'});
 const shell=root.closest<HTMLElement>('[data-cy=app-shell]')??root;
 const topbar=shell.querySelector<HTMLElement>('[data-cy=app-topbar]');
 const clearance=topbar&&getComputedStyle(topbar).position==='sticky'
  ?topbar.getBoundingClientRect().bottom+parseFloat(getComputedStyle(topbar).paddingBottom||'0'):0;
 const top=target.getBoundingClientRect().top;
 // Round away from zero so subpixel clipping also clears a non-sticky header.
 if(top<clearance)window.scrollBy({top:Math.floor(top-clearance),behavior:'instant'});
}
