import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
export type VapiAgentRole='reception'|'new_enquiry'|'qualification'|'consultation'|'proposal'|'booking_recovery'|'onboarding'|'retention';
export type VapiGrowthToolKey='lead.lookup'|'lead.contact_preferences'|'lead.create'|'lead.advance'|'lead.followup'|'lead.suppress'|'lead.contact_update'|'consultation.create'|'consultation.update';
export type NativeGrowthToolOptions={
 agentKey:VapiAgentRole;
 /** Existing host-authenticated fetch; never a model-supplied credential. */
 fetch(url:string,request:RequestInit):Promise<Response>;
 currentScope():string|null;
 /** Server/native-host bindings, never function parameters. */
 leadId?:string;ownerId?:string;appointmentId?:string;search?:string;
};
export class VapiGrowthToolClient extends BoundedBinaryAdapterBase {
 constructor(options:NativeGrowthToolOptions);
 functionDefinitions():Array<{type:'function';function:{name:string;description:string;parameters:Record<string,unknown>}}>;
 executeFunction(name:string,input:Record<string,unknown>,operationId?:string):Promise<Readonly<Record<string,unknown>>>;
 execute(key:VapiGrowthToolKey,input?:Record<string,unknown>,operationId?:string):Promise<Readonly<Record<string,unknown>>>;
}
