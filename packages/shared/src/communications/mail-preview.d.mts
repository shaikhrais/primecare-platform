export type InboundMailPreview={status:'unavailable'}|{status:'available';text:string;subject?:string};
export interface InboundMailPreviewPort {project(rawBase64:unknown):Promise<InboundMailPreview>}
export class InboundMailTextPreview implements InboundMailPreviewPort {
 constructor(maximumBytes:number,options?:{parse:(bytes:Uint8Array,options:Record<string,unknown>)=>Promise<{text?:string;subject?:string}>});
 project(rawBase64:unknown):Promise<InboundMailPreview>;
}

export function boundedMailPreview(value:unknown,maximumBytes:number):InboundMailPreview;
