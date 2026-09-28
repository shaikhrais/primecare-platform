import { Client } from 'pg';
import bcrypt from 'bcryptjs';

export interface Env { DB_URL: string; SERVICE_NAME: string }
type Json = Record<string, unknown>;

export function json(body: unknown, status = 200, headers: HeadersInit = {}): Response {
  return Response.json(body, { status, headers });
}

function tokenFrom(request: Request): string | null {
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

async function sha256(value: string): Promise<string> {
  const digest = await crypto.subtle.digest('SHA-256', new TextEncoder().encode(value));
  return [...new Uint8Array(digest)].map((byte) => byte.toString(16).padStart(2, '0')).join('');
}

function newToken(): string {
  const bytes = crypto.getRandomValues(new Uint8Array(32));
  return btoa(String.fromCharCode(...bytes)).replaceAll('+', '-').replaceAll('/', '_').replaceAll('=', '');
}

export async function withDb<T>(env: Env, operation: (client: Client) => Promise<T>): Promise<T> {
  const client = new Client({ connectionString: env.DB_URL });
  await client.connect();
  try {
    return await operation(client);
  } finally {
    await client.end();
  }
}

export async function parseBody(request: Request): Promise<Json> {
  const body = await request.json();
  if (!body || typeof body !== 'object' || Array.isArray(body)) throw new Error('Invalid JSON object');
  return body as Json;
}

export async function auth(request: Request, env: Env, path: string, headers: HeadersInit): Promise<Response | null> {
  // Authentication errors are sensitive too, including responses from direct Worker URLs.
  const safeHeaders = new Headers(headers);
  safeHeaders.set('cache-control', 'no-store');
  headers = Object.fromEntries(safeHeaders.entries());
  try {
    return await handleAuth(request, env, path, headers);
  } catch {
    // Never serialize database errors, connection strings, hashes or request data.
    return json({ error: 'Authentication service unavailable' }, 503, headers);
  }
}

async function handleAuth(request: Request, env: Env, path: string, headers: HeadersInit): Promise<Response | null> {
  if (request.method === 'POST' && path === '/login') {
    let body: Json;
    try { body = await parseBody(request); } catch { return json({ error: 'Invalid request' }, 400, headers); }
    const email = typeof body.email === 'string' ? body.email.trim().toLowerCase() : '';
    const password = typeof body.password === 'string' ? body.password : '';
    if (!email || email.length > 254 || !password) return json({ error: 'Email and password are required' }, 400, headers);

    return withDb(env, async (db) => {
      const result = await db.query(
        'SELECT id, roles, password_hash, status FROM users WHERE LOWER(email) = $1 LIMIT 2', [email]);
      const user = result.rows[0];
      if (result.rows.length !== 1 || !user || String(user.status).toLowerCase() !== 'active' ||
          typeof user.password_hash !== 'string' || !await bcrypt.compare(password, user.password_hash)) {
        return json({ error: 'Invalid credentials' }, 401, headers);
      }
      const token = newToken();
      await db.query(
        "INSERT INTO auth_sessions (token_hash, user_id, expires_at) VALUES ($1, $2, NOW() + INTERVAL '12 hours')",
        [await sha256(token), user.id]);
      return json({ userId: String(user.id), role: String(user.roles), token, status: 'authenticated' }, 200, {
        ...headers,
        'set-cookie': `session_token=${token}; Path=/; HttpOnly; Secure; SameSite=Lax; Max-Age=43200`,
        'cache-control': 'no-store',
      });
    });
  }

  if (request.method === 'GET' && path === '/me') {
    const token = tokenFrom(request);
    if (!token) return json({ error: 'No session' }, 401, headers);
    return withDb(env, async (db) => {
      const result = await db.query(
        "SELECT u.id, u.roles FROM auth_sessions s JOIN users u ON u.id = s.user_id WHERE s.token_hash = $1 AND s.expires_at > NOW() AND LOWER(u.status) = 'active' LIMIT 1",
        [await sha256(token)]);
      const user = result.rows[0];
      return user
        ? json({ userId: String(user.id), roles: String(user.roles), status: 'authenticated' }, 200, { ...headers, 'cache-control': 'no-store' })
        : json({ error: 'Invalid session' }, 401, headers);
    });
  }

  if (request.method === 'POST' && path === '/logout') {
    const token = tokenFrom(request);
    if (token) {
      const hash = await sha256(token);
      await withDb(env, (db) => db.query('DELETE FROM auth_sessions WHERE token_hash = $1', [hash]).then(() => undefined));
    }
    return json({ status: 'signed_out' }, 200, {
      ...headers,
      'set-cookie': 'session_token=; Path=/; HttpOnly; Secure; SameSite=Lax; Max-Age=0',
      'cache-control': 'no-store',
    });
  }
  return null;
}
