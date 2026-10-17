import policy from '../../../../docs/transport/compression-policy.json';
import * as zlib from 'node:zlib';
import { Readable } from 'node:stream';

type Coding = 'zstd' | 'br' | 'gzip' | 'identity';
const preference = policy.preference as Coding[];

/** Fixed server preference; q=0 and explicit exclusions always win. */
export function selectEncoding(header: string | null, available: readonly string[]): Coding | null {
  if (!header?.trim()) return available.includes('identity') ? 'identity' : null;
  const weights = new Map<string, number>();
  for (const member of header.split(',')) {
    const [name, ...params] = member.trim().toLowerCase().split(';');
    let quality = 1;
    for (const param of params) {
      const match = /^\s*q\s*=\s*(0(?:\.\d{0,3})?|1(?:\.0{0,3})?)\s*$/.exec(param);
      quality = match ? Math.min(quality, Number(match[1])) : 0;
    }
    weights.set(name.trim(), Math.min(weights.get(name.trim()) ?? 1, quality));
  }
  return preference.find(coding => available.includes(coding) &&
    (weights.get(coding) ?? (coding === 'identity' ? (weights.get('*') === 0 ? 0 : 1) : weights.get('*') ?? 0)) > 0) ?? null;
}

const factories: Record<string, (() => any) | undefined> = {
  zstd: (zlib as unknown as { createZstdCompress?: () => unknown }).createZstdCompress,
  br: () => zlib.createBrotliCompress({ params: { [zlib.constants.BROTLI_PARAM_QUALITY]: 4 } }),
  gzip: () => zlib.createGzip(),
};

export async function compressResponse(request: Request, response: Response): Promise<Response> {
  if (new URL(request.url).hostname === 'service' || request.method === 'HEAD' || !response.body ||
      response.status < 200 || response.status === 204 || response.status === 304 || response.status === 206 ||
      request.headers.has('range') || response.headers.has('content-range') || response.headers.has('content-encoding') ||
      /(?:^|,)\s*no-transform\b/i.test(response.headers.get('cache-control') ?? '') ||
      !/^(?:application\/(?:[\w.-]+\+)?(?:json|xml)|application\/javascript|text\/(?!event-stream)[\w.+-]+|image\/svg\+xml)(?:;|$)/i.test(response.headers.get('content-type') ?? '')) return response;
  const headers = new Headers(response.headers);
  const vary = headers.get('vary');
  if (vary !== '*' && !vary?.split(',').some(value => value.trim().toLowerCase() === 'accept-encoding'))
    headers.set('vary', vary ? `${vary}, Accept-Encoding` : 'Accept-Encoding');
  const original = (request as Request & { cf?: { clientAcceptEncoding?: string } }).cf?.clientAcceptEncoding;
  const accepted = typeof original === 'string' ? original : request.headers.get('accept-encoding');
  const available = [...preference];
  let coding: Coding | null;
  let encoder: any;
  while ((coding = selectEncoding(accepted, available)) && coding !== 'identity') {
    try {
      if (!factories[coding]) throw new Error('Unavailable encoder');
      encoder = factories[coding]!();
      break;
    } catch {
      available.splice(available.indexOf(coding), 1);
    }
  }
  if (!coding) {
    await response.body.cancel();
    return new Response(null, { status: 406, headers: { vary: headers.get('vary') ?? 'Accept-Encoding' } });
  }
  if (coding === 'identity') return new Response(response.body, { status: response.status, statusText: response.statusText, headers });
  headers.set('content-encoding', coding);
  for (const name of ['content-length', 'content-md5', 'digest', 'content-digest']) headers.delete(name);
  const etag = headers.get('etag');
  if (etag && !etag.startsWith('W/')) headers.set('etag', `W/${etag}`);
  const source = Readable.fromWeb(response.body as any);
  source.on('error', error => encoder.destroy(error));
  encoder.on('error', () => source.destroy());
  encoder.on('close', () => source.destroy());
  source.pipe(encoder);
  return new Response(Readable.toWeb(encoder) as ReadableStream, {
    status: response.status, statusText: response.statusText, headers, encodeBody: 'manual',
  } as ResponseInit);
}
