import {test} from 'node:test';import assert from 'node:assert/strict';import {api,page,authority} from './page-template-fixtures.mjs';
test('only registered ID/route intersections and authorized breadcrumbs survive',()=>{
 const r=api.buildPageRoutes([page()],authority);assert.equal(r.length,1);assert.deepEqual(r[0].breadcrumbs.map(x=>x.id),['home','current']);assert.equal(api.resolvePageRoute(r,'/one#anchor').id,'page_one');assert.equal(api.resolvePageRoute(r,'/one?other'),undefined);assert.deepEqual(api.buildPageRoutes([page()],{...authority,ids:[]}),[]);assert.deepEqual(api.buildPageRoutes([page()],{...authority,routes:[]}),[]);assert.ok(Object.isFrozen(r[0].layout.left));
});
test('unknown authority fields, unsafe routes, ambiguous bindings and malformed geometry fail closed',()=>{
 for(const p of [{...page(),permissions:['admin']},{...page(),route:'//external.invalid'},{...page(),layout:{...api.defaultPageLayout(),left:{mode:'responsive',width:Infinity,open:true}}},{...page(),layout:{...api.defaultPageLayout(),chrome:{navigation:true,toolbar:true,footer:true,role:'admin'}}},{...page(),breadcrumbs:[{id:'x',label:'X',route:'javascript:alert(1)'}]}])assert.throws(()=>api.buildPageRoutes([p],authority));
 assert.throws(()=>api.buildPageRoutes([page(),page('other','/one#other')],authority));assert.throws(()=>api.buildPageRoutes([page(),page()],authority));
});
