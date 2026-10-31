import test from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
const compiled=await build({entryPoints:['packages/domain/src/workspace_layout.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {defaultWorkspaceLayout,validateWorkspaceLayout,parseWorkspaceLayout}=await import('data:text/javascript;base64,'+Buffer.from(compiled.outputFiles[0].text).toString('base64'));
const ids=['schedule','messages'];
test('180 layout combinations survive a validated data-only JSON roundtrip',()=>{
  let combinations=0;
  for(const navigation of ['left','right','top','bottom','hidden'])
  for(const container of ['fullwidth','boxed','content'])
  for(const toolbar of ['top','bottom'])
  for(const scroll of ['page','content'])
  for(const footer of ['static','sticky','hidden']) {
    const value={...defaultWorkspaceLayout(ids),navigation,container,toolbar,scroll,footer};
    assert.deepEqual(parseWorkspaceLayout(JSON.stringify(value),ids),value);combinations++;
  }
  assert.equal(combinations,180);
});
test('unregistered panels, authority fields, script-like settings and invalid dimensions fail closed',()=>{
  const base=defaultWorkspaceLayout(ids);
  for(const patch of [{role:'admin'},{tenant:'another'},{version:2},{navigation:'url(x)'},{navigation:{}},{maxWidth:NaN},{maxWidth:2000},{navigationWidth:159},{panels:{unknown:base.panels.schedule}},{panels:{schedule:base.panels.schedule}},{panels:{...base.panels,schedule:{...base.panels.schedule,width:Infinity}}},{panels:{...base.panels,schedule:{...base.panels.schedule,x:-1}}},{panels:{...base.panels,schedule:{...base.panels.schedule,endpoint:'/admin'}}}]) {
    assert.throws(()=>validateWorkspaceLayout({...base,...patch},ids));
  }
  assert.throws(()=>parseWorkspaceLayout(' '.repeat(32769),ids));
  assert.throws(()=>parseWorkspaceLayout('<script>bad</script>',ids));
  assert.throws(()=>defaultWorkspaceLayout(['constructor']));
  assert.throws(()=>defaultWorkspaceLayout(['schedule','schedule']));
});
test('validated profiles do not retain mutable caller references',()=>{
  const value=defaultWorkspaceLayout(ids),copy=validateWorkspaceLayout(value,ids);
  value.panels.schedule.width=999;
  assert.equal(copy.panels.schedule.width,320);
});
