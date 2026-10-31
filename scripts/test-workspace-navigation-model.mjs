import test from 'node:test';import assert from 'node:assert/strict';import {items,authority,api} from './workspace-navigation-fixtures.mjs';import {build} from 'esbuild';
const bundle=await build({entryPoints:['packages/domain/src/workspace_layout.ts'],bundle:true,write:false,format:'esm',platform:'node'});const {defaultWorkspaceLayout}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
test('both IDs and routes intersect; denied parents and disabled descendants remain unavailable',()=>{
 const nodes=api.buildWorkspaceNavigation(items,authority),text=JSON.stringify(nodes);assert.ok(!text.includes('PRIVATE'));assert.equal(api.activeWorkspaceDestination(nodes,'/app/people/123'),'home');assert.equal(api.activeWorkspaceDestination(nodes,'/app/people'),'people');assert.equal(api.activeWorkspaceDestination(nodes,'/apple'),undefined);assert.equal(api.activeWorkspaceDestination(nodes,'/disabled'),undefined);
 assert.ok(api.flattenWorkspaceNavigation(nodes).find(n=>n.id==='locked').disabled);assert.equal(api.buildWorkspaceNavigation(items,{...authority,routes:[]}).length,0);
});
test('unknown fields, malformed trees, duplicate identities, unsafe routes and icons fail closed',()=>{
 for(const mutate of [x=>x[0].permission='admin',x=>x.push(x[0]),x=>x[0].children[0].route='javascript:alert(1)',x=>x[0].children[0].route='//evil.invalid',x=>x[0].children[0].route='/\\evil.invalid',x=>x[0].children[0].icon='unregistered',x=>x[0].children[0].disabled='false',x=>x[0].children[0].children=[]]){const raw=structuredClone(items);mutate(raw);assert.throws(()=>api.buildWorkspaceNavigation(raw,authority));}
 const nodes=api.buildWorkspaceNavigation(items,authority);assert.throws(()=>nodes[0].children.push({}));assert.throws(()=>nodes[0].label='changed');
});
test('three compositions preserve geometry and cannot add destinations',()=>{
 const base=defaultWorkspaceLayout(['note']),snapshot=JSON.stringify(base);for(const family of ['vertical','horizontal-header','horizontal-footer']){const p=api.navigationPreset(base,family);assert.deepEqual(p.panels,base.panels);p.panels.note.width=700;assert.equal(JSON.stringify(base),snapshot);}assert.throws(()=>api.navigationPreset(base,'invented'));
});
