import {OperationsClient,type Overview,type Filters,type OperationsLocale,type TenantRow,type Destination} from './client';
import {operationsPanel} from './panel';
const owners=new WeakMap<HTMLElement,OperationsController>();
export class OperationsController{
 get navigationPending(){return this.busy;}
 private client:OperationsClient;private root:HTMLElement|null=null;private data:Overview|null=null;private locale:OperationsLocale='en';private filters:Filters={search:'',filter:'all',offset:0};private draft={search:'',filter:'all'};private busy=false;private notice='';
 private lifecycle=0;private renderRevision=0;private loadRevision=0;
 constructor(gateway:string,token:string,private open:(tenant:TenantRow,view:Destination)=>void){this.client=new OperationsClient(gateway,token);}
 // Unmount only: the parent reuses this controller when returning to the tab.
 dispose(){this.lifecycle++;this.loadRevision++;this.renderRevision++;this.busy=false;if(this.root&&owners.get(this.root)===this)owners.delete(this.root);this.root=null;}
 private retainSession(){try{this.client.assertSession();return true;}catch{}if(this.root&&owners.get(this.root)===this)this.root.replaceChildren();this.data=null;this.dispose();return false;}
 private requireCurrent(lifecycle:number){if(lifecycle!==this.lifecycle)throw Error('view_changed');if(this.root&&(!this.root.isConnected||owners.get(this.root)!==this)){this.dispose();throw Error('view_changed');}if(!this.retainSession())throw Error('account_changed');}
 async load(){
  // A new explicit load may precede remounting a reused, detached panel.
  if(this.root&&!this.root.isConnected)this.dispose();
  const lifecycle=this.lifecycle,revision=++this.loadRevision;this.requireCurrent(lifecycle);
  try{const data=await this.client.read(this.filters,()=>this.requireCurrent(lifecycle));this.requireCurrent(lifecycle);if(revision!==this.loadRevision)throw Error('view_changed');this.data=data;}
  catch(error){this.requireCurrent(lifecycle);if(revision!==this.loadRevision)throw error;this.data=null;this.notice=(error as Error).message==='forbidden'?'forbidden':'failed';throw error;}
 }
 mount(root:HTMLElement,locale:OperationsLocale){const previous=owners.get(root);if(previous&&previous!==this)previous.dispose();this.dispose();this.root=root;owners.set(root,this);this.locale=locale;this.draw();}
 private draw(){
  if(!this.root||!this.retainSession())return;const root=this.root,render=++this.renderRevision;
  const active=()=>this.root===root&&owners.get(root)===this&&render===this.renderRevision&&root.isConnected&&this.retainSession();
  root.innerHTML=operationsPanel(this.data,{...this.filters,...this.draft},this.locale,this.notice,this.busy);
  const form=root.querySelector<HTMLFormElement>('[data-cy=operations-form]')!;
  const capture=()=>{if(!active()||this.busy)return;const values=new FormData(form);this.draft={search:String(values.get('search')??''),filter:String(values.get('filter')??'all')};};form.oninput=capture;form.onchange=capture;
  form.onsubmit=e=>{e.preventDefault();if(!active()||this.busy)return;capture();void this.run(async()=>{this.filters={...this.draft,offset:0};await this.load();});};
  root.querySelector<HTMLButtonElement>('[data-cy=operations-refresh]')!.onclick=()=>{if(!active()||this.busy)return;capture();void this.run(async()=>{if(this.draft.search!==this.filters.search||this.draft.filter!==this.filters.filter)this.filters={...this.draft,offset:0};await this.load();});};
  for(const [key,direction] of [['previous',-1],['next',1]] as const){const button=root.querySelector<HTMLButtonElement>('[data-cy=operations-'+key+']');if(button)button.onclick=()=>{if(!active()||this.busy)return;void this.run(async()=>{this.filters.offset=Math.max(0,this.filters.offset+direction*this.data!.pagination.limit);await this.load();});};}
  root.querySelectorAll<HTMLButtonElement>('[data-operations-tenant]').forEach(button=>button.onclick=()=>{if(!active()||this.busy)return;const tenant=this.data?.tenants.find(t=>t.id===button.dataset.operationsTenant);if(tenant&&tenant.actions.includes(button.dataset.operationsView as Destination))this.open(tenant,button.dataset.operationsView as Destination);});
  root.querySelectorAll<HTMLInputElement|HTMLButtonElement|HTMLSelectElement>('input,button,select').forEach(e=>e.disabled=this.busy||e.hasAttribute('data-protected'));
 }
 private async run(work:()=>Promise<void>){
  if(this.busy||!this.retainSession())return;const lifecycle=this.lifecycle;this.busy=true;this.notice='working';this.draw();
  try{await work();this.requireCurrent(lifecycle);this.notice='';}
  catch(error){if(lifecycle!==this.lifecycle||!this.retainSession())return;this.data=null;this.notice=(error as Error).message==='forbidden'?'forbidden':'failed';}
  finally{if(lifecycle===this.lifecycle){this.busy=false;this.draw();}}
 }
}
