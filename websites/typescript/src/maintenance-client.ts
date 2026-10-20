import {BaseSessionClient} from './infrastructure/http/base-session-client';
import {signOut} from './auth-client';
import catalog from '../../../packages/shared/src/maintenance.json';

export type MaintenanceIdentity={userId:string;roles:string;status:string};
export type MaintenanceConfiguration={sender:string;settingsReady:boolean;emailReady:boolean;revision:number;templates:Record<string,{subject:string;title:string;body:string;required:string[]}>;pending:string[];externalConfiguration:{name:string;value:string;instructions:string}[];audit:{action:string;created_at:string}[]};
export class MaintenanceClient extends BaseSessionClient {
 protected readonly endpoint='';
 readonly locale:'en'|'fr'|'es';
 readonly controls=catalog.controls;
 private identity?:MaintenanceIdentity;
 constructor(gateway:string,token:string,locale:string){super(gateway.replace(/\/+$/,''),token);this.locale=locale==='fr'||locale==='es'?locale:'en';}
 text(key:keyof typeof catalog.locales.en){return catalog.locales[this.locale][key];}
 message(value:unknown){const key=catalog.serverMessages[String(value)] as keyof typeof catalog.locales.en|undefined;return key?this.text(key):String(value??'');}
 route(key:keyof typeof catalog.routes){return catalog.routes[key]+'?'+(key==='login'?'returnUrl='+encodeURIComponent(catalog.route)+'&':'')+'locale='+this.locale+'&enable-semantics=true';}
 templateControl(id:string,field:string){const key='template_'+id+'_'+field;const value=this.controls[key as keyof typeof this.controls];if(!value)throw Error(this.text('failed'));return value;}
 templateName(id:string){const key='template_'+id as keyof typeof catalog.locales.en;return this.text(key);}
 protected async requestJson(path:string,method:string,body?:unknown){try{return await super.requestJson(path,method,body);}catch(error){if(error instanceof TypeError||error instanceof SyntaxError)throw Error(this.text('cannotConnect'));throw error;}}
 protected accountChangedError(){return Error(this.text('changed'));}
 protected rejectResponse(_response:Response,value:unknown):never {const error=this.errorData(value).error,key=catalog.serverMessages[String(error)] as keyof typeof catalog.locales.en|undefined;throw Error(key?this.text(key):this.text('failed'));}
 async identify(){const value=await this.requestJson(catalog.endpoints.identity,'GET') as MaintenanceIdentity;if(!value||!catalog.actorRoles.includes(value.roles)||typeof value.userId!=='string')throw Error(this.text('access'));this.identity=value;return value;}
 get canCreateMaintenance(){return !!this.identity&&catalog.creationActorRoles.includes(this.identity.roles);}
 async read(){return await this.requestJson(catalog.endpoints.configuration,'GET') as MaintenanceConfiguration;}
 async save(value:unknown){return await this.requestJson(catalog.endpoints.configuration,'POST',value) as Record<string,unknown>;}
 async testEmail(){return await this.requestJson(catalog.endpoints.testEmail,'POST',{}) as Record<string,unknown>;}
 async createAccount(email:unknown,password:unknown){return await this.requestJson(catalog.endpoints.createAccount,'POST',{email,password,role:catalog.creationRole}) as Record<string,unknown>;}
 async logout(){this.assertSession();await signOut(this.gateway,this.token);this.assertSession();sessionStorage.removeItem('primecare_session');}
}
