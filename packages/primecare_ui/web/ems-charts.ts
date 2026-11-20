import {shellIcon} from './icons';
import {ThemeControlBase} from './theme-control-base';
import {installEmsDashboardStyles} from './ems-dashboard-styles';
import {readTrafficReport} from '../../domain/src/endpoint_traffic';
type Traffic=ReturnType<typeof readTrafficReport>;
type Locale='en'|'fr'|'es';
const words={en:['Endpoint observatory','Readiness distribution','Request trend','Busiest operations','Response status mix','Waiting for live observations.','Requests/s · completed windows observed in this session only','No requests in this window.','Sampled gateway observations; excludes direct service traffic.','Chart data','Ready','Blocked','Maintenance','Unverified','Requests','Window end','HTTP status','No response','Declared inbound bytes','Measured completed response bytes','Unknown declared response lengths','Clear session history'],fr:['Observatoire des API','Répartition de préparation','Évolution des requêtes','Opérations les plus actives','Répartition des statuts HTTP','En attente des observations.','Requêtes/s · fenêtres complètes observées dans cette session uniquement','Aucune requête dans cette fenêtre.','Observations échantillonnées de la passerelle ; appels directs exclus.','Données du graphique','Prêt','Bloqué','Maintenance','Non vérifié','Requêtes','Fin de fenêtre','Statut HTTP','Sans réponse','Octets entrants déclarés','Octets des réponses terminées mesurés','Tailles de réponse déclarées inconnues','Effacer l’historique de session'],es:['Observatorio de API','Distribución de preparación','Tendencia de solicitudes','Operaciones más activas','Distribución de estados HTTP','Esperando observaciones.','Solicitudes/s · solo ventanas completas observadas en esta sesión','Sin solicitudes en esta ventana.','Observaciones muestreadas de la puerta de enlace; excluye llamadas directas.','Datos del gráfico','Listo','Bloqueado','Mantenimiento','Sin verificar','Solicitudes','Fin de ventana','Estado HTTP','Sin respuesta','Bytes entrantes declarados','Bytes medidos de respuestas completadas','Longitudes declaradas de respuesta desconocidas','Borrar historial de sesión']} as const;
const svgNS='http://www.w3.org/2000/svg';
function svgNode(name:string,attrs:Record<string,string|number>={}){const el=document.createElementNS(svgNS,name);for(const [k,v]of Object.entries(attrs))el.setAttribute(k,String(v));return el;}
function createEmsCharts(host:HTMLElement,locale:Locale){
 installEmsDashboardStyles(host.ownerDocument);
 const w=words[locale],nf=new Intl.NumberFormat(locale,{maximumFractionDigits:3});
 const title=document.createElement('h2');title.textContent=w[0];title.className='pc-visually-hidden';
 const note=document.createElement('p');note.textContent=w[8];
 const clear=document.createElement('button');clear.type='button';clear.textContent=w[21];
 const grid=document.createElement('div');grid.className='ems-chart-grid';
 const toolbar=document.createElement('div');toolbar.className='ems-observatory-toolbar';const intro=document.createElement('div');const notes=document.createElement('details');notes.className='ems-notes';const summary=document.createElement('summary');summary.textContent=({en:'Measurement notes',fr:'Notes de mesure',es:'Notas de medición'}[locale]);notes.append(summary,note);intro.append(title);toolbar.append(intro,notes,clear);
 const widgets=document.createElement('div');widgets.className='ems-widget-grid';
 const widgetCopy={en:['Registered endpoints','Verified ready','Needs attention','Requests in window','Gateway throughput','HTTP 2xx rate','Catalog declarations','Current release evidence','Blocked declarations','Observed gateway arrivals','Requests per second','Transport responses, not business completion'],fr:['API enregistrées','Préparation vérifiée','À examiner','Requêtes par fenêtre','Débit passerelle','Taux HTTP 2xx','Déclarations du catalogue','Preuves de version actuelle','Déclarations bloquées','Arrivées observées','Requêtes par seconde','Réponses HTTP, pas achèvement métier'],es:['API registradas','Preparación verificada','Requiere atención','Solicitudes por ventana','Rendimiento de puerta','Tasa HTTP 2xx','Declaraciones del catálogo','Evidencia de versión actual','Declaraciones bloqueadas','Llegadas observadas','Solicitudes por segundo','Respuestas HTTP, no finalización de negocio']}[locale];
 const widgetValues:HTMLElement[]=[];
 for(let i=0;i<6;i++){const tile=document.createElement('section');tile.className='ems-widget ems-widget-'+i;const label=document.createElement('h3');label.textContent=widgetCopy[i];const value=document.createElement('strong');value.textContent='—';value.dataset.cy='ems-widget-'+i;const description=document.createElement('p');description.textContent=widgetCopy[i+6];const mark=document.createElement('span');mark.className='ems-widget-mark';mark.setAttribute('aria-hidden','true');mark.innerHTML=shellIcon((['database','shield-check','clipboard-check','refresh','chart-bar','adjustments-horizontal'] as const)[i] as Parameters<typeof shellIcon>[0]);tile.append(mark,label,value,description);widgets.append(tile);widgetValues.push(value);}
 host.className='ems-observatory';host.replaceChildren(toolbar,widgets,grid);
 function card(label:string){const section=document.createElement('section');section.className='ems-chart-card';const h=document.createElement('h3');h.textContent=label;const body=document.createElement('div');section.append(h,body);grid.append(section);return body;}
 const readiness=card(w[1]),trend=card(w[2]),operations=card(w[3]),statuses=card(w[4]);
 readiness.parentElement!.classList.add('ems-readiness-card');trend.parentElement!.classList.add('ems-trend-card');operations.parentElement!.classList.add('ems-operations-card');statuses.parentElement!.classList.add('ems-status-card');
 const serviceText=({en:'Traffic by API namespace',fr:'Trafic par espace API',es:'Tráfico por espacio de API'}[locale]);
 const services=card(serviceText);services.parentElement!.classList.add('ems-services-card');
 const overview=card(({en:'Operational status',fr:'État opérationnel',es:'Estado operativo'}[locale]));overview.parentElement!.classList.add('ems-operational-card');

 const operationDisclosure=document.createElement('details');operationDisclosure.className='ems-chart-card ems-operation-disclosure';const operationSummary=document.createElement('summary');operationSummary.textContent=w[3];operationDisclosure.append(operationSummary,operations);grid.querySelector('.ems-operations-card')?.remove();host.append(operationDisclosure);
 const metrics=document.createElement('dl');metrics.className='ems-metric-grid';host.append(metrics);
 let history:Array<{end:number;rate:number;start:number}>=[],disposed=false;
 function empty(target:HTMLElement,message:string=w[5]){target.replaceChildren();const p=document.createElement('p');p.textContent=message;target.append(p);}
 function chart(target:HTMLElement,label:string){target.replaceChildren();const svg=svgNode('svg',{viewBox:'0 0 420 220',role:'img','aria-label':label});target.append(svg);return svg;}
 function dataTable(target:HTMLElement,head:string[],rows:string[][]){const details=document.createElement('details'),summary=document.createElement('summary');summary.textContent=w[9];const table=document.createElement('table'),tr=table.createTHead().insertRow();for(const label of head){const th=document.createElement('th');th.scope='col';th.textContent=label;tr.append(th);}const body=table.createTBody();for(const row of rows){const tr=body.insertRow();for(const cell of row)tr.insertCell().textContent=cell;}details.append(summary,table);target.append(details);}
 function donut(target:HTMLElement,label:string,values:Array<[string,number]>){
  const total=values.reduce((s,[,v])=>s+v,0);if(!total){empty(target,w[7]);return;}
  const svg=chart(target,label);let offset=0;
  values.forEach(([name,value],i)=>{if(!value)return;const arc=svgNode('circle',{cx:110,cy:108,r:70,fill:'none','stroke-width':30,pathLength:100,'stroke-dasharray':`${value/total*100} ${100-value/total*100}`,'stroke-dashoffset':-offset,transform:'rotate(-90 110 108)',class:`ems-series-${i%5}`});const tooltip=svgNode('title');tooltip.textContent=`${name}: ${nf.format(value)}`;arc.append(tooltip);svg.append(arc);offset+=value/total*100;});
  const center=svgNode('text',{x:110,y:115,'text-anchor':'middle',class:'ems-chart-total'});center.textContent=nf.format(total);svg.append(center);
  values.forEach(([name,value],i)=>{const swatch=svgNode('rect',{x:210,y:35+i*31,width:10,height:10,class:`ems-series-${i%5}`});const label=svgNode('text',{x:228,y:45+i*31});label.textContent=`${name}: ${nf.format(value)}`;svg.append(swatch,label);});
  dataTable(target,[label,w[14]],values.map(([name,v])=>[name,nf.format(v)]));
 }
 function renderTrend(){
  if(!history.length){empty(trend);return;}
  const svg=chart(trend,w[2]),max=Math.max(...history.map(p=>p.rate),0.001),first=history[0].end,last=history.at(-1)!.end;
  const x=(t:number)=>last===first?220:50+(t-first)/(last-first)*345,y=(v:number)=>175-v/max*140;
  for(const ratio of [0,0.5,1]){const yy=y(max*ratio);svg.append(svgNode('line',{x1:50,x2:395,y1:yy,y2:yy,class:'ems-chart-gridline'}));const text=svgNode('text',{x:44,y:yy+4,'text-anchor':'end'});text.textContent=nf.format(max*ratio);svg.append(text);}
  // Missing completed windows break the line; no invented zero traffic or history.
  for(let i=1;i<history.length;i++){const a=history[i-1],b=history[i];if(b.start>a.end)continue;svg.append(svgNode('polygon',{points:x(a.end)+',175 '+x(a.end)+','+y(a.rate)+' '+x(b.end)+','+y(b.rate)+' '+x(b.end)+',175',class:'ems-trend-area'}));svg.append(svgNode('line',{x1:x(a.end),y1:y(a.rate),x2:x(b.end),y2:y(b.rate),class:'ems-trend-line'}));}
  for(const point of history){const dot=svgNode('circle',{cx:x(point.end),cy:y(point.rate),r:4,class:'ems-series-0'});const tip=svgNode('title');tip.textContent=`${new Date(point.end).toLocaleString(locale)}: ${nf.format(point.rate)} requests/s`;dot.append(tip);svg.append(dot);}
  for(const [time,anchor] of [[first,'start'],[last,'end']] as const){const label=svgNode('text',{x:x(time),y:202,'text-anchor':anchor});label.textContent=new Date(time).toLocaleTimeString(locale,{hour:'2-digit',minute:'2-digit'});svg.append(label);}
  const caption=document.createElement('p');caption.textContent=w[6];trend.append(caption);
  dataTable(trend,[w[15],'Requests/s'],history.map(p=>[new Date(p.end).toLocaleString(locale),nf.format(p.rate)]));
 }
 function setSummary(summary:{readiness:Record<string,number>}|undefined){if(disposed)return;if(!summary){empty(readiness);empty(overview);widgetValues.slice(0,3).forEach(v=>v.textContent='—');return;}const r=summary.readiness;
 overview.replaceChildren();const list=document.createElement('dl');list.className='ems-status-list';for(const [label,count] of [[w[10],r.ready??0],[w[11],r.blocked??0],[w[12],(r.maintenance??0)+(r.active_maintenance??0)+(r.recorded_maintenance??0)+(r.scheduled_maintenance??0)],[w[13],r.unverified??0]] as Array<[string,number]>){const pair=document.createElement('div'),dt=document.createElement('dt'),dd=document.createElement('dd');dt.textContent=label;dd.textContent=nf.format(count);pair.append(dt,dd);list.append(pair);}overview.append(list);
 widgetValues[0].textContent=nf.format(Object.values(r).reduce((a,b)=>a+b,0));widgetValues[1].textContent=nf.format(r.ready??0);widgetValues[2].textContent=nf.format(r.blocked??0);donut(readiness,w[1],[[w[10],r.ready??0],[w[11],r.blocked??0],[w[12],(r.maintenance??0)+(r.active_maintenance??0)+(r.recorded_maintenance??0)+(r.scheduled_maintenance??0)],[w[13],r.unverified??0]]);}
 function setTraffic(report:Traffic|undefined){
  if(disposed)return;
  if(!report){widgetValues.slice(3).forEach(v=>v.textContent='—');history=[];for(const target of [trend,operations,statuses,services])empty(target);metrics.replaceChildren();return;}
  widgetValues[3].textContent=nf.format(report.observedRequests);widgetValues[4].textContent=nf.format(report.requestsPerSecond);widgetValues[5].textContent=report.observedRequests&&report.statusCoveredRequests===report.observedRequests?nf.format(report.successfulRequests/report.observedRequests*100)+'%':'—';
  history=history.filter(p=>p.end!==report.end);history.push({end:report.end,start:report.start,rate:report.requestsPerSecond});history.sort((a,b)=>a.end-b.end);history=history.slice(-24);renderTrend();
  const rows=[...report.endpoints.entries()].sort((a,b)=>b[1].observedRequests-a[1].observedRequests).slice(0,6);
  if(!rows.length||!report.observedRequests)empty(operations,w[7]);else{
   const svg=chart(operations,w[3]),max=Math.max(...rows.map(([,r])=>r.observedRequests),1);
   rows.forEach(([name,row],i)=>{const label=svgNode('text',{x:8,y:18+i*33});label.textContent=name.length>45?name.slice(0,42)+'…':name;const title=svgNode('title');title.textContent=name;label.append(title);const bar=svgNode('rect',{x:8,y:23+i*33,width:row.observedRequests/max*340,height:9,rx:4,class:`ems-series-${i%5}`});svg.append(label,bar);});
   dataTable(operations,[w[3],w[14]],rows.map(([name,row])=>[name,nf.format(row.observedRequests)]));
  }
  const namespaces=new Map<string,number>();for(const [operation,row] of report.endpoints){const name=/^[A-Z]+ \/v1\/([a-z0-9-]+)(?:\/|$)/i.exec(operation)?.[1]??'unmatched';namespaces.set(name,(namespaces.get(name)??0)+row.observedRequests);}
  services.replaceChildren();const serviceRows=[...namespaces].sort((a,b)=>b[1]-a[1]);const serviceList=document.createElement('div');serviceList.className='ems-service-bars';for(const [name,count]of serviceRows.slice(0,5)){const row=document.createElement('div'),label=document.createElement('span'),meter=document.createElement('meter'),value=document.createElement('strong');label.textContent=name;meter.min=0;meter.max=Math.max(report.observedRequests,1);meter.value=count;meter.setAttribute('aria-label',name);value.textContent=nf.format(count);row.append(label,meter,value);serviceList.append(row);}services.append(serviceList);dataTable(services,[serviceText,w[14]],serviceRows.map(([name,count])=>[name,nf.format(count)]));
  const groups=new Map<string,number>();for(const row of report.endpoints.values())for(const [status,n]of Object.entries(row.statusCounts??{})){const group=status==='no_response'?w[17]:status[0]+'xx';groups.set(group,(groups.get(group)??0)+n);}
  // Five HTTP families plus no-response: keep all values visible in the table.
  if(report.statusCoveredRequests<report.observedRequests){const p=document.createElement('p');p.textContent=w[13];statuses.replaceChildren(p);dataTable(statuses,[w[16],w[14]],[...groups].map(([k,v])=>[k,nf.format(v)]));}else{
   const values=[...groups].sort(([a],[b])=>a.localeCompare(b));if(!report.observedRequests)empty(statuses,w[7]);else{const svg=chart(statuses,w[4]);let x=10;values.forEach(([name,value],i)=>{const width=value/report.observedRequests*390;const bar=svgNode('rect',{x,y:24,width,height:40,class:'ems-series-'+i%5});const tooltip=svgNode('title');tooltip.textContent=name+': '+nf.format(value);bar.append(tooltip);svg.append(bar);x+=width;const label=svgNode('text',{x:12,y:92+i*22});label.textContent=name+' · '+nf.format(value)+' ('+nf.format(value/report.observedRequests*100)+'%)';svg.append(label);});dataTable(statuses,[w[16],w[14]],values.map(([name,value])=>[name,nf.format(value)]));}
  }
  metrics.replaceChildren();for(const [label,value]of [[w[18],nf.format(report.inboundBytes)],[w[19],report.bodyTotals?nf.format(report.bodyTotals.completedBytes):'—'],[w[20],nf.format(report.unknownOutbound)]]){const item=document.createElement('div'),dt=document.createElement('dt'),dd=document.createElement('dd');dt.textContent=label;dd.textContent=value;item.append(dt,dd);metrics.append(item);}
 }
 clear.onclick=()=>{history=[];renderTrend();};for(const target of [readiness,trend,operations,statuses,services,overview])empty(target);
 return {setSummary,setTraffic,dispose(){disposed=true;history=[];host.replaceChildren();}};
}

/** Central, theme-controlled dashboard group. The host owns API access and authorization. */
export class PrimeEmsDashboardControls extends ThemeControlBase {
 private readonly controller:ReturnType<typeof createEmsCharts>;
 constructor(root:HTMLElement,locale:Locale='en'){super(root);this.controller=createEmsCharts(root,locale);}
 readonly setSummary=(summary:Parameters<ReturnType<typeof createEmsCharts>['setSummary']>[0])=>{if(!this.dead)this.controller.setSummary(summary);};
 readonly setTraffic=(report:Traffic|undefined)=>{if(!this.dead)this.controller.setTraffic(report);};
 dispose(){this.disposeControlScope([()=>this.controller.dispose()]);}
}
export function mountEmsCharts(root:HTMLElement,locale:Locale){return new PrimeEmsDashboardControls(root,locale);}
