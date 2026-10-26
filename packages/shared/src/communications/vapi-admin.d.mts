import {VapiManagementClient} from './vapi-management.mjs';
export type VapiAdminCapability={key:string;name:string;enabled:boolean;description:string;url:string;method:string;credentialId:string;body?:Record<string,unknown>};
export class VapiAdminClient extends VapiManagementClient {
 constructor(options:{apiKey:string;orgId:string;templateId:string;catalog?:VapiAdminCapability[];fetch?:typeof fetch});
 inventory():Promise<any>;
 createAgent(input:{name:string;firstMessage:string;prompt:string}):Promise<any>;
 createTool(key:string):Promise<any>;
 attach(assistantId:string,toolId:string,key:string,attached?:boolean):Promise<any>;
}
