import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {mkdtemp, rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {pathToFileURL} from 'node:url';
const root=await mkdtemp(join(tmpdir(),'primecare-gateway-cors-'));
let checks=0;
try {
  const output=join(root,'gateway.mjs');
  await build({entryPoints:['cloudflare/workers/src/gateway.ts'],outfile:output,bundle:true,platform:'node',format:'esm'});
  const worker=(await import(pathToFileURL(output))).default;
  const origins=['https://primecare-clinic.pages.dev','https://primecare-client.pages.dev','https://preview.primecare-clinic.pages.dev'];
  for(const origin of origins){
    const preflight=await worker.fetch(new Request('https://gateway/v1/auth/login',{method:'OPTIONS',headers:{Origin:origin,'Access-Control-Request-Method':'POST','Access-Control-Request-Headers':'content-type,x-device-id,x-requested-with'}}),{});
    assert.equal(preflight.status,204);assert.equal(preflight.headers.get('access-control-allow-origin'),origin);assert.equal(preflight.headers.get('access-control-allow-credentials'),'true');checks++;
    for(const status of [200,401]){
      const response=await worker.fetch(new Request('https://gateway/v1/auth/login',{method:'POST',headers:{Origin:origin,'Content-Type':'application/json'},body:'{}'}),{AUTH:{fetch:async()=>Response.json({fixture:true},{status})}});
      assert.equal(response.status,status);assert.equal(response.headers.get('access-control-allow-origin'),origin);assert.equal(response.headers.get('access-control-allow-credentials'),'true');assert.deepEqual(await response.json(),{fixture:true});checks++;
    }
  }
  for(const origin of ['https://foreign.example','https://primecare-clinic.pages.dev.foreign.example','http://primecare-clinic.pages.dev','null']){
    const response=await worker.fetch(new Request('https://gateway/v1/auth/login',{method:'OPTIONS',headers:{Origin:origin}}),{});
    assert.equal(response.status,403);assert.equal(response.headers.get('access-control-allow-origin'),null);assert.equal(response.headers.get('access-control-allow-credentials'),null);checks++;
  }
  const noOrigin=await worker.fetch(new Request('https://gateway/v1/auth/login',{method:'OPTIONS'}),{});
  assert.equal(noOrigin.headers.get('access-control-allow-credentials'),null);checks++;
  console.log(`${checks} gateway credential CORS scenarios passed`);
}finally{await rm(root,{recursive:true,force:true});}
