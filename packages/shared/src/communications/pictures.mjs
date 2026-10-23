/** Shared private storage/scan boundary. Derived codecs never grant access. */
import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
export class PrivatePictureRepositoryBase extends BoundedBinaryAdapterBase {
 constructor({bucket,scan,maxPixels,maxBytes}) {
  super(maxBytes);
  if(typeof scan!=='function'||!bucket||['put','head','get'].some(method=>typeof bucket[method]!=='function')||!Number.isSafeInteger(maxPixels)||maxPixels<1||!Number.isSafeInteger(maxBytes)||maxBytes<1)throw Error('Picture adapters required');
  this.bucket=bucket;this.scan=scan;this.maxPixels=maxPixels;
 }
 async inspect(_bytes,_mediaType){throw Error('Picture codec required');}
 async encode(_bytes,_mediaType,_inspected){throw Error('Picture codec required');}
 async prepare(actor,threadId,bytes,mediaType) {
  this.validateBytes(bytes);
  if(!['image/png','image/jpeg'].includes(mediaType))throw Error('Invalid picture');
  if(typeof actor?.tenantId!=='string'||!actor.tenantId||typeof threadId!=='string'||!threadId)throw Error('Picture unavailable');
  // Own scope and bytes before provider work suspends or a scanner handles them.
  const tenantId=actor.tenantId;bytes=Uint8Array.from(bytes);
  const inspected=await this.inspect(bytes,mediaType);
  if(await this.scan(Uint8Array.from(bytes))!==true)throw Error('Picture scan failed');
  const output=Uint8Array.from(await this.encode(bytes,mediaType,inspected));
  this.validateBytes(output);
  if(await this.scan(Uint8Array.from(output))!==true)throw Error('Picture scan failed');
  const id=crypto.randomUUID();
  const record={id,tenantId,threadId,mediaType:'image/png',size:output.length,status:'clean'};
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

/** Existing Node codec, retaining its public constructor and private read behavior. */
export class PrivatePictureRepository extends PrivatePictureRepositoryBase {
 constructor(options){super(options);if(typeof options.sharp!=='function')throw Error('Picture adapters required');this.sharp=options.sharp;}
 async inspect(bytes,mediaType){
  const image=this.sharp(bytes,{limitInputPixels:this.maxPixels,failOn:'warning',animated:false});
  const metadata=await image.metadata();
  if(!['png','jpeg'].includes(metadata.format)||mediaType!==('image/'+metadata.format)||!metadata.width||!metadata.height||metadata.width*metadata.height>this.maxPixels||(metadata.pages??1)>1)throw Error('Invalid raster');
  return image;
 }
 async encode(_bytes,_mediaType,image){
  // Default output strips source metadata; do not keepMetadata/withMetadata.
  return image.rotate().png().toBuffer();
 }
}
