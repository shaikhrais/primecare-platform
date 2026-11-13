/** Optional B16 renderer; host must verify registration and authorization before mounting. */
export function renderDashboardProjection(root: HTMLElement, projection: {
 family: string; dataset: 'live'|'demo'; synthetic: boolean;
 status: 'ready'|'denied'|'unavailable'; metrics: {key:string;value:number|null;sourceField:string}[];
}, labels: {title:string;demo:string;live:string;denied:string;unavailable:string;missing?:string;metrics:Record<string,string>}) {
 const doc=root.ownerDocument, section=doc.createElement('section'), title=doc.createElement('h2');
 section.dataset.cy='dashboard-pages-'+projection.family;
 title.textContent=labels.title;section.append(title);
 const note=doc.createElement('p');note.setAttribute('role','status');
 note.textContent=projection.status==='ready'?(projection.synthetic?labels.demo:labels.live):labels[projection.status];section.append(note);
 if(projection.status==='ready') {
  const list=doc.createElement('dl');
  for(const metric of projection.metrics){
   if((metric.value===null?!labels.missing?.trim():!Number.isSafeInteger(metric.value)||metric.value<0)||!labels.metrics[metric.key])throw Error('invalid_metric');
   const name=doc.createElement('dt'),value=doc.createElement('dd');name.textContent=labels.metrics[metric.key];value.textContent=metric.value===null?labels.missing!:String(metric.value);list.append(name,value);
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
type ReadPageOwner={active:boolean;dirty:boolean;refresh:()=>void};
const readPageOwners=new WeakMap<HTMLElement,ReadPageOwner>();
/** Shared lifecycle binding for optional registered read-only host slots. */
export function bindReadPage<P>(root:HTMLElement,session:ReadPageSession<P>,render:(projection:P)=>void,labels:Record<string,unknown>){
 const previousOwner=readPageOwners.get(root),previousChildren=Array.from(root.childNodes),owner:ReadPageOwner={active:true,dirty:false,refresh:()=>{}};
 let unsubscribe=()=>{},revision=0;
 readPageOwners.set(root,owner);
 const current=()=>owner.active&&readPageOwners.get(root)===owner;
 const statusNote=(status:string)=>{
  const note=root.ownerDocument.createElement('p');
  note.dataset.cy='dashboard-pages-status';note.setAttribute('role',status==='error'||status==='denied'?'alert':'status');
  note.textContent=Object.hasOwn(labels,status)?String(labels[status]):String(labels.unavailable);
  root.replaceChildren(note);
 };
 const draw=()=>{
  if(!current()){if(owner.active)owner.dirty=true;return;}
  owner.dirty=false;revision++;
  const state=session.state;
  if(!current())return;
  if(state.projection){
   try{render(state.projection);}catch(error){if(current())statusNote('error');throw error;}
   return;
  }
  statusNote(state.status);
 };
 owner.refresh=draw;
 try{draw();if(current()){unsubscribe=session.subscribe(draw);if(current()){
  const pending=session.load(),loadedRevision=revision;
  void pending.catch(()=>{if(current()&&revision===loadedRevision){revision++;statusNote('error');}});
 }}}
 catch(error){
  owner.active=false;try{unsubscribe();}catch{}
  if(readPageOwners.get(root)===owner){
   if(previousOwner?.active)readPageOwners.set(root,previousOwner);else readPageOwners.delete(root);
   // A suspended owner may have been denied while replacement construction failed.
   // Restore retained nodes only when no session notification invalidated them.
   if(previousOwner?.active&&previousOwner.dirty){
    root.replaceChildren();
    try{previousOwner.refresh();}catch{if(readPageOwners.get(root)===previousOwner)root.replaceChildren();}
   }else root.replaceChildren(...(previousOwner&&!previousOwner.active?[]:previousChildren));
  }
  throw error;
 }
 return ()=>{if(!owner.active)return;owner.active=false;try{unsubscribe();}finally{try{session.dispose();}finally{if(readPageOwners.get(root)===owner){readPageOwners.delete(root);root.replaceChildren();}}}};
}
export function bindDashboardPage(root:HTMLElement,session:ReadPageSession<Parameters<typeof renderDashboardProjection>[1]>,labels:Parameters<typeof renderDashboardProjection>[2]&{loading:string;error:string;idle:string;disposed:string}){
 return bindReadPage(root,session,projection=>{renderDashboardProjection(root,projection,labels);},labels);
}
