import {storeRestoreCopy,themeLibraryAbsent,withThemeLibraryLock} from './theme-restore-storage';
import {TenantThemeRestoreReview} from './advanced-theme-tenant-restore';
import type {PreferenceSyncClient} from '../../shared/src/preference-sync/client';

type Locale='en'|'fr'|'es';
const copy={
 en:{review:'Review account themes',confirm:'Restore to this browser',changed:'Review the preview. Some advanced settings cannot be represented in this editor.',ready:'Review ready',failed:'Could not restore. Your local themes were not replaced.'},
 fr:{review:'Vérifier les thèmes du compte',confirm:'Restaurer dans ce navigateur',changed:'Vérifiez l’aperçu. Certains paramètres avancés ne peuvent pas être représentés dans cet éditeur.',ready:'Vérification prête',failed:'Restauration impossible. Vos thèmes locaux n’ont pas été remplacés.'},
 es:{review:'Revisar temas de la cuenta',confirm:'Restaurar en este navegador',changed:'Revise la vista previa. Algunos ajustes avanzados no se pueden representar en este editor.',ready:'Revisión lista',failed:'No se pudo restaurar. Sus temas locales no se reemplazaron.'},
};
/** Review a remote library and restore only into a browser with no local theme or draft. */
export function mountTenantThemeRestore(root:HTMLElement,client:PreferenceSyncClient,storage:Storage,key:string,locale:Locale,isCurrent:()=>boolean,hasDraft:()=>boolean,onRestored:()=>void){
 const doc=root.ownerDocument,text=copy[locale],review=new TenantThemeRestoreReview(client);
 const section=doc.createElement('section'),preview=doc.createElement('pre'),status=doc.createElement('output');
 const message=doc.createElement('p');message.textContent=text.changed;
 preview.dataset.cy='theme-restore-preview';status.dataset.cy='theme-restore-status';status.setAttribute('role','status');
 const button=(id:string,label:string)=>{const el=doc.createElement('button');el.type='button';el.dataset.cy='theme-restore-'+id;el.textContent=label;return el;};
 const prepare=button('review',text.review),confirm=button('confirm',text.confirm);confirm.disabled=true;
 section.append(prepare,message,preview,confirm,status);root.append(section);
 let dead=false,busy=false,candidate:unknown=null;
 const valid=()=>!dead&&isCurrent()&&root.contains(section);
 prepare.onclick=()=>{if(!valid()||busy)return;try{const value=review.prepare();candidate=value.candidate;preview.textContent=JSON.stringify({candidate:value.candidate,unmappedFields:value.unmappedFields},null,2);status.textContent=text.ready;confirm.disabled=false;}catch{candidate=null;confirm.disabled=true;status.textContent=text.failed;}};
 confirm.onclick=async()=>{if(!valid()||busy||!candidate)return;busy=true;confirm.disabled=true;try{
  const result=await review.confirm(candidate,()=>({libraryAbsent:themeLibraryAbsent(storage,key),draftAbsent:!hasDraft()}));
  await withThemeLibraryLock(key,()=>{
   if(!valid()||hasDraft()||!themeLibraryAbsent(storage,key))throw Error('Local theme changed');
   storeRestoreCopy(storage,key,JSON.stringify(result),crypto.randomUUID());
  });
  if(valid())onRestored();
 }catch{if(valid())status.textContent=text.failed;}finally{busy=false;}};
 return ()=>{dead=true;review.dispose();section.remove();};
}
