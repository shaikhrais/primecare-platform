import {observeTerritoryLabels} from './labels';
import {TerritoryClient,type Board} from './client';
import {territoryPanel,type PanelState,type TerritoryLocale} from './panel';
const owners=new WeakMap<HTMLElement,TerritoryController>();
export class TerritoryController{
 get navigationPending(){return this.state.busy;}
 private stopLabels:(()=>void)|null=null;
 private lifecycle=0;private renderRevision=0;private loadRevision=0;
 // Reusable unmount, not terminal teardown: parent redraws and later remounts us.
 dispose(){this.stopLabels?.();this.stopLabels=null;this.lifecycle++;this.loadRevision++;this.renderRevision++;this.state.busy=false;if(this.root&&owners.get(this.root)===this)owners.delete(this.root);this.root=null;}
 private client:TerritoryClient;private board:Board|null=null;private root:HTMLElement|null=null;private locale:TerritoryLocale='en';private state:PanelState={selected:'',zoom:false,notice:'',busy:false,draft:this.emptyDraft()};
 constructor(gateway:string,token:string,actor:string){this.client=new TerritoryClient(gateway,token,actor);}
 private emptyDraft(){return {tenantId:'',reference:'',psw:false,home_care:false,confirmed:false};}
 private retainSession(){try{this.client.assertSession();return true;}catch{}if(this.root&&owners.get(this.root)===this)this.root.replaceChildren();this.board=null;this.dispose();return false;}
 private requireCurrent(lifecycle:number){if(lifecycle!==this.lifecycle)throw Error('view_changed');if(this.root&&(!this.root.isConnected||owners.get(this.root)!==this)){this.dispose();throw Error('view_changed');}if(!this.retainSession())throw Error('account_changed');}
 async load(){
  // A new explicit load may precede remounting a reused, detached panel.
  if(this.root&&!this.root.isConnected)this.dispose();
  const lifecycle=this.lifecycle,revision=++this.loadRevision;this.requireCurrent(lifecycle);
  let receipt;try{receipt=await this.client.request(undefined,undefined,true,()=>this.requireCurrent(lifecycle));}finally{this.requireCurrent(lifecycle);}
  if(revision!==this.loadRevision)throw Error('view_changed');this.board=receipt.consume();
 }
 mount(root:HTMLElement,locale:TerritoryLocale){const previous=owners.get(root);if(previous&&previous!==this)previous.dispose();this.dispose();this.root=root;owners.set(root,this);this.locale=locale;this.draw();}
 private draw(){
  if(!this.root||!this.retainSession()||!this.board)return;this.stopLabels?.();this.stopLabels=null;
  const root=this.root,render=++this.renderRevision;
  const active=()=>this.root===root&&owners.get(root)===this&&render===this.renderRevision&&root.isConnected&&this.retainSession();
  root.innerHTML=territoryPanel(this.board,this.state,this.locale);this.stopLabels=observeTerritoryLabels(root.querySelector<SVGSVGElement>('[data-cy=territory-map]')!);
  const select=(id:string)=>{if(!active()||this.state.busy)return;if(id!==this.state.selected)this.state.draft=this.emptyDraft();this.state.selected=id;this.state.notice='';this.draw();root.querySelector<HTMLElement>('[data-cy=territory-details] h3')?.setAttribute('tabindex','-1');root.querySelector<HTMLElement>('[data-cy=territory-details] h3')?.focus({preventScroll:true});};
  root.querySelector<HTMLSelectElement>('[data-cy=territory-picker]')!.onchange=e=>select((e.currentTarget as HTMLSelectElement).value);
  for(const a of this.board.territories){if(a.canSell){const piece=root.querySelector<SVGElement>(`[data-cy=territory-piece-${a.id}]`)!;piece.onclick=()=>select(a.id);piece.onkeydown=e=>{if(e.key==='Enter'||e.key===' '){e.preventDefault();select(a.id);}};}root.querySelector<HTMLButtonElement>(`[data-cy=territory-detail-${a.id}]`)!.onclick=()=>select(a.id);}
  root.querySelector<HTMLButtonElement>('[data-cy=territory-overview]')!.onclick=()=>{if(!active()||this.state.busy)return;this.state.zoom=false;this.draw();};root.querySelector<HTMLButtonElement>('[data-cy=territory-zoom]')!.onclick=()=>{if(!active()||this.state.busy)return;this.state.zoom=true;this.draw();};
  root.querySelector<HTMLButtonElement>('[data-cy=territory-refresh]')!.onclick=()=>{if(!active()||this.state.busy)return;void this.run(async current=>{await this.load();current();this.state.draft=this.emptyDraft();});};
  const form=root.querySelector<HTMLFormElement>('[data-cy=territory-form]');if(form){
   const capture=()=>{if(!active()||this.state.busy)return;const v=new FormData(form);this.state.draft={tenantId:String(v.get('tenantId')??''),reference:String(v.get('reference')??''),psw:v.has('psw'),home_care:v.has('home_care'),confirmed:v.has('confirmed')};};form.oninput=capture;form.onchange=capture;
   form.onsubmit=e=>{e.preventDefault();if(!active()||this.state.busy)return;capture();const area=this.board!.territories.find(a=>a.id===this.state.selected)!;const d=this.state.draft;void this.run(async current=>{
    const receipt=await this.client.request(area.id,{version:area.version,tenantId:d.tenantId,services:Object.entries({psw:d.psw,home_care:d.home_care}).filter(([,v])=>v).map(([k])=>k),reference:d.reference,confirmed:d.confirmed},true,current);
    current();receipt.consume();this.state.draft=this.emptyDraft();this.state.notice='saved';await this.load();current();
   });};
  }
  root.querySelectorAll<HTMLInputElement|HTMLSelectElement|HTMLButtonElement>('input,select,button').forEach(e=>e.disabled=this.state.busy||e.hasAttribute('data-protected'));
 }
 private async run(work:(current:()=>void)=>Promise<void>){
  if(this.state.busy||!this.retainSession())return;const lifecycle=this.lifecycle,current=()=>this.requireCurrent(lifecycle);this.state.busy=true;this.state.notice='working';this.draw();
  try{await work(current);current();if(this.state.notice==='working')this.state.notice='';}
  catch(error){
   if(lifecycle!==this.lifecycle||!this.retainSession())return;
   const conflict=(error as Error).message==='conflict';this.state.notice=conflict?'conflict':'failed';
   if(conflict){
    try{await this.load();current();const area=this.board?.territories.find(a=>a.id===this.state.selected);if(!area?.canSell)this.state.draft=this.emptyDraft();this.state.notice='conflict_refreshed';}
    catch{if(lifecycle===this.lifecycle&&this.retainSession())this.state.notice='failed';}
   }
  }finally{if(lifecycle===this.lifecycle){this.state.busy=false;this.draw();}}
 }
}
