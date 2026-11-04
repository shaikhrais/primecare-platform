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
 return {binding:{scope,kind:'theme',resource:'advanced-v2'},current:{loaded:true,status:'clean',dirty:false,pending:null,remote:null,base:{scope,revision:1,document:doc}}};
}
test('reviewed theme is returned only after explicit unchanged confirmation',()=>{
 const client=fixture(),review=new TenantThemeRestoreReview(client),preview=review.prepare();
 assert.deepEqual(review.confirm(preview.candidate,true,true),preview.candidate);
 assert.throws(()=>review.confirm(preview.candidate,true,true),/resolution/);
});
test('local changes, stale revisions, altered previews and wrong scopes are rejected',()=>{
 for(const change of [c=>c.current.dirty=true,c=>c.current.pending={},c=>c.current.status='offline',c=>c.binding.scope.role='other',c=>c.current.base.scope={...c.binding.scope,userId:'other'}]){
  const c=fixture();change(c);assert.throws(()=>new TenantThemeRestoreReview(c).prepare());
 }
 for(const [library,draft] of [[false,true],[true,false]]){
  const review=new TenantThemeRestoreReview(fixture()),p=review.prepare();assert.throws(()=>review.confirm(p.candidate,library,draft));
 }
 for(const change of [(c,p)=>c.current.base.revision++,(c,p)=>c.current.base.document.active.name='Other',(c,p)=>p.candidate.active.name='Other']){
  const c=fixture(),review=new TenantThemeRestoreReview(c),p=review.prepare();change(c,p);assert.throws(()=>review.confirm(p.candidate,true,true));
 }
});
