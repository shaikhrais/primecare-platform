import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';

const result=await build({stdin:{contents:"export * from './packages/primecare_ui/web/original-assets';export * from './packages/primecare_ui/web/icons';",resolveDir:process.cwd()},bundle:true,format:'esm',platform:'node',write:false});
const api=await import('data:text/javascript;base64,'+Buffer.from(result.outputFiles[0].text).toString('base64'));

test('caller mutation cannot replace geometry in later original icon renders',()=>{
  const original=api.primeCareIconPaths.phone,before=api.primeCareIcon('phone');
  try{
    try{api.primeCareIconPaths.phone='<path d="M0 0"/>';}catch(error){assert.ok(error instanceof TypeError);}
    assert.equal(api.primeCareIcon('phone'),before);
    assert.equal(Reflect.deleteProperty(api.primeCareIconPaths,'phone'),false);
    assert.equal(Reflect.set(api.primeCareIconPaths,'unregistered','<path/>'),false);
    assert.throws(()=>api.primeCareIcon('unregistered'));
  }finally{
    if(!Object.isFrozen(api.primeCareIconPaths))api.primeCareIconPaths.phone=original;
  }
});

test('caller mutation cannot redirect a legacy shell alias',()=>{
  const original=api.primeCareAssetAliases.building,before=api.shellIcon('building');
  try{
    try{api.primeCareAssetAliases.building='phone';}catch(error){assert.ok(error instanceof TypeError);}
    assert.equal(api.shellIcon('building'),before);
    assert.equal(Reflect.deleteProperty(api.primeCareAssetAliases,'building'),false);
    assert.equal(Reflect.set(api.primeCareAssetAliases,'injected','phone'),false);
  }finally{
    if(!Object.isFrozen(api.primeCareAssetAliases))api.primeCareAssetAliases.building=original;
  }
});
