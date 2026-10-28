import {BaseSessionClient} from '../infrastructure/http/base-session-client';
import {renderDemoPSW} from './demo.mjs';
import {renderLivePSW} from './live';
import {pswStyles} from './styles';
export class PSWClient extends BaseSessionClient {
 protected endpoint='/v1/governance/care/workspace';
 constructor(gateway:string,token:string,readonly tenant=''){super(gateway,token);}
 protected accountChangedError(){return Error('Your account changed. Reload this workspace.');}
 protected rejectResponse(r:Response,v:unknown):never{if(r.status===401){sessionStorage.removeItem('primecare_session');location.assign('/login');}throw Error(String(this.errorData(v).error||'Workspace service unavailable. Refresh to confirm saved data.'));}
 async read(dataset='demo',extra:Record<string,string>={}){return this.requestJson('?'+new URLSearchParams({dataset,...(this.tenant?{tenant:this.tenant}:{}),...extra}),'GET');}
 async mutate(body:any){return this.requestJson('?'+new URLSearchParams({dataset:'demo',...(this.tenant?{tenant:this.tenant}:{})}),'POST',body);}
}
export async function renderPSW(root:HTMLElement,gateway:string){
 const token=sessionStorage.getItem('primecare_session');if(!token){location.assign('/login');return;}
 if(!document.getElementById('psw-workspace-styles')){const style=document.createElement('style');style.id='psw-workspace-styles';style.textContent=pswStyles;document.head.append(style);}
 root.innerHTML='<main class="main" role="status"><h1>Loading care workspace…</h1><p>Reading authorized records from PostgreSQL.</p></main>';
 const params=new URLSearchParams(location.search),api=new PSWClient(gateway,token,params.get('tenant')||'');
 try{const info=await api.read('info'),dataset=params.get('dataset')||(info.liveCareAvailable?'live':'demo');
  if(dataset==='live'){if(!info.liveCareAvailable)throw Error('A clinical or care-operations account is required for live care records. Use the database demo from administration.');await renderLivePSW(root,gateway,api,info);}
  else if(dataset==='demo')await renderDemoPSW(root,gateway,await api.read('demo'),api);
  else throw Error('Choose the live or demo dataset.');
 }catch(e){root.innerHTML='<main class="main"><h1>Care workspace unavailable</h1><p role="alert"></p><button data-retry>Retry</button> <a href="/success">Account</a> <a href="/psw?dataset=demo">Database demo</a></main>';root.querySelector('[role=alert]')!.textContent=(e as Error).message;root.querySelector('[data-retry]')!.addEventListener('click',()=>void renderPSW(root,gateway));}
}
