import {Miniflare} from 'miniflare';
import {build} from 'esbuild';
import {mkdtemp, rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join, resolve} from 'node:path';
import http from 'node:http';
import assert from 'node:assert/strict';
import {zstdDecompressSync, brotliDecompressSync, gunzipSync} from 'node:zlib';
const temporary = await mkdtemp(join(tmpdir(), 'primecare-compression-runtime-'));
let runtime;
try {
  const scriptPath = join(temporary, 'worker.mjs');
  await build({stdin: {contents: `import {BaseWorker,workerHandler} from ${JSON.stringify(resolve('cloudflare/workers/src/core/base-worker.ts'))}; class TestWorker extends BaseWorker { async handle(){return new Response('transport test '.repeat(1000),{headers:{'content-type':'application/json'}})} } export default workerHandler(new TestWorker());`, resolveDir: process.cwd(), loader: 'ts'}, bundle: true, platform: 'neutral', external: ['node:*'], format: 'esm', outfile: scriptPath});
  runtime = new Miniflare({rootPath: temporary, modulesRoot: temporary, modules: true, scriptPath, compatibilityDate: '2026-07-30', compatibilityFlags: ['nodejs_compat']});
  const url = await runtime.ready;
  for (const [accept, coding, decode] of [
    ['zstd,br,gzip', 'zstd', zstdDecompressSync], ['br,gzip', 'br', brotliDecompressSync],
    ['gzip', 'gzip', gunzipSync], ['zstd;q=0,br;q=0,gzip', 'gzip', gunzipSync],
    ['identity', undefined, value => value],
  ]) {
    const result = await new Promise((resolve, reject) => http.get(url, {headers: {'accept-encoding': accept}}, response => {
      const chunks = [];
      response.on('data', chunk => chunks.push(chunk));
      response.on('error', reject);
      response.on('end', () => resolve({headers: response.headers, body: Buffer.concat(chunks)}));
    }).on('error', reject));
    assert.equal(result.headers['content-encoding'], coding);
    assert.equal(decode(result.body).toString(), 'transport test '.repeat(1000));
    console.log(`Cloudflare runtime ${coding ?? 'identity'} passed`);
  }
} finally { if (runtime) await runtime.dispose(); await rm(temporary, {recursive: true, force: true}); }
