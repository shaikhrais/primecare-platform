import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';

const built = await build({entryPoints:['cloudflare/workers/src/gateway.ts'],bundle:true,write:false,platform:'node',format:'esm'});
const {default:gateway} = await import('data:text/javascript;base64,' + Buffer.from(built.outputFiles[0].text).toString('base64'));
for (const path of ['/v1/public/','/v1/debug/','/v1/marketing/']) {
  for (const method of ['POST','GET','PUT','PATCH','DELETE']) {
    test(method + ' ' + path + ' remains an unrouted namespace prefix', async () => {
      let forwarding = 0;
      const env = new Proxy({}, {get(){forwarding++;throw Error('Namespace prefix must not access any Worker binding');}});
      const request = new Request('https://fixture' + path, {method,...(method==='GET'?{}:{body:'{}',headers:{'content-type':'application/json'}})});
      const response = await gateway.fetch(request, env);
      assert.equal(response.status,404);
      assert.deepEqual(await response.json(),{error:'Route not found'});
      assert.equal(forwarding,0); // No Worker can open a DB or perform a business action.
    });
  }
}
