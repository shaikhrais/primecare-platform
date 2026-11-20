import assert from 'node:assert/strict';
import {test} from 'node:test';
import {build} from 'esbuild';
import {spawnSync} from 'node:child_process';

const result=await build({entryPoints:['cloudflare/workers/src/gateway.ts'],bundle:true,
  write:false,platform:'node',format:'esm'});
const {default:gateway}=await import('data:text/javascript;base64,'+Buffer.from(result.outputFiles[0].text).toString('base64'));
const prefix='primecare_endpoint_traffic_v1 ';

test('gateway telemetry is opt-in, excludes caller data and preserves responses',async()=>{
  const lines=[], original=console.log;
  console.log=message=>lines.push(message);
  try {
    const env={AUTH:{fetch:async()=>new Response('abc',{headers:{'content-length':'3'}})}};
    const request=()=>new Request('https://gateway.test/v1/auth/me?secret=private',{headers:{authorization:'Bearer hidden'}});
    assert.equal(await (await gateway.fetch(request(),env)).text(),'abc');
    assert.equal(lines.length,0);
    const response=await gateway.fetch(request(),{...env,ENDPOINT_TRAFFIC_ENABLED:'1'});
    assert.equal(await response.text(),'abc');
    assert.equal(lines.length,1);
    assert.ok(lines[0].startsWith(prefix));
    assert.doesNotMatch(lines[0],/secret|private|hidden/);
    const event=JSON.parse(lines[0].slice(prefix.length));
    assert.equal(event.endpoint,'GET /v1/auth/me');
    assert.equal(event.declaredRequestBytes,0);
    assert.equal(event.declaredResponseBytes,3);
    const rollup=spawnSync('python3',['scripts/summarize-endpoint-traffic.py','--interval-seconds','60'],
      {input:lines[0]+'\n',encoding:'utf8'});
    assert.equal(rollup.status,0,rollup.stderr);
    assert.equal(JSON.parse(rollup.stdout).endpoints[0].declaredResponseBytes.knownBytes,3);
  }finally{console.log=original;}
});
