/** Bounded response decoding. Actor/session and cancellation checks remain owned by each caller. */
export async function guardedJson(response:Response,maxBytes:number,guard:()=>void,invalid:()=>Error,signal?:AbortSignal):Promise<unknown> {
 let reader:ReadableStreamDefaultReader<Uint8Array>|undefined;
 const abort=()=>{void reader?.cancel().catch(()=>{});};
 try {
  guard();
  const length=response.headers.get('content-length');
  if(!Number.isSafeInteger(maxBytes)||maxBytes<1||maxBytes>1048576||length!==null&&(!/^\d+$/.test(length)||Number(length)>maxBytes)||!response.body)throw invalid();
  reader=response.body.getReader();signal?.addEventListener('abort',abort,{once:true});if(signal?.aborted)abort();const chunks:Uint8Array[]=[];let size=0;
  while(true){guard();const part=await reader.read();guard();if(part.done)break;size+=part.value.byteLength;if(size>maxBytes)throw invalid();chunks.push(part.value);}
  const bytes=new Uint8Array(size);let offset=0;for(const chunk of chunks){bytes.set(chunk,offset);offset+=chunk.byteLength;}
  let raw:unknown;try{raw=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(bytes));}catch{throw invalid();}
  guard();return raw;
 }catch(error){guard();throw error;}
 finally{
  signal?.removeEventListener('abort',abort);
  // Stream cancellation is best-effort: an uncooperative source must never
  // delay an already determined denial or successful bounded decode.
  if(reader){
   try{void reader.cancel().catch(()=>{});}catch{}
   try{reader.releaseLock();}catch{}
  }else if(response.body){
   try{void response.body.cancel().catch(()=>{});}catch{}
  }
  // A detached cancellation may synchronously schedule an ownership change.
  // Let already-queued cleanup continuations run, without awaiting cancellation.
  await Promise.resolve();
  guard();
 }
}
