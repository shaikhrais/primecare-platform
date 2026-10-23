import {CommunicationResourceBase} from './adapter-base.mjs';
const intentId=value=>typeof value==='string'&&value.length===36&&/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i.test(value);
/** App-only exact-action approval. Never expose this port as a model tool.
 * The host owns native session auth, CSRF, registered routes and logout cleanup.
 * Approval does not execute a task or establish identity; the server rechecks both. */
export class VoiceTaskApprovalSession extends CommunicationResourceBase {
 #scope;#currentScope;#transport;#onChange;#state='idle';#proposal=null;#timer;
 constructor({currentScope,transport,onChange=()=>{}}){
  super();if(typeof currentScope!=='function'||typeof onChange!=='function'||['preview','approve'].some(k=>typeof transport?.[k]!=='function'))throw Error('Task approval ports required');
  this.#scope=currentScope();if(typeof this.#scope!=='string'||!this.#scope)throw Error('Current app session required');
  this.#currentScope=currentScope;this.#transport=Object.freeze({preview:transport.preview.bind(transport),approve:transport.approve.bind(transport)});this.#onChange=onChange;
  this.registerCleanup(()=>{clearTimeout(this.#timer);this.#proposal=null;});
 }
 get state(){return this.#state;}
 get proposal(){return this.#proposal?Object.freeze({...this.#proposal}):null;}
 #current(){this.assertOpen();if(this.#currentScope()!==this.#scope){this.close();throw Error('App session changed');}}
 #set(state){this.#state=state;try{this.#onChange({state,proposal:this.proposal});}catch{this.close();throw Error('Task approval display unavailable');}}
 #expire(){this.#state='expired';this.close();}
 async preview(id){
  this.#current();if(this.#state!=='idle'||!intentId(id))throw Error('Task preview unavailable');
  try{
   this.#set('loading');this.#current();const result=await this.#transport.preview(id);this.#current();
   if(result?.intentId!==id||typeof result.summary!=='string'||!result.summary.trim()||result.summary.length>1000||/[\u0000-\u001f\u007f]/.test(result.summary)||typeof result.digest!=='string'||result.digest.length!==64||!/^[a-f0-9]{64}$/.test(result.digest)||!Number.isSafeInteger(result.expiresAt)||result.expiresAt<=Date.now()||result.expiresAt>Date.now()+120000)throw Error('Invalid task preview');
   this.#proposal=Object.freeze({intentId:id,summary:result.summary,digest:result.digest,expiresAt:result.expiresAt});
   this.#timer=setTimeout(()=>this.#expire(),Math.max(0,result.expiresAt-Date.now()));this.#timer.unref?.();this.#set('ready');this.#current();
   return this.proposal;
  }catch{if(!this.closed){this.#proposal=null;this.#set('unavailable');}throw Error('Task preview unavailable');}
 }
 /** Call only from an explicit user gesture after displaying proposal.summary. */
 async approve(){
  this.#current();if(this.#state!=='ready'||!this.#proposal)throw Error('Task approval unavailable');
  if(this.#proposal.expiresAt<=Date.now()){this.#expire();throw Error('Task approval expired');}
  const proposal=this.#proposal;
  try{
   this.#set('approving');this.#current();if(proposal.expiresAt<=Date.now()){this.#expire();throw Error('Task approval expired');}
   const result=await this.#transport.approve(proposal.intentId,proposal.digest);this.#current();
   if(result?.approved!==true||!Number.isSafeInteger(result.expiresAt)||result.expiresAt<=Date.now()||result.expiresAt>proposal.expiresAt||result.expiresAt>Date.now()+60000)throw Error('Invalid approval receipt');
   clearTimeout(this.#timer);this.#proposal=null;this.#set('approved');this.#current();return Object.freeze({approved:true,expiresAt:result.expiresAt});
  }catch{if(!this.closed){clearTimeout(this.#timer);this.#proposal=null;this.#set('unavailable');}throw Error('Task approval unavailable; check status before trying again');}
 }
 afterClose(){this.#state=this.#state==='expired'?'expired':'closed';try{this.#onChange({state:this.#state,proposal:null});}catch{/* Closing must finish even when the host display is unavailable. */}}
}
/** Optional app read-back form. Hosts supply localized copy and register the UI.
 * Uses textContent, never HTML; no task argument, actor or tenant inputs. */
export function mountVoiceTaskApprovalPanel({element,intentId,copy,...options}){
 const doc=element?.ownerDocument;const keys=['idle','loading','ready','approving','approved','unavailable','expired','closed','approve','cancel'];
 if(!doc||typeof element.replaceChildren!=='function'||!intentId||!copy||keys.some(k=>typeof copy[k]!=='string'||!copy[k].trim()))throw Error('Task approval panel configuration required');
 const text=Object.freeze(Object.fromEntries(keys.map(k=>[k,copy[k]])));
 const status=doc.createElement('p'),summary=doc.createElement('p'),approve=doc.createElement('button'),cancel=doc.createElement('button');
 status.setAttribute('role','status');status.setAttribute('aria-live','polite');approve.type=cancel.type='button';approve.textContent=text.approve;cancel.textContent=text.cancel;
 const render=({state,proposal})=>{status.textContent=text[state];summary.textContent=proposal?.summary??'';approve.disabled=state!=='ready';cancel.disabled=['approved','unavailable','expired','closed'].includes(state);};
 const session=new VoiceTaskApprovalSession({...options,onChange:render});
 const confirm=()=>{session.approve().catch(()=>{});},dismiss=()=>session.close();
 approve.addEventListener('click',confirm);cancel.addEventListener('click',dismiss);
 session.registerCleanup(()=>{approve.removeEventListener('click',confirm);cancel.removeEventListener('click',dismiss);});
 element.replaceChildren(status,summary,approve,cancel);render({state:session.state,proposal:null});
 session.preview(intentId).catch(()=>{});return session;
}
