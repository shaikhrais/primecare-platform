import {UploadCandidate,UploadPolicy,validateFiles} from '../../../domain/src/data_controls';
export type UploadPort=(request:{scope:string;operationKey:string;files:readonly UploadCandidate[];signal:AbortSignal;progress:(fraction:number)=>void})=>Promise<{receiptId:string}>;
export type UploadRemovalPort=(request:{scope:string;receiptId:string;operationKey:string;signal:AbortSignal})=>Promise<{receiptId:string;removed:true}>;
export type UploadReceiptPort=(scope:string,receiptId:string,signal:AbortSignal)=>Promise<{scope:string;receiptId:string;present:boolean}>;
/** The host declares server idempotency; no removal succeeds without independent receipt readback. */
export class UploadTask {
 status:'idle'|'ready'|'uploading'|'error'|'cancelled'|'success'|'removing'|'remove-error'|'removed'|'disposed'='idle';progress=0;receiptId:string|null=null;files:UploadCandidate[]=[];private epoch=0;private selection=0;private abort=new AbortController();private listeners=new Set<()=>void>();
 private removal?:{receiptId:string;operationKey:string;attempted:boolean;acknowledged:boolean};
 constructor(readonly scope:string,readonly policy:UploadPolicy,readonly port?:UploadPort,readonly retrySafe=false,readonly removalPort?:UploadRemovalPort,readonly receiptPort?:UploadReceiptPort,readonly removalRetrySafe=false){if(!scope.trim()||scope.length>1024)throw Error('invalid_upload_scope');this.policy=Object.freeze({maxFiles:policy.maxFiles,maxBytes:policy.maxBytes,types:Object.freeze([...policy.types])});}
 subscribe(f:()=>void){this.listeners.add(f);return()=>{this.listeners.delete(f);};}private emit(){for(const f of this.listeners)f();}
 choose(files:readonly UploadCandidate[]){if(this.status==='disposed'||this.status==='uploading'||this.status==='removing'||this.removal)throw Error('upload_busy');const valid=validateFiles(files,this.policy);this.epoch++;this.selection++;this.files=valid;this.receiptId=null;this.progress=0;this.status='ready';this.emit();}
 removeSelection(index:number){if(this.status!=='ready'||!Number.isSafeInteger(index)||index<0||index>=this.files.length)throw Error('selection_unavailable');this.files=this.files.filter((_,i)=>i!==index);this.selection++;this.epoch++;this.progress=0;this.status=this.files.length?'ready':'idle';this.emit();}
 async send(){if(!this.port||!['ready','error','cancelled'].includes(this.status)||this.status!=='ready'&&!this.retrySafe)return;const generation=++this.epoch;this.abort.abort();if(generation!==this.epoch)return;this.abort=new AbortController();this.status='uploading';this.receiptId=null;this.progress=0;this.emit();if(generation!==this.epoch)return;try{const result=await this.port({scope:this.scope,operationKey:this.scope+':'+this.selection,files:this.files.map(f=>({...f})),signal:this.abort.signal,progress:p=>{if(generation===this.epoch&&Number.isFinite(p)&&p>=this.progress&&p<=1){this.progress=p;this.emit();}}});if(generation!==this.epoch)return;if(!result||typeof result.receiptId!=='string'||!result.receiptId.trim()||result.receiptId.length>256)throw Error('missing_receipt');this.receiptId=result.receiptId;this.progress=1;this.status='success';}catch{if(generation!==this.epoch)return;this.status='error';}this.emit();}
 private async present(receiptId:string){const value=await this.receiptPort!(this.scope,receiptId,this.abort.signal);if(!value||value.scope!==this.scope||value.receiptId!==receiptId||typeof value.present!=='boolean')throw Error('invalid_removal_readback');return value.present;}
 async removeUpload(){
  if(!this.removalPort||!this.receiptPort||!['success','remove-error'].includes(this.status)||!this.receiptId)return;
  const generation=++this.epoch;this.abort.abort();if(generation!==this.epoch)return;this.abort=new AbortController();
  const pending=this.removal??={receiptId:this.receiptId,operationKey:this.scope+':remove:'+this.selection,attempted:false,acknowledged:false};
  this.status='removing';this.emit();
  if(generation!==this.epoch)return;
  try{
   if(pending.attempted){const exists=await this.present(pending.receiptId);if(generation!==this.epoch)return;if(!exists){this.finishRemoval();return;}if(pending.acknowledged||!this.removalRetrySafe)throw Error('removal_reconciliation_required');}
   pending.attempted=true;
   const ack=await this.removalPort({scope:this.scope,receiptId:pending.receiptId,operationKey:pending.operationKey,signal:this.abort.signal});
   if(generation!==this.epoch)return;
   if(!ack||ack.receiptId!==pending.receiptId||ack.removed!==true)throw Error('invalid_removal_ack');
   pending.acknowledged=true;
   if(await this.present(pending.receiptId))throw Error('removal_readback_present');
   if(generation!==this.epoch)return;
   this.finishRemoval();
  }catch{if(generation!==this.epoch)return;this.status='remove-error';this.emit();}
 }
 private finishRemoval(){this.files=[];this.receiptId=null;this.progress=0;this.removal=undefined;this.status='removed';this.emit();}
 cancel(){if(this.status!=='uploading')return;const generation=++this.epoch;this.abort.abort();if(generation!==this.epoch)return;this.status='cancelled';this.emit();}
 dispose(){if(this.status==='disposed')return;this.epoch++;this.files=[];this.receiptId=null;this.removal=undefined;this.progress=0;this.status='disposed';this.listeners.clear();this.abort.abort();}
}
