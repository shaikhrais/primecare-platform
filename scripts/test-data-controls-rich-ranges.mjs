import {test} from 'node:test';import assert from 'node:assert/strict';
import {build} from 'esbuild';import {readFile,writeFile} from 'node:fs/promises';
import {richRangeFixture} from './data-controls-rich-range-fixtures.mjs';
const bundle=await build({entryPoints:['packages/domain/src/data_controls.ts'],bundle:true,platform:'node',format:'esm',write:false});
const api=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
const block=(text='Hello world',bold=false)=>({text,bold,italic:false,kind:'paragraph'});
const fixture=richRangeFixture(api),path='packages/flutter_core/test/data_controls/rich-range-fixtures.json';
if(process.argv.includes('--write'))await writeFile(path,JSON.stringify(fixture,null,2)+'\n');
else assert.deepEqual(JSON.parse(await readFile(path,'utf8')),fixture);

test('range toggle changes selected characters, merges spans and preserves other styles',()=>{
 const original=block(),bold=api.toggleRichRange(original,0,5,'bold'),mixed=api.toggleRichRange(bold,3,8,'italic');
 assert.deepEqual(original,block());assert.deepEqual(mixed.marks,[{start:0,end:3,bold:true,italic:false},{start:3,end:5,bold:true,italic:true},{start:5,end:8,bold:false,italic:true}]);
 assert.deepEqual(api.toggleRichRange(mixed,0,5,'bold').marks,[{start:3,end:8,bold:false,italic:true}]);
 const invert=api.toggleRichRange(block('abc',true),1,2,'bold');assert.equal(invert.bold,true);assert.deepEqual(invert.marks,[{start:1,end:2,bold:false,italic:false}]);
});
test('overlapping style changes agree with an independent per-character reference',()=>{
 let value=block('abcdefghijklmnopqrstuvwxyz'),reference=Array.from(value.text,()=>({bold:false,italic:false}));
 for(let i=0;i<250;i++){
  const start=(i*17)%25,end=start+1+(i*11)%(26-start),style=i%2?'italic':'bold';
  const wanted=!reference.slice(start,end).every(r=>r[style]);for(let n=start;n<end;n++)reference[n][style]=wanted;
  value=api.toggleRichRange(value,start,end,style);
  const actual=[];for(const run of api.richRuns(value))for(let n=run.start;n<run.end;n++)actual.push({bold:run.bold,italic:run.italic});
  assert.deepEqual(actual,reference);
 }
});
test('insertion, replacement and deletion rebase spans without changing adjacent content',()=>{
 const original=api.toggleRichRange(block('abcde'),1,4,'bold');
 assert.deepEqual(api.replaceRichText(original,'abXYcde').marks,[{start:1,end:6,bold:true,italic:false}]);
 assert.deepEqual(api.replaceRichText(original,'ae'),block('ae'));
 assert.deepEqual(api.replaceRichText(original,'abcde'),original);
 assert.deepEqual(api.replaceRichText(original,''),block(''));
});
test('UTF-16 boundaries protect emoji and edits preserve valid range offsets',()=>{
 const original=api.toggleRichRange(block('a😀b'),1,3,'bold');
 assert.throws(()=>api.toggleRichRange(original,2,3,'italic'));
 assert.deepEqual(api.replaceRichText(original,'aX😀b').marks,[{start:2,end:4,bold:true,italic:false}]);
 for(const sample of fixture.cases)for(const step of sample.steps)for(const mark of step.expected.marks??[]){assert.ok(api.richTextBoundary(step.expected.text,mark.start));assert.ok(api.richTextBoundary(step.expected.text,mark.end));}
});
test('actual edit positions disambiguate repeated characters and directional deletions',()=>{
 const marked=api.toggleRichRange(block('aaaa'),1,2,'bold');
 const inserted=api.inferRichEdit('aaaa','aaaaa',0,0,1);assert.deepEqual(inserted,{start:0,end:0});
 assert.deepEqual(api.replaceRichText(marked,'aaaaa',inserted).marks,[{start:2,end:3,bold:true,italic:false}]);
 assert.deepEqual(api.inferRichEdit('aaaa','aaa',2,2,1),{start:1,end:2});
 assert.deepEqual(api.inferRichEdit('aaaa','aaa',2,2,2),{start:2,end:3});
 assert.deepEqual(api.replaceRichText(marked,'aaa',{start:1,end:2}),block('aaa'));
 assert.equal(api.inferRichEdit('a😀b','ab',3,3,1)?.start,1);
 assert.equal(api.inferRichEdit('aaaa','changed',1,2,2),null);
 assert.throws(()=>api.replaceRichText(marked,'aaaaa',{start:-1,end:0}));
 assert.throws(()=>api.replaceRichText(block('abcd'),'axcd',{start:0,end:0}));
});
test('malformed, overlapping, executable or unbounded marks are rejected',()=>{
 const good={start:0,end:1,bold:true,italic:false};
 for(const marks of [null,[{...good,start:0.1}],[{...good,end:12}],[good,good],[{...good,html:'<script>'}],Array(1025).fill(good)])assert.throws(()=>api.validateDocument({version:2,blocks:[{...block(),marks}]}));
 assert.throws(()=>api.toggleRichRange(block(),0,1,'link'));
 assert.throws(()=>api.replaceRichText(block(),'x'.repeat(32769)));
});
test('maximum bounded mark set can be edited and canonicalized without counting plain runs as marks',()=>{
 let value={...block('ab'.repeat(1024)),marks:Array.from({length:1024},(_,i)=>({start:i*2,end:i*2+1,bold:true,italic:false}))};
 value=api.toggleRichRange(value,0,2048,'bold');assert.deepEqual(value.marks,[{start:0,end:2048,bold:true,italic:false}]);
});
test('existing plain documents retain their original shape and text stays literal',()=>{
 assert.deepEqual(api.validateDocument({version:1,blocks:[block()]}),{version:1,blocks:[block()]});assert.throws(()=>api.validateDocument({version:1,blocks:[{...block(),marks:[{start:0,end:1,bold:true,italic:false}]}]}));
 const literal=api.toggleRichRange(block('<script>literal</script>'),0,8,'bold');assert.equal(api.richRuns(literal).map(r=>r.text).join(''),literal.text);
 const canonical=api.validateDocument({version:2,blocks:[{...block('ab'),marks:[{start:0,end:1,bold:false,italic:false}]}]});assert.ok(!('marks' in canonical.blocks[0]));
});
