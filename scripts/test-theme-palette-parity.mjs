import test from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
const reference=JSON.parse(await readFile('scripts/theme_palette_reference.json','utf8'));
const catalog=JSON.parse(await readFile('scripts/primecare_presets.json','utf8'));
const leaves=(object,path='')=>Object.entries(object).flatMap(([key,value])=>{const name=path?path+'.'+key:key;return value&&typeof value==='object'?leaves(value,name):[[name,value]];});
test('Every declared ZIP palette value survives in the central runtime catalog',()=>{
 assert.equal(Object.keys(reference.palettes).length,37);
 for(const [name,palette] of Object.entries(reference.palettes)){
  assert.ok(catalog[name],name);
  for(const [path,value] of leaves(palette))assert.equal(path.split('.').reduce((v,k)=>v[k],catalog[name]),value,name+':'+path);
 }
 assert.equal(Object.keys(catalog).length,39);
});
test('Every source color is emitted as an alpha-aware Dart token',async()=>{
 const dart=await readFile('packages/flutter_core/lib/theme/theme_config_generated.dart','utf8');
 for(const palette of Object.values(reference.palettes))for(const [path,value] of leaves(palette)){
  if(typeof value==='string'&&/^(#|rgba?\()/.test(value))assert.ok(dart.includes("'"+path+"': Color("),path);
 }
 assert.ok(dart.includes('0x14FFFFFF'),'8% white alpha preserved');
});

test('all custom color-ramp shades are retained',async()=>{
 assert.deepEqual(JSON.parse(await readFile('scripts/theme_color_ramps.json','utf8')),reference.ramps);
 assert.equal(Object.values(reference.ramps).reduce((n,r)=>n+Object.keys(r).length,0),28);
});
test('day/night retains paired and unpaired accent combinations and settings',async()=>{
 const {build}=await import('esbuild');const result=await build({entryPoints:['packages/domain/src/theme_center.ts'],bundle:true,platform:'node',format:'esm',write:false});
 const {themeForMode,defaultPersonalTheme}=await import('data:text/javascript;base64,'+Buffer.from(result.outputFiles[0].text).toString('base64'));
 for(const preset of Object.keys(catalog))for(const mode of ['light','dark']){
  const next=themeForMode({...defaultPersonalTheme,preset,fontScale:1.25,radius:16},mode);assert.equal(catalog[next.preset].mode,mode);assert.equal(next.fontScale,1.25);assert.equal(next.radius,16);
 }
 let profile={...defaultPersonalTheme,preset:'navyTealPalette'};
 profile=themeForMode(themeForMode(profile,'dark'),'light');assert.equal(profile.colors.primary,catalog.navyTealPalette.primary.main.toLowerCase());
 assert.equal(themeForMode({...defaultPersonalTheme,preset:'skyBlueOrange'},'dark').preset,'skyBlueOrangeDark');
});


test('all 22 source combinations resolve all four independent areas',async()=>{
 const combinations=JSON.parse(await readFile('scripts/theme_color_combinations.json','utf8'));
 assert.equal(combinations.length,22);
 for(const combination of combinations){assert.deepEqual(Object.keys(combination.sections).sort(),['footer','main','navbar','toolbar']);for(const name of Object.values(combination.sections))assert.ok(reference.palettes[name]);}
 assert.equal(combinations.find(c=>c.name==='Charcoal Teal').sections.footer,'charcoalTealDark');
});
