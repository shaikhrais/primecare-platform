import {OperationsClient,type Overview,type Filters,type OperationsLocale,type TenantRow,type Destination} from './client';
import {operationsPanel} from './panel';
export class OperationsController{
 private client:OperationsClient;private root:HTMLElement|null=null;private data:Overview|null=null;private locale:OperationsLocale='en';private filters:Filters={search:'',filter:'all',offset:0};private draft={search:'',filter:'all'};private busy=false;private notice='';
 constructor(gateway:string,token:string,private open:(tenant:TenantRow,view:Destination)=>void){this.client=new OperationsClient(gateway,token);}
 async load(){try{this.data=await this.client.read(this.filters);}catch(error){this.data=null;this.notice=(error as Error).message==='forbidden'?'forbidden':'failed';throw error;}}
 mount(root:HTMLElement,locale:OperationsLocale){this.root=root;this.locale=locale;this.draw();}
 private draw(){
  if(!this.root)return;const root=this.root;root.innerHTML=operationsPanel(this.data,{...this.filters,...this.draft},this.locale,this.notice,this.busy);
  const form=root.querySelector<HTMLFormElement>('[data-cy=operations-form]')!;
  const capture=()=>{const values=new FormData(form);this.draft={search:String(values.get('search')??''),filter:String(values.get('filter')??'all')};};form.oninput=capture;form.onchange=capture;
  form.onsubmit=e=>{e.preventDefault();capture();void this.run(async()=>{this.filters={...this.draft,offset:0};await this.load();});};
  root.querySelector<HTMLButtonElement>('[data-cy=operations-refresh]')!.onclick=()=>void this.run(async()=>{capture();if(this.draft.search!==this.filters.search||this.draft.filter!==this.filters.filter)this.filters={...this.draft,offset:0};await this.load();});
  for(const [key,direction] of [['previous',-1],['next',1]] as const){const button=root.querySelector<HTMLButtonElement>('[data-cy=operations-'+key+']');if(button)button.onclick=()=>void this.run(async()=>{this.filters.offset=Math.max(0,this.filters.offset+direction*this.data!.pagination.limit);await this.load();});}
  root.querySelectorAll<HTMLButtonElement>('[data-operations-tenant]').forEach(button=>button.onclick=()=>{if(this.busy)return;const tenant=this.data?.tenants.find(t=>t.id===button.dataset.operationsTenant);if(tenant&&tenant.actions.includes(button.dataset.operationsView as Destination))this.open(tenant,button.dataset.operationsView as Destination);});
  root.querySelectorAll<HTMLInputElement|HTMLButtonElement|HTMLSelectElement>('input,button,select').forEach(e=>e.disabled=this.busy||e.hasAttribute('data-protected'));
 }
 private async run(work:()=>Promise<void>){if(this.busy)return;this.busy=true;this.notice='working';this.draw();try{await work();this.notice='';}catch(error){this.data=null;this.notice=(error as Error).message==='forbidden'?'forbidden':'failed';}finally{this.busy=false;this.draw();}}
}
