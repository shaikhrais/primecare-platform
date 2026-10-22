export interface InboundEmailMessage {
 from:string;
 to:string;
 raw:ReadableStream<Uint8Array>;
 rawSize:number;
 setReject(reason:string):void;
}
export interface InboundMailService {
 receive(envelope:{from:string;to:string;raw:Uint8Array}):Promise<unknown>;
}
export class InboundEmailAdapter {
 constructor(service:InboundMailService,maximumBytes:number);
 receive(message:InboundEmailMessage):Promise<void>;
}
export function createInboundEmailHandler(service:InboundMailService,maximumBytes:number):(message:InboundEmailMessage)=>Promise<void>;
