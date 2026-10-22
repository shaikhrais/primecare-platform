/** Cloudflare email() handler factory. No public HTTP endpoint, mailbox creation or auto reply. */
import {BoundedBinaryAdapterBase,CommunicationInputError} from './adapter-base.mjs';
export class InboundEmailAdapter extends BoundedBinaryAdapterBase {
 constructor(service,maximumBytes) {
  super(maximumBytes);
  if(!service||typeof service.receive!=='function')throw Error('Inbound adapters required');
  this.service=service;
 }
 async receive(message) {
  let bytes;
  try{bytes=await this.readBoundedStream(message.raw,message.rawSize);}
  catch(error){if(error instanceof CommunicationInputError){message.setReject(error.message);return;}throw error;}
  await this.service.receive({from:message.from,to:message.to,raw:bytes});
 }
}
export function createInboundEmailHandler(service,maximumBytes) {
 const adapter=new InboundEmailAdapter(service,maximumBytes);
 return adapter.receive.bind(adapter);
}
