/** Cloudflare email() handler factory. No public HTTP endpoint, mailbox creation or auto reply. */
import {BoundedBinaryAdapterBase,CommunicationInputError} from './adapter-base.mjs';
export class InboundEmailAdapter extends BoundedBinaryAdapterBase {
 constructor(service,maximumBytes) {
  super(maximumBytes);
  if(!service||typeof service.receive!=='function')throw Error('Inbound adapters required');
  this.service=service;
 }
 async receive(message) {
  // Bind the original SMTP envelope and rejection callback before reading can
  // suspend. MIME headers never select the owned mailbox.
  const {from,to,raw,rawSize}=message,reject=message.setReject.bind(message);
  let bytes;
  try{bytes=await this.readBoundedStream(raw,rawSize);}
  catch(error){if(error instanceof CommunicationInputError){reject(error.message);return;}throw error;}
  await this.service.receive({from,to,raw:bytes});
 }
}
export function createInboundEmailHandler(service,maximumBytes) {
 const adapter=new InboundEmailAdapter(service,maximumBytes);
 return adapter.receive.bind(adapter);
}
