import {focusInWorkspace} from '../focus';
import type {BundleHistory,HistoryTarget,BundleLocale} from '../../../../packages/shared/src/platform-bundle/contract';
import {BundleClient} from './client';
import {historyPanel} from './history-panel';

export class BundleHistoryController{
 private target:HistoryTarget|null=null;private data:BundleHistory|null=null;private offset=0;private revision=0;private returnFocus='';
 constructor(private client:BundleClient){}
 reset(){this.revision++;this.target=null;this.data=null;this.offset=0;}
 markup(locale:BundleLocale){return historyPanel(this.target,this.data,locale);}
 private async load(){const revision=++this.revision,target=this.target;if(!target)return;this.data=null;try{const data=await this.client.history(target,this.offset);if(revision===this.revision)this.data=data;}catch(error){if(revision===this.revision)throw error;}}
 bind(root:HTMLElement,run:(work:()=>Promise<void>)=>Promise<void>,redraw:()=>void){
  const focus=()=>{if(this.data)focusInWorkspace(root,root.querySelector<HTMLElement>('[data-cy=bundle-history-heading]'));};
  root.querySelectorAll<HTMLButtonElement>('[data-history-kind]').forEach(button=>button.onclick=async()=>{
   if(button.disabled)return;this.returnFocus=button.dataset.cy!;this.target={kind:button.dataset.historyKind as HistoryTarget['kind'],tenantId:button.dataset.historyTenant!,ticketId:button.dataset.historyTicket||null};this.offset=0;this.data=null;await run(()=>this.load());focus();
  });
  for(const [key,step] of [['previous',-1],['next',1]] as const){const button=root.querySelector<HTMLButtonElement>('[data-cy=bundle-history-'+key+']');if(button)button.onclick=async()=>{if(button.disabled)return;this.offset=Math.max(0,this.offset+step*this.data!.pagination.limit);this.data=null;await run(()=>this.load());focus();};}
  const close=root.querySelector<HTMLButtonElement>('[data-cy=bundle-history-close]');if(close)close.onclick=()=>{this.reset();redraw();focusInWorkspace(root,root.querySelector<HTMLElement>('[data-cy="'+this.returnFocus+'"]')); };
  const retry=root.querySelector<HTMLButtonElement>('[data-cy=bundle-history-retry]');if(retry)retry.onclick=async()=>{await run(()=>this.load());focus();};
  root.querySelectorAll<HTMLButtonElement>('[data-history-download]').forEach(button=>button.onclick=async()=>{if(this.data?.kind!=='documents')return;const doc=this.data.items.find(d=>d.id===button.dataset.historyDownload);if(doc)await run(()=>this.client.download(this.target!.tenantId,doc.id,doc.filename));});
 }
}
