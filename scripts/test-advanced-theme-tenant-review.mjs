import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
const built=await build({entryPoints:['packages/primecare_ui/web/advanced-theme-tenant-review.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {TenantThemeMigrationReview}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));

test('review preserves original, requires confirmation and rejects changed source',async()=>{
 const scope={tenantId:'t1',userId:'u1',role:'tenant_admin',dataset:'live'};
 const key='primecare-themes:v1:'+encodeURIComponent(JSON.stringify(['tenant-dashboard','live','t1','u1','tenant_admin']));
 const initial=JSON.stringify({version:1,active:null,items:[]});
 const data=new Map([[key,initial]]);
 const storage={getItem:k=>data.get(k)??null,setItem:(k,v)=>data.set(k,v)};
 let saves=0;
 const client={binding:{scope,kind:'theme',resource:'advanced-v2'},current:{status:'clean',pending:null,base:{revision:0},error:null},async adoptLocal(){this.current.status='dirty'},async save(){saves++;this.current.status='clean';this.current.base.revision=1;}};
 const review=new TenantThemeMigrationReview(storage,client);
 await assert.rejects(review.confirm(),/Review/);
 const preview=review.prepare();
 assert.equal(preview.candidate.version,2);
 assert.equal(saves,0);
 data.set(key,JSON.stringify({version:1,active:{version:1,name:'Changed',preset:'default',fontFamily:'system',fontScale:1,radius:12,colors:{}},items:[]}));
 await assert.rejects(review.confirm(),/backup differs|no longer matches/i);
 assert.equal(saves,0);
 data.set(key,initial);
 review.prepare();
 assert.equal((await review.confirm()).status,'clean');
 assert.equal(saves,1);
 review.dispose();
 assert.throws(()=>review.prepare(),/disposed/);
});
