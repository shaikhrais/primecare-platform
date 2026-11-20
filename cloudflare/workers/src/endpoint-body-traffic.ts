import type {EndpointAnalyticsDataset} from './endpoint-analytics';
import {endpointBucket} from './endpoint-traffic';
/** Count application response bytes as they are pulled, before gateway compression.
 * No cloning, buffering, caller identifiers or payload retention. Header request counts
 * stay in their original dataset; completion events cannot double-count requests.
 */
export function observeEndpointResponseBody(request:Request,response:Response,dataset?:EndpointAnalyticsDataset):Response {
 if(!dataset||response.status<200||response.headers.has('content-encoding')||/^text\/event-stream(?:;|$)/i.test(response.headers.get('content-type')??''))return response;
 const route=endpointBucket(request.method,new URL(request.url).pathname);
 let finished=false,bytes=0,overflow=false;
 const finish=(complete:boolean)=>{if(finished)return;finished=true;try{dataset.writeDataPoint({indexes:[route],blobs:[route,complete&&!overflow?'complete':'incomplete'],doubles:[bytes]});}catch{/* Observation must not fail a business response. */}};
 if(request.method==='HEAD'||!response.body){finish(true);return response;}
 let reader:ReadableStreamDefaultReader<Uint8Array>;
 try{reader=response.body.getReader();}catch{return response;}
 const release=()=>{try{reader.releaseLock();}catch{}};
 const stream=new ReadableStream<Uint8Array>({
  async pull(controller){
   try{
    const part=await reader.read();
    if(part.done){finish(true);release();controller.close();return;}
    if(!overflow){const total=bytes+part.value.byteLength;if(Number.isSafeInteger(total))bytes=total;else overflow=true;}
    controller.enqueue(part.value);
   }catch(error){finish(false);release();controller.error(error);}
  },
  async cancel(reason){finish(false);try{await reader.cancel(reason);}finally{release();}},
 },{highWaterMark:0});
 try{return new Response(stream,{status:response.status,statusText:response.statusText,headers:response.headers});}
 catch{release();return response;}
}
