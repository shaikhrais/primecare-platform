# HTTP response compression

The shared Worker response boundary reads the original client Accept-Encoding value (`request.cf.clientAcceptEncoding` on Cloudflare, otherwise the request header). It selects the first accepted, available encoding in the registered policy: **zstd → Brotli (`br`) → gzip → identity**. Positive quality values mean accepted; explicit zero values exclude a coding. Missing or empty headers conservatively receive uncompressed data. If identity and every available coding are rejected, the response is 406.

Compression streams rather than buffering the response. Encoded responses preserve CORS Vary values, add Accept-Encoding, remove obsolete byte lengths/digests, and weaken strong ETags. Internal service bindings, already encoded responses, ranges, bodyless responses, event streams and no-transform responses bypass transformation. Cloudflare receives encodeBody=manual to preserve the bytes already encoded by the Worker.

Register with `python3 scripts/register-response-compression.py`. Verify with `node scripts/test-response-compression.mjs` and `node scripts/test-response-compression-runtime.mjs` (esbuild, Miniflare and Node 24 required). The latter checks actual compressed bytes through HTTP in workerd, not fetch's automatically decoded representation. This change does not authorize deployment or change clinical readiness.

References: [Cloudflare original client encoding](https://developers.cloudflare.com/workers/runtime-apis/request/), [manual response encoding](https://developers.cloudflare.com/workers/runtime-apis/response/), [HTTP negotiation](https://www.rfc-editor.org/rfc/rfc9110.html#section-12.5.3).
