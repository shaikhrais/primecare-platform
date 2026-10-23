/** Node-side image adapter. Deployment must provide a scanner and private object storage. */
import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
export class PrivatePictureRepository extends BoundedBinaryAdapterBase {
 constructor({sharp,bucket,scan,maxPixels,maxBytes}) {
  super(maxBytes);
  if(typeof sharp!=='function'||typeof scan!=='function'||!bucket||['put','head','get'].some(method=>typeof bucket[method]!=='function')||!Number.isSafeInteger(maxPixels)||maxPixels<1||!Number.isSafeInteger(maxBytes)||maxBytes<1)throw Error('Picture adapters required');
  this.sharp=sharp;this.bucket=bucket;this.scan=scan;this.maxPixels=maxPixels;
 }
 async prepare(actor,threadId,bytes,mediaType) {
  this.validateBytes(bytes);
  if(!['image/png','image/jpeg'].includes(mediaType))throw Error('Invalid picture');
  const image=this.sharp(bytes,{limitInputPixels:this.maxPixels,failOn:'warning',animated:false});
  const metadata=await image.metadata();
  if(!['png','jpeg'].includes(metadata.format)||mediaType!==('image/'+metadata.format)||!metadata.width||!metadata.height||metadata.width*metadata.height>this.maxPixels||(metadata.pages??1)>1)throw Error('Invalid raster');
  if(await this.scan(bytes)!==true)throw Error('Picture scan failed');
  // Do not call withMetadata/keepMetadata. Default output strips EXIF and other source metadata.
  const output=await image.rotate().png().toBuffer();
  if(output.length>this.maxBytes)throw Error('Processed picture exceeds limit');
  if(await this.scan(output)!==true)throw Error('Picture scan failed');
  const id=crypto.randomUUID();
  const record={id,tenantId:actor.tenantId,threadId,mediaType:'image/png',size:output.length,status:'clean'};
  await this.bucket.put('private-pictures/'+id,output,{httpMetadata:{contentType:'image/png'},customMetadata:{record:JSON.stringify(record)}});
  return record;
 }
 validateId(id){if(typeof id!=='string'||!/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/.test(id))throw Error('Picture unavailable');}
 record(actor,id,object,threadId) {
  let record;try{record=JSON.parse(object?.customMetadata?.record);}catch{throw Error('Picture unavailable');}
  if(!record||record.id!==id||typeof actor?.tenantId!=='string'||!actor.tenantId||record.tenantId!==actor.tenantId||record.status!=='clean'||typeof record.threadId!=='string'||!record.threadId||threadId!==undefined&&record.threadId!==threadId||record.mediaType!=='image/png'||object.httpMetadata?.contentType!=='image/png'||!Number.isSafeInteger(record.size)||record.size<1||record.size>this.maxBytes||object.size!==record.size)throw Error('Picture unavailable');
  return Object.freeze({id:record.id,tenantId:record.tenantId,threadId:record.threadId,mediaType:record.mediaType,size:record.size,status:record.status});
 }
 async get(actor,id) {
  this.validateId(id);
  return this.record(actor,id,await this.bucket.head('private-pictures/'+id));
 }
 async open(actor,id,threadId) {
  this.validateId(id);
  if(typeof threadId!=='string'||!threadId)throw Error('Picture unavailable');
  const object=await this.bucket.get('private-pictures/'+id);
  try {
   // Validate the downloaded object itself, never a previous HEAD snapshot.
   this.record(actor,id,object,threadId);
   if(!object.body)throw Error('Picture unavailable');
   return object;
  }catch(error){
   try{if(typeof object?.body?.cancel==='function')await object.body.cancel();}catch{/* Preserve the authorization/validation error. */}
   throw error;
  }
 }
}
