import definition from '../../../packages/shared/src/endpoint-management/contract.json';
import {mountEndpointManagement} from './endpoint-management-panel';
import {readCapacityEvidence} from './endpoint-capacity';
type Locale='en'|'fr'|'es';
const copy={
 en:['Endpoint management · EMS','Registered declarations','Unique operations','Verified ready','Blocked','Missing permission metadata','Refresh EMS','EMS access denied. The Code Admin screen and API grants must be registered.','EMS data unavailable.','Full-system capacity is unmeasured.','Capacity evidence unavailable or expired.','Reference workload benchmark','Maintenance windows','No recorded active or scheduled maintenance.','Recorded windows are informational; they do not block traffic.','Operation','Status','Start','End','Reason'],
 fr:['Gestion des API · EMS','Déclarations enregistrées','Opérations uniques','Préparation vérifiée','Bloqué','Métadonnées de permission manquantes','Actualiser EMS','Accès EMS refusé. Les droits Code Admin doivent être enregistrés.','Données EMS indisponibles.','La capacité globale du système n’est pas mesurée.','Mesure de capacité indisponible ou expirée.','Mesure de référence de la charge','Fenêtres de maintenance','Aucune maintenance active ou planifiée enregistrée.','Les fenêtres sont informatives et ne bloquent pas le trafic.','Opération','État','Début','Fin','Motif'],
 es:['Gestión de API · EMS','Declaraciones registradas','Operaciones únicas','Preparación verificada','Bloqueado','Faltan metadatos de permisos','Actualizar EMS','Acceso EMS denegado. Se requieren permisos registrados de Code Admin.','Datos EMS no disponibles.','La capacidad total del sistema no está medida.','Medición de capacidad no disponible o vencida.','Medición de referencia de carga','Ventanas de mantenimiento','No hay mantenimiento activo o programado registrado.','Las ventanas son informativas y no bloquean el tráfico.','Operación','Estado','Inicio','Fin','Motivo'],
} as const;
export const emsTitle=(locale:Locale)=>copy[locale][0];
const validCount=(v:unknown):v is number=>typeof v==='number'&&Number.isSafeInteger(v)&&v>=0;
export function readEmsSummary(raw:unknown){
 const value=raw as {declarations:number;uniqueOperations:number;implementation:Record<string,number>;protection:Record<string,number>;readiness:Record<string,number>;maintenance:Record<string,number>};
 if(!value||!validCount(value.declarations)||!validCount(value.uniqueOperations)||value.uniqueOperations>value.declarations)throw Error('Invalid EMS summary');
 for(const field of ['implementation','protection','readiness','maintenance'] as const){
  const group=value[field];if(!group||typeof group!=='object'||Array.isArray(group)||Object.keys(group).length>20||!Object.values(group).every(validCount)||Object.values(group).reduce((n,v)=>n+v,0)!==value.declarations)throw Error('Invalid EMS counts');
 }
 return value;
}
/** Registered child panel of the existing Code Admin administration host. */
export function mountCodeAdminEms(panel:HTMLElement,gateway:string,token:string,locale:Locale,current:()=>boolean){
 const text=copy[locale],base='/v1/governance/platform/ems';
 panel.innerHTML='<section data-cy="ems-overview"><button type="button" data-cy="ems-refresh"></button><p role="status" data-cy="ems-summary"></p><p role="status" data-cy="ems-capacity"></p><h2></h2><p data-cy="ems-maintenance-note"></p><div data-cy="ems-maintenance"></div><button type="button" data-cy="ems-maintenance-previous"></button> <button type="button" data-cy="ems-maintenance-next"></button></section><section data-cy="ems-inventory"></section>';
 const summary=panel.querySelector<HTMLElement>('[data-cy=ems-summary]')!,capacity=panel.querySelector<HTMLElement>('[data-cy=ems-capacity]')!,maintenance=panel.querySelector<HTMLElement>('[data-cy=ems-maintenance]')!;
 panel.querySelector('h2')!.textContent=text[12];panel.querySelector('[data-cy=ems-maintenance-note]')!.textContent=text[14];
 const button=panel.querySelector<HTMLButtonElement>('[data-cy=ems-refresh]')!;button.textContent=text[6];
 const previous=panel.querySelector<HTMLButtonElement>('[data-cy=ems-maintenance-previous]')!,next=panel.querySelector<HTMLButtonElement>('[data-cy=ems-maintenance-next]')!;
 previous.textContent=({en:'Previous',fr:'Précédent',es:'Anterior'}[locale]);next.textContent=({en:'Next',fr:'Suivant',es:'Siguiente'}[locale]);
 let maintenanceOffset=0;
 let request:AbortController|undefined,disposed=false;
 const active=()=>!disposed&&current()&&panel.isConnected;
 const numbers=new Intl.NumberFormat(locale,{maximumFractionDigits:3});
 const stopInventory=mountEndpointManagement(panel.querySelector<HTMLElement>('[data-cy=ems-inventory]')!,gateway,token,locale,active,{inventory:base+'/endpoints',services:base+'/services',traffic:base+'/traffic'});
 async function load(){
  if(!active())return;request?.abort();const pending=new AbortController();request=pending;
  const owns=()=>active()&&request===pending&&!pending.signal.aborted;
  button.disabled=previous.disabled=next.disabled=true;summary.textContent=capacity.textContent='…';maintenance.replaceChildren();
  const read=async(path:string)=>{const response=await fetch(gateway+base+path,{headers:{authorization:'Bearer '+token},cache:'no-store',signal:AbortSignal.any([pending.signal,AbortSignal.timeout(10000)])});if(!response.ok)throw Error(response.status===401||response.status===403?text[7]:text[8]);return await response.json();};
  const results=await Promise.allSettled([read('/summary'),read('/capacity'),read('/maintenance?limit=100&offset='+maintenanceOffset)]);
  if(!owns())return;
  for(let i=0;i<results.length;i++){
   const result=results[i],target=[summary,capacity,maintenance][i];
   if(result.status==='rejected'){target.textContent=result.reason instanceof Error?result.reason.message:text[8];continue;}
   try{
    if(i===0){const data=readEmsSummary(result.value);target.textContent=[data.declarations,data.uniqueOperations,data.readiness.ready??0,data.readiness.blocked??0,data.protection.permission_metadata_missing??0].map((v,j)=>text[j+1]+': '+numbers.format(v)).join(' · ');}
    else if(i===1){const data=result.value;if(data.status==='unmeasured')target.textContent=text[9];else if(data.status==='reference'){
     const benchmark=readCapacityEvidence(data.benchmark);target.textContent=`${text[11]}: ${benchmark.environment} · ${benchmark.workload} · ${numbers.format(benchmark.sustainableRequestsPerSecond)} requests/s · P95 ${numbers.format(benchmark.p95LatencyMs)} ms · ${benchmark.measuredAt} – ${benchmark.expiresAt}`;
     target.append(' '+({en:'Reference only; full-system production capacity is not verified.',fr:'Référence uniquement ; capacité globale en production non vérifiée.',es:'Solo referencia; capacidad total en producción sin verificar.'}[locale]));
     if(benchmark.measurementScope==='staging_http_read_mix')target.append(' '+({en:'Staging reads only.',fr:'Lectures en préproduction uniquement.',es:'Solo lecturas de preproducción.'}[locale]));
    }else target.textContent=text[10];
     if(typeof data.recommendation==='string'&&data.recommendation.length<=600)target.append(' '+data.recommendation);
    }else{
     const data=result.value;if(!Array.isArray(data.data)||data.data.length>100||!validCount(data.pagination?.total)||data.data.length>data.pagination.total||typeof data.pagination.hasMore!=='boolean'||data.pagination.hasMore!==(maintenanceOffset+data.data.length<data.pagination.total))throw Error();
     previous.disabled=maintenanceOffset===0;next.disabled=!data.pagination.hasMore;
     if(!data.data.length)target.textContent=text[13];else{
      const table=document.createElement('table'),head=table.createTHead().insertRow(),body=table.createTBody();
      for(const label of text.slice(15)){const th=document.createElement('th');th.scope='col';th.textContent=label;head.append(th);}
      for(const row of data.data){if(!row||typeof row.api!=='string'||row.api.length>400||typeof row.management?.maintenance!=='string')throw Error();const window=row.management.maintenanceWindow;
       const tr=body.insertRow();for(const value of [row.api,row.management.maintenance,window?.startsAt??'—',window?.endsAt??'—',window?.reason??'—']){if(typeof value!=='string'||value.length>400)throw Error();tr.insertCell().textContent=value;}}
      target.append(table);
      target.append(` · ${maintenanceOffset+1}–${maintenanceOffset+data.data.length} / ${data.pagination.total}`);
     }
    }
   }catch{target.replaceChildren();target.textContent=text[8];}
  }
  button.disabled=false;
 }
 previous.onclick=()=>{if(!previous.disabled&&maintenanceOffset>=100){maintenanceOffset-=100;void load();}};next.onclick=()=>{if(!next.disabled){maintenanceOffset+=100;void load();}};
 button.onclick=()=>{maintenanceOffset=0;void load();};void load();
 const timer=setInterval(()=>{if(active()&&!document.hidden)void load();},60000);
 return ()=>{disposed=true;request?.abort();clearInterval(timer);stopInventory();};
}
