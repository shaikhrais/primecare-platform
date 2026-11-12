import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
const bundle=await build({stdin:{contents:"export * from './packages/shared/src/shell-utilities/controller';export * from './packages/shared/src/preference-sync/client';",resolveDir:process.cwd()},bundle:true,platform:'node',format:'esm',write:false});
const api=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
const scope={tenantId:'t',userId:'u',role:'psw',dataset:'live'};
const item={id:'record1',title:'Notice',detail:'Owned content',read:false,status:'delivered'};
function make(ports,beforeCreate=()=>{},changed=()=>{}){
 const storage=new Map();
 const favourites=new api.PreferenceSyncClient({scope,kind:'shortcuts',resource:'navigation',policy:{panelIds:[],screenIds:[]}},async()=>{throw Error('No preference transport expected');},{read:async k=>storage.get(k)??null,write:async(k,v)=>{storage.set(k,v);},remove:async k=>storage.delete(k)},()=>crypto.randomUUID(),changed);
 beforeCreate(favourites);return new api.ShellUtilitiesController(scope,ports,favourites,[],()=>{});
}
test('class adapters retain prototype methods and private-state receiver',async()=>{
 class Notices {
  #read=false;#opened=[];
  async load(){return [{...item,read:this.#read}];}
  async markRead(id,read){this.#read=read;return {...item,id,read};}
  activate(id){this.#opened.push(id);}
  get opened(){return [...this.#opened];}
 }
 const port=new Notices(),c=make({notifications:port});
 try {
  assert.equal(c.canMarkRead('notifications'),true);
  assert.equal(c.canActivate('notifications'),true);
  await c.load('notifications');assert.equal(c.current.notifications.status,'ready');
  await c.markRead('notifications',item.id,true);assert.equal(c.current.notifications.items[0].read,true);
  c.activate('notifications',item.id);assert.deepEqual(port.opened,[item.id]);
 }finally{await c.dispose();}
});
test('captured object adapter keeps original receiver and callback identities',async()=>{
 const port={expected:null,calls:0,async load(){assert.equal(this,port.expected);this.calls++;return [item];}};
 port.expected=port;
 const c=make({notes:port});
 try {
  port.load=async()=>{throw Error('replacement must not be adopted');};
  await c.load('notes');assert.equal(c.current.notes.status,'ready');assert.equal(port.calls,1);
 }finally{await c.dispose();}
});
test('subscriber disposal before load dispatch makes no adapter call',async()=>{
 let calls=0;const c=make({notes:{load:async()=>{calls++;return [item];}}});
 c.subscribe(()=>{if(c.current.notes.busy)void c.dispose();});
 await c.load('notes');assert.equal(calls,0);assert.deepEqual(c.current.notes,{status:'unavailable',error:null,items:[],busy:false});
});
test('subscriber disposal before read receipt dispatch makes no mutation call',async()=>{
 let calls=0;const c=make({notifications:{load:async()=>[item],markRead:async(id,read)=>{calls++;return {...item,id,read};}}});
 await c.load('notifications');
 c.subscribe(()=>{if(c.current.notifications.busy)void c.dispose();});
 await c.markRead('notifications',item.id,true);assert.equal(calls,0);assert.deepEqual(c.current.notifications,{status:'unavailable',error:null,items:[],busy:false});
});

test('direct preference changes notify utilities without replacing the host callback',async()=>{
 let host=0,updates=0;const c=make({},()=>{},()=>host++),off=c.subscribe(()=>updates++);
 try{
  await c.favourites.load();assert.ok(updates>0);assert.ok(host>0);
  const before=updates,hostBefore=host;
  await c.favourites.edit({version:1,screenIds:[]});assert.ok(updates>before);assert.ok(host>hostBefore);
 }finally{off();await c.dispose();}
});
test('preference observer bridge is detached exactly once on controller disposal',async()=>{
 let subscribed=0,unsubscribed=0;
 const c=make({},pref=>{const original=pref.subscribe.bind(pref);pref.subscribe=listener=>{subscribed++;const off=original(listener);return()=>{unsubscribed++;off();};};});
 assert.equal(subscribed,1);await c.dispose();await c.dispose();assert.equal(unsubscribed,1);
});
