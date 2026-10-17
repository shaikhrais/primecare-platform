import {registry,type BundleData,type AttentionData,type HistoryTarget,type BundleHistory} from '../../../../packages/shared/src/platform-bundle/contract';
export class BundleClient{
 private keys=new Map<string,string>();
 constructor(private gateway:string,private token:string){}
 private url(path:string){return this.gateway.replace(/\/+$/,'')+registry.endpoint+path;}
 async read(tenant:string,list:string,offset:number,search:string):Promise<BundleData>{
  return this.send((tenant?'/tenants/'+encodeURIComponent(tenant):'')+'?'+new URLSearchParams({list,offset:String(offset),search}));
 }
 async history(target:HistoryTarget,offset:number):Promise<BundleHistory>{return this.send('/tenants/'+encodeURIComponent(target.tenantId)+'/history?'+new URLSearchParams({kind:target.kind,offset:String(offset),...(target.ticketId?{ticketId:target.ticketId}:{})}));}
 async attention(offset:number,search:string,kind:string):Promise<AttentionData>{return this.send('/attention?'+new URLSearchParams({offset:String(offset),search,kind}));}
 async send(path:string,body?:Record<string,unknown>){
  const headers:Record<string,string>={authorization:'Bearer '+this.token};let signature='';
  if(body){headers['content-type']='application/json';signature=path+':'+[...new Uint8Array(await crypto.subtle.digest('SHA-256',new TextEncoder().encode(JSON.stringify(body))))].map(b=>b.toString(16).padStart(2,'0')).join('');headers['idempotency-key']=this.keys.get(signature)??crypto.randomUUID();this.keys.set(signature,headers['idempotency-key']);}
  const response=await fetch(this.url(path),{method:body?'POST':'GET',headers,cache:'no-store',...(body?{body:JSON.stringify(body)}:{})});
  if(response.status===401){sessionStorage.removeItem('primecare_session');location.assign('/login');}
  const data=await response.json();if(!response.ok){if(response.status<500)this.keys.delete(signature);throw Error(data.error??'failed');}this.keys.delete(signature);return data;
 }
 async download(tenant:string,id:string,filename:string){
  const response=await fetch(this.url('/tenants/'+encodeURIComponent(tenant)+'/documents/'+id+'/download'),{headers:{authorization:'Bearer '+this.token},cache:'no-store'});if(!response.ok)throw Error('failed');
  const url=URL.createObjectURL(await response.blob()),link=document.createElement('a');link.href=url;link.download=filename;link.click();setTimeout(()=>URL.revokeObjectURL(url),1000);
 }
}
export async function fileContent(file:File){
 if(!file||file.size>registry.maxFileBytes||file.size===0||!['application/pdf','image/png','image/jpeg'].includes(file.type))throw Error('cannot_upload');
 const bytes=new Uint8Array(await file.arrayBuffer());let binary='';for(let i=0;i<bytes.length;i+=8192)binary+=String.fromCharCode(...bytes.subarray(i,i+8192));return btoa(binary);
}
