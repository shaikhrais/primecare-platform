import {CommunicationResourceBase} from './adapter-base.mjs';
const digits=(value,length)=>typeof value==='string'&&value.length===length&&/^[0-9]+$/.test(value);
/** Reusable authenticated app flow. Ports must use the host's registered,
 * CSRF-protected transport. No session tokens, phone numbers or grants in UI.
 * Scope includes the host session generation; logout must also call close(). */
export class VoiceOtpAppSession extends CommunicationResourceBase {
 #scope;#busy=false;
 constructor({callSid,currentScope,transport,onChange=()=>{}}){
  super();if(typeof callSid!=='string'||callSid.length!==34||!/^CA[a-fA-F0-9]{32}$/.test(callSid)||typeof currentScope!=='function'||typeof onChange!=='function'||['start','check'].some(k=>typeof transport?.[k]!=='function'))throw Error('Call verification ports required');
  this.callSid=callSid;this.currentScope=currentScope;this.transport=transport;this.onChange=onChange;this.state='pairing';this.#scope=currentScope();
  if(typeof this.#scope!=='string'||!this.#scope)throw Error('Current app session required');
 }
 #current(){this.assertOpen();if(this.currentScope()!==this.#scope){this.close();throw Error('App session changed');}}
 #set(state){this.state=state;this.onChange({state});}
 async start(pairingCode){
  this.#current();if(this.#busy||this.state!=='pairing')throw Error('Pairing unavailable');if(!digits(pairingCode,8))throw Error('Enter the eight digit pairing code');
  this.#busy=true;this.#set('sending');
  try{const result=await this.transport.start({callSid:this.callSid,pairingCode});this.#current();if(result?.verificationRequested!==true)throw Error('Invalid receipt');this.#set('code');}
  catch{if(!this.closed)this.#set('unavailable');throw Error('Verification unavailable; contact reception');}finally{this.#busy=false;}
 }
 async check(code){
  this.#current();if(this.#busy||this.state!=='code')throw Error('Verification unavailable');if(!digits(code,6))throw Error('Enter the six digit SMS code');
  this.#busy=true;this.#set('checking');
  try{const result=await this.transport.check({callSid:this.callSid,code});this.#current();if(typeof result?.verified!=='boolean')throw Error('Invalid receipt');this.#set(result.verified?'verified':'code');return result.verified;}
  catch{if(!this.closed)this.#set('unavailable');throw Error('Verification unavailable; contact reception');}finally{this.#busy=false;}
 }
 afterClose(){this.#set('closed');}
}
/** Optional DOM mount; no screen/route registration. Typed codes are cleared
 * before transport I/O and when closed; textContent prevents HTML injection. */
export function mountVoiceOtpPanel({element,...options}){
 const doc=element?.ownerDocument;if(!doc||typeof element.replaceChildren!=='function')throw Error('Verification panel element required');
 const status=doc.createElement('p');status.setAttribute('role','status');status.setAttribute('aria-live','polite');
 const instructions=doc.createElement('p');instructions.textContent='Keep your call connected. Enter the pairing code spoken before the AI starts, then the SMS code sent to your verified account phone. Do not speak the SMS code to the AI.';
 const label=doc.createElement('label'),input=doc.createElement('input'),button=doc.createElement('button'),form=doc.createElement('form');
 const caption=doc.createElement('span');label.append(caption,input);input.type='text';input.inputMode='numeric';input.autocomplete='off';input.required=true;button.type='submit';
 const render=({state})=>{
  status.textContent=({pairing:'Pair your call',sending:'Requesting verification…',code:'Enter the SMS code',checking:'Checking verification…',verified:'Call verified. Each task still requires your approval.',unavailable:'Verification unavailable. Contact reception.',closed:'Verification closed'})[state];
  const pairing=state==='pairing',editable=pairing||state==='code';caption.textContent=pairing?'Eight digit call pairing code':'Six digit SMS code';input.maxLength=pairing?8:6;input.pattern=pairing?'[0-9]{8}':'[0-9]{6}';button.textContent=pairing?'Send SMS code':'Verify call';input.disabled=button.disabled=!editable;if(!editable)input.value='';
 };
 const session=new VoiceOtpAppSession({...options,onChange:render});
 const submit=event=>{event.preventDefault();const value=input.value;input.value='';const operation=session.state==='pairing'?session.start(value):session.check(value);operation.catch(()=>{if(!session.closed&&['pairing','code'].includes(session.state))status.textContent='Enter the required numeric code.';});};
 form.addEventListener('submit',submit);session.registerCleanup(()=>{input.value='';form.removeEventListener('submit',submit);});form.append(label,button);element.replaceChildren(instructions,status,form);render({state:session.state});return session;
}
