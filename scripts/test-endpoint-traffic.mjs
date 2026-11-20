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

test('the panel accepts timestamped rollups and rejects mismatched coverage',async()=>{
  const browser=await build({entryPoints:['websites/typescript/src/endpoint-traffic-report.ts'],
    bundle:true,write:false,platform:'node',format:'esm'});
  const {readTrafficReport}=await import('data:text/javascript;base64,'+Buffer.from(browser.outputFiles[0].text).toString('base64'));
  const event={endpoint:'GET /v1/auth/me',status:401,latencyMs:15,declaredRequestBytes:0,declaredResponseBytes:null};
  const rollup=spawnSync('python3',['scripts/summarize-endpoint-traffic.py','--interval-seconds','60',
    '--window-ended-at','2026-11-20T15:00:00Z'],{input:prefix+JSON.stringify(event)+'\n',encoding:'utf8'});
  assert.equal(rollup.status,0,rollup.stderr);
  const data=JSON.parse(rollup.stdout);
  const report=readTrafficReport(data);
  assert.equal(report.requestsPerSecond,1/60);
  assert.equal(report.endpoints.get(event.endpoint).declaredResponseBytes.unknownRequests,1);
  assert.throws(()=>readTrafficReport({...data,observedRequests:2}),/Invalid request total/);
  assert.throws(()=>readTrafficReport({...data,windowStartedAt:data.windowEndedAt}),/Invalid traffic interval/);
});

test('gateway sends only sanitized events to analytics and survives writer failure',async()=>{
 const original=console.log;console.log=()=>{};
 try{
  const points=[];
  const env={AUTH:{fetch:async()=>new Response('ok')},ENDPOINT_TRAFFIC_ENABLED:'1',ENDPOINT_ANALYTICS:{writeDataPoint(point){points.push(point);}}};
  const request=()=>new Request('https://gateway.test/v1/auth/me?caller=secret',{headers:{authorization:'Bearer private'}});
  assert.equal((await gateway.fetch(request(),env)).status,200);
  assert.equal(points.length,1);
  assert.doesNotMatch(JSON.stringify(points),/private|secret|caller/);
  env.ENDPOINT_ANALYTICS.writeDataPoint=()=>{throw Error('provider failure');};
  assert.equal(await (await gateway.fetch(request(),env)).text(),'ok');
 }finally{console.log=original;}
});

test('new EMS contracts retain operation buckets before the next inventory snapshot export',async()=>{
 const original=console.log,lines=[];console.log=line=>lines.push(line);
 try{
  await gateway.fetch(new Request('https://gateway.test/v1/governance/platform/ems/summary?private=hidden'),{GOVERNANCE:{fetch:async()=>Response.json({ok:true})},ENDPOINT_TRAFFIC_ENABLED:'1'});
  assert.equal(JSON.parse(lines[0].slice(prefix.length)).endpoint,'GET /v1/governance/platform/ems/summary');assert.doesNotMatch(lines[0],/private|hidden/);
 }finally{console.log=original;}
});
