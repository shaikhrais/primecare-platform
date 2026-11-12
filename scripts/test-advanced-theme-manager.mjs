import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
const bundled=await build({entryPoints:['packages/primecare_ui/web/theme-manager.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {BaseThemeManager}=await import('data:text/javascript;base64,'+Buffer.from(bundled.outputFiles[0].text).toString('base64'));
const profile={version:1,theme:'default',accent:'',sidebar:'left',navigation:'expanded',density:'comfortable',contentWidth:100};
const personal={version:1,name:'Current theme',preset:'default',fontFamily:'serif',fontScale:1.25,radius:18,colors:{primary:'#123456'}};
function host(){const values=new Map([['--color-primary','#087f80'],['--font-family','system-ui']]);return {dataset:{},style:{colorScheme:'light',getPropertyValue:k=>values.get(k)??'',setProperty:(k,v)=>values.set(k,v),removeProperty:k=>values.delete(k)},snapshot(){return {values:[...values],colorScheme:this.style.colorScheme};}};}
for(const invalid of [{...personal,colors:{primary:'url(secret)'}},{...personal,fontScale:100},{...personal,name:''}])test(`invalid personal ${JSON.stringify(invalid)} leaves current presentation untouched`,()=>{
 const root=host(),manager=new BaseThemeManager(root);manager.apply(profile,personal);const before=root.snapshot();
 assert.throws(()=>manager.apply({...profile,theme:'dark',accent:'#abcdef'},invalid));assert.deepEqual(root.snapshot(),before);
 // Rejection must not poison later explicit apply/reset operations.
 manager.apply(profile,{...personal,fontFamily:'monospace',fontScale:1});assert.equal(root.style.getPropertyValue('--font-family'),'ui-monospace, monospace');
 manager.apply(profile,null);assert.equal(root.style.getPropertyValue('--font-family'),'system-ui');assert.equal(root.style.getPropertyValue('--color-primary'),'#087f80');
});
