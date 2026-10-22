/** Cross-platform adapter bases. No DOM, database, role or provider dependency. */
export class CommunicationInputError extends Error {}

export class BoundedBinaryAdapterBase {
 constructor(maximumBytes) {
  if(!Number.isSafeInteger(maximumBytes)||maximumBytes<1)throw Error('Invalid binary limit');
  this.maxBytes=maximumBytes;
 }
 validateBytes(bytes) {
  if(!(bytes instanceof Uint8Array)||!bytes.length||bytes.length>this.maxBytes)throw new CommunicationInputError('Message size not permitted');
 }
 async readBoundedStream(stream,declaredSize) {
  if(!Number.isSafeInteger(declaredSize)||declaredSize<1||declaredSize>this.maxBytes)throw new CommunicationInputError('Message size not permitted');
  const reader=stream.getReader();const chunks=[];let size=0;
  try {
   for(;;) {
    const {done,value}=await reader.read();if(done)break;
    if(!(value instanceof Uint8Array))throw new CommunicationInputError('Invalid message stream');
    size+=value.length;
    if(size>this.maxBytes){await reader.cancel();throw new CommunicationInputError('Message size not permitted');}
    chunks.push(value);
   }
  }finally{reader.releaseLock();}
  if(size!==declaredSize)throw new CommunicationInputError('Message size mismatch');
  const bytes=new Uint8Array(size);let offset=0;for(const chunk of chunks){bytes.set(chunk,offset);offset+=chunk.length;}
  return bytes;
 }
}

/** Own cleanup once, including resources that arrive after a pending operation was closed. */
export class CommunicationResourceBase {
 constructor(){this.closed=false;this.cleanups=[];}
 assertOpen(){if(this.closed)throw Error('Communication resource closed');}
 registerCleanup(cleanup) {
  if(typeof cleanup!=='function')throw Error('Cleanup required');
  if(this.closed)cleanup();else this.cleanups.push(cleanup);
 }
 close() {
  if(this.closed)return [];
  this.closed=true;const errors=[];
  for(const cleanup of this.cleanups.reverse()){try{cleanup();}catch(error){errors.push(error);}}
  this.cleanups=[];this.afterClose();return errors;
 }
 afterClose(){}
}
