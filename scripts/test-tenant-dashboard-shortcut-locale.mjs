import assert from 'node:assert/strict';
import {test} from 'node:test';
import {tenantView,tenantNavigation} from '../packages/shared/src/tenant-dashboard/view.mjs';
import catalog from '../packages/shared/src/tenant-dashboard/catalog.json' with {type:'json'};
assert.equal(process.env.GITHUB_ACTIONS,'true','GitHub Actions only');assert.match(process.env.GITHUB_SHA??'',/^[a-f0-9]{40}$/);
const data={today:'2026-01-01',dataset:'live',database:'PostgreSQL',organization:{id:'synthetic',name:'Synthetic'},identity:{role:'tenant_admin'},synthetic:false,canCreate:false,canManage:true,users:[],clients:[],tasks:[],events:[],workflows:[],stats:{},taskStats:{},taskPage:{total:0,offset:0},workflowPage:{total:0,offset:0},preference:{view:'overview'}};
const href=(html,id)=>{const match=html.match(new RegExp('href="([^"]+)"[^>]*data-cy="'+id+'"'));assert.ok(match,'Expected existing shortcut');return new URL(match[1],'https://synthetic.test');};
for(const locale of ['en','fr','es'])await test(locale+' existing dashboard shortcuts preserve language, route, query and hash without changing grants',()=>{
 for(const view of ['overview','people','operations','growth','audit']){
  const html=tenantView(data,{view,locale});
  for(const shortcut of catalog.shortcuts){
   for(const prefix of ['tenant-shortcut-','tenant-module-']){
    const id=prefix+shortcut.id;if(!html.includes('data-cy="'+id+'"'))continue;
    const actual=href(html,id),expected=new URL(shortcut.route,'https://synthetic.test');assert.equal(actual.origin,expected.origin);assert.equal(actual.pathname,expected.pathname);assert.equal(actual.hash,expected.hash);assert.equal(actual.searchParams.get('locale')||'en',locale);assert.equal(actual.searchParams.get('enable-semantics'),'true');for(const [key,value]of expected.searchParams)assert.equal(actual.searchParams.get(key),value);
   }
  }
 }
 const nav=tenantNavigation('people',()=>'',undefined,true,locale),admin=href(nav,'tenant-admin-settings'),account=href(nav,'tenant-account');assert.equal(admin.pathname,'/platform/administration');assert.equal(admin.hash,'#accounts');assert.equal(account.pathname,'/success');for(const target of [admin,account])assert.equal(target.searchParams.get('locale')||'en',locale);
 assert.equal(tenantNavigation('tasks',()=>'', ['tasks'],false,locale).includes('tenant-admin-settings'),false,'No manager link added to non-manager navigation');
});
await test('unknown locale cannot enter shortcut URL; unchanged callers keep English default',()=>{
 for(const locale of [undefined,'unsupported','fr&tenant=foreign']){const target=href(tenantView(data,{view:'people',locale}),'tenant-shortcut-accounts');assert.equal(target.searchParams.has('locale'),false);assert.equal(target.searchParams.has('tenant'),false);assert.equal(target.hash,'#accounts');}
});
