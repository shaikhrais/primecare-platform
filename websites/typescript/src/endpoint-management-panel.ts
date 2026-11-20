import {readTrafficReport} from './endpoint-traffic-report';
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

const healthLabels = {
  en:['Check live health','Checking service health…','Health check unavailable.','Responding','Degraded','Observed at'],
  fr:['Vérifier l’état en direct','Vérification des services…','Vérification indisponible.','Opérationnel','Dégradé','Observé à'],
  es:['Comprobar estado en vivo','Comprobando servicios…','Comprobación no disponible.','Operativo','Degradado','Observado a las'],
} as const;

export async function readEndpointServiceHealth(gateway:string, signal:AbortSignal, send:typeof fetch=fetch) {
  const response=await send(gateway+'/health',{method:'GET',cache:'no-store',credentials:'omit',signal});
  if(response.status!==200&&response.status!==503)throw Error('Unexpected health status');
  const data=await response.json() as {status?:unknown;services?:Record<string,unknown>};
  if(!data.services||typeof data.services!=='object'||Array.isArray(data.services))throw Error('Missing service results');
  const services=Object.entries(data.services);
  if(!services.length||services.length>30||services.some(([name,healthy])=>!/^[a-z][a-z0-9-]{0,39}$/.test(name)||typeof healthy!=='boolean')){
    throw Error('Invalid service results');
  }
  const healthy=services.every(([,value])=>value===true);
  if(healthy!==(response.status===200)||data.status!==(healthy?'healthy':'degraded'))throw Error('Inconsistent health status');
  return services.map(([service,value])=>({service,healthy:value===true}));
}

const trafficLabels = {
  en:['Open traffic report','Invalid traffic report.','Observed requests','Known inbound bytes','Known outbound bytes','Unknown sizes','P95 latency (ms)','observed requests/s'],
  fr:['Ouvrir un rapport de trafic','Rapport de trafic invalide.','Requêtes observées','Octets entrants connus','Octets sortants connus','Tailles inconnues','Latence P95 (ms)','requêtes observées/s'],
  es:['Abrir informe de tráfico','Informe de tráfico no válido.','Solicitudes observadas','Bytes entrantes conocidos','Bytes salientes conocidos','Tamaños desconocidos','Latencia P95 (ms)','solicitudes observadas/s'],
} as const;

export function mountEndpointManagement(panel:HTMLElement, gateway:string, token:string, locale:Locale, current:()=>boolean) {
  const [title,searchLabel,search,previous,next,loading,empty,denied,unavailable,...columns]=labels[locale];
  panel.innerHTML='<h2></h2><form><label><span></span> <input type="search" maxlength="200"></label> <button type="submit"></button></form><p role="status"></p><div class="table-scroll" tabindex="0"><table><thead><tr></tr></thead><tbody></tbody></table></div><button type="button"></button> <button type="button"></button>';
  const [checkHealth,checkingHealth,healthUnavailable,healthy,degraded,observedAt]=healthLabels[locale];
  const healthButton=document.createElement('button');healthButton.type='button';healthButton.textContent=checkHealth;
  const healthStatus=document.createElement('p');healthStatus.setAttribute('role','status');
  const healthResults=document.createElement('ul');
  const heading=panel.querySelector('h2')!;
  heading.textContent=title;heading.after(healthButton,healthStatus,healthResults);
  let healthRequest:AbortController|undefined;
  healthButton.onclick=async()=>{
    if(!current()||healthRequest)return;
    const request=new AbortController();healthRequest=request;
    const active=()=>healthRequest===request&&!request.signal.aborted&&current();
    healthButton.disabled=true;healthStatus.textContent=checkingHealth;healthResults.replaceChildren();
    try {
      const services=await readEndpointServiceHealth(gateway,AbortSignal.any([request.signal,AbortSignal.timeout(10000)]));
      if(!active())return;
      for(const service of services){
        const item=document.createElement('li');item.textContent=service.service+' — '+(service.healthy?healthy:degraded);
        healthResults.append(item);
      }
      healthStatus.textContent=observedAt+' '+new Date().toLocaleString(locale);
    }catch{if(active())healthStatus.textContent=healthUnavailable;}
    finally{if(active()){healthRequest=undefined;healthButton.disabled=false;}}
  };
  const form=panel.querySelector('form')!, input=panel.querySelector('input')!;
  form.querySelector('span')!.textContent=searchLabel;
  form.querySelector('button')!.textContent=search;
  const status=form.nextElementSibling as HTMLElement; const table=panel.querySelector('table')!;
  const header=table.tHead!.rows[0], body=table.tBodies[0];
  const [openTraffic,invalidTraffic,requests,inbound,outbound,unknownSizes,latency,rps]=trafficLabels[locale];
  const trafficLabel=document.createElement('label');
  const trafficFile=document.createElement('input');trafficFile.type='file';trafficFile.accept='.json,application/json';
  trafficLabel.append(openTraffic+' ',trafficFile);
  const trafficStatus=document.createElement('p');trafficStatus.setAttribute('role','status');
  form.before(trafficLabel,trafficStatus);
  let traffic:ReturnType<typeof readTrafficReport>|undefined;
  let importVersion=0;
  const numbers=new Intl.NumberFormat(locale,{maximumFractionDigits:3});
  trafficFile.onchange=async()=>{
    if(!current())return;
    const version=++importVersion,file=trafficFile.files?.[0];
    const active=()=>version===importVersion&&current();
    traffic=undefined;
    try {
      if(!file||file.size>2_000_000)throw Error();
      const parsed=readTrafficReport(JSON.parse(await file.text()));
      if(!active())return;
      traffic=parsed;
      const time=(value:number)=>new Date(value).toLocaleString(locale);
      trafficStatus.textContent=`${time(parsed.start)} – ${time(parsed.end)} · ${numbers.format(parsed.observedRequests)} ${requests.toLocaleLowerCase(locale)} · ${numbers.format(parsed.requestsPerSecond)} ${rps} · ${inbound} ${numbers.format(parsed.inboundBytes)} · ${outbound} ${numbers.format(parsed.outboundBytes)}`;
    }catch{if(active())trafficStatus.textContent=invalidTraffic;}
    if(active())void load();
  };
  panel.querySelector('.table-scroll')!.setAttribute('aria-label',title);
  for(const column of [...columns,requests,inbound,outbound,latency]){
    const th=document.createElement('th'); th.scope='col'; th.textContent=column; header.append(th);
  }
  const [back,forward]=[...panel.querySelectorAll<HTMLButtonElement>('button[type="button"]')].filter(button=>button!==healthButton);
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
        const observed=traffic?.endpoints.get(row.api);
        const size=(bytes:{knownBytes:number;unknownRequests:number})=>
          numbers.format(bytes.knownBytes)+(bytes.unknownRequests?' · '+unknownSizes+': '+numbers.format(bytes.unknownRequests):'');
        cells.push(...(observed?[numbers.format(observed.observedRequests),size(observed.declaredRequestBytes),
          size(observed.declaredResponseBytes),numbers.format(observed.responseHeaderLatencyP95Ms)]:Array(4).fill('—')));
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
  return ()=>{request?.abort();request=undefined;healthRequest?.abort();healthRequest=undefined;};
}
