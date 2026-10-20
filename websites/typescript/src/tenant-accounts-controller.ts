import {TenantAccountsClient,TenantAccountError,type AccountPage,type ReadMode,type ReadView} from './tenant-accounts-client';
export type ReadState={accounts:AccountPage;search:string;selected:string|null;mode:ReadMode;detail:ReadView;busy:boolean;error:''|'unavailable'|'forbidden'};
const empty=():AccountPage=>({users:[],assignableRoles:[],pagination:{limit:25,offset:0,total:0,hasMore:false}});
/** Owns request ordering; the panel only renders state and delegates actions. */
export class TenantAccountsController{
 private stopped=false;private serial=0;private listeners=new Set<(s:ReadState)=>void>();
 readonly state:ReadState={accounts:empty(),search:'',selected:null,mode:'details',detail:{rows:[],pagination:null},busy:false,error:''};
 constructor(private client:TenantAccountsClient){}
 subscribe(listener:(s:ReadState)=>void){this.listeners.add(listener);listener(this.state);return()=>this.listeners.delete(listener);}
 private notify(){if(!this.stopped)for(const fn of this.listeners)fn(this.state);}
 private async run(action:()=>Promise<void>){if(this.stopped||this.state.busy)return;const serial=++this.serial;this.state.busy=true;this.state.error='';this.notify();try{await action();}catch(error){if(serial===this.serial&&!this.stopped){this.state.accounts=empty();this.state.detail={rows:[],pagination:null};this.state.error=error instanceof TenantAccountError&&[401,403].includes(error.status)?'forbidden':'unavailable';}}finally{if(serial===this.serial&&!this.stopped){this.state.busy=false;this.notify();}}}
 async load(search=this.state.search,offset=0){await this.run(async()=>{const result=await this.client.list(search,offset);if(this.stopped)return;this.state.accounts=result;this.state.search=search;this.state.selected=null;this.state.detail={rows:[],pagination:null};});}
 async open(mode:ReadMode,userId:string,offset=0){await this.run(async()=>{const result=await this.client.read(mode,userId,offset);if(this.stopped)return;this.state.mode=mode;this.state.selected=userId;this.state.detail=result;});}
 previous(){return this.load(this.state.search,Math.max(0,this.state.accounts.pagination.offset-25));}
 next(){if(this.state.accounts.pagination.hasMore)return this.load(this.state.search,this.state.accounts.pagination.offset+25);}
 detailPage(direction:number){const p=this.state.detail.pagination;if(p&&this.state.selected&&(direction<0&&p.offset>0||direction>0&&p.hasMore))return this.open(this.state.mode,this.state.selected,Math.max(0,p.offset+direction*p.limit));}
 dispose(){this.stopped=true;this.serial++;this.listeners.clear();}
}
