import {Pool} from 'pg';
import {BoundedBinaryAdapterBase} from '../../../../packages/shared/src/communications/adapter-base.mjs';
import {sha256} from '../session-token.ts';
import {PostgresCallEventsSession} from './internal-call-events-policy.ts';
import {internalCallDatabaseOptions,type InternalCallDatabaseBinding} from './internal-call-database.ts';
import config from './internal-call-deployment.json' with {type:'json'};
type Socket=WebSocket&{serializeAttachment(value:unknown):void;deserializeAttachment():Attachment};
type Attachment={selectedUserId:string;expiresAt:number;hash?:string;tenantId?:string;lastInputAt?:number};
type State={acceptWebSocket(socket:Socket):void;getWebSockets():Socket[];storage:{setAlarm(at:number):Promise<void>;deleteAlarm():Promise<void>}};
type Environment={CALL_DATABASE:InternalCallDatabaseBinding};
type Runtime=typeof globalThis&{WebSocketPair:new()=>{0:Socket;1:Socket}};
export interface CallEventsNamespace {idFromName(name:string):unknown;get(id:unknown):{fetch(request:Request):Promise<Response>};}
export async function callEventsTarget(namespace:CallEventsNamespace,userId:string){return namespace.get(namespace.idFromName(await sha256(JSON.stringify(['internal-call-events-v1',userId]))));}
/** Per-user notification transport. PostgreSQL owns identity, grants and calls.
 * Attachments contain session hashes only. No SDP, call IDs or audio is sent. */
export class InternalCallEventsHub extends BoundedBinaryAdapterBase {
 private readonly busy=new WeakSet<Socket>();
 readonly state:State;readonly env:Environment;
 constructor(state:State,env:Environment){super(512);this.state=state;this.env=env;}
 protected async authorize(hash:string,userId:string){
  const pool=new Pool(internalCallDatabaseOptions(this.env.CALL_DATABASE));pool.on('error',()=>{});
  try{return await new PostgresCallEventsSession(pool).currentHash(hash,userId);}finally{await pool.end();}
 }
 private async schedule(){const times=this.state.getWebSockets().filter(s=>s.readyState===1).map(s=>s.deserializeAttachment()?.expiresAt).filter(Number.isFinite);if(times.length)await this.state.storage.setAlarm(Math.min(...times));else await this.state.storage.deleteAlarm();}
 private close(socket:Socket,code:number){try{socket.close(code,'Call events closed');}catch{}}
 async fetch(request:Request){
  const url=new URL(request.url);
  // Only the Worker binding can invoke this internal POST; the public route is GET.
  if(request.method==='POST'&&url.pathname==='/invalidate'){
   let kind='changed';if(request.body){const input=JSON.parse(new TextDecoder().decode(await this.readBoundedBody(request.body)));if(!input||Object.keys(input).join(',')!=='kind'||!['changed','signal'].includes(input.kind))return new Response(null,{status:400});kind=input.kind;}
   await Promise.all(this.state.getWebSockets().map(async socket=>{
    const a=socket.deserializeAttachment();if(!a?.hash||a.expiresAt<Date.now())return;
    try{const actor=await this.authorize(a.hash,a.selectedUserId);if(actor.tenantId!==a.tenantId)throw Error('Forbidden');socket.send(JSON.stringify({type:kind}));}catch{this.close(socket,4403);}
   }));return new Response(null,{status:204});
  }
  const userId=url.searchParams.get('userId');
  if(request.method!=='GET'||url.pathname!=='/v1/calls/events'||request.headers.get('upgrade')?.toLowerCase()!=='websocket')return new Response(null,{status:426});
  if(!config.appOrigins.includes(request.headers.get('origin')??'')||!userId||!/^[A-Za-z0-9][A-Za-z0-9_:.-]{0,199}$/.test(userId)||[...url.searchParams.keys()].some(k=>k!=='userId')||url.searchParams.getAll('userId').length!==1)return new Response(null,{status:403});
  const sockets=this.state.getWebSockets();for(const socket of sockets)if(socket.deserializeAttachment()?.expiresAt<Date.now())this.close(socket,4408);
  if(this.state.getWebSockets().filter(s=>s.readyState===1).length>=8)return new Response(null,{status:429});
  const pair=new (globalThis as Runtime).WebSocketPair();this.state.acceptWebSocket(pair[1]);pair[1].serializeAttachment({selectedUserId:userId,expiresAt:Date.now()+5000});await this.schedule();
  return new Response(null,{status:101,webSocket:pair[0]} as ResponseInit);
 }
 async webSocketMessage(socket:Socket,message:string|ArrayBuffer){
  if(this.busy.has(socket)){this.close(socket,1008);return;}
  const a=socket.deserializeAttachment();if(!a||a.expiresAt<Date.now()){this.close(socket,4408);return;}
  if(typeof message!=='string'||new TextEncoder().encode(message).length>this.maxBytes){this.close(socket,1009);return;}
  if(a.lastInputAt&&Date.now()-a.lastInputAt<1000){this.close(socket,1008);return;}
  this.busy.add(socket);try{
   const value=JSON.parse(message);let hash=a.hash;
   if(!hash){if(!value||Object.keys(value).sort().join(',')!=='token,type'||value.type!=='authenticate'||typeof value.token!=='string'||!/^[A-Za-z0-9_-]{43}$/.test(value.token))throw Error('Forbidden');hash=await sha256(value.token);}
   else if(!value||Object.keys(value).join(',')!=='type'||value.type!=='ping'){this.close(socket,1008);return;}
   const actor=await this.authorize(hash,a.selectedUserId);if(a.expiresAt<Date.now()||a.tenantId&&actor.tenantId!==a.tenantId)throw Error('Forbidden');
   socket.serializeAttachment({...a,hash,tenantId:actor.tenantId,expiresAt:Date.now()+60000,lastInputAt:Date.now()});socket.send(a.hash?'{"type":"pong"}':'{"type":"ready"}');await this.schedule();
  }catch{this.close(socket,4403);}finally{this.busy.delete(socket);}
 }
 async alarm(){for(const socket of this.state.getWebSockets())if(socket.deserializeAttachment()?.expiresAt<=Date.now())this.close(socket,4408);await this.schedule();}
 async webSocketClose(){await this.schedule();}
 async webSocketError(){await this.schedule();}
}
