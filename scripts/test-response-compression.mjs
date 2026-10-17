import assert from 'node:assert/strict';
import {mkdtemp, rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join, resolve} from 'node:path';
import {pathToFileURL} from 'node:url';
import {zstdDecompressSync, brotliDecompressSync, gunzipSync} from 'node:zlib';
import {build} from 'esbuild';
const temporary = await mkdtemp(join(tmpdir(), 'primecare-compression-'));
try {
  const output = join(temporary, 'compression.mjs');
  await build({entryPoints: [resolve('cloudflare/workers/src/core/response-compression.ts')], outfile: output, bundle: true, platform: 'node', format: 'esm'});
  const {selectEncoding, compressResponse} = await import(pathToFileURL(output));
  const available = ['zstd', 'br', 'gzip', 'identity'];
  for (const [header, expected] of [
    ['zstd,br,gzip', 'zstd'], ['br,gzip', 'br'], ['gzip', 'gzip'], [null, 'identity'], ['', 'identity'],
    ['zstd;q=0,br', 'br'], ['*;q=0', null], ['zstd;q=invalid,gzip', 'gzip'],
    ['zstd;q=0,zstd,gzip', 'gzip'], ['GZIP; q=1', 'gzip'], ['*', 'zstd'],
    ['zstd;q=0,*', 'br'], ['compress', 'identity'], ['identity;q=0', null],
  ]) assert.equal(selectEncoding(header, available), expected, String(header));
  assert.equal(selectEncoding('zstd,br,gzip', ['gzip', 'identity']), 'gzip');
  const plain = 'PrimeCare response '.repeat(1000);
  const makeResponse = (extra = {}) => new Response(plain, {headers: {'content-type': 'application/json', vary: 'Origin', etag: '"version"', 'content-length': String(plain.length), ...extra}});
  for (const [coding, decode] of [['zstd', zstdDecompressSync], ['br', brotliDecompressSync], ['gzip', gunzipSync]]) {
    const response = await compressResponse(new Request('https://example.test/data', {headers: {'accept-encoding': coding}}), makeResponse());
    assert.equal(response.headers.get('content-encoding'), coding);
    assert.equal(response.headers.get('vary'), 'Origin, Accept-Encoding');
    assert.equal(response.headers.get('content-length'), null);
    assert.equal(response.headers.get('etag'), 'W/"version"');
    assert.equal(decode(Buffer.from(await response.arrayBuffer())).toString(), plain);
  }
  for (const [url, requestHeaders, responseHeaders] of [
    ['https://service/data', {'accept-encoding': 'gzip'}, {}],
    ['https://example.test/data', {'accept-encoding': 'gzip', range: 'bytes=0-5'}, {}],
    ['https://example.test/data', {'accept-encoding': 'gzip'}, {'cache-control': 'no-transform'}],
    ['https://example.test/data', {'accept-encoding': 'gzip'}, {'content-type': 'text/event-stream'}],
  ]) {
    const original = makeResponse(responseHeaders);
    assert.equal(await compressResponse(new Request(url, {headers: requestHeaders}), original), original);
  }
  const request = new Request('https://example.test/data', {headers: {'accept-encoding': 'zstd,br,gzip'}});
  Object.defineProperty(request, 'cf', {value: {clientAcceptEncoding: 'gzip'}});
  const response = await compressResponse(request, makeResponse());
  assert.equal(response.headers.get('content-encoding'), 'gzip');
  await response.arrayBuffer();
  const rejected = await compressResponse(new Request('https://example.test/data', {headers: {'accept-encoding': '*;q=0'}}), makeResponse());
  assert.equal(rejected.status, 406);
  console.log('Response compression: negotiation, byte round trips, exclusions, original client header, and rejection passed');
} finally { await rm(temporary, {recursive: true, force: true}); }
