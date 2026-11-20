type Locale = 'en' | 'fr' | 'es';
const labels = {
  en: ['Endpoint management','Search endpoints','Search','Previous','Next','Loading endpoints…','No matching endpoints.','Endpoint inventory access denied.','Endpoint inventory unavailable.','Operation','Service','Implementation','Protection','Readiness','Maintenance','Offline HTTP result'],
  fr: ['Gestion des API','Rechercher des points d’accès','Rechercher','Précédent','Suivant','Chargement des API…','Aucun résultat.','Accès à l’inventaire refusé.','Inventaire des API indisponible.','Opération','Service','Implémentation','Protection','État de préparation','Maintenance','Résultat HTTP hors ligne'],
  es: ['Gestión de API','Buscar endpoints','Buscar','Anterior','Siguiente','Cargando endpoints…','Sin resultados.','Acceso al inventario denegado.','Inventario de API no disponible.','Operación','Servicio','Implementación','Protección','Preparación','Mantenimiento','Resultado HTTP sin conexión'],
} as const;
const states: Record<string, readonly [string,string,string]> = {
  blocked:['Blocked','Bloqué','Bloqueado'],
  declared_implemented:['Declared implemented','Déclaré implémenté','Implementación declarada'],
  partial:['Partial','Partiel','Parcial'],
  unknown:['Unknown','Inconnu','Desconocido'],
  permission_metadata_missing:['Permission metadata missing','Métadonnées de permission manquantes','Faltan metadatos de permisos'],
  ready:['Ready','Prêt','Listo'],
  verified_access_policy:['Access policy verified','Politique d’accès vérifiée','Política de acceso verificada'],
  unverified:['Unverified','Non vérifié','Sin verificar'],
  maintenance:['Maintenance','Maintenance','Mantenimiento'],
  active_maintenance:['Active maintenance','Maintenance en cours','Mantenimiento activo'],
  scheduled_maintenance:['Scheduled maintenance','Maintenance planifiée','Mantenimiento programado'],
  recorded_maintenance:['Recorded maintenance','Maintenance enregistrée','Mantenimiento registrado'],
};
const fields = ['implementation','protection','readiness','maintenance'] as const;
type Endpoint = {api:string;service:string;management:Record<typeof fields[number],string>&{maintenanceWindow?:{startsAt:string;endsAt:string;reason:string}};routingEvidence?:{status:number}|null};

export function mountEndpointManagement(panel:HTMLElement, gateway:string, token:string, locale:Locale, current:()=>boolean) {
  const [title,searchLabel,search,previous,next,loading,empty,denied,unavailable,...columns]=labels[locale];
  panel.innerHTML='<h2></h2><form><label><span></span> <input type="search" maxlength="200"></label> <button type="submit"></button></form><p role="status"></p><div class="table-scroll" tabindex="0"><table><thead><tr></tr></thead><tbody></tbody></table></div><button type="button"></button> <button type="button"></button>';
  panel.querySelector('h2')!.textContent=title;
  const form=panel.querySelector('form')!, input=panel.querySelector('input')!;
  form.querySelector('span')!.textContent=searchLabel;
  form.querySelector('button')!.textContent=search;
  const status=panel.querySelector('p')!, table=panel.querySelector('table')!;
  const header=table.tHead!.rows[0], body=table.tBodies[0];
  panel.querySelector('.table-scroll')!.setAttribute('aria-label',title);
  for(const column of columns){
    const th=document.createElement('th'); th.scope='col'; th.textContent=column; header.append(th);
  }
  const [back,forward]=panel.querySelectorAll<HTMLButtonElement>('button[type="button"]');
  back.textContent=previous; forward.textContent=next;
  const limit=25, language=locale==='en'?0:locale==='fr'?1:2;
  let offset=0, query='', request:AbortController|undefined;
  async function load() {
    if(!current())return;
    request?.abort();
    const pending=new AbortController();request=pending;
    const active=()=>request===pending&&!pending.signal.aborted&&current();
    status.textContent=loading;table.hidden=true;back.disabled=forward.disabled=true;body.replaceChildren();
    try {
      const params=new URLSearchParams({limit:String(limit),offset:String(offset),search:query});
      const response=await fetch(gateway+'/v1/governance/api-execution-status?'+params,{headers:{authorization:'Bearer '+token},cache:'no-store',signal:pending.signal});
      if(!active())return;
      if(response.status===401||response.status===403){status.textContent=denied;return;}
      if(!response.ok)throw Error();
      const data=await response.json() as {data:Endpoint[];pagination:{total:number;hasMore:boolean}};
      if(!active())return;
      if(!Array.isArray(data.data)||!Number.isSafeInteger(data.pagination?.total)||data.pagination.total<0)throw Error();
      for(const row of data.data) {
        const cells=[row.api,row.service,...fields.map(key=>states[row.management?.[key]]?.[language]??states.unknown[language]),row.routingEvidence?.status?.toString()??states.unknown[language]];
        const tr=body.insertRow();
        for(const cell of cells)tr.insertCell().textContent=cell??'';
        const window=row.management?.maintenanceWindow;
        if(window){
          const dates=document.createElement('small');
          dates.textContent=`${window.startsAt} – ${window.endsAt} · ${window.reason}`;
          tr.cells[5].append(document.createElement('br'),dates);
        }
      }
      table.hidden=data.data.length===0;
      status.textContent=data.data.length?`${offset+1}–${offset+data.data.length} / ${data.pagination.total}`:empty;
      back.disabled=offset===0;forward.disabled=data.pagination.hasMore!==true;
    }catch{if(active())status.textContent=unavailable;}
  }
  form.onsubmit=event=>{event.preventDefault();query=input.value.trim();offset=0;void load();};
  back.onclick=()=>{if(offset>=limit){offset-=limit;void load();}};
  forward.onclick=()=>{offset+=limit;void load();};
  void load();
  return ()=>{request?.abort();request=undefined;};
}
