import {readTrafficReport,endpointTrafficMetrics,readEndpointSummary} from './endpoint-traffic-report';
import {readCapacityEvidence,assessCapacity} from './endpoint-capacity';
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

export function mountEndpointManagement(panel:HTMLElement, gateway:string, token:string, locale:Locale, current:()=>boolean, paths?:{inventory:string;services:string;traffic:string}) {
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
  const summary=document.createElement('p');summary.setAttribute('role','status');
  heading.after(summary);
  const summaryRequest=new AbortController();
  const summaryText={en:['Registered declarations','Ready','Blocked','Maintenance','Unverified','Status summary unavailable.'],fr:['Déclarations enregistrées','Prêt','Bloqué','Maintenance','Non vérifié','Résumé indisponible.'],es:['Declaraciones registradas','Listo','Bloqueado','Mantenimiento','Sin verificar','Resumen no disponible.']}[locale];
  async function loadSummary(){
    try{
      const response=await fetch(gateway+(paths?.services??'/v1/governance/api-service-status')+'?limit=100',{
        headers:{authorization:'Bearer '+token},cache:'no-store',signal:AbortSignal.any([summaryRequest.signal,AbortSignal.timeout(10000)])});
      if(!response.ok)throw Error();
      const payload=await response.json() as {traffic?:{status?:string;report?:unknown}};
      const totals=readEndpointSummary(payload);
      if(paths&&!localTraffic){
        try{
          const response=await fetch(gateway+paths.traffic,{headers:{authorization:'Bearer '+token},cache:'no-store',signal:AbortSignal.any([summaryRequest.signal,AbortSignal.timeout(10000)])});
          payload.traffic=response.ok?await response.json() as {status?:string;report?:unknown}:{status:response.status===401||response.status===403?'denied':'unavailable'};
        }catch{payload.traffic={status:'unavailable'};}
      }
      if(!current()||summaryRequest.signal.aborted)return;
      if(!localTraffic){
        if(payload.traffic?.status==='available'){
          try{traffic=readTrafficReport(payload.traffic.report);showTraffic();showCapacity();void load();}
          catch{traffic=undefined;trafficStatus.textContent=invalidTraffic;showCapacity();void load();}
        }else{
          traffic=undefined;
          const text={en:{denied:'Platform-wide traffic access is not granted to this role.',not_configured:'Live traffic reporting is not configured.',unavailable:'Live traffic reporting is unavailable.'},fr:{denied:'Accès au trafic global refusé pour ce rôle.',not_configured:'Rapport de trafic en direct non configuré.',unavailable:'Rapport de trafic en direct indisponible.'},es:{denied:'Acceso al tráfico global no autorizado para este rol.',not_configured:'Informe de tráfico en vivo sin configurar.',unavailable:'Informe de tráfico en vivo no disponible.'}}[locale];
          trafficStatus.textContent=text[payload.traffic?.status as keyof typeof text]??text.not_configured;
          showCapacity();void load();
        }
      }
      summary.textContent=[totals.operations,totals.ready,totals.blocked,totals.maintenance,totals.unverified].map((n,i)=>summaryText[i]+': '+n.toLocaleString(locale)).join(' · ');
    }catch{if(current()&&!summaryRequest.signal.aborted){summary.textContent=summaryText[5];if(!localTraffic){traffic=undefined;trafficStatus.textContent=summaryText[5];showCapacity();void load();}}}
  }
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
  let localTraffic=false;
  const capacityText={
    en:['Sustainable benchmark','Successful benchmark','requests/s','Measured','Expires','Observed average / benchmark','Average rate margin','Benchmark evidence','Interval averages and retained logs do not establish peak headroom. Confirm matching deployment and workload before comparison.','Invalid, expired or failing benchmark.'],
    fr:['Débit soutenu mesuré','Débit réussi mesuré','requêtes/s','Mesuré','Expiration','Moyenne observée / mesure','Marge du débit moyen','Preuve de mesure','Les moyennes et journaux conservés ne prouvent pas la marge de pointe. Confirmez la même version et charge avant comparaison.','Mesure invalide, expirée ou hors cible.'],
    es:['Capacidad sostenida medida','Capacidad exitosa medida','solicitudes/s','Medido','Vence','Promedio observado / medición','Margen de tasa media','Evidencia de medición','Los promedios y registros retenidos no demuestran margen de pico. Confirme la misma versión y carga antes de comparar.','Medición inválida, vencida o fuera de objetivos.'],
  }[locale];
  const capacityLabel=document.createElement('label');
  capacityLabel.textContent=locale==='fr'?'Ouvrir une mesure de capacité ':locale==='es'?'Abrir medición de capacidad ':'Open capacity benchmark ';
  const capacityFile=document.createElement('input');capacityFile.type='file';capacityFile.accept='.json,application/json';
  capacityLabel.append(capacityFile);
  const capacityStatus=document.createElement('p');capacityStatus.setAttribute('role','status');
  trafficStatus.after(capacityLabel,capacityStatus);
  let capacity:ReturnType<typeof readCapacityEvidence>|undefined,capacityVersion=0;
  function showCapacity(){
    if(!capacity){capacityStatus.textContent=locale==='fr'?'Capacité non mesurée.':locale==='es'?'Capacidad sin medir.':'Capacity unmeasured. Import a benchmark for the same release, environment and workload as the traffic report.';return;}
    try{readCapacityEvidence(capacity);}catch{capacity=undefined;showCapacity();return;}
    const result=traffic?assessCapacity(capacity,traffic.requestsPerSecond):undefined;
    capacityStatus.textContent=`${capacity.releaseId} · ${capacity.environment} · ${capacity.workload} · ${capacityText[0]}: ${numbers.format(capacity.sustainableRequestsPerSecond)} ${capacityText[2]} · ${capacityText[1]}: ${numbers.format(capacity.sustainableRequestsPerSecond*(1-capacity.errorRate))} ${capacityText[2]} · P95 ${numbers.format(capacity.p95LatencyMs)} ms · Errors ${numbers.format(capacity.errorRate*100)}% · ${capacityText[3]} ${capacity.measuredAt} · ${capacityText[4]} ${capacity.expiresAt}`+
      (result?` · ${capacityText[5]}: ${numbers.format(result.observedAverageUtilization*100)}% · ${capacityText[6]}: ${numbers.format(result.averageRateMargin)} ${capacityText[2]}`:'')+
      ` · ${assessCapacity(capacity,0).recommendation} ${capacityText[8]}`;
    if(capacity.measurementScope==='staging_http_read_mix')capacityStatus.append(' '+(locale==='fr'?'Mesure limitée aux lectures en préproduction.':locale==='es'?'Medición limitada a lecturas en preproducción.':'Measurement covers staging reads only.'));
    const link=document.createElement('a');link.href=capacity.evidenceUrl;link.textContent=' '+capacityText[7];link.target='_blank';link.rel='noopener noreferrer';capacityStatus.append(link);
  }
  capacityFile.onchange=async()=>{
    const version=++capacityVersion;
    capacity=undefined;
    try{
      const file=capacityFile.files?.[0];if(!file||file.size>20000)throw Error();
      const parsed=readCapacityEvidence(JSON.parse(await file.text()));
      if(!current()||version!==capacityVersion)return;
      capacity=parsed;showCapacity();
    }catch{if(current()&&version===capacityVersion){showCapacity();capacityStatus.append(' '+capacityText[9]);}}
  };
  let importVersion=0;
  const numbers=new Intl.NumberFormat(locale,{maximumFractionDigits:3});
  const efficiencyLabels={en:['Known inbound bytes/s','Known outbound bytes/s','Observed HTTP 2xx/s','HTTP status coverage','no response'],fr:['Octets entrants connus/s','Octets sortants connus/s','HTTP 2xx observés/s','Couverture des statuts HTTP','sans réponse'],es:['Bytes entrantes conocidos/s','Bytes salientes conocidos/s','HTTP 2xx observados/s','Cobertura de estados HTTP','sin respuesta']}[locale];
  function showTraffic(){
    if(!traffic)return;
    const parsed=traffic;
    const time=(value:number)=>new Date(value).toLocaleString(locale);
    trafficStatus.textContent=`${time(parsed.start)} – ${time(parsed.end)} · ${numbers.format(parsed.observedRequests)} ${requests.toLocaleLowerCase(locale)} · ${numbers.format(parsed.requestsPerSecond)} ${rps} · ${inbound} ${numbers.format(parsed.inboundBytes)} · ${outbound} ${numbers.format(parsed.outboundBytes)} · ${unknownSizes}: ${numbers.format(parsed.unknownInbound)} / ${numbers.format(parsed.unknownOutbound)} · HTTP 2xx: ${numbers.format(parsed.successfulRequests)} · HTTP 5xx / ${efficiencyLabels[4]}: ${numbers.format(parsed.failedRequests)} · ${efficiencyLabels[3]}: ${numbers.format(parsed.statusCoveredRequests)} / ${numbers.format(parsed.observedRequests)} · ${efficiencyLabels[0]}: ${numbers.format(parsed.inboundBytesPerSecond)} · ${efficiencyLabels[1]}: ${numbers.format(parsed.outboundBytesPerSecond)} · ${efficiencyLabels[2]}: ${numbers.format(parsed.successfulRequestsPerSecond)}`;
    const note=locale==='fr'?'Estimations pondérées par échantillonnage; trafic global de la passerelle.':locale==='es'?'Estimaciones ponderadas por muestreo; tráfico global de la puerta de enlace.':'Sample-weighted estimates; platform-wide gateway traffic.';
    if(parsed.measurementKind==='sample_weighted_estimate')trafficStatus.textContent=note+' '+trafficStatus.textContent;
  }
  showCapacity();
  trafficFile.onchange=async()=>{
    if(!current())return;
    const version=++importVersion,file=trafficFile.files?.[0];
    localTraffic=Boolean(file);
    if(!file){traffic=undefined;void loadSummary();return;}
    const active=()=>version===importVersion&&current();
    traffic=undefined;
    try {
      if(!file||file.size>2_000_000)throw Error();
      const parsed=readTrafficReport(JSON.parse(await file.text()));
      if(!active())return;
      traffic=parsed;
      showTraffic();
    }catch{if(active())trafficStatus.textContent=invalidTraffic;}
    if(active()){showCapacity();void load();}
  };
  panel.querySelector('.table-scroll')!.setAttribute('aria-label',title);
  const metricLabels={en:['Requests/s','HTTP 2xx','HTTP 5xx / no response','Error rate'],fr:['Requêtes/s','HTTP 2xx','HTTP 5xx / sans réponse','Taux d’erreur'],es:['Solicitudes/s','HTTP 2xx','HTTP 5xx / sin respuesta','Tasa de error']}[locale];
  for(const column of [...columns,requests,inbound,outbound,latency,...metricLabels]){
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
      const response=await fetch(gateway+(paths?.inventory??'/v1/governance/api-execution-status')+'?'+params,{headers:{authorization:'Bearer '+token},cache:'no-store',signal:pending.signal});
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
        const metrics=observed&&traffic?endpointTrafficMetrics(observed,(traffic.end-traffic.start)/1000):undefined;
        cells.push(...(metrics?[numbers.format(metrics.requestsPerSecond),metrics.successful===null?'—':numbers.format(metrics.successful),metrics.failed===null?'—':numbers.format(metrics.failed),metrics.errorRate===null?'—':numbers.format(metrics.errorRate*100)+'%']:Array(4).fill('—')));
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
  void loadSummary();
  const summaryTimer=setInterval(()=>{if(current()&&!document.hidden)void loadSummary();},60000);
  return ()=>{clearInterval(summaryTimer);summaryRequest.abort();request?.abort();request=undefined;healthRequest?.abort();healthRequest=undefined;};
}
