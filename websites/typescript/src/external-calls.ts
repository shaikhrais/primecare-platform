import {MicrophoneAccess,microphoneHelp} from './microphone-access';
import {Device,Call} from '@twilio/voice-sdk';
import {CommunicationResourceBase} from '../../../packages/shared/src/communications/adapter-base.mjs';
import {BaseSessionClient} from './infrastructure/http/base-session-client';
class ExternalCallFailure extends Error{
 constructor(readonly status:number,readonly reference:string|undefined){super('Calling request failed');}
}
class ExternalClient extends BaseSessionClient{
 protected readonly endpoint='/v1/external-calls';
 protected accountChangedError(){return Error('Sign in again');}
 protected rejectResponse(response:Response):never{const ref=response.headers.get('x-primecare-external-request')??'';throw new ExternalCallFailure(response.status,/^[a-f0-9-]{36}$/.test(ref)?ref:undefined);}
 state(){return this.requestJson('/state','POST',{});}
 prepare(phone:string,requestId:string){return this.requestJson('/prepare','POST',{phone,requestId});}
 end(ticket:string){return this.requestJson('/end','POST',{ticket});}
}
let nextDialer=0;
/** Shared floating dialer. Collapse changes presentation only, never call/media state. */
export class ExternalCallsPanel extends CommunicationResourceBase{
 private device:Device|null=null;
 private call:Call|null=null;
 private ticket:string|null=null;
 private timer:ReturnType<typeof setTimeout>|null=null;
 private diagnostics:Record<string,unknown>[]=[];
 private busy=false;
 private muted=false;
 private connected=false;
 private checkingMicrophone=false;
 private microphone=new MicrophoneAccess();
 private pending:{phone:string;requestId:string}|null=null;
 private client:ExternalClient;
 constructor(readonly root:HTMLElement,gateway:string,readonly token:string,options:{collapsed?:boolean}={}){
  super();this.client=new ExternalClient(gateway,token);
  const id='primecare-phone-'+(++nextDialer);
  const keys=[['1',''],['2','ABC'],['3','DEF'],['4','GHI'],['5','JKL'],['6','MNO'],['7','PQRS'],['8','TUV'],['9','WXYZ'],['*',''],['0','+'],['#','']];
  root.hidden=true;root.classList.add('external-call-panel','external-dialer');root.dataset.callState='ready';
  root.setAttribute('role','region');root.setAttribute('aria-label','PrimeCare phone dialer');
  root.innerHTML=`
   <button class="external-dialer-toggle" type="button" data-cy="external-dialer-toggle" aria-controls="${id}-content" aria-expanded="true" aria-label="Minimize phone dialer">
    <span class="external-dialer-logo" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M7 3H4a1 1 0 0 0-1 1c0 9.4 7.6 17 17 17a1 1 0 0 0 1-1v-3l-5-2-2 2a14 14 0 0 1-7-7l2-2-2-5Z"/></svg></span>
    <span class="external-dialer-title"><strong>PrimeCare Phone</strong><span data-cy="external-dialer-summary" role="status" aria-live="polite">Ready to call</span></span>
    <span class="external-dialer-chevron" data-cy="external-dialer-chevron" aria-hidden="true">−</span>
   </button>
   <div class="external-dialer-content" id="${id}-content">
    <div class="external-dialer-body">
     <div class="external-call-caller"><span>Caller ID</span><strong data-cy="external-call-caller">Your business number</strong></div>
     <form class="external-call-form" id="${id}-form">
      <label>Phone number<span class="external-dialer-number"><button type="button" data-cy="external-dialer-plus" aria-label="Add country prefix">+</button><input type="tel" inputmode="tel" autocomplete="tel" name="phone" placeholder="+16475550123" maxlength="16" required pattern="\\+[1-9][0-9]{6,14}" data-cy="external-call-phone"><button type="button" data-cy="external-dialer-backspace" aria-label="Delete last digit">⌫</button></span></label>
     </form>
     <p class="external-dialer-hint">Start with + and the country code.</p>
     <div class="external-dialer-keypad" role="group" aria-label="Phone keypad">${keys.map(([key,letters])=>`<button type="button" data-dial-key="${key}" aria-label="${key==='*'?'Star':key==='#'?'Hash':key}"><span>${key}</span><small aria-hidden="true">${letters||'&nbsp;'}</small></button>`).join('')}</div>
     <p class="external-call-help external-dialer-mic-note" data-cy="external-microphone-status" role="status">Enable mic to check access. No call starts.</p>
     <p class="external-dialer-hint">During a connected call, use the keypad for phone menus.</p>
     <details class="external-dialer-diagnostics"><summary>Call diagnostics</summary><pre data-cy="external-call-diagnostics" tabindex="0" aria-label="Call diagnostic log"></pre></details>
    </div>
    <footer class="external-dialer-footer">
     <div class="external-call-status-box"><span class="external-call-dot" aria-hidden="true"></span><p role="status" aria-live="polite" aria-atomic="true" data-cy="external-call-status">Ready to call</p></div>
     <button class="external-call-start" type="submit" form="${id}-form" data-cy="external-call-dial">Call phone</button>
     <div class="external-call-controls"><button class="external-call-microphone" type="button" data-cy="external-call-microphone" aria-label="Enable microphone">Enable mic</button><button type="button" data-cy="external-call-mute" aria-pressed="false" disabled>Mute</button><button class="external-call-stop" type="button" data-cy="external-call-end" disabled>End call</button></div>
    </footer>
   </div>`;
  this.setCollapsed(options.collapsed===true);
  // Follow the visible viewport when Android's keyboard covers the layout viewport.
  const viewport=()=>{const visual=window.visualViewport;root.style.setProperty('--dialer-visible-height',(visual?.height??window.innerHeight)+'px');root.style.setProperty('--dialer-bottom-inset',Math.max(0,window.innerHeight-(visual?.height??window.innerHeight)-(visual?.offsetTop??0))+'px');};
  viewport();window.addEventListener('resize',viewport);window.visualViewport?.addEventListener('resize',viewport);window.visualViewport?.addEventListener('scroll',viewport);

  const submit=(event:Event)=>{event.preventDefault();void this.dial(String(new FormData(root.querySelector('form')!).get('phone')??''));};
  const end=()=>this.finish();
  const microphone=()=>{void this.checkMicrophone();};
  const mute=()=>{if(this.call){this.muted=!this.muted;this.call.mute(this.muted);this.muteControl();}};
  const toggle=()=>this.setCollapsed(root.dataset.collapsed!=='true');
  const plus=()=>this.editNumber('+');
  const backspace=()=>this.editNumber('delete');
  const keysClick=(event:Event)=>{const button=(event.target as Element).closest<HTMLButtonElement>('[data-dial-key]');if(button&&!button.disabled)this.key(button.dataset.dialKey!);};
  const escape=(event:KeyboardEvent)=>{if(event.key==='Escape'&&root.dataset.collapsed!=='true'){event.preventDefault();this.setCollapsed(true);root.querySelector<HTMLButtonElement>('[data-cy=external-dialer-toggle]')!.focus();}};
  const bindings:[Element,string,EventListener][]=[
   [root.querySelector('form')!,'submit',submit],
   [root.querySelector('[data-cy=external-call-end]')!,'click',end],
   [root.querySelector('[data-cy=external-call-microphone]')!,'click',microphone],
   [root.querySelector('[data-cy=external-call-mute]')!,'click',mute],
   [root.querySelector('[data-cy=external-dialer-toggle]')!,'click',toggle],
   [root.querySelector('[data-cy=external-dialer-plus]')!,'click',plus],
   [root.querySelector('[data-cy=external-dialer-backspace]')!,'click',backspace],
   [root.querySelector('.external-dialer-keypad')!,'click',keysClick],
   [root,'keydown',escape as EventListener]
  ];
  for(const [node,event,handler]of bindings)node.addEventListener(event,handler);
  const leave=()=>this.close();window.addEventListener('pagehide',leave);window.addEventListener('storage',leave);
  this.registerCleanup(()=>{
   window.removeEventListener('resize',viewport);window.visualViewport?.removeEventListener('resize',viewport);window.visualViewport?.removeEventListener('scroll',viewport);
   this.microphone.close();for(const [node,event,handler]of bindings)node.removeEventListener(event,handler);
   window.removeEventListener('pagehide',leave);window.removeEventListener('storage',leave);
   clearTimeout(this.timer!);this.release();root.hidden=true;
  });
  this.controls(false);
  this.record('state','started');void this.client.state().then((state:any)=>{
   this.record('state','ok');
   if(this.closed)return;root.hidden=false;
   if(['prepared','active'].includes(state.status)&&state.expiresAt>Date.now()){
    this.ticket=state.ticket;
    if(typeof state.phone==='string')root.querySelector<HTMLInputElement>('[data-cy=external-call-phone]')!.value=state.phone;
    this.controls(true);this.message('An earlier phone call is reserved. End it before starting another.','reserved');
   }
  }).catch(error=>{this.record('state','failed',error);this.close();});
 }
 setCollapsed(collapsed:boolean){
  this.root.dataset.collapsed=String(collapsed);
  this.root.querySelector<HTMLElement>('.external-dialer-content')!.hidden=collapsed;
  const button=this.root.querySelector('[data-cy=external-dialer-toggle]')!;
  button.setAttribute('aria-expanded',String(!collapsed));button.setAttribute('aria-label',collapsed?'Open phone dialer':'Minimize phone dialer');
  this.root.querySelector('[data-cy=external-dialer-chevron]')!.textContent=collapsed?'+':'−';
 }
 private record(stage:string,event:string,error?:unknown){
  // Allowlisted metadata only. Never retain error messages, tokens, numbers or SDK payloads.
  const e=error as {code?:unknown;name?:unknown;status?:unknown;reference?:unknown}|undefined;
  const entry:Record<string,unknown>={at:new Date().toISOString(),stage,event};
  if(Number.isInteger(e?.code)&&Number(e?.code)>0&&Number(e?.code)<100000)entry.code=e?.code;
  if(Number.isInteger(e?.status)&&Number(e?.status)>=400&&Number(e?.status)<=599)entry.httpStatus=e?.status;
  if(typeof e?.reference==='string'&&/^[a-f0-9-]{36}$/.test(e.reference))entry.reference=e.reference;
  if(['NotAllowedError','NotFoundError','NotReadableError','AbortError','TypeError'].includes(String(e?.name)))entry.kind=e?.name;
  this.diagnostics.push(entry);if(this.diagnostics.length>50)this.diagnostics.shift();
  this.root.querySelector('[data-cy=external-call-diagnostics]')!.textContent=JSON.stringify(this.diagnostics,null,2);
  console.info('primecare_external_call',entry);
 }
 private failure(stage:string,error:unknown){
  this.record(stage,'failed',error);const e=error as {status?:number;code?:number;reference?:string};
  const known=e?.status===401?'Sign in again to call.':e?.status===403?'Calling access was denied for this account.':e?.status===409?'A call is already reserved or its state changed. End it and retry.':e?.status===429?'Too many calling requests. Wait a moment and retry.':e?.status===503?'The calling service is temporarily unavailable.':microphoneHelp(error)??'Unable to call. Check your connection and calling access.';
  const reference=typeof e?.reference==='string'&&/^[a-f0-9-]{36}$/.test(e.reference)?' Reference: '+e.reference:typeof e?.code==='number'&&Number.isInteger(e.code)&&e.code>0&&e.code<100000?' Code: '+e.code:'';
  this.message(known+' Step: '+stage+'.'+reference,'error');
 }
 private current(){this.assertOpen();if(sessionStorage.getItem('primecare_session')!==this.token){this.close();throw Error('Sign in again');}}
 private summary(){
  const labels:Record<string,string>={ready:'Ready to call',preparing:'Preparing…',calling:'Calling…',ringing:'Ringing…',connected:this.muted?'Connected · muted':'Connected',ended:'Call ended',error:'Check call',reserved:'Call reserved'};
  this.root.querySelector('[data-cy=external-dialer-summary]')!.textContent=labels[this.root.dataset.callState??'ready']??'Phone';
 }
 private message(text:string,state='ready'){this.root.dataset.callState=state;this.root.querySelector('[data-cy=external-call-status]')!.textContent=text;this.summary();}
 private muteControl(){const button=this.root.querySelector('[data-cy=external-call-mute]')!;button.textContent=this.muted?'Unmute':'Mute';button.setAttribute('aria-pressed',String(this.muted));this.summary();}
 private editNumber(value:string){
  const input=this.root.querySelector<HTMLInputElement>('[data-cy=external-call-phone]')!;
  if(input.disabled)return;
  if(value==='+'){if(!input.value.startsWith('+'))input.value=('+'+input.value).slice(0,16);return;}
  const start=input.selectionStart??input.value.length,end=input.selectionEnd??input.value.length;
  if(value==='delete'){if(start!==end)input.setRangeText('',start,end,'end');else if(start>0)input.setRangeText('',start-1,end,'end');}
  else if(/^[0-9]$/.test(value)&&input.value.length-(end-start)<16)input.setRangeText(value,start,end,'end');
 }
 private key(value:string){
  if(!/^[0-9*#]$/.test(value))return;
  if(this.call&&this.connected){
   try{this.current();this.call.sendDigits(value);this.root.querySelector('[data-cy=external-microphone-status]')!.textContent='Keypad tone sent';}
   catch{this.message('Unable to send keypad tone. The call may still be connected.','error');}
  }else if(!this.busy&&!this.checkingMicrophone&&!this.ticket)this.editNumber(value);
 }
 private controls(active:boolean){
  const editBlocked=this.busy||this.checkingMicrophone||active;
  for(const key of ['microphone','dial'])this.root.querySelector<HTMLButtonElement>('[data-cy=external-call-'+key+']')!.disabled=editBlocked;
  this.root.querySelector<HTMLInputElement>('[data-cy=external-call-phone]')!.disabled=editBlocked;
  this.root.querySelector<HTMLButtonElement>('[data-cy=external-call-end]')!.disabled=!active;
  this.root.querySelector<HTMLButtonElement>('[data-cy=external-call-mute]')!.disabled=!this.call;
  for(const key of ['plus','backspace'])this.root.querySelector<HTMLButtonElement>('[data-cy=external-dialer-'+key+']')!.disabled=editBlocked;
  for(const button of this.root.querySelectorAll<HTMLButtonElement>('[data-dial-key]'))button.disabled=this.connected?false:editBlocked||['*','#'].includes(button.dataset.dialKey!);
 }
 private async checkMicrophone(){
  if(this.busy||this.checkingMicrophone||this.call)return;
  this.checkingMicrophone=true;this.controls(!!this.call);
  const status=this.root.querySelector('[data-cy=external-microphone-status]')!;status.textContent='Choose Allow when Chrome asks for microphone access…';
  try{this.current();await this.microphone.request();this.current();status.textContent='Microphone ready. Enter a number and tap Call phone.';}
  catch(error){if(!this.closed)status.textContent=microphoneHelp(error)??'Unable to check microphone access. Try again.';}
  finally{this.checkingMicrophone=false;if(!this.closed)this.controls(!!this.call||!!this.ticket);}
 }
 private release(){const call=this.call,device=this.device;this.call=null;this.device=null;this.connected=false;this.muted=false;this.muteControl();call?.disconnect();device?.destroy();this.controls(false);}
 private finish(){this.record('call','ended');clearTimeout(this.timer!);this.timer=null;const ticket=this.ticket;this.ticket=null;this.pending=null;this.release();this.message('Call ended','ended');if(ticket)void this.client.end(ticket).then(()=>this.record('end','ok')).catch(error=>this.record('end','failed',error));}
 private watch(){if(this.closed||!this.ticket)return;this.timer=setTimeout(async()=>{try{this.current();const state=await this.client.state() as any;if(state.ticket!==this.ticket||!['prepared','active'].includes(state.status)){this.finish();return;}this.watch();}catch(error){this.finish();this.failure('watch',error);}},2000);}
 private async renew(device:Device,phone:string,ticket:string){try{this.current();if(this.device!==device||this.ticket!==ticket)return;const renewed=await this.client.prepare(phone,ticket) as any;this.current();if(this.device===device&&this.ticket===ticket)device.updateToken(renewed.token);}catch(error){this.finish();this.failure('renew',error);}}
 private async dial(phone:string){
  if(this.busy||this.checkingMicrophone||this.call||!/^\+[1-9][0-9]{6,14}$/.test(phone))return;
  this.busy=true;this.controls(false);this.message('Allow microphone access to start your call…','preparing');
  let stage='microphone';this.record(stage,'started');
  try{
   this.current();await this.microphone.request();this.current();this.root.querySelector('[data-cy=external-microphone-status]')!.textContent='Microphone ready';this.message('Preparing phone call…','preparing');
   if(this.pending&&this.pending.phone!==phone)throw Error('Resolve previous phone attempt');
   this.pending??={phone,requestId:crypto.randomUUID()};
   this.record(stage,'ok');stage='prepare';this.record(stage,'started');
   const prepared=await this.client.prepare(phone,this.pending.requestId) as any;this.current();this.ticket=prepared.ticket;
   this.record(stage,'ok');stage='device';this.record(stage,'started');
   const device=new Device(prepared.token,{closeProtection:true,logLevel:'silent',tokenRefreshMs:30000});this.device=device;
   this.root.querySelector<HTMLButtonElement>('[data-cy=external-call-end]')!.disabled=false;
   device.on('tokenWillExpire',()=>{void this.renew(device,phone,prepared.ticket);});
   device.on('error',error=>{this.finish();this.failure('device',error);});
   this.root.querySelector('[data-cy=external-call-caller]')!.textContent=typeof prepared.callerId==='string'?prepared.callerId:'Your business number';this.message('Calling '+phone+'…','calling');
   this.record(stage,'ok');stage='connect';this.record(stage,'started');
   const call=await device.connect({params:{Ticket:prepared.ticket}});this.current();if(this.device!==device){call.disconnect();return;}
   this.record(stage,'ok');this.call=call;this.controls(true);
   call.on('ringing',()=>{this.record('call','ringing');this.message('Ringing '+phone+'…','ringing');});
   call.on('accept',()=>{this.record('call','connected');this.connected=true;this.controls(true);this.message('Connected to '+phone,'connected');});
   call.on('disconnect',()=>this.finish());call.on('cancel',()=>this.finish());call.on('error',error=>{this.finish();this.failure('call',error);});this.watch();
  }catch(error){const pending=this.pending,retain=!this.ticket;this.finish();if(retain)this.pending=pending;this.failure(stage,error);}
  finally{this.busy=false;this.controls(!!this.call);}
 }
}
/** Current native capability only; no role guess, token creation or provider traffic. */
export async function canUseExternalCalls(gateway:string,token:string):Promise<boolean>{try{await new ExternalClient(gateway,token).state();return true;}catch{return false;}}
let dock:{gateway:string;token:string;root:HTMLElement;panel:ExternalCallsPanel}|null=null;
/** One account-bound dock across the portal. No permission or provider cache. */
export function mountExternalDialer(gateway:string,token:string,open=false):ExternalCallsPanel{
 if(dock&&(dock.gateway!==gateway||dock.token!==token||dock.panel.closed)){dock.panel.close();dock?.root.remove();dock=null;}
 if(!dock){
  const root=document.createElement('section');document.body.append(root);
  const panel=new ExternalCallsPanel(root,gateway,token,{collapsed:!open});dock={gateway,token,root,panel};
  panel.registerCleanup(()=>{root.remove();if(dock?.panel===panel)dock=null;});
 }
 if(open)dock.panel.setCollapsed(false);
 return dock.panel;
}
