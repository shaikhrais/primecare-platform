/** Optional B16 renderer; host must verify registration and authorization before mounting. */
export function renderDashboardProjection(root: HTMLElement, projection: {
 family: string; dataset: 'live'|'demo'; synthetic: boolean;
 status: 'ready'|'denied'|'unavailable'; metrics: {key:string;value:number;sourceField:string}[];
}, labels: {title:string;demo:string;live:string;denied:string;unavailable:string;metrics:Record<string,string>}) {
 const doc=root.ownerDocument, section=doc.createElement('section'), title=doc.createElement('h2');
 section.dataset.cy='dashboard-pages-'+projection.family;
 title.textContent=labels.title;section.append(title);
 const note=doc.createElement('p');note.setAttribute('role','status');
 note.textContent=projection.status==='ready'?(projection.synthetic?labels.demo:labels.live):labels[projection.status];section.append(note);
 if(projection.status==='ready') {
  const list=doc.createElement('dl');
  for(const metric of projection.metrics){
   if(!Number.isSafeInteger(metric.value)||metric.value<0||!labels.metrics[metric.key])throw Error('invalid_metric');
   const name=doc.createElement('dt'),value=doc.createElement('dd');name.textContent=labels.metrics[metric.key];value.textContent=String(metric.value);list.append(name,value);
  }
  section.append(list);
 }
 root.replaceChildren(section);
 return ()=>{if(section.parentNode===root)section.remove();};
}

export type ReadPageSession<P>={
 state:{status:string;projection:P|null};
 subscribe:(listener:()=>void)=>()=>void;load:()=>Promise<void>;dispose:()=>void;
};
/** Shared lifecycle binding for optional registered read-only host slots. */
export function bindReadPage<P>(root:HTMLElement,session:ReadPageSession<P>,render:(projection:P)=>void,labels:Record<string,unknown>){
 const draw=()=>{
  const state=session.state;
  if(state.projection){render(state.projection);return;}
  const note=root.ownerDocument.createElement('p');
  note.dataset.cy='dashboard-pages-status';note.setAttribute('role',state.status==='error'||state.status==='denied'?'alert':'status');
  note.textContent=Object.hasOwn(labels,state.status)?String(labels[state.status]):String(labels.unavailable);
  root.replaceChildren(note);
 };
 const unsubscribe=session.subscribe(draw);draw();void session.load();
 return ()=>{unsubscribe();session.dispose();root.replaceChildren();};
}
export function bindDashboardPage(root:HTMLElement,session:ReadPageSession<Parameters<typeof renderDashboardProjection>[1]>,labels:Parameters<typeof renderDashboardProjection>[2]&{loading:string;error:string;idle:string;disposed:string}){
 return bindReadPage(root,session,projection=>{renderDashboardProjection(root,projection,labels);},labels);
}
