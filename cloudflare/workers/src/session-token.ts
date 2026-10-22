/** Canonical session credential parsing and hashing, shared by authenticated adapters. */
export function tokenFrom(request: Request): string | null {
  const authorization = request.headers.get('authorization');
  // An explicit but invalid Authorization header must not fall back to cookies.
  if (authorization !== null) {
    return /^Bearer ([A-Za-z0-9_-]{43})$/i.exec(authorization)?.[1] ?? null;
  }
  const cookie = request.headers.get('cookie') ?? '';
  const tokens = cookie.split(';').map(value => value.trim()).filter(value => value.startsWith('session_token='));
  if (tokens.length !== 1) return null;
  const token = tokens[0].slice('session_token='.length);
  return /^[A-Za-z0-9_-]{43}$/.test(token) ? token : null;
}

export async function sha256(value: string): Promise<string> {
  const digest = await crypto.subtle.digest('SHA-256', new TextEncoder().encode(value));
  return [...new Uint8Array(digest)].map((byte) => byte.toString(16).padStart(2, '0')).join('');
}

