import {test} from 'node:test';import assert from 'node:assert/strict';import {build} from 'esbuild';
const bundle=await build({entryPoints:['packages/primecare_ui/web/advanced-theme-tenant-control.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {mountTenantThemeMigration}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
// Minimal ownership/event port; browser execution remains in the integration lane.
function fixture(pending=false){
 const doc={createElement(){return {ownerDocument:doc,children:[],dataset:{},disabled:false,hidden:false,textContent:'',setAttribute(){},append(...nodes){for(const n of nodes){this.children.push(n);n.parent=this;}},contains(node){return this===node||this.children.some(c=>c.contains(node));},remove(){if(this.parent)this.parent.children=this.parent.children.filter(c=>c!==this);this.parent=null;}};}};
 const root=doc.createElement('div'),scope={tenantId:'t1',userId:'u1',role:'tenant_admin',dataset:'live'};
 const key='primecare-themes:v1:'+encodeURIComponent(JSON.stringify(['tenant-dashboard','live','t1','u1','tenant_admin']));
 const data=new Map([[key,JSON.stringify({version:1,active:null,items:[]})]]);let current=true,adoptions=0,saves=0,retries=0,hook=async()=>{},adoptHook=async()=>{};
 const client={binding:{scope,kind:'theme',resource:'advanced-v2'},current:{status:'clean',pending:pending?{action:'write'}:null,base:{revision:0},error:null},async adoptLocal(){adoptions++;await adoptHook();this.current.status='dirty';},async save(){saves++;this.current.status='clean';this.current.base.revision=1;},async retryPending(){retries++;await hook();this.current.pending=null;this.current.status='clean';this.current.base.revision=1;}};
 const dispose=mountTenantThemeMigration(root,client,{getItem:k=>data.get(k)??null,setItem:(k,v)=>data.set(k,v)},'en',()=>current);
 const section=root.children[0],find=name=>section.children.find(c=>c.dataset.cy==='theme-migration-'+name);
 return {root,section,find,dispose,set current(v){current=v;},set hook(v){hook=v;},set adoptHook(v){adoptHook=v;},get calls(){return {adoptions,saves,retries};}};
}
for(const action of ['save','retry'])for(const lost of ['stale','detached'])test(`${action} cannot mutate after host becomes ${lost}`,async()=>{
 const f=fixture(action==='retry');if(action==='save')f.find('review').onclick();
 if(lost==='stale')f.current=false;else f.section.remove();
 await f.find(action).onclick();assert.deepEqual(f.calls,{adoptions:0,saves:0,retries:0});f.dispose();
});
for(const outcome of ['success','failure'])test(`late retry ${outcome} cannot change a stale host`,async()=>{
 const f=fixture(true);let release;f.hook=()=>new Promise((resolve,reject)=>{release=outcome==='success'?resolve:()=>reject(Error('late failure'));});
 const retry=f.find('retry'),status=f.find('status'),work=retry.onclick();assert.equal(retry.disabled,true);const before=status.textContent;
 f.current=false;release();await work;assert.equal(retry.disabled,true);assert.equal(status.textContent,before);f.dispose();
});
test('current host still supports reviewed save and explicit pending retry',async()=>{
 const saved=fixture();saved.find('review').onclick();await saved.find('save').onclick();assert.deepEqual(saved.calls,{adoptions:1,saves:1,retries:0});assert.equal(saved.find('status').textContent,'Saved');saved.dispose();
 const retried=fixture(true);await retried.find('retry').onclick();assert.equal(retried.calls.retries,1);assert.equal(retried.find('retry').disabled,false);assert.equal(retried.find('status').textContent,'Saved');retried.dispose();
});

for(const lost of ['stale','disposed'])test(`mounted migration cannot start cloud save after ${lost} staging`,async()=>{
 const f=fixture();let release,started;const entered=new Promise(r=>started=r);f.adoptHook=()=>new Promise(r=>{release=r;started();});
 f.find('review').onclick();const saving=f.find('save').onclick();await entered;
 if(lost==='stale')f.current=false;else f.dispose();release();await saving;assert.deepEqual(f.calls,{adoptions:1,saves:0,retries:0});f.dispose();
});
