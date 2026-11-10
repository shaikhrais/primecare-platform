import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile,mkdtemp,mkdir,writeFile,rm} from 'node:fs/promises';
import {execFileSync} from 'node:child_process';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {fileURLToPath} from 'node:url';

test('common Login probe applies to its actual fixture and remains valid JavaScript',async()=>{
 const root=fileURLToPath(new URL('../',import.meta.url));
 const directory=await mkdtemp(join(tmpdir(),'primecare-login-probe-'));
 try{
  await mkdir(join(directory,'scripts'));
  const name='scripts/test-auth-password-workflow.mjs';
  const original=await readFile(join(root,name));
  await writeFile(join(directory,name),original);
  execFileSync('git',['init','-q'],{cwd:directory});
  const patch=join(root,'tools/workflow-verification/patches/login-session-race.patch');
  execFileSync('git',['apply','--check',patch],{cwd:directory});
  execFileSync('git',['apply',patch],{cwd:directory});
  execFileSync(process.execPath,['--check',join(directory,name)]);
  const probe=await readFile(join(directory,name),'utf8');
  assert.match(probe,/loginIdentityGate=\{held,reached,finished\}/);
  assert.match(probe,/response\.status,200/);
  assert.match(probe,/\['en','fr','es'\]/);
  assert.match(probe,/provisionalSessionRevoked:true/);
  assert.match(probe,/Login labels must match the registered isolated-service catalog/);
  assert.deepEqual(await readFile(join(root,name)),original,'Preparation never edits the source fixture');
 }finally{await rm(directory,{recursive:true,force:true});}
});
