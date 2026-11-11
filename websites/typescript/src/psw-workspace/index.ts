import {renderPersonal} from '../psw-personal';
import {BaseSessionClient} from '../infrastructure/http/base-session-client';
import {ownCareRoute,type CareOwnership} from '../care/ownership';
import {renderDemoPSW} from './demo.mjs';
import {renderLivePSW} from './live';
import {pswStyles} from './styles';
import {demoSnapshot,demoScope} from './demo-snapshot';
export class PSWClient extends BaseSessionClient {
 protected endpoint='/v1/governance/care/workspace';
 constructor(gateway:string,token:string,readonly tenant=''){super(gateway,token);}
 protected accountChangedError(){return Error('Your account changed. Reload this workspace.');}
 protected rejectResponse(r:Response,v:unknown):never{if(r.status===401){sessionStorage.removeItem('primecare_session');location.assign('/login');}throw Error(String(this.errorData(v).error||'Workspace service unavailable. Refresh to confirm saved data.'));}
 async read(dataset='demo',extra:Record<string,string>={}){return this.requestJson('?'+new URLSearchParams({dataset,...(this.tenant?{tenant:this.tenant}:{}),...extra}),'GET');}
 async mutate(body:any){return this.requestJson('?'+new URLSearchParams({dataset:'demo',...(this.tenant?{tenant:this.tenant}:{})}),'POST',body);}
}
// Managed renderers keep authentication effects with the current route owner.
class LiveWorkspaceClient extends PSWClient {
 protected rejectResponse(r:Response,v:unknown):never{throw Object.assign(Error(String(this.errorData(v).error||'Workspace service unavailable. Refresh to confirm saved data.')),{status:r.status});}
}
// Receipts live only for this authenticated route owner and are released only
// after a valid, advancing snapshot has been successfully published.
class ManagedDemoClient extends LiveWorkspaceClient {
 private readonly receipts=new Map<string,{result:any;version:number}>();
 private identity:string;
 constructor(gateway:string,token:string,tenant:string,private owner:CareOwnership,info:any){super(gateway,token,tenant);this.identity=demoScope({...info,dataset:'demo'});owner.onDispose(()=>this.receipts.clear());}
 private accept(value:any){demoSnapshot(value);if(demoScope(value)!==this.identity)throw Object.assign(Error('Demo workspace changed. Reload your workspace.'),{status:403});return value;}
 private reflected(value:any,receipt:{result:any;version:number}){const ack=receipt.result;return demoScope(ack)===this.identity&&demoScope(value)===this.identity&&Number.isSafeInteger(receipt.version)&&receipt.version>0&&Number.isSafeInteger(ack?.version)&&ack.version>receipt.version&&Number.isSafeInteger(value?.version)&&value.version>=ack.version;}
 confirmSnapshot(value:any){if(!this.owner.current())return;for(const[key,receipt]of this.receipts)if(this.reflected(value,receipt))this.receipts.delete(key);}
 async read(dataset='demo',extra:Record<string,string>={}){if(!this.owner.current())throw Error('Demo renderer is no longer current');return this.accept(await super.read(dataset,extra));}
 async mutate(body:any){
  if(!this.owner.current())throw Error('Demo renderer is no longer current');const key=JSON.stringify(body),receipt=this.receipts.get(key);
  if(this.receipts.size){const snapshot=await this.read();if(!receipt||!this.reflected(snapshot,receipt))throw Error('Refresh to confirm the previous database save before another change.');return snapshot;}
  const result=await super.mutate(body),accepted={result,version:body.version};this.receipts.set(key,accepted);
  const snapshot=this.accept(result);if(!this.reflected(snapshot,accepted))throw Error('Refresh to confirm the previous database save before another change.');return snapshot;
 }
}
export async function renderPSW(root:HTMLElement,gateway:string){
 const owner=ownCareRoute(root);if(!owner.current())return;
 const token=owner.token;if(!token){owner.dispose();root.replaceChildren();location.assign('/login?enable-semantics=true');return;}
 if(!document.getElementById('psw-workspace-styles')){const style=document.createElement('style');style.id='psw-workspace-styles';style.textContent=pswStyles;document.head.append(style);}
 if(!owner.publish(()=>{root.innerHTML='<main class="main" role="status"><h1>Loading care workspace…</h1><p>Reading authorized records from PostgreSQL.</p></main>';}))return;
 const params=new URLSearchParams(location.search),api=new LiveWorkspaceClient(gateway,token,params.get('tenant')||'');
 try{
  const info=await api.read('info');await owner.whenActive();if(!owner.current())return;
  const dataset=params.get('dataset')||(info.liveCareAvailable?'live':'demo');
  if(params.get('experience')==='personal'||['psw','hsw'].includes(info.identity.role)){
   await renderPersonal(root,gateway,token,dataset,params.get('tenant')||'',owner);
  }else if(dataset==='live'){
   if(!info.liveCareAvailable)throw Error('A clinical or care-operations account is required for live care records. Use the database demo from administration.');
   await renderLivePSW(root,gateway,api,info,owner);
  }else if(dataset==='demo'){
   const demo=new ManagedDemoClient(gateway,token,params.get('tenant')||'',owner,info),data=await demo.read();await owner.whenActive();if(!owner.current())return;
   await renderDemoPSW(root,gateway,data,demo,owner);
  }else throw Error('Choose the live or demo dataset.');
 }catch(error){await owner.whenActive();if(owner.current())careUnavailable(root,gateway,error,owner);}
}
export function careUnavailable(root:HTMLElement,gateway:string,error:unknown,owner?:CareOwnership){
 if(owner&&!owner.current())return;
 if(owner&&(error as {status?:number}).status===401){owner.unauthorized();return;}
 const draw=()=>{root.innerHTML='<main class="main"><h1>Care workspace unavailable</h1><p role="alert"></p><button data-retry>Retry</button> <a href="/success">Account</a> <a href="/psw?dataset=demo">Database demo</a></main>';root.querySelector('[role=alert]')!.textContent=(error as Error).message;root.querySelector<HTMLButtonElement>('[data-retry]')!.onclick=()=>void renderPSW(root,gateway);};
 if(owner){owner.dispose();const errorOwner=ownCareRoute(root);if(errorOwner.current()){errorOwner.publish(draw);errorOwner.bind();}}else draw();
}
