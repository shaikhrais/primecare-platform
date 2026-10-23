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
  if(!Number.isSafeInteger(declaredSize)||declaredSize<1||declaredSize>this.maxBytes){
   // No reader is owned yet. Stop an unread rejected body without replacing the
   // public size error with provider cancellation details.
   try{await stream?.cancel?.();}catch{}
   throw new CommunicationInputError('Message size not permitted');
  }
  let reader;
  try{reader=stream.getReader();}catch{throw new CommunicationInputError('Invalid message stream');}
  let size=0,reads=0;
  try {
   const bytes=new Uint8Array(declaredSize);
   for(;;) {
    const {done,value}=await reader.read();if(done)break;
    // Nonempty chunks are bounded by declared bytes. Also allow 1,024 empty
    // chunks, then stop a producer that makes no bounded progress.
    if(++reads>declaredSize+1024)throw new CommunicationInputError('Message stream limit exceeded');
    if(!(value instanceof Uint8Array))throw new CommunicationInputError('Invalid message stream');
    if(size+value.length>this.maxBytes)throw new CommunicationInputError('Message size not permitted');
    if(size+value.length>declaredSize)throw new CommunicationInputError('Message size mismatch');
    // Producers may reuse a chunk buffer. Own its content before the next read.
    // One declared-size allocation also bounds bookkeeping for tiny/empty chunks.
    bytes.set(value,size);size+=value.length;
   }
   if(size!==declaredSize)throw new CommunicationInputError('Message size mismatch');
   return bytes;
  }catch(error){
   try{await reader.cancel();}catch{/* Preserve the original bounded-input error. */}
   throw error;
  }finally{reader.releaseLock();}
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
