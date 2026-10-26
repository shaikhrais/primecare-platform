interface InstallPromptEvent extends Event {
 prompt():Promise<void>;
 userChoice:Promise<{outcome:'accepted'|'dismissed'}>;
}
/** Browser install support is independent of sign-in and grants no calling access. */
export function initializePortalInstall():void{
 let pending:InstallPromptEvent|null=null;
 const bar=document.createElement('div');bar.className='portal-install';bar.dataset.cy='portal-install';
 const button=document.createElement('button');button.type='button';button.dataset.cy='portal-install-button';button.textContent='Install PrimeCare';
 const note=document.createElement('p');note.dataset.cy='portal-install-status';note.setAttribute('role','status');note.setAttribute('aria-live','polite');
 note.textContent='Add PrimeCare to your home screen for quick access.';
 bar.append(button,note);document.body.prepend(bar);
 const standalone=window.matchMedia('(display-mode: standalone)');
 const visibility=()=>{bar.hidden=standalone.matches;};visibility();standalone.addEventListener('change',visibility);
 window.addEventListener('beforeinstallprompt',event=>{event.preventDefault();pending=event as InstallPromptEvent;button.disabled=false;note.textContent='PrimeCare is ready to install.';});
 window.addEventListener('appinstalled',()=>{pending=null;bar.hidden=true;});
 button.addEventListener('click',async()=>{
  const prompt=pending;
  if(!prompt){note.textContent='In Chrome, open ⋮ → Add to Home screen → Install. If the option is not shown yet, stay on this page briefly and try again. Installed apps may offer Open instead.';return;}
  pending=null;button.disabled=true;
  try{await prompt.prompt();const choice=await prompt.userChoice;note.textContent=choice.outcome==='accepted'?'Installation accepted. Complete any confirmation shown by Chrome.':'Installation cancelled. You can still use PrimeCare in Chrome.';}
  catch{note.textContent='Open Chrome’s ⋮ menu and choose Add to Home screen → Install.';}
  finally{button.disabled=false;}
 });
 if(window.isSecureContext&&'serviceWorker' in navigator){void navigator.serviceWorker.register('/service-worker.js',{scope:'/',updateViaCache:'none'}).catch(()=>{/* Online use remains available if browser policy blocks registration. */});}
}
