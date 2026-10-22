/** Node-side image adapter. Deployment must provide a scanner and private object storage. */
export class PrivatePictureRepository {
 constructor({sharp,bucket,scan,maxPixels,maxBytes}) {
  if(typeof sharp!=='function'||typeof scan!=='function'||!bucket||!Number.isSafeInteger(maxPixels)||maxPixels<1||!Number.isSafeInteger(maxBytes)||maxBytes<1)throw Error('Picture adapters required');
  this.sharp=sharp;this.bucket=bucket;this.scan=scan;this.maxPixels=maxPixels;this.maxBytes=maxBytes;
 }
 async prepare(actor,threadId,bytes,mediaType) {
  if(!(bytes instanceof Uint8Array)||!bytes.length||bytes.length>this.maxBytes||!['image/png','image/jpeg'].includes(mediaType))throw Error('Invalid picture');
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
 async get(actor,id) {
  if(typeof id!=='string'||!/^[0-9a-f-]{36}$/.test(id))throw Error('Picture unavailable');
  const object=await this.bucket.head('private-pictures/'+id);
  let record;try{record=JSON.parse(object?.customMetadata?.record);}catch{throw Error('Picture unavailable');}
  if(!record||record.id!==id||record.tenantId!==actor.tenantId||record.status!=='clean')throw Error('Picture unavailable');
  return record;
 }
 async open(actor,id) {
  await this.get(actor,id);
  const object=await this.bucket.get('private-pictures/'+id);
  if(!object)throw Error('Picture unavailable');
  return object;
 }
}
