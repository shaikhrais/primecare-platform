import {BatchedIcePeerConnection} from './infrastructure/webrtc/batched-peer';
import {CommunicationResourceBase} from '../../../packages/shared/src/communications/adapter-base.mjs';
import {BrowserCallEvents} from '../../../packages/shared/src/communications/call-events.mjs';
import {BrowserAudioSession} from '../../../packages/shared/src/communications/audio-session.mjs';
import {InternalCallClient,InternalCallRequestError} from './internal-call-client';
import catalog from '../../../tools/governance-production/internal-call-ui-registration.json';
import {renderShell,bindShell} from './shell';
const escape=(v:unknown)=>String(v??'').replace(/[&<>'"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;',"'":'&#39;','"':'&quot;'}[c]!));
type Call={id:string;callerId:string;recipientId:string;status:string;expiresAt:number;offered?:boolean;answered?:boolean};
type View={id:string;version:number;members:string[];calls:Call[]};
type Context={userId:string;role:string;home:string;navigation:string};
/** One request/session-scoped panel for all permitted websites. Server grants and
 * account/call scope remain authoritative. Closing/navigation releases media. */
export class InternalCallsPanel extends CommunicationResourceBase {
 readonly client:InternalCallClient;readonly root:HTMLElement;readonly token:string;readonly userId:string;readonly labels:Record<string,string>;
 readonly audio=document.createElement('audio');private session:BrowserAudioSession|null=null;private timer:ReturnType<typeof setTimeout>|null=null;
 private events:BrowserCallEvents;private pushWork:Promise<void>|null=null;private pushDirty=false;private refreshWork:Promise<void>|null=null;
 private preparedCall:string|null=null;private prepWork:Promise<void>|null=null;private mediaStages:{stage:string;at:number}[]=[];
 private active:{view:View;call:Call}|null=null;private self:any=null;private directory:any[]=[];private pending:{extension:string;requestId:string}|null=null;private busy=false;private polling=false;private muted=false;private starting=false;private lastHeartbeat=0;private attempted=new Set<string>();private notification:string|null=null;
 constructor(root:HTMLElement,gateway:string,token:string,context:Context){
  super();this.root=root;this.token=token;this.userId=context.userId;this.client=new InternalCallClient(gateway,token);const locale=document.documentElement.lang==='fr'?'fr':document.documentElement.lang==='es'?'es':'en';this.labels=catalog.locales[locale];
  this.events=new BrowserCallEvents({gateway,userId:this.userId,token,isCurrent:()=>!this.closed&&sessionStorage.getItem('primecare_session')===this.token,onChange:type=>{if(type==='signal'){void this.session?.refresh().catch(()=>{});}else this.pushed();},onStatus:connected=>{if(!this.closed)this.root.querySelector('[data-cy=internal-call-panel]')?.setAttribute('data-push',connected?'connected':'disconnected');},onDenied:()=>{if(sessionStorage.getItem('primecare_session')!==this.token){this.session?.close();this.close();}}});
  this.registerCleanup(()=>this.events.close());
  const t=(key:string)=>escape(this.labels[key]),button=(key:string)=>`<button type="button" data-call="${key}" data-cy="internal-call-${key}">${t(key)}</button>`;
  renderShell(root,{home:escape(context.home),role:escape(context.role),navigation:context.navigation,controls:`<a href="${escape(context.home)}">${t('back')}</a>`,content:`<section class="section" data-cy="internal-call-panel"><h1>${t('title')}</h1><p>${t('ready')}</p><p data-cy="internal-call-own"></p><div>${button('enable')}${button('disable')}${button('refresh')}${button('notifications')}</div><form data-cy="internal-call-dial-form"><label>${t('extension')} <input data-cy="internal-call-extension" name="extension" inputmode="numeric" pattern="[1-9][0-9]{3}" maxlength="4" required></label><button data-call="dial" data-cy="internal-call-dial">${t('dial')}</button></form><button type="button" data-call="pending" data-cy="internal-call-pending" hidden>${t('pending')}</button><p role="status" aria-live="polite" data-cy="internal-call-status">${t('loading')}</p><div data-cy="internal-call-active"></div><div data-cy="internal-call-controls">${button('answer')}${button('decline')}${button('end')}${button('start')}${button('mute')}${button('hear')}</div><h2>${t('directory')}</h2><div data-cy="internal-call-directory"></div><ul data-cy="internal-call-history"></ul><div data-cy="internal-call-audio"></div></section>`});
  bindShell(root,this.labels.title,locale,'calls:'+this.userId,()=>[]);
  this.audio.autoplay=true;this.audio.setAttribute('playsinline','');this.audio.controls=false;root.querySelector('[data-cy=internal-call-audio]')!.append(this.audio);
  const click=(event:Event)=>{const element=(event.target as Element).closest<HTMLButtonElement>('[data-call]');if(!element)return;const action=element.dataset.call!;if(action==='dial')return;
   event.preventDefault();if(action==='hear'){void this.audio.play().catch(()=>this.message('permission'));return;}if(action==='mute'){if(this.session&&!this.session.closed){this.muted=!this.muted;this.session.mute(this.muted);element.setAttribute('aria-pressed',String(this.muted));}return;}
   if(action==='notifications'){if('Notification'in window)void Notification.requestPermission();return;}
   if(action==='refresh'){void this.operation(async()=>{await this.refreshDirectory();});return;}if(action==='start'){this.attempted.delete(this.active?.call.id??'');void this.startMedia();return;}
   void this.operation(async()=>{if(action==='enable'||action==='disable'){this.self=await this.client.extension(action==='enable');await this.refreshDirectory();}else if(action==='pending'&&this.pending)await this.place(this.pending.extension);else if(['answer','decline','end'].includes(action))await this.callAction(action==='answer'?'accept':action);});
  };
  const form=root.querySelector<HTMLFormElement>('[data-cy=internal-call-dial-form]')!,submit=(event:Event)=>{event.preventDefault();const extension=String(new FormData(form).get('extension')??'');if(/^[1-9][0-9]{3}$/.test(extension))void this.operation(()=>this.place(extension));};
  root.addEventListener('click',click);form.addEventListener('submit',submit);const leave=()=>this.close();window.addEventListener('pagehide',leave);window.addEventListener('storage',leave);
  this.registerCleanup(()=>{root.removeEventListener('click',click);form.removeEventListener('submit',submit);window.removeEventListener('pagehide',leave);window.removeEventListener('storage',leave);});
  this.registerCleanup(()=>{clearTimeout(this.timer!);this.timer=null;this.session?.close();this.session=null;this.audio.pause();this.audio.srcObject=null;});this.draw();
 }
 private message(key:string){const el=this.root.querySelector('[data-cy=internal-call-status]');if(el)el.textContent=this.labels[key]??key;}
 private current(){this.assertOpen();if(sessionStorage.getItem('primecare_session')!==this.token){this.close();throw new InternalCallRequestError(401);}}
 private draw(){
  if(this.closed)return;const own=this.root.querySelector('[data-cy=internal-call-own]')!;own.textContent=this.self?`${this.labels.own}: ${this.self.extension} — ${this.labels[this.self.published?'published':'unpublished']}`:this.labels.unpublished;
  this.root.querySelector<HTMLElement>('[data-cy=internal-call-pending]')!.hidden=this.pending===null;
  const call=this.active?.call,remote=call&&(call.callerId===this.userId?call.recipientId:call.callerId),extension=this.directory.find(e=>e.userId===remote)?.extension??'';
  this.root.querySelector('[data-cy=internal-call-active]')!.textContent=call?`${extension} · ${this.labels[call.status==='accepted'?'accepted':call.status==='missed'?'missed':call.status==='ringing'?'ringing':'closed']}`:this.labels.empty;
  for(const button of this.root.querySelectorAll<HTMLButtonElement>('[data-call]')){const a=button.dataset.call;button.disabled=this.busy||a==='answer'&&(call?.status!=='ringing'||call.recipientId!==this.userId)||a==='decline'&&(call?.status!=='ringing'||call.recipientId!==this.userId)||a==='end'&&!call||a==='dial'&&!!call||a==='start'&&call?.status!=='accepted'||a==='mute'&&(!this.session||this.session.closed||!this.session.started);}
  this.root.querySelector('[data-cy=internal-call-directory]')!.innerHTML=this.directory.map(e=>`<p><strong>${escape(e.extension)}</strong></p>`).join('');
 }
 private async operation(work:()=>Promise<void>){if(this.busy||this.closed)return;this.busy=true;this.draw();try{this.current();await work();this.current();await this.refresh();}catch(error){this.session?.close();this.message(error instanceof InternalCallRequestError&&error.status===401?'login':this.pending?'unknown':'unavailable');}finally{this.busy=false;this.draw();}}
 async refreshDirectory(){const data=await this.client.directory() as any;this.current();if(data.userId!==this.userId)throw Error('Wrong session');this.self=data.self;this.directory=data.items;this.draw();}
 async start(){try{await this.refreshDirectory();await this.refresh();this.events.start();}finally{this.schedule();}}
 private schedule(){if(this.closed||this.timer)return;this.timer=setTimeout(()=>{this.timer=null;this.refresh().catch(()=>{}).finally(()=>this.schedule());},this.events.connected?Math.max(500,Math.min(10000,this.active?.call.status==='ringing'?this.active.call.expiresAt-Date.now():10000)):2000);}
 private pushed(){
  this.pushDirty=true;if(this.pushWork||this.closed)return;
  this.pushWork=(async()=>{while(this.pushDirty&&!this.closed){this.pushDirty=false;await this.refreshWork?.catch(()=>{});if(this.closed)break;await Promise.all([this.refresh(),this.session&&!this.session.closed?this.session.refresh():Promise.resolve()]);}})().catch(()=>{}).finally(()=>{this.pushWork=null;});
 }
 refresh(){if(this.refreshWork)return this.refreshWork;this.refreshWork=this.refreshOnce().finally(()=>{this.refreshWork=null;});return this.refreshWork;}
 private async refreshOnce(){if(this.polling||this.closed)return;this.polling=true;try{
  this.current();const data=await this.client.command({action:'inbox'}) as {items:View[]};this.current();
  const all=data.items.flatMap(view=>view.calls.map(call=>({view,call}))),active=all.filter(x=>['ringing','accepted'].includes(x.call.status));this.active=active.find(x=>x.call.recipientId===this.userId)??active[0]??null;
  this.root.querySelector('[data-cy=internal-call-history]')!.innerHTML=all.filter(x=>!['ringing','accepted'].includes(x.call.status)).sort((a,b)=>a.call.expiresAt-b.call.expiresAt).slice(-20).reverse().map(x=>`<li>${escape(this.labels[x.call.status==='missed'?'missed':'closed'])}</li>`).join('');
  if(this.session&&!this.session.closed&&this.active?.call.status==='accepted'&&Date.now()-this.lastHeartbeat>10000){this.lastHeartbeat=Date.now();try{await this.client.command({action:'heartbeat',id:this.active.view.id,callId:this.active.call.id});}catch(error){if(!(error instanceof InternalCallRequestError)||error.status!==409)throw error;}}
  if(this.pending&&all.some(x=>x.call.id==='call:'+this.pending!.requestId))this.pending=null;
  if(!this.active||this.preparedCall&&this.preparedCall!==this.active.call.id||this.session&&this.session.closed){this.session?.close();this.session=null;}this.draw();if(this.root.querySelector('[data-cy=internal-call-status]')?.textContent===this.labels.loading)this.message(this.active?.call.status==='accepted'?'accepted':this.active?'ringing':'ready');
  if(this.active?.call.status==='ringing'&&this.active.call.recipientId===this.userId&&this.notification!==this.active.call.id){this.notification=this.active.call.id;if('Notification'in window&&Notification.permission==='granted'&&document.hidden)new Notification(this.labels.ringing,{body:this.labels.title,tag:this.active.call.id});}
  if(this.active?.call.status==='ringing')this.prepareMedia();
  if(this.active?.call.status==='accepted'&&(!this.session||!this.session.started)&&!this.attempted.has(this.active.call.id))await this.startMedia();
 }catch(error){this.session?.close();this.session=null;this.message(error instanceof InternalCallRequestError&&error.status===401?'login':'unavailable');throw error;}finally{this.polling=false;}}
 private async place(extension:string){
  if(this.pending&&this.pending.extension!==extension)throw Error('Resolve original call');this.pending??={extension,requestId:crypto.randomUUID()};this.draw();
  let view:View;try{view=await this.client.dial(extension,this.pending.requestId) as View;}catch(error){if(error instanceof InternalCallRequestError&&[400,403,404,409].includes(error.status))this.pending=null;throw error;}this.current();this.pending=null;const call=view.calls.find(c=>c.callerId===this.userId&&['ringing','accepted'].includes(c.status));this.active=call?{view,call}:null;this.message('ringing');
 }
 private async callAction(action:string){
  const current=this.active;if(!current)return;if(action==='end'){this.session?.close();this.session=null;}
  let view=current.view;for(let attempt=0;attempt<2;attempt++){try{const updated=await this.client.command({action,id:view.id,key:crypto.randomUUID(),version:view.version,callId:current.call.id}) as View;this.current();if(action==='accept'&&updated.id===view.id&&Number.isSafeInteger(updated.version)){this.active={view:{...view,version:updated.version},call:{...current.call,status:'accepted'}};await this.startMedia();}return;}catch(error){if(!(error instanceof InternalCallRequestError)||error.status!==409||attempt===1)throw error;view=await this.client.read(current.view.id) as View;}}
 }
 private makeSession(current:{view:View;call:Call}){
  this.mediaStages=[];this.preparedCall=current.call.id;this.root.querySelector('[data-cy=internal-call-panel]')?.setAttribute('data-media-prepared','false');
  const session=new BrowserAudioSession({userId:this.userId,threadId:current.view.id,callId:current.call.id,transport:{execute:(_channel,input)=>this.client.command(input)},preparationProvider:async()=>await this.client.prepare(current.view.id,current.call.id) as any,onTiming:(stage,at)=>{if(this.mediaStages.length<80){this.mediaStages.push({stage,at});this.root.querySelector('[data-cy=internal-call-panel]')?.setAttribute('data-media-trace',JSON.stringify(this.mediaStages));}},configurationProvider:async()=>await this.client.media(current.view.id,current.call.id) as any,intervalMilliseconds:1000,onError:()=>this.message('unavailable'),media:{configuration:{iceServers:[],iceTransportPolicy:'relay'},getUserMedia:c=>navigator.mediaDevices.getUserMedia(c),createPeer:c=>new BatchedIcePeerConnection(c),onTrack:stream=>{this.audio.srcObject=stream;void this.audio.play().catch(()=>this.message('hear'));},onState:state=>{if(state==='closed'&&this.session===session)this.root.querySelector('[data-cy=internal-call-panel]')?.setAttribute('data-media-prepared','false');if(!this.closed&&(session.started||state!=='closed')){this.message(state==='connected'?'connected':state==='closed'?'closed':'accepted');this.draw();}}}});
  return session;
 }
 private prepareMedia(){
  if(this.closed||this.prepWork||this.session&&!this.session.closed||this.active?.call.status!=='ringing')return;
  const current=this.active,session=this.makeSession(current);this.session=session;
  this.prepWork=session.prepare().then(()=>{if(!this.closed&&!session.closed&&this.session===session)this.root.querySelector('[data-cy=internal-call-panel]')?.setAttribute('data-media-prepared','true');}).catch(()=>{session.close();if(this.session===session)this.session=null;}).finally(()=>{this.prepWork=null;});
 }
 async startMedia(){
  if(this.closed||this.starting||this.session?.started&&!this.session.closed||this.active?.call.status!=='accepted')return;const current=this.active;this.starting=true;this.message('accepted');this.attempted.add(current.call.id);
  if(this.prepWork)await this.prepWork;this.current();
  const session=this.session&&!this.session.closed&&this.preparedCall===current.call.id?this.session:this.makeSession(current);
  this.session=session;try{await session.start();this.current();}catch(error){session.close();if(this.session===session)this.session=null;this.message(error instanceof DOMException&&['NotAllowedError','SecurityError'].includes(error.name)?'permission':error instanceof InternalCallRequestError&&error.status===401?'login':'unavailable');}finally{this.starting=false;this.draw();}
 }
}
export async function renderInternalCalls(root:HTMLElement,gateway:string,context:Context){const token=sessionStorage.getItem('primecare_session');if(!token){location.assign('/login');return;}const panel=new InternalCallsPanel(root,gateway,token,context);try{await panel.start();}catch{root.querySelector('[data-cy=internal-call-status]')!.textContent=panel.labels.unavailable;}return panel;}
