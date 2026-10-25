import {CommunicationResourceBase} from './adapter-base.mjs';
/** Push invalidations only. Native HTTP reads still authorize all private state. */
export class BrowserCallEvents extends CommunicationResourceBase {
 constructor({gateway,userId,token,isCurrent,onChange,onStatus=()=>{},onDenied=()=>{},createSocket=url=>new WebSocket(url)}){
  super();const url=new URL(gateway);
  if(url.protocol!=='https:'||url.origin!==gateway||typeof userId!=='string'||!/^[A-Za-z0-9][A-Za-z0-9_:.-]{0,199}$/.test(userId)||typeof token!=='string'||!/^[A-Za-z0-9_-]{43}$/.test(token)||[isCurrent,onChange,onStatus,onDenied,createSocket].some(f=>typeof f!=='function'))throw Error('Call event adapters required');
  url.protocol='wss:';url.pathname='/v1/calls/events';url.searchParams.set('userId',userId);
  this.url=url.href;this.token=token;this.isCurrent=isCurrent;this.onChange=onChange;this.onStatus=onStatus;this.onDenied=onDenied;this.createSocket=createSocket;this.connected=false;this.attempt=0;this.socket=null;this.timer=null;this.authTimer=null;this.pingTimer=null;this.lastMessage=0;
  this.registerCleanup(()=>{clearTimeout(this.timer);clearTimeout(this.authTimer);clearInterval(this.pingTimer);this.timer=this.authTimer=this.pingTimer=null;const socket=this.socket;this.socket=null;socket?.close();this.connected=false;this.token='';this.onStatus(false);});
 }
 current(){if(this.closed)return false;if(this.isCurrent()!==true){this.close();this.onDenied();return false;}return true;}
 start(){if(!this.current()||this.socket||this.timer)return;this.connect();}
 connect(){
  if(!this.current())return;let socket;try{socket=this.createSocket(this.url);}catch{this.retry();return;}this.socket=socket;
  const live=()=>this.current()&&this.socket===socket;
  socket.onopen=()=>{if(!live())return;socket.send(JSON.stringify({type:'authenticate',token:this.token}));this.authTimer=setTimeout(()=>{if(this.socket===socket&&!this.connected)socket.close();},7000);};
  socket.onmessage=event=>{
   if(!live())return;let value;try{if(typeof event.data!=='string'||event.data.length>128)throw Error();value=JSON.parse(event.data);if(!value||Object.keys(value).join(',')!=='type'||!['ready','changed','pong','signal'].includes(value.type))throw Error();}catch{socket.close();return;}
   this.lastMessage=Date.now();if(value.type==='ready'){
    clearTimeout(this.authTimer);this.connected=true;this.attempt=0;this.onStatus(true);this.onChange('ready');
    clearInterval(this.pingTimer);this.pingTimer=setInterval(()=>{if(!live())return;if(Date.now()-this.lastMessage>45000){socket.close();return;}socket.send('{"type":"ping"}');},20000);
   }else if(this.connected&&['changed','signal'].includes(value.type))this.onChange(value.type);
  };
  socket.onerror=()=>socket.close();
  socket.onclose=event=>{if(this.socket!==socket)return;this.socket=null;this.connected=false;clearTimeout(this.authTimer);clearInterval(this.pingTimer);this.onStatus(false);if(this.closed)return;if([4401,4403].includes(event.code)){this.close();this.onDenied();return;}this.retry();};
 }
 retry(){if(!this.current()||this.timer)return;this.timer=setTimeout(()=>{this.timer=null;this.connect();},Math.min(10000,1000*2**Math.min(this.attempt++,4))+Math.floor(Math.random()*250));}
}
