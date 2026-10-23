import {PrivatePictureRepositoryBase} from './pictures.mjs';

const signature=[137,80,78,71,13,10,26,10];
const crcTable=Uint32Array.from({length:256},(_,n)=>{for(let k=0;k<8;k++)n=n&1?0xedb88320^(n>>>1):n>>>1;return n>>>0;});
function crc(bytes,start,end){let n=0xffffffff;for(let i=start;i<end;i++)n=crcTable[(n^bytes[i])&255]^(n>>>8);return (n^0xffffffff)>>>0;}
/** Container validation only. Actual decoding/re-encoding belongs to Images.
 * Reject animation; retain only pixel/transparency chunks in encoded output.
 */
export function boundedStaticPng(bytes,maxPixels,{stripMetadata=false}={}){
 if(!Number.isSafeInteger(maxPixels)||maxPixels<1)throw Error('Invalid raster');
 if(!(bytes instanceof Uint8Array)||bytes.length<45||!signature.every((v,i)=>bytes[i]===v))throw Error('Invalid raster');
 const view=new DataView(bytes.buffer,bytes.byteOffset,bytes.byteLength);
 const output=stripMetadata?new Uint8Array(bytes.length):null;
 if(output)output.set(signature);let written=8,offset=8,header=false,data=false,endedData=false,palette=false,transparency=false;
 while(offset+12<=bytes.length){
  const length=view.getUint32(offset),end=offset+12+length;
  if(end>bytes.length)throw Error('Invalid raster');
  const type=String.fromCharCode(...bytes.subarray(offset+4,offset+8));
  if(!/^[A-Za-z]{4}$/.test(type)||(type.charCodeAt(2)&32)||crc(bytes,offset+4,end-4)!==view.getUint32(end-4))throw Error('Invalid raster');
  if(!header&&type!=='IHDR'||['acTL','fcTL','fdAT'].includes(type))throw Error('Invalid raster');
  if(type==='IHDR'){
   if(header||offset!==8||length!==13)throw Error('Invalid raster');header=true;
   const width=view.getUint32(offset+8),height=view.getUint32(offset+12);
   if(!width||!height||!Number.isSafeInteger(width*height)||width*height>maxPixels)throw Error('Invalid raster');
  }else if(type==='IDAT'){if(endedData)throw Error('Invalid raster');data=true;}
  else{
   if(data)endedData=true;
   if(type==='PLTE'){if(palette||data||!length||length>768||length%3)throw Error('Invalid raster');palette=true;}
   if(type==='tRNS'){if(transparency||data||!length||length>256)throw Error('Invalid raster');transparency=true;}
   if(!['PLTE','IEND','tRNS'].includes(type)&&!(type.charCodeAt(0)&32))throw Error('Invalid raster');
  }
  const keep=['IHDR','PLTE','IDAT','IEND','tRNS'].includes(type);
  if(output&&keep){output.set(bytes.subarray(offset,end),written);written+=end-offset;}
  if(type==='IEND'){
   if(length!==0||!data||end!==bytes.length)throw Error('Invalid raster');
   return output?output.slice(0,written):bytes;
  }
  offset=end;
 }
 throw Error('Invalid raster');
}
const stream=bytes=>new ReadableStream({start(controller){controller.enqueue(Uint8Array.from(bytes));controller.close();}});

/** Native Workers Images codec and private R2-compatible storage. No public URL,
 * scan fallback, provider account creation or role-specific implementation.
 */
export class WorkersPrivatePictureRepository extends PrivatePictureRepositoryBase {
 constructor(options){
  super(options);
  if(!options.images||typeof options.images.info!=='function'||typeof options.images.input!=='function')throw Error('Picture adapters required');
  this.images=options.images;
 }
 async inspect(bytes,mediaType){
  if(mediaType==='image/png')boundedStaticPng(bytes,this.maxPixels);
  else if(bytes.length<3||bytes[0]!==255||bytes[1]!==216||bytes[2]!==255)throw Error('Invalid raster');
  let info;try{info=await this.images.info(stream(bytes));}catch{throw Error('Picture processing unavailable');}
  if(info?.format!==mediaType||!Number.isSafeInteger(info.width)||!Number.isSafeInteger(info.height)||info.width<1||info.height<1||!Number.isSafeInteger(info.width*info.height)||info.width*info.height>this.maxPixels||info.fileSize!==bytes.length)throw Error('Invalid raster');
 }
 async encode(bytes){
  let response;
  try{response=await (await this.images.input(stream(bytes)).output({format:'image/png',anim:false})).response();}
  catch{throw Error('Picture processing unavailable');}
  if(!response||response.status!==200||response.headers?.get('content-type')?.split(';')[0].trim().toLowerCase()!=='image/png'||!response.body){
   try{await response?.body?.cancel();}catch{}throw Error('Picture processing unavailable');
  }
  const declared=response.headers.get('content-length'),length=declared===null?null:Number(declared);
  if(declared!==null&&(!/^[0-9]+$/.test(declared)||!Number.isSafeInteger(length)||length<1||length>this.maxBytes)){
   try{await response.body.cancel();}catch{}throw Error('Processed picture exceeds limit');
  }
  const reader=response.body.getReader(),output=new Uint8Array(this.maxBytes);let size=0,reads=0;
  try{
   for(;;){
    const part=await reader.read();if(part.done)break;
    if(++reads>this.maxBytes+1||!(part.value instanceof Uint8Array)||size+part.value.length>this.maxBytes||length!==null&&size+part.value.length>length)throw Error('Processed picture exceeds limit');
    output.set(part.value,size);size+=part.value.length;
   }
   if(!size||length!==null&&size!==length)throw Error('Processed picture size mismatch');
   // Independent chunk filtering also protects against accidentally retained
   // EXIF/text/profile data in a provider result. Does not replace real decoding.
   return boundedStaticPng(output.slice(0,size),this.maxPixels,{stripMetadata:true});
  }catch(error){try{await reader.cancel();}catch{}throw error;}
  finally{reader.releaseLock();}
 }
}
