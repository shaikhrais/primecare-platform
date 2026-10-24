import type {VoiceRuntimePorts} from './voice-runtime.ts';
import type {RelaySocket} from '../../../../packages/shared/src/communications/twilio-relay-session.mjs';

type WorkerPair={0:RelaySocket;1:RelaySocket};
type WorkerPlatform={WebSocketPair:new()=>WorkerPair;Response:new(body:null,init:ResponseInit&{webSocket:unknown})=>Response};
/** Workers host port. Authentication and server.accept() stay owned by the
 * signed relay adapter. No global socket or cross-call state is retained. */
export function createCloudflareVoiceSockets(platform:WorkerPlatform):VoiceRuntimePorts['sockets']{
 if(typeof platform?.WebSocketPair!=='function'||typeof platform?.Response!=='function')throw Error('Cloudflare WebSocket runtime required');
 return Object.freeze({
  pair(){const pair=new platform.WebSocketPair();return {client:pair[0],server:pair[1]};},
  upgrade(client:unknown){return new platform.Response(null,{status:101,webSocket:client,headers:{'cache-control':'no-store'}});},
 });
}
