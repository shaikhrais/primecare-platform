import {focusInWorkspace} from '../focus';
import {BundleHistoryController} from './history-controller';
import {attentionPanel} from './attention-panel';
import {registry,type BundleData,type BundleLocale,type AttentionData,type AttentionItem} from '../../../../packages/shared/src/platform-bundle/contract';
import {BundleClient,fileContent} from './client';
import {bundlePanel} from './panel';
import {FormDraft} from '../form-draft';
export class BundleController{
 private client:BundleClient;private history:BundleHistoryController;private data:BundleData|null=null;private root:HTMLElement|null=null;private locale:BundleLocale='en';private tenant='';private tab='launch';private list='tickets';private offset=0;private search='';private notice='';private busy=false;
 private loadRevision=0;private attention:AttentionData|null=null;private attentionQuery={offset:0,search:'',kind:'all'};
 private drafts=new Map<string,{baseline:string;draft:FormDraft}>();
 constructor(gateway:string,token:string,private openAttention?:(item:AttentionItem)=>void){this.client=new BundleClient(gateway,token);this.history=new BundleHistoryController(this.client);}
 async load(tenant=this.tenant){const revision=++this.loadRevision;this.history.reset();if(tenant!==this.tenant){this.capture();this.drafts.clear();this.data=null;this.tenant=tenant;this.offset=0;this.root=null;}try{const attention=this.tab==='attention';const data=attention?await this.client.attention(this.attentionQuery.offset,this.attentionQuery.search,this.attentionQuery.kind):await this.client.read(this.tenant,this.list,this.offset,this.search);if(revision!==this.loadRevision)return;if(attention)this.attention=data as AttentionData;else this.data=data as BundleData;this.notice='';}catch(error){if(revision!==this.loadRevision)return;this.data=null;this.attention=null;this.notice=this.error(error);throw error;}}
 openTab(tab:string){if(!['launch','documents','support'].includes(tab)||tab===this.tab)return;this.capture();this.tab=tab;this.list='tickets';this.offset=0;this.search='';this.data=null;}
 mount(root:HTMLElement,locale:BundleLocale){this.capture();this.root=root;this.locale=locale;this.draw();}
 openWorkflow(item:AttentionItem){this.capture();this.tab=item.destination;this.list=item.destination==='routing'?'routes':'tickets';this.search=['support','routing'].includes(item.destination)?item.id:'';this.offset=0;}
 private capture(){if(!this.root)return;for(const form of this.root.querySelectorAll<HTMLFormElement>('form[data-cy]')){const draft=new FormDraft();draft.capture(form);this.drafts.set(form.dataset.cy!,{baseline:form.dataset.baseline??'',draft});}}
 private draw(){if(!this.root)return;this.capture();const root=this.root;root.innerHTML=bundlePanel(this.tab==='attention'?null:this.data,this.locale,this.notice,{list:this.list,search:this.search},this.tab,attentionPanel(this.attention,this.locale,this.attentionQuery),this.history.markup(this.locale));
  for(const form of root.querySelectorAll<HTMLFormElement>('form[data-cy]')){const saved=this.drafts.get(form.dataset.cy!);if(saved?.baseline===(form.dataset.baseline??''))saved.draft.restore(form);else this.drafts.delete(form.dataset.cy!);}
  const bind=(key:string,work:(values:Record<string,string>,submitter:HTMLElement|null)=>Promise<void>)=>{const form=root.querySelector<HTMLFormElement>('[data-cy="'+key+'"]');if(form)form.onsubmit=e=>{e.preventDefault();const values=Object.fromEntries(new FormData(form)) as Record<string,string>;void this.run(async()=>{await work(values,(e as SubmitEvent).submitter);this.drafts.delete(key);root.querySelector<HTMLFormElement>('[data-cy="'+key+'"]')?.reset();await this.load();this.notice='saved';});};};
  root.querySelectorAll<HTMLButtonElement>('[data-tab]').forEach(button=>button.onclick=()=>{if(this.busy)return;this.capture();this.tab=button.dataset.tab!;if(['support','routing'].includes(this.tab)){this.list=this.tab==='support'?'tickets':'routes';this.offset=0;this.data=null;}void this.run(()=>this.load());});
  const queueForm=root.querySelector<HTMLFormElement>('[data-cy=bundle-attention-form]');
  const captureQueue=()=>{if(queueForm){const values=new FormData(queueForm);this.attentionQuery={offset:0,search:String(values.get('search')??''),kind:String(values.get('kind')??'all')};}};
  if(queueForm)queueForm.onsubmit=e=>{e.preventDefault();captureQueue();void this.run(()=>this.load());};
  for(const [key,step] of [['previous',-1],['next',1]] as const){const button=root.querySelector<HTMLButtonElement>('[data-cy=bundle-attention-'+key+']');if(button)button.onclick=()=>{this.attentionQuery.offset=Math.max(0,this.attentionQuery.offset+step*this.attention!.pagination.limit);void this.run(()=>this.load());};}
  root.querySelectorAll<HTMLButtonElement>('[data-attention-open]').forEach(button=>button.onclick=()=>{if(this.busy)return;const item=this.attention?.items.find(i=>i.key===button.dataset.attentionOpen);if(item)this.openAttention?.(item);});
  const tenantPath='/tenants/'+encodeURIComponent(this.tenant||this.data?.tenantId||'');
  bind('bundle-training-form',async v=>{await this.client.send(tenantPath+'/launch',{version:this.data!.launch!.version,action:'training',evidence:v.evidence,confirmed:false});});
  bind('bundle-launch-form',async(v,button)=>{await this.client.send(tenantPath+'/launch',{version:this.data!.launch!.version,action:button?.dataset.action,evidence:v.evidence,confirmed:v.confirmed==='on'});});
  bind('bundle-upload-form',async v=>{const form=root.querySelector<HTMLFormElement>('[data-cy=bundle-upload-form]')!,file=(form.elements.namedItem('file') as HTMLInputElement).files?.[0];if(!file)throw Error('cannot_upload');const contentBase64=await fileContent(file);await this.client.send(tenantPath+'/documents',{kind:v.kind,expiresOn:v.expiresOn,filename:file.name,mediaType:file.type,contentBase64});});
  bind('bundle-ticket-form',async v=>{await this.client.send(tenantPath+'/tickets',v);});
  bind('bundle-enquiry-form',async v=>{await this.client.send('/enquiries',{...v,confirmed:v.confirmed==='on'});});
  for(const doc of this.data?.documents??[]){bind('bundle-review-form-'+doc.id,async(v,button)=>{await this.client.send(tenantPath+'/documents/'+doc.id+'/review',{version:doc.version,decision:button?.dataset.decision,evidence:v.evidence});});const download=root.querySelector<HTMLButtonElement>('[data-cy="bundle-download-'+doc.id+'"]');if(download)download.onclick=()=>void this.run(()=>this.client.download(this.data!.tenantId!,doc.id,doc.filename));}
  for(const ticket of this.data?.tickets??[]){const path='/tenants/'+encodeURIComponent(ticket.tenant_id)+'/tickets/'+ticket.id;
   bind('bundle-reply-form-'+ticket.id,async v=>{await this.client.send(path,{version:ticket.version,action:ticket.canReopen?'reopen':'reply',message:v.message});});
   bind('bundle-triage-form-'+ticket.id,async v=>{await this.client.send(path,{...v,version:ticket.version,action:'triage',ownerId:v.ownerId||null});});
  }
  for(const route of this.data?.routes??[])bind('bundle-route-form-'+route.id,async(v,button)=>{await this.client.send('/enquiries/'+route.id,{version:route.version,action:button?.dataset.action,evidence:v.evidence});});
  const refresh=root.querySelector<HTMLButtonElement>('[data-cy=bundle-refresh]');if(refresh)refresh.onclick=()=>{if(this.tab==='attention')captureQueue();void this.run(()=>this.load());};
  const filter=root.querySelector<HTMLFormElement>('[data-cy=bundle-filter-form]');if(filter)filter.onsubmit=e=>{e.preventDefault();const values=new FormData(filter);this.list=String(values.get('list'));this.tab=registry.listNavigation.workflowByList[this.list as keyof typeof registry.listNavigation.workflowByList];this.search=String(values.get('search'));this.offset=0;this.data=null;void this.run(()=>this.load());};
  for(const [key,step] of [['previous',-1],['next',1]] as const){const b=root.querySelector<HTMLButtonElement>('[data-cy=bundle-'+key+']');if(b)b.onclick=()=>{this.offset=Math.max(0,this.offset+step*this.data!.pagination.limit);void this.run(()=>this.load());};}
  this.history.bind(root,work=>this.run(work),()=>this.draw());
  root.querySelectorAll<HTMLInputElement|HTMLTextAreaElement|HTMLSelectElement|HTMLButtonElement>('input,textarea,select,button').forEach(e=>e.disabled=this.busy||e.hasAttribute('data-protected'));
 }
 private error(error:unknown){const message=(error as Error).message;return ['conflict','forbidden','invalid_request','rate_limited','not_found','unavailable','routing_conflict','cannot_upload'].includes(message)?message:'failed';}
 private async run(work:()=>Promise<void>){if(this.busy)return;const focused=this.root?.contains(document.activeElement)?(document.activeElement as HTMLElement).dataset.cy:null;this.capture();this.busy=true;this.notice='working';this.draw();try{await work();if(this.notice==='working')this.notice='';}catch(error){this.notice=this.error(error);}finally{this.busy=false;this.draw();const status=this.root?.querySelector<HTMLElement>('[data-cy=bundle-notice]');if(this.notice&&status){status.tabIndex=-1;focusInWorkspace(this.root!,status);}else if(focused&&this.root)focusInWorkspace(this.root,this.root.querySelector<HTMLElement>('[data-cy="'+focused+'"]'));}}
}
