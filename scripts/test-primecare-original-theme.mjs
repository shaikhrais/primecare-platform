import test from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {build} from 'esbuild';
const result=await build({entryPoints:['packages/domain/src/primecare_appearance.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {toPrimeCareAppearance,defaultPrimeCareProfile}=await import('data:text/javascript;base64,'+Buffer.from(result.outputFiles[0].text).toString('base64'));
const palettes=JSON.parse(await readFile('scripts/primecare_presets.json','utf8'));
const contrast=(a,b)=>{const luminance=s=>{const c=s.slice(1).match(/../g).map(x=>parseInt(x,16)/255).map(x=>x<=.04045?x/12.92:((x+.055)/1.055)**2.4);return c[0]*.2126+c[1]*.7152+c[2]*.0722;};const x=luminance(a),y=luminance(b);return (Math.max(x,y)+.05)/(Math.min(x,y)+.05);};
test('Original palettes provide readable text, controls and shared chrome',()=>{
 for(const preset of Object.keys(palettes)){
  const view=toPrimeCareAppearance({...defaultPrimeCareProfile(),preset,colors:{}});
  for(const region of Object.values(view.theme)){
   const p=region.palette;
   for(const background of Object.values(p.background))for(const text of Object.values(p.text))assert.ok(contrast(text,background)>=4.5,preset);
   assert.ok(contrast(p.primary.main,p.primary.contrastText)>=4.5,preset);
  }
 }
});
test('Active generators and shared factories do not import vendor presets or widgets',async()=>{
 for(const path of ['packages/domain/src/theme_center.ts','packages/domain/src/primecare_appearance.ts','packages/primecare_ui/lib/src/theme/primecare_theme.dart','packages/primecare_ui/lib/src/application/base_primecare_app.dart','scripts/generate_theme.js','scripts/generate-theme-center-catalog.mjs','packages/primecare_ui/web/theme-center.ts','packages/primecare_ui/web/theme-manager.ts','packages/primecare_ui/web/theme-library.ts','packages/primecare_ui/web/layout-manager.ts','packages/primecare_ui/web/layout-customizer.ts','packages/primecare_ui/web/icons.ts','packages/primecare_ui/web/sidebar.ts','packages/primecare_ui/web/navigation.ts','packages/primecare_ui/web/media-look.ts']){
  assert.doesNotMatch(await readFile(path,'utf8'),/fuse_presets|@fuse|prime_fuse_theme|PrimeFuseTheme|websites\//,path);
 }
 const css=await readFile('packages/primecare_ui/web/prime-skeleton.css','utf8');
 assert.doesNotMatch(css,/@import|url\(|#[\da-f]{3,8}\b/i);
 assert.ok(css.includes('prefers-reduced-motion'));
});
