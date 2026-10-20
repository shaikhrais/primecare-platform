import {SessionsClient,SessionRequestError,type SessionPage} from './sessions-client';
import policy from '../../../packages/shared/src/account-sessions.json';
export type SessionsState={busy:'loading'|'revoking'|null;message:'loading'|'revoking'|'load_failed'|'revoke_failed'|'changed'|null;confirming:boolean;page:SessionPage};
export type SessionEnvironment={current:()=>string|null;clear:()=>void;locale:()=>string;redirect:(url:string)=>void};
const browserEnvironment:SessionEnvironment={current:()=>sessionStorage.getItem('primecare_session'),clear:()=>sessionStorage.removeItem('primecare_session'),locale:()=>document.documentElement.lang,redirect:url=>location.assign(url)};
/** Coordinates session state and navigation independently of the presentation. */
export class SessionsController {
 private listeners=new Set<(state:SessionsState)=>void>();private disposed=false;
 private state:SessionsState={busy:null,message:null,confirming:false,page:{sessions:[],pagination:{limit:25,offset:0,total:0,hasMore:false}}};
 constructor(private readonly client:SessionsClient,private readonly env:SessionEnvironment=browserEnvironment){}
 get snapshot():SessionsState{return this.state;}
 subscribe(listener:(state:SessionsState)=>void){this.listeners.add(listener);listener(this.state);return()=>this.listeners.delete(listener);}
 dispose(){this.disposed=true;this.listeners.clear();}
 private update(patch:Partial<SessionsState>){if(this.disposed)return;this.state={...this.state,...patch};for(const listener of this.listeners)listener(this.state);}
 private leave(){
  if(this.env.current()!==this.client.token){this.update({busy:null,message:'changed',confirming:false,page:{sessions:[],pagination:{limit:25,offset:0,total:0,hasMore:false}}});return;}
  this.env.clear();const q=new URLSearchParams(),locale=this.env.locale();if(locale==='fr'||locale==='es')q.set('locale',locale);q.set('enable-semantics','true');this.env.redirect(policy.routes.login+'?'+q);
 }
 private fail(error:unknown,action:'load'|'revoke'){
  if(error instanceof SessionRequestError&&error.status===401){this.leave();return;}
  this.update({busy:null,message:error instanceof SessionRequestError&&error.status===409?'changed':action==='load'?'load_failed':'revoke_failed',confirming:action==='revoke',...(error instanceof SessionRequestError&&error.status===409?{page:{sessions:[],pagination:{limit:25,offset:0,total:0,hasMore:false}}}:{})});
 }
 async load(offset=this.state.page.pagination.offset){
  if(this.state.busy||this.disposed)return;this.update({busy:'loading',message:'loading',confirming:false});
  try{const page=await this.client.list(25,offset);this.update({page,busy:null,message:null});}catch(error){this.fail(error,'load');}
 }
 previous(){return this.load(Math.max(0,this.state.page.pagination.offset-25));}
 next(){if(this.state.page.pagination.hasMore)return this.load(this.state.page.pagination.offset+25);}
 requestRevoke(){if(!this.state.busy)this.update({confirming:true,message:null});}
 cancelRevoke(){if(!this.state.busy)this.update({confirming:false,message:null});}
 async confirmRevoke(){
  if(this.state.busy||!this.state.confirming||this.disposed)return;this.update({busy:'revoking',message:'revoking'});
  try{await this.client.revokeAll();this.leave();}catch(error){this.fail(error,'revoke');}
 }
}
