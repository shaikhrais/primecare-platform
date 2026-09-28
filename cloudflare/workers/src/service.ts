import { Client } from 'pg';
import bcrypt from 'bcryptjs';

interface Env {
  DB_URL: string;
  SERVICE_NAME: string;
}

type Json = Record<string, unknown>;

const allowedOrigins = [
  /^https:\/\/primecare-[a-z0-9-]+\.pages\.dev$/,
  /^https:\/\/[a-z0-9.-]+\.primecare\.ca$/,
];

function cors(origin: string | null): HeadersInit {
  if (origin && !allowedOrigins.some((pattern) => pattern.test(origin))) return {};
  return {
    'access-control-allow-origin': origin ?? '*',
    'access-control-allow-methods': 'GET,POST,PUT,PATCH,DELETE,OPTIONS',
    'access-control-allow-headers': 'Authorization,Content-Type,X-Device-Id,X-Tenant-Id',
    vary: 'Origin',
  };
}

function json(body: unknown, status = 200, headers: HeadersInit = {}): Response {
  return Response.json(body, { status, headers });
}

function tokenFrom(request: Request): string | null {
  const authorization = request.headers.get('authorization') ?? '';
  if (authorization.startsWith('Bearer ')) return authorization.slice(7).trim();
  const cookie = request.headers.get('cookie') ?? '';
  return cookie.split(';').map((value) => value.trim()).find((value) =>
    value.startsWith('session_token='))?.slice('session_token='.length) ?? null;
}

async function sha256(value: string): Promise<string> {
  const digest = await crypto.subtle.digest('SHA-256', new TextEncoder().encode(value));
  return [...new Uint8Array(digest)].map((byte) => byte.toString(16).padStart(2, '0')).join('');
}

function newToken(): string {
  const bytes = crypto.getRandomValues(new Uint8Array(32));
  return btoa(String.fromCharCode(...bytes)).replaceAll('+', '-').replaceAll('/', '_').replaceAll('=', '');
}

async function withDb<T>(env: Env, operation: (client: Client) => Promise<T>): Promise<T> {
  const client = new Client({ connectionString: env.DB_URL });
  await client.connect();
  try {
    return await operation(client);
  } finally {
    await client.end();
  }
}

async function parseBody(request: Request): Promise<Json> {
  const body = await request.json();
  if (!body || typeof body !== 'object' || Array.isArray(body)) throw new Error('Invalid JSON object');
  return body as Json;
}

async function auth(request: Request, env: Env, path: string, headers: HeadersInit): Promise<Response | null> {
  if (request.method === 'POST' && path === '/login') {
    let body: Json;
    try { body = await parseBody(request); } catch { return json({ error: 'Invalid request' }, 400, headers); }
    const email = typeof body.email === 'string' ? body.email.trim().toLowerCase() : '';
    const password = typeof body.password === 'string' ? body.password : '';
    if (!email || email.length > 254 || !password) return json({ error: 'Email and password are required' }, 400, headers);

    return withDb(env, async (db) => {
      const result = await db.query(
        'SELECT id, roles, password_hash, status FROM users WHERE LOWER(email) = $1 LIMIT 1', [email]);
      const user = result.rows[0];
      if (!user || String(user.status).toLowerCase() !== 'active' ||
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

async function domainRoute(request: Request, env: Env, path: string, headers: HeadersInit): Promise<Response | null> {
  const service = env.SERVICE_NAME;
  if (request.method === 'GET' && service === 'client' && path === '/api/clients')
    return withDb(env, async (db) => json((await db.query('SELECT * FROM clients')).rows, 200, headers));
  if (request.method === 'POST' && service === 'client' && path === '/api/clients') {
    const body = await parseBody(request);
    await withDb(env, (db) => db.query(
      'INSERT INTO clients (first_name, last_name, email) VALUES ($1, $2, $3)',
      [body.first_name, body.last_name, body.email]).then(() => undefined));
    return json({ status: 'success' }, 200, headers);
  }
  if (request.method === 'GET' && service === 'provider' && path === '/api/providers')
    return withDb(env, async (db) => json((await db.query('SELECT * FROM providers')).rows, 200, headers));
  const provider = path.match(/^\/api\/providers\/([^/]+)$/);
  if (request.method === 'GET' && service === 'provider' && provider) {
    const row = await withDb(env, async (db) => (await db.query('SELECT * FROM providers WHERE id = $1', [provider[1]])).rows[0]);
    return row ? json(row, 200, headers) : json({ error: 'Provider not found' }, 404, headers);
  }
  if (request.method === 'GET' && service === 'visit' && path === '/api/visits')
    return withDb(env, async (db) => json((await db.query('SELECT * FROM visits ORDER BY visit_date DESC')).rows, 200, headers));
  if (request.method === 'POST' && service === 'visit' && path === '/api/visits') {
    const body = await parseBody(request);
    await withDb(env, (db) => db.query(
      "INSERT INTO visits (client_id, provider_id, visit_date, status) VALUES ($1, $2, NOW(), 'started')",
      [body.client_id, body.provider_id]).then(() => undefined));
    return json({ status: 'visit_created' }, 200, headers);
  }
  if (request.method === 'GET' && service === 'billing' && path === '/api/invoices')
    return withDb(env, async (db) => json((await db.query('SELECT * FROM invoices')).rows, 200, headers));
  if (request.method === 'GET' && service === 'scheduling' && path === '/api/schedules')
    return withDb(env, async (db) => json((await db.query(
      'SELECT s.id, s.start_time, s.end_time, c.first_name AS client_name, p.first_name AS provider_name FROM schedules s JOIN clients c ON s.client_id = c.id JOIN providers p ON s.provider_id = p.id')).rows, 200, headers));
  if (request.method === 'GET' && service === 'compliance' && path === '/api/compliance/audits')
    return withDb(env, async (db) => json((await db.query('SELECT * FROM compliance_audits ORDER BY created_at DESC')).rows, 200, headers));
  if (request.method === 'POST' && service === 'compliance' && path === '/api/compliance/findings') {
    const body = await parseBody(request);
    await withDb(env, (db) => db.query(
      'INSERT INTO compliance_findings (category, severity, message, metadata) VALUES ($1, $2, $3, $4)',
      [body.category, body.severity, body.message, JSON.stringify(body.metadata ?? {})]).then(() => undefined));
    return json({ status: 'finding_registered' }, 200, headers);
  }
  return null;
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const origin = request.headers.get('origin');
    const headers = cors(origin);
    if (origin && !Object.keys(headers).length) return new Response('Origin not allowed', { status: 403 });
    if (request.method === 'OPTIONS') return new Response(null, { status: 204, headers });
    const path = new URL(request.url).pathname;

    try {
      if (path === '/health') {
        await withDb(env, (db) => db.query('SELECT 1').then(() => undefined));
        return json({ status: 'healthy', service: env.SERVICE_NAME, runtime: 'cloudflare-worker-typescript' }, 200, headers);
      }
      if (path === '/') return json({ status: 'ok', service: env.SERVICE_NAME }, 200, headers);
      if (env.SERVICE_NAME === 'auth') {
        const response = await auth(request, env, path, headers);
        if (response) return response;
      }
      const response = await domainRoute(request, env, path, headers);
      if (response) return response;

      if (/^\/api\/[a-z0-9-]+-screen$/.test(path) && request.method === 'GET')
        return json({ status: 'success', message: 'Data retrieved successfully', data: [] }, 200, headers);
      const action = path.match(/^\/api\/([a-z0-9-]+-screen)\/action$/);
      if (action && request.method === 'POST')
        return json({ status: 'action_completed', message: `Successfully processed action for ${action[1]}` }, 200, headers);
      return json({ error: 'Route not found', service: env.SERVICE_NAME }, 404, headers);
    } catch (error) {
      console.error(error);
      return json({ error: 'Internal server error', service: env.SERVICE_NAME }, 500, headers);
    }
  },
} satisfies ExportedHandler<Env>;
