import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
const result=await build({entryPoints:['packages/primecare_ui/web/advanced-theme-tenant-restore.ts','packages/domain/src/advanced_theme.ts'],bundle:true,platform:'node',format:'esm',outdir:'out',write:false});
const load=async name=>import('data:text/javascript;base64,'+Buffer.from(result.outputFiles.find(f=>f.path.endsWith('/'+name+'.js')).text).toString('base64'));
const {TenantThemeRestoreReview}=await load('advanced-theme-tenant-restore');
const {defaultAdvancedTheme}=await load('advanced_theme');
function fixture(){
 const scope={tenantId:'tenant',userId:'user',role:'tenant_admin',dataset:'live'};
 const doc={version:2,active:defaultAdvancedTheme(),items:[]};
 return {async load(){},binding:{scope,kind:'theme',resource:'advanced-v2'},current:{loaded:true,status:'clean',dirty:false,pending:null,remote:null,base:{scope,revision:1,document:doc}}};
}
test('reviewed theme is returned only after explicit unchanged confirmation',async()=>{
 const client=fixture(),review=new TenantThemeRestoreReview(client),preview=review.prepare();
 assert.deepEqual(await review.confirm(preview.candidate,()=>({libraryAbsent:true,draftAbsent:true})),preview.candidate);
 await assert.rejects(review.confirm(preview.candidate,()=>({libraryAbsent:true,draftAbsent:true})),/review required/);
});
test('local changes, stale revisions, altered previews and wrong scopes are rejected',async()=>{
 for(const change of [c=>c.current.dirty=true,c=>c.current.pending={},c=>c.current.status='offline',c=>c.binding.scope.role='other',c=>c.current.base.scope={...c.binding.scope,userId:'other'}]){
  const c=fixture();change(c);assert.throws(()=>new TenantThemeRestoreReview(c).prepare());
 }
 for(const [library,draft] of [[false,true],[true,false]]){
  const review=new TenantThemeRestoreReview(fixture()),p=review.prepare();await assert.rejects(review.confirm(p.candidate,()=>({libraryAbsent:library,draftAbsent:draft})));
 }
 for(const change of [(c,p)=>c.current.base.revision++,(c,p)=>c.current.base.document.active.name='Other',(c,p)=>p.candidate.active.name='Other']){
  const c=fixture(),review=new TenantThemeRestoreReview(c),p=review.prepare();change(c,p);await assert.rejects(review.confirm(p.candidate,()=>({libraryAbsent:true,draftAbsent:true})));
 }
});

test('confirmation refreshes the server and checks local state after the refresh',async()=>{
 const c=fixture(),review=new TenantThemeRestoreReview(c),p=review.prepare();
 c.load=async()=>{c.current.base.revision++;};
 await assert.rejects(review.confirm(p.candidate,()=>({libraryAbsent:true,draftAbsent:true})),/changed/);
 const offline=fixture(),r2=new TenantThemeRestoreReview(offline),p2=r2.prepare();
 offline.load=async()=>{offline.current.status='offline';};
 await assert.rejects(r2.confirm(p2.candidate,()=>({libraryAbsent:true,draftAbsent:true})),/not ready/);
 const changed=fixture(),r3=new TenantThemeRestoreReview(changed),p3=r3.prepare();let localAbsent=true;
 changed.load=async()=>{localAbsent=false;};
 await assert.rejects(r3.confirm(p3.candidate,()=>({libraryAbsent:localAbsent,draftAbsent:true})),/Local theme/);
});

test('confirmation cannot complete after its host is disposed during a read',async()=>{
 const c=fixture(),review=new TenantThemeRestoreReview(c),p=review.prepare();
 c.load=async()=>{review.dispose();};
 await assert.rejects(review.confirm(p.candidate,()=>({libraryAbsent:true,draftAbsent:true})),/disposed/);
});
