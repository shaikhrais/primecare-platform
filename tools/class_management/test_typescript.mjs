import test from 'node:test';import assert from 'node:assert/strict';import fs from 'node:fs';import os from 'node:os';import path from 'node:path';import {execFileSync} from 'node:child_process';
test('TypeScript AST identifies bindings and ignores fake class text',()=>{
 const root=fs.mkdtempSync(path.join(os.tmpdir(),'class-registry-'));
 try{fs.mkdirSync(path.join(root,'packages/example/src'),{recursive:true});fs.writeFileSync(path.join(root,'packages/example/src/example.ts'),"// class Fake {}\nconst text='class AlsoFake {}'; const One=class X{}; const Two=class X{}; interface Contract {} class Actual implements Contract {};");
 const output=path.join(root,'catalog.json');execFileSync(process.execPath,[new URL('./scan-typescript.mjs',import.meta.url).pathname,root,output],{stdio:'pipe'});
 const data=JSON.parse(fs.readFileSync(output,'utf8'));assert.equal(data.complete,true);assert.equal(data.classes.length,4);assert.equal(new Set(data.classes.map(x=>x.id)).size,4);assert.deepEqual(data.classes.map(x=>x.name).sort(),['Actual','Contract','One.X','Two.X']);
 }finally{fs.rmSync(root,{recursive:true,force:true})}
});
