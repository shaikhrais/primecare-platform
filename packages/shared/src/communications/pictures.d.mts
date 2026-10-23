import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
export type PictureScope={tenantId:string};
export type PrivatePictureRecord={id:string;tenantId:string;threadId:string;mediaType:'image/png';size:number;status:'clean'};
export type PrivatePictureObject={size:number;httpMetadata?:{contentType?:string};customMetadata?:Record<string,string>;body?:unknown};
export interface PrivatePictureBucket {
 put(key:string,body:Uint8Array,options:{httpMetadata:{contentType:string};customMetadata:Record<string,string>}):Promise<unknown>;
 head(key:string):Promise<PrivatePictureObject|null>;
 get(key:string):Promise<PrivatePictureObject|null>;
}
export type PrivatePictureOptions={bucket:PrivatePictureBucket;scan:(bytes:Uint8Array)=>Promise<boolean>;maxPixels:number;maxBytes:number};
export class PrivatePictureRepositoryBase extends BoundedBinaryAdapterBase {
 constructor(options:PrivatePictureOptions);
 readonly bucket:PrivatePictureBucket;
 readonly maxPixels:number;
 readonly scan:PrivatePictureOptions['scan'];
 inspect(bytes:Uint8Array,mediaType:string):Promise<unknown>;
 encode(bytes:Uint8Array,mediaType:string,inspected?:unknown):Promise<Uint8Array>;
 prepare(actor:PictureScope,threadId:string,bytes:Uint8Array,mediaType:string):Promise<PrivatePictureRecord>;
 validateId(id:string):void;
 record(actor:PictureScope,id:string,object:PrivatePictureObject|null,threadId?:string):Readonly<PrivatePictureRecord>;
 get(actor:PictureScope,id:string):Promise<Readonly<PrivatePictureRecord>>;
 open(actor:PictureScope,id:string,threadId:string):Promise<PrivatePictureObject>;
}
export interface SharpPictureImage {
 metadata():Promise<{format?:string;width?:number;height?:number;pages?:number}>;
 rotate():{png():{toBuffer():Promise<Uint8Array>}};
}
export class PrivatePictureRepository extends PrivatePictureRepositoryBase {
 constructor(options:PrivatePictureOptions&{sharp:(bytes:Uint8Array,options:{limitInputPixels:number;failOn:'warning';animated:false})=>SharpPictureImage});
}
