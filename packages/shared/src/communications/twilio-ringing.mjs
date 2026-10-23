import {CommunicationResourceBase} from './adapter-base.mjs';
/** Per-call answer UI state. Host passes current session generation and a current
 * authenticated answer authorization port; caller metadata is display-only.
 */
export class TwilioRingingCall extends CommunicationResourceBase {
 #call;#scope;#pending=false;
 constructor({call,currentScope,authorizeAnswer,onChange=()=>{}}){
  super();
  if(!call||['on','off','accept','reject','disconnect','mute'].some(k=>typeof call[k]!=='function')||[currentScope,authorizeAnswer,onChange].some(f=>typeof f!=='function'))throw Error('Incoming call ports required');
  this.#call=call;this.currentScope=currentScope;this.authorizeAnswer=authorizeAnswer;this.onChange=onChange;this.state='ringing';this.muted=false;
  this.#scope=currentScope();if(typeof this.#scope!=='string'||!this.#scope)throw Error('Current session required');
  this.registerCleanup(()=>{if(this.state==='ringing')call.reject();else if(this.state==='answering'){try{call.reject();}finally{call.disconnect();}}else if(this.state==='connected')call.disconnect();});
  for(const event of ['cancel','disconnect','reject']){
   const ended=()=>{this.state='ended';this.close();};call.on(event,ended);this.registerCleanup(()=>call.off(event,ended));
  }
  // An error notification is not proof that SDK media has disconnected. Preserve
  // the current state until cleanup rejects/ends the owned call. Listeners are
  // removed first by the inherited reverse cleanup order, avoiding reentrant end events.
  const failed=()=>this.close();call.on('error',failed);this.registerCleanup(()=>call.off('error',failed));
  const accepted=()=>{try{this.#current();if(this.state!=='answering')throw Error('Unexpected acceptance');this.#set('connected');}catch{try{call.disconnect();}finally{this.close();}}};
  call.on('accept',accepted);this.registerCleanup(()=>call.off('accept',accepted));
 }
 #current(){this.assertOpen();if(this.currentScope()!==this.#scope){this.close();throw Error('Call session changed');}}
 #set(state){this.state=state;this.onChange({state,muted:this.muted});}
 async answer(){
  this.#current();if(this.state!=='ringing'||this.#pending)throw Error('Call unavailable');this.#pending=true;
  try{if(await this.authorizeAnswer()!==true)throw Error('Answer denied');this.#current();if(this.state!=='ringing')throw Error('Call ended');this.#set('answering');this.#current();if(this.state!=='answering')throw Error('Call ended');await this.#call.accept();if(this.closed){this.#call.disconnect();throw Error('Call ended');}this.#current();}
  catch{this.close();throw Error('Call unavailable');}finally{this.#pending=false;}
 }
 decline(){this.#current();if(this.state!=='ringing')throw Error('Call unavailable');this.close();}
 hangup(){this.#current();if(!['answering','connected'].includes(this.state))throw Error('Call unavailable');this.close();}
 mute(value){this.#current();if(this.state!=='connected'||typeof value!=='boolean')throw Error('Call unavailable');this.#call.mute(value);this.muted=value;this.#set('connected');}
 afterClose(){try{this.#set('ended');}catch{/* Display failure must not escape SDK events or interrupt shutdown. */}}
}
/** Optional accessible DOM panel. No page/route activation or HTML interpolation. */
export function mountTwilioCallPanel({element,call,currentScope,authorizeAnswer}){
 const doc=element?.ownerDocument;if(!doc||typeof element.replaceChildren!=='function')throw Error('Call panel element required');
 const status=doc.createElement('p');status.setAttribute('role','status');status.setAttribute('aria-live','polite');
 const buttons={};let session;
 const render=({state,muted})=>{status.textContent=({ringing:'Incoming call',answering:'Connecting…',connected:'Call connected',ended:'Call ended'})[state];for(const [key,button] of Object.entries(buttons))button.disabled=key==='answer'||key==='decline'?state!=='ringing':key==='mute'?state!=='connected':!['answering','connected'].includes(state);if(buttons.mute)buttons.mute.textContent=muted?'Unmute':'Mute';};
 session=new TwilioRingingCall({call,currentScope,authorizeAnswer,onChange:render});
 const actions={answer:()=>session.answer(),decline:()=>session.decline(),mute:()=>session.mute(!session.muted),hangup:()=>session.hangup()};
 for(const [key,action] of Object.entries(actions)){
  const button=doc.createElement('button');button.type='button';button.textContent=({answer:'Answer',decline:'Decline',mute:'Mute',hangup:'End call'})[key];
  const listener=()=>{if(key==='answer'){buttons.answer.disabled=true;buttons.decline.disabled=false;}Promise.resolve().then(action).catch(()=>{status.textContent='Call unavailable';});};
  button.addEventListener('click',listener);session.registerCleanup(()=>button.removeEventListener('click',listener));buttons[key]=button;
 }
 element.replaceChildren(status,...Object.values(buttons));render({state:session.state,muted:false});
 return session;
}
