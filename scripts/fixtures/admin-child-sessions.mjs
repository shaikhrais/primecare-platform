import {build} from 'esbuild';
import {webcrypto} from 'node:crypto';
import {readFileSync} from 'node:fs';
export const token='synthetic-old-session';
export const filters={search:'A & B',filter:'attention',offset:25};
export const deferred=()=>{let resolve,reject;const promise=new Promise((yes,no)=>{resolve=yes;reject=no;});return {promise,resolve,reject};};
export const tick=()=>new Promise(resolve=>setImmediate(resolve));
export const flush=async(ready=()=>true)=>{
 for(let i=0;i<12;i++)await tick();
 const deadline=Date.now()+2000;
 while(!ready()){if(Date.now()>=deadline)throw Error('Timed out waiting for actual controller work to settle');await new Promise(resolve=>setTimeout(resolve,1));}
};
export const operationsRegistry=JSON.parse(readFileSync('packages/shared/src/tenant-operations.json','utf8'));
export const territoryRegistry=JSON.parse(readFileSync('packages/shared/src/territories/registry.json','utf8'));
const geometry=JSON.parse(readFileSync('packages/shared/src/territories/map.json','utf8'));
export const areaId=geometry.pieces[0].id;
export const overview=()=>({scope:'global',source:operationsRegistry.source,tenants:[{id:'fixture-tenant',name:'Fixture tenant',slug:'fixture',status:'active',counts:{accounts:1,administrators:1,locations:1,categories:1,territories:1,seniors65:1},checks:[],issues:[],actions:['accounts','masters','territories']}],summary:{total:1,active:1,inactive:0,attention:0,territories:1,seniors65:1},pagination:{offset:0,limit:25,total:50,hasMore:true}});
export const board=()=>({canManage:true,source:territoryRegistry.source,territories:[{id:areaId,number:1,code:'FIXTURE',name:'Fixture area',fsas:[],seniors65:1,population:2,status:'available',canSell:true,version:1,allocation:null}],tenants:[{id:'fixture-tenant',name:'Fixture tenant',slug:'fixture'}],summary:{available:{count:1,seniors65:1},sold:{count:0,seniors65:0},reserve:{count:0,seniors65:0}}});
export const sale={version:1,tenantId:'fixture-tenant',services:['psw'],reference:'Fixture reference',confirmed:true};
export function setup(){
 const values=new Map([['primecare_session',token]]),requests=[],redirects=[];
 const env={values,requests,redirects,handler:async()=>Response.json({ok:true})};
 Object.assign(globalThis,{sessionStorage:{getItem:k=>values.get(k)??null,setItem:(k,v)=>values.set(k,String(v)),removeItem:k=>values.delete(k)},location:{assign:p=>redirects.push(p)},fetch:async(url,options)=>{requests.push({url:String(url),options});return env.handler(url,options);},FormData:class {constructor(form){this.values=form.fields??{};}get(k){return this.values[k]??null;}has(k){return Object.hasOwn(this.values,k);}},ResizeObserver:class {observe(){}disconnect(){}},document:{createElement:()=>new Element()}});
 Object.defineProperty(globalThis,'crypto',{value:webcrypto,configurable:true});
 return env;
}
// A deliberately small DOM peripheral. Production HTML and all handlers are real;
// layout, event dispatch, and form extraction are synthetic, not browser acceptance.
export class Element {
 constructor(){this.controls=[];this.attrs={};this.dataset={};this.style={};this.isConnected=true;this.value='';this.disabled=false;this.fields={};this.renderCount=0;this.ownerDocument=globalThis.document;}
 setAttribute(k,v){this.attrs[k]=String(v);}getAttribute(k){return this.attrs[k]??null;}hasAttribute(k){return Object.hasOwn(this.attrs,k);}removeAttribute(k){delete this.attrs[k];}focus(){}append(){}replaceChildren(){this.innerHTML="";}remove(){this.isConnected=false;}getScreenCTM(){return null;}getBoundingClientRect(){return {width:0};}contains(el){return el===this||this.controls.includes(el);}
 set innerHTML(html){this.html=html;this.renderCount++;for(const el of this.controls)el.isConnected=false;this.controls=[];
  for(const match of html.matchAll(/<([\w-]+)\b([^>]*)>/g)){const el=new Element();el.tagName=match[1];el.parentElement=this;
   for(const a of match[2].matchAll(/([\w-]+)(?:=(?:"([^"]*)"|'([^']*)'|([^\s>]+)))?/g)){const value=a[2]??a[3]??a[4]??'';el.attrs[a[1]]=value;if(a[1].startsWith('data-'))el.dataset[a[1].slice(5).replace(/-([a-z])/g,(_,c)=>c.toUpperCase())]=value;if(a[1]==='value')el.value=value;}
   this.controls.push(el);
  }
 }
 get innerHTML(){return this.html??'';}
 querySelector(selector){if(selector.endsWith(' h3'))return this.controls.find(e=>e.tagName==='h3')??null;return this.querySelectorAll(selector)[0]??null;}
 querySelectorAll(selector){if(selector.includes(','))return this.controls.filter(e=>selector.split(',').includes(e.tagName));const match=selector.match(/^\[([^=\]]+)(?:=["']?([^\]"']+)["']?)?\]$/);if(match)return this.controls.filter(e=>Object.hasOwn(e.attrs,match[1])&&(match[2]===undefined||e.attrs[match[1]]===match[2]));return this.controls.filter(e=>e.tagName===selector);}
}
export const control=(root,cy)=>{const el=root.querySelector(`[data-cy=${cy}]`);if(!el)throw Error('Missing actual panel control '+cy);return el;};
export const click=el=>el.onclick?.({currentTarget:el,preventDefault(){}});
export const submit=el=>el.onsubmit?.({currentTarget:el,preventDefault(){}});
export function fillSale(root){const form=control(root,'territory-form');form.fields={tenantId:sale.tenantId,reference:sale.reference,psw:'on',confirmed:'on'};form.oninput?.();return form;}
export async function runtime(){const built=await build({stdin:{contents:`export {OperationsClient} from './websites/typescript/src/tenant-operations/client';export {OperationsController} from './websites/typescript/src/tenant-operations/controller';export {TerritoryClient} from './websites/typescript/src/territories/client';export {TerritoryController} from './websites/typescript/src/territories/controller';`,resolveDir:process.cwd()},bundle:true,write:false,format:'esm',platform:'node'});return import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text+'\n//# sourceURL=admin-child-sessions-runtime.mjs').toString('base64'));}
