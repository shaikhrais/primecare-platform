import {observeTerritoryLabels} from './labels';
import {TerritoryClient,type Board} from './client';
import {territoryPanel,type PanelState,type TerritoryLocale} from './panel';
export class TerritoryController{
 private stopLabels:(()=>void)|null=null;
 dispose(){this.stopLabels?.();this.stopLabels=null;}
 private client:TerritoryClient;private board:Board|null=null;private root:HTMLElement|null=null;private locale:TerritoryLocale='en';private state:PanelState={selected:'',zoom:false,notice:'',busy:false,draft:this.emptyDraft()};
 constructor(gateway:string,token:string,actor:string){this.client=new TerritoryClient(gateway,token,actor);}
 private emptyDraft(){return {tenantId:'',reference:'',psw:false,home_care:false,confirmed:false};}
 async load(){this.board=await this.client.request();}
 mount(root:HTMLElement,locale:TerritoryLocale){this.root=root;this.locale=locale;this.draw();}
 private draw(){if(!this.root||!this.board)return;this.dispose();this.root.innerHTML=territoryPanel(this.board,this.state,this.locale);const root=this.root;this.stopLabels=observeTerritoryLabels(root.querySelector<SVGSVGElement>('[data-cy=territory-map]')!);
  const select=(id:string)=>{if(this.state.busy)return;if(id!==this.state.selected)this.state.draft=this.emptyDraft();this.state.selected=id;this.state.notice='';this.draw();root.querySelector<HTMLElement>('[data-cy=territory-details] h3')?.setAttribute('tabindex','-1');root.querySelector<HTMLElement>('[data-cy=territory-details] h3')?.focus({preventScroll:true});};
  root.querySelector<HTMLSelectElement>('[data-cy=territory-picker]')!.onchange=e=>select((e.currentTarget as HTMLSelectElement).value);
  for(const a of this.board.territories){if(a.canSell){const piece=root.querySelector<SVGElement>(`[data-cy=territory-piece-${a.id}]`)!;piece.onclick=()=>select(a.id);piece.onkeydown=e=>{if(e.key==='Enter'||e.key===' '){e.preventDefault();select(a.id);}};}root.querySelector<HTMLButtonElement>(`[data-cy=territory-detail-${a.id}]`)!.onclick=()=>select(a.id);}
  root.querySelector<HTMLButtonElement>('[data-cy=territory-overview]')!.onclick=()=>{this.state.zoom=false;this.draw();};root.querySelector<HTMLButtonElement>('[data-cy=territory-zoom]')!.onclick=()=>{this.state.zoom=true;this.draw();};
  root.querySelector<HTMLButtonElement>('[data-cy=territory-refresh]')!.onclick=()=>void this.run(async()=>{await this.load();this.state.draft=this.emptyDraft();});
  const form=root.querySelector<HTMLFormElement>('[data-cy=territory-form]');if(form){const capture=()=>{const v=new FormData(form);this.state.draft={tenantId:String(v.get('tenantId')??''),reference:String(v.get('reference')??''),psw:v.has('psw'),home_care:v.has('home_care'),confirmed:v.has('confirmed')};};form.oninput=capture;form.onchange=capture;form.onsubmit=e=>{e.preventDefault();capture();const area=this.board!.territories.find(a=>a.id===this.state.selected)!;const d=this.state.draft;void this.run(async()=>{await this.client.request(area.id,{version:area.version,tenantId:d.tenantId,services:Object.entries({psw:d.psw,home_care:d.home_care}).filter(([,v])=>v).map(([k])=>k),reference:d.reference,confirmed:d.confirmed});this.state.draft=this.emptyDraft();this.state.notice='saved';await this.load();});};}
  root.querySelectorAll<HTMLInputElement|HTMLSelectElement|HTMLButtonElement>('input,select,button').forEach(e=>e.disabled=this.state.busy||e.hasAttribute('data-protected'));
 }
 private async run(work:()=>Promise<void>){
  if(this.state.busy)return;this.state.busy=true;this.state.notice='working';this.draw();
  try{await work();if(this.state.notice==='working')this.state.notice='';}
  catch(error){
   const conflict=(error as Error).message==='conflict';this.state.notice=conflict?'conflict':'failed';
   if(conflict){
    try{await this.load();const area=this.board?.territories.find(a=>a.id===this.state.selected);if(!area?.canSell)this.state.draft=this.emptyDraft();this.state.notice='conflict_refreshed';}
    catch{this.state.notice='failed';}
   }
  }finally{this.state.busy=false;this.draw();}
 }
}
