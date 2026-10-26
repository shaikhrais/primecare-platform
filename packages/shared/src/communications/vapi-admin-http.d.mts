import type {VapiAdminClient} from './vapi-admin.mjs';
export function handleVapiAdmin(request:Request,ports:{client?:VapiAdminClient;authorize(operation:string):Promise<void>;claim(key:string,operation:string,body:unknown):Promise<{body:unknown;status:number}|null>;complete(key:string,result:unknown):Promise<void>}):Promise<Response>;
