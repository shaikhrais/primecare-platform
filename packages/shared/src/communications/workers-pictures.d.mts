import {PrivatePictureRepositoryBase,type PrivatePictureOptions} from './pictures.mjs';
export interface WorkersImagesBinding {
 info(input:ReadableStream<Uint8Array>):Promise<{format:string;width?:number;height?:number;fileSize?:number}>;
 input(input:ReadableStream<Uint8Array>):{output(options:{format:'image/png';anim:false}):Promise<{response():Response|Promise<Response>}>};
}
export function boundedStaticPng(bytes:Uint8Array,maxPixels:number,options?:{stripMetadata?:boolean}):Uint8Array;
export class WorkersPrivatePictureRepository extends PrivatePictureRepositoryBase {
 constructor(options:PrivatePictureOptions&{images:WorkersImagesBinding});
 readonly images:WorkersImagesBinding;
}
