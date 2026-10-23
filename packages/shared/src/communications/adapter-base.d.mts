export class CommunicationInputError extends Error {}
export class BoundedBinaryAdapterBase {
 constructor(maximumBytes:number);
 readonly maxBytes:number;
 validateBytes(bytes:Uint8Array):void;
 readBoundedStream(stream:ReadableStream<Uint8Array>,declaredSize:number):Promise<Uint8Array>;
}
export class CommunicationResourceBase {
 constructor();
 readonly closed:boolean;
 assertOpen():void;
 registerCleanup(cleanup:()=>void):void;
 close():unknown[];
 afterClose():void;
}
