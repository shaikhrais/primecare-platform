import {test} from 'node:test';import assert from 'node:assert/strict';import {build} from 'esbuild';
const bundle=await build({entryPoints:['packages/primecare_ui/web/advanced-theme.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {AdvancedThemeRegions,defaultAdvancedTheme}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
function fixture(){const doc={};const element=()=>{const values=new Map([['--color-primary','original']]);return {ownerDocument:doc,parent:null,style:{getPropertyValue:k=>values.get(k)??'',getPropertyPriority:()=>'',setProperty:(k,v)=>values.set(k,v),removeProperty:k=>values.delete(k)},contains(node){for(let p=node;p;p=p.parent)if(p===this)return true;return false;},values};};doc.body=element();doc.documentElement=element();return {doc,main:element(),other:element()};}
for(const change of ['redirect','delete','add'])test(`caller map ${change} cannot change captured region ownership`,()=>{
 const {doc,main,other}=fixture(),roots={main},regions=new AdvancedThemeRegions(roots);const bodyBefore=[...doc.body.values],otherBefore=[...other.values];
 if(change==='redirect')roots.main=doc.body;if(change==='delete')delete roots.main;if(change==='add')roots.footer=other;
 regions.apply(defaultAdvancedTheme());assert.notEqual(main.style.getPropertyValue('--color-primary'),'original');assert.deepEqual([...doc.body.values],bodyBefore);assert.deepEqual([...other.values],otherBefore);
 regions.dispose();assert.equal(main.style.getPropertyValue('--color-primary'),'original');assert.deepEqual([...doc.body.values],bodyBefore);assert.deepEqual([...other.values],otherBefore);
});
test('captured region roots retain existing document-wide, duplicate and nested rejection',()=>{
 const {doc,main,other}=fixture();assert.throws(()=>new AdvancedThemeRegions({main:doc.body}));assert.throws(()=>new AdvancedThemeRegions({main,footer:main}));other.parent=main;assert.throws(()=>new AdvancedThemeRegions({main,footer:other}));
});

for(const failure of [Error('style restoration'),null,undefined])test('scoped theme restores other tokens and regions after '+String(failure),()=>{const f=fixture(),regions=new AdvancedThemeRegions({main:f.main,footer:f.other}),before=[...f.other.values];regions.apply(defaultAdvancedTheme());const remove=f.main.style.removeProperty;let attempts=0;f.main.style.removeProperty=key=>{attempts++;if(key==='background-color')throw failure;return remove(key);};let caught=false;try{regions.dispose();}catch(error){caught=true;assert.equal(error,failure);}assert.equal(caught,true);assert.ok(attempts>1);assert.equal(f.main.style.getPropertyValue('--color-primary'),'original');assert.deepEqual([...f.other.values],before);assert.equal(regions.originals.size,0);const after=[...f.main.values];regions.dispose();assert.deepEqual([...f.main.values],after);});
