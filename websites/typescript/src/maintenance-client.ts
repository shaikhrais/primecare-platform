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
 protected rejectResponse(response:Response,value:unknown):never {if(response.status===401&&sessionStorage.getItem('primecare_session')===this.token)sessionStorage.removeItem('primecare_session');const error=this.errorData(value).error,key=catalog.serverMessages[String(error)] as keyof typeof catalog.locales.en|undefined;throw Error(key?this.text(key):this.text('failed'));}
 async identify(){const value=await this.requestJson(catalog.endpoints.identity,'GET') as MaintenanceIdentity;if(!value||!catalog.actorRoles.includes(value.roles)||typeof value.userId!=='string')throw Error(this.text('access'));this.identity=value;return value;}
 get canCreateMaintenance(){return !!this.identity&&catalog.creationActorRoles.includes(this.identity.roles);}
 async read(){
  const value=await this.requestJson(catalog.endpoints.configuration,'GET');
  const record=(item:unknown):item is Record<string,unknown>=>!!item&&typeof item==='object'&&!Array.isArray(item);
  const strings=(item:unknown):item is string[]=>Array.isArray(item)&&item.every(value=>typeof value==='string');
  const templateIds=Object.keys(this.controls).filter(key=>key.startsWith('template_')&&key.endsWith('_subject')).map(key=>key.slice('template_'.length,-'_subject'.length));
  if(!record(value)||typeof value.sender!=='string'||!['settingsReady','emailReady'].every(key=>typeof value[key]==='boolean')||!Number.isSafeInteger(value.revision)||Number(value.revision)<0||
   !record(value.templates)||Object.keys(value.templates).length!==templateIds.length||!templateIds.every(id=>Object.hasOwn(value.templates as object,id))||!Object.values(value.templates).every(item=>record(item)&&['subject','title','body'].every(key=>typeof item[key]==='string')&&strings(item.required))||
   !strings(value.pending)||!Array.isArray(value.externalConfiguration)||!value.externalConfiguration.every(item=>record(item)&&['name','value','instructions'].every(key=>typeof item[key]==='string'))||
   !Array.isArray(value.audit)||!value.audit.every(item=>record(item)&&typeof item.action==='string'&&typeof item.created_at==='string'))throw Error(this.text('failed'));
  return value as MaintenanceConfiguration;
 }
 private acknowledgement(value:unknown,message:keyof typeof catalog.serverMessages){
  if(value===null||typeof value!=='object'||Array.isArray(value)||this.errorData(value).message!==message)throw Error(this.text('failed'));
  return {message};
 }
 async save(value:unknown){return this.acknowledgement(await this.requestJson(catalog.endpoints.configuration,'POST',value),'Settings saved. Send a test email to check delivery.');}
 async testEmail(){return this.acknowledgement(await this.requestJson(catalog.endpoints.testEmail,'POST',{}),'Provider accepted the test. Check your inbox/spam to confirm delivery.');}
 async createAccount(email:unknown,password:unknown){return await this.requestJson(catalog.endpoints.createAccount,'POST',{email,password,role:catalog.creationRole}) as Record<string,unknown>;}
 async logout(){this.assertSession();await signOut(this.gateway,this.token);this.assertSession();sessionStorage.removeItem('primecare_session');}
}
