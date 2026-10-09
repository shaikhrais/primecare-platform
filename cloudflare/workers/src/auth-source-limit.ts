import {sourceLimitAllowed} from './source-limit-result';
import {isIP} from 'node:net';
import policy from './auth-source-policy.json';

export interface SourceLimitEnv {
  AUTH_SOURCE_LIMIT?: {limit(input: {key: string}): Promise<{success: boolean}>};
}

/** Run once in the auth Worker, before parsing credentials or opening PostgreSQL.
 * Cloudflare supplies CF-Connecting-IP; never trust X-Forwarded-For or X-Real-IP.
 * Same-account Workers are trusted infrastructure and must preserve this header.
 */
export async function sourceLoginLimit(request: Request, env: SourceLimitEnv): Promise<Response | null> {
  if (request.method !== 'POST' || !['/login','/forgot-password','/reset-password'].includes(new URL(request.url).pathname)) return null;
  const headers = {'cache-control':'no-store','retry-after':String(policy.login.windowSeconds)};
  const ip = request.headers.get('cf-connecting-ip');
  if (!ip || !isIP(ip) || !env.AUTH_SOURCE_LIMIT) {
    return Response.json({error:'Authentication temporarily unavailable'},{status:503,headers});
  }
  try {
    const digest = await crypto.subtle.digest('SHA-256',new TextEncoder().encode('auth-source-login:'+ip));
    const key = [...new Uint8Array(digest)].map(byte=>byte.toString(16).padStart(2,'0')).join('');
    const result = await env.AUTH_SOURCE_LIMIT.limit({key});
    return sourceLimitAllowed(result) ? null : Response.json({error:'Too many requests'},{status:429,headers});
  } catch {
    // Do not log addresses, keys, credentials or provider exception details.
    return Response.json({error:'Authentication temporarily unavailable'},{status:503,headers});
  }
}
