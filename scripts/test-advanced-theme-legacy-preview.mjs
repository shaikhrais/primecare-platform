import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
const result=await build({entryPoints:['packages/domain/src/advanced-theme-legacy-preview.ts','packages/domain/src/advanced_theme.ts'],bundle:true,platform:'node',format:'esm',outdir:'out',write:false});
const load=async name=>import('data:text/javascript;base64,'+Buffer.from(result.outputFiles.find(f=>f.path.endsWith('/'+name+'.js')).text).toString('base64'));
const {previewAdvancedLibraryInLegacyEditor}=await load('advanced-theme-legacy-preview');
const {defaultAdvancedTheme}=await load('advanced_theme');
const id='00000000-0000-4000-8000-000000000001';
test('preview preserves source, identity, mapped settings and reports unmapped settings',()=>{
 const theme=defaultAdvancedTheme();theme.name='Account theme';theme.regions.navigation.background='#14283f';theme.regions.navigation.surface='#14283f';theme.regions.navigation.text='#ffffff';theme.tokens.fontFamily='serif';
 const input={version:2,active:theme,items:[{id,theme}]},before=structuredClone(input);
 const result=previewAdvancedLibraryInLegacyEditor(input);
 assert.deepEqual(input,before);assert.deepEqual(result.source,before);assert.equal(result.requiresReview,true);
 assert.equal(result.candidate.items[0].id,id);assert.equal(result.candidate.active.name,theme.name);
 assert.equal(result.candidate.active.colors.sidebar,'#14283f');assert.equal(result.candidate.active.colors.primary,theme.regions.main.primary);
 assert.equal(result.candidate.active.fontFamily,'serif');assert.ok(result.unmappedFields.includes('layout'));
 result.source.active.name='Changed';assert.equal(input.active.name,'Account theme');
});
test('preview validates source and accepts an empty library',()=>{
 assert.deepEqual(previewAdvancedLibraryInLegacyEditor({version:2,active:null,items:[]}).candidate,{version:1,active:null,items:[]});
 assert.throws(()=>previewAdvancedLibraryInLegacyEditor({version:2,active:null,items:[{id:'bad',theme:defaultAdvancedTheme()}]}));
 assert.throws(()=>previewAdvancedLibraryInLegacyEditor({version:2,active:{...defaultAdvancedTheme(),tokens:{}},items:[]}));
});
