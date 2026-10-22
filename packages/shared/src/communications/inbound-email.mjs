/** Cloudflare email() handler factory. No public HTTP endpoint, mailbox creation or auto reply. */
export function createInboundEmailHandler(service,maximumBytes) {
 if(!service||typeof service.receive!=='function'||!Number.isSafeInteger(maximumBytes)||maximumBytes<1)throw Error('Inbound adapters required');
 return async function email(message) {
  if(!Number.isSafeInteger(message.rawSize)||message.rawSize<1||message.rawSize>maximumBytes){message.setReject('Message size not permitted');return;}
  const reader=message.raw.getReader();const chunks=[];let size=0;
  try {
   for(;;){const {done,value}=await reader.read();if(done)break;size+=value.byteLength;
    if(size>maximumBytes){await reader.cancel();message.setReject('Message size not permitted');return;}chunks.push(value);}
  } finally {reader.releaseLock();}
  if(size!==message.rawSize){message.setReject('Message size mismatch');return;}
  const bytes=new Uint8Array(size);let offset=0;for(const chunk of chunks){bytes.set(chunk,offset);offset+=chunk.length;}
  // Storage/policy failures throw so the transport can retry; never acknowledge lost mail.
  await service.receive({from:message.from,to:message.to,raw:bytes});
 };
}
