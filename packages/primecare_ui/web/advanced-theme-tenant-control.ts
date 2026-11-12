import {TenantThemeMigrationReview} from './advanced-theme-tenant-review';
import type {PreferenceSyncClient} from '../../shared/src/preference-sync/client';

type Locale = 'en' | 'fr' | 'es';
const labels = {
  en: {review:'Review saved themes',save:'Confirm migration',retry:'Retry pending save',heading:'Theme migration',
    changed:'Review these settings before saving. Some original settings remain in the browser backup:',
    ready:'Review ready',saved:'Saved',pending:'Save pending. Retry when connected.',failed:'Could not save. Review your connection and existing cloud settings.'},
  fr: {review:'Vérifier les thèmes enregistrés',save:'Confirmer la migration',retry:'Réessayer l’enregistrement',heading:'Migration des thèmes',
    changed:'Vérifiez ces paramètres avant de les enregistrer. Certains restent dans la sauvegarde du navigateur :',
    ready:'Vérification prête',saved:'Enregistré',pending:'Enregistrement en attente. Réessayez une fois connecté.',failed:'Enregistrement impossible. Vérifiez la connexion et les paramètres existants.'},
  es: {review:'Revisar temas guardados',save:'Confirmar migración',retry:'Reintentar guardado',heading:'Migración de temas',
    changed:'Revise los ajustes antes de guardar. Algunos permanecen en la copia del navegador:',
    ready:'Revisión lista',saved:'Guardado',pending:'Guardado pendiente. Reintente al conectarse.',failed:'No se pudo guardar. Revise la conexión y los ajustes existentes.'},
};

/** Mount only within a host that has registered these controls and verified its actor. */
export function mountTenantThemeMigration(
  root: HTMLElement, client: PreferenceSyncClient, storage: Storage, locale: Locale, isCurrent:()=>boolean=()=>true,
) {
  const doc=root.ownerDocument, text=labels[locale], review=new TenantThemeMigrationReview(storage,client,()=>valid());
  const section=doc.createElement('section');
  const heading=doc.createElement('h3');heading.textContent=text.heading;
  const description=doc.createElement('p');
  const preview=doc.createElement('pre');preview.dataset.cy='theme-migration-preview';
  const status=doc.createElement('output');status.dataset.cy='theme-migration-status';status.setAttribute('role','status');
  const button=(name:string,label:string)=>{const el=doc.createElement('button');el.type='button';el.dataset.cy='theme-migration-'+name;el.textContent=label;return el;};
  const prepare=button('review',text.review),save=button('save',text.save),retry=button('retry',text.retry);
  save.disabled=true;
  retry.hidden=client.current.pending?.action !== 'write';
  prepare.disabled=!retry.hidden;
  section.append(heading,prepare,description,preview,save,retry,status);root.append(section);
  let disposed=false,busy=false;
  const valid=()=>!disposed&&isCurrent()&&root.contains(section);
  const result=(value:{status:string;pending:boolean})=>{
    if(!valid())return;
    retry.hidden=!value.pending;
    prepare.disabled=value.pending;
    status.textContent=value.status==='clean'?text.saved:value.pending?text.pending:text.failed;
  };
  prepare.onclick=()=>{if(!valid()||busy)return;try{
    const value=review.prepare();description.textContent=text.changed+' '+value.unmappedFields.join(', ');
    preview.textContent=JSON.stringify(value.candidate,null,2);save.disabled=false;status.textContent=text.ready;
  }catch{save.disabled=true;status.textContent=text.failed;}};
  save.onclick=async()=>{if(!valid()||busy)return;busy=true;save.disabled=true;try{result(await review.confirm());}catch{if(valid())status.textContent=text.failed;}finally{busy=false;}};
  retry.onclick=async()=>{if(!valid()||busy)return;busy=true;retry.disabled=true;try{result(await review.retry());}catch{if(valid())status.textContent=text.failed;}finally{busy=false;if(valid())retry.disabled=false;}};
  return ()=>{disposed=true;review.dispose();section.remove();};
}
