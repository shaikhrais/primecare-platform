import {authIdentity,mutatedAccount} from './auth-projection';
import {selfRecords} from './self-records';
import {selfSessions} from './self-sessions';
import {recoverPassword,resetPassword,validateRecovery} from './password-recovery';
import {maintenance,maintenanceRoles,configuredMail,type MaintenanceEnv} from './maintenance';
import type {SourceLimitEnv} from './auth-source-limit';
import { Client } from 'pg';
import bcrypt from 'bcryptjs';
import accountPolicy from './account-policy.json';
import {loginRateLimit,authRateLimit,type AuthOperation} from './auth-rate-limit';
import {manageAccount,validateAccountUpdate,listAccounts} from './account-management';
import {parseAccountAdminRequest,accountAdministration} from './account-admin';
import {changePassword,validatePasswordChange} from './password-change';

export interface Env extends SourceLimitEnv, MaintenanceEnv {
  DB_URL: string; SERVICE_NAME: string;
  WORKSPACE_SOURCE_LIMIT?: {limit(options:{key:string}):Promise<{success:boolean}>};
}
type Json = Record<string, unknown>;

export function json(body: unknown, status = 200, headers: HeadersInit = {}): Response {
  return Response.json(body, { status, headers });
}

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

class RequestTooLarge extends Error {}
function bodyFailure(error: unknown, message: string, headers: HeadersInit): Response {
  return error instanceof RequestTooLarge ? json({error:'Request too large'},413,headers) : json({error:message},400,headers);
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

/** Authenticate before creating a counter. Mutations revalidate under their
 * existing locks, so this preflight never replaces authorization or revocation. */
async function mutationLimit(db:Client,token:string,operation:AuthOperation,headers:HeadersInit):Promise<Response|null> {
  const actor=(await db.query("SELECT u.id FROM auth_sessions s JOIN users u ON u.id=s.user_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' LIMIT 1",[await sha256(token)])).rows[0];
  if(!actor)return json({error:'Invalid session'},401,headers);
  const retryAfter=await authRateLimit(db,await sha256(operation+':'+String(actor.id)),operation);
  return retryAfter===null?null:json({error:'Too many authentication attempts'},429,
    {...headers,'retry-after':String(retryAfter)});
}

/** Bound parsed authentication JSON by wire bytes, including chunked requests. */
export async function parseBody(request: Request): Promise<Json> {
  const limit = 50_000;
  const declared = request.headers.get('content-length');
  if (declared !== null && /^\d+$/.test(declared) && Number(declared) > limit) throw new RequestTooLarge();
  const reader = request.body?.getReader();
  if (!reader) throw new Error('Invalid JSON object');
  const chunks: Uint8Array[] = [];
  let size = 0;
  try {
    while (true) {
      const {done, value} = await reader.read();
      if (done) break;
      size += value.byteLength;
      if (size > limit) {
        await reader.cancel().catch(() => {});
        throw new RequestTooLarge();
      }
      chunks.push(value);
    }
  } finally {
    reader.releaseLock();
  }
  const bytes = new Uint8Array(size);
  let offset = 0;
  for (const chunk of chunks) { bytes.set(chunk, offset); offset += chunk.byteLength; }
  const body = JSON.parse(new TextDecoder().decode(bytes));
  if (!body || typeof body !== 'object' || Array.isArray(body)) throw new Error('Invalid JSON object');
  return body as Json;
}

async function handleAuth(request: Request, env: Env, path: string, headers: HeadersInit): Promise<Response | null> {
  const records=await selfRecords(request,env,path,headers);
  if(records)return records;
  const personal=await selfSessions(request,env,path,headers);
  if(personal)return personal;
  const adminRequest=parseAccountAdminRequest(request,path);
  if(adminRequest) {
    if('error' in adminRequest)return json({error:adminRequest.error},adminRequest.status,{...headers,...(adminRequest.allow?{allow:adminRequest.allow}:{})});
    const token=request.headers.has('authorization')?tokenFrom(request):null;
    if(!token)return json({error:'No session'},401,headers);
    if(env.WORKSPACE_SOURCE_LIMIT) {
      const key=await sha256('account-admin:'+(request.headers.get('cf-connecting-ip')??'unknown'));
      if(!(await env.WORKSPACE_SOURCE_LIMIT.limit({key})).success)return json({error:'Too many requests'},429,{...headers,'retry-after':'60'});
    }
    const mutating=adminRequest.input.operation==='sessions_revoke';
    return withDb(env,async db=>{
      if(mutating){const limited=await mutationLimit(db,token,'manageAccount',headers);if(limited)return limited;}
      await db.query(mutating?'BEGIN':'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
      let finished=false;
      try {
        const actor=(await db.query("SELECT u.id,u.roles,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active'"+(mutating?' FOR SHARE OF u,s':' LIMIT 1'),[await sha256(token)])).rows[0];
        if(!actor)return json({error:'Invalid session'},401,headers);
        if(!actor.tenant_id||(request.headers.has('x-tenant-id')&&request.headers.get('x-tenant-id')!==String(actor.tenant_id)))return json({error:'Forbidden'},403,headers);
        const result=await accountAdministration(db,actor,adminRequest.input);
        if(mutating&&result.status===200){await db.query('COMMIT');finished=true;}
        return json(result.body,result.status,headers);
      }finally {if(!finished)await db.query('ROLLBACK');}
    });
  }
  if(['/maintenance/configuration','/maintenance/configuration/test-email'].includes(path)) {
    if(!((path==='/maintenance/configuration' && ['GET','POST'].includes(request.method)) || (path.endsWith('/test-email') && request.method==='POST')))return json({error:'Method not allowed'},405,headers);
    const token=request.headers.has('authorization')?tokenFrom(request):null;
    if(!token)return json({error:'No session'},401,headers);
    let body:Json={};
    try {if(request.method==='POST'){body=await parseBody(request);}}
    catch(error) {return bodyFailure(error,'Invalid request',headers);}
    return withDb(env,async db=>{
      await db.query('BEGIN');
      try {
        const actor=(await db.query("SELECT u.id,u.email,u.roles,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' FOR SHARE OF u,s",[await sha256(token)])).rows[0];
        if(!actor){await db.query('ROLLBACK');return json({error:'Invalid session'},401,headers);}
        if(!actor.tenant_id || !maintenanceRoles.includes(String(actor.roles)) || (request.headers.has('x-tenant-id') && request.headers.get('x-tenant-id')!==String(actor.tenant_id))){await db.query('ROLLBACK');return json({error:'Forbidden'},403,headers);}
        await db.query('SELECT pg_advisory_xact_lock(hashtext($1))',['maintenance:'+String(actor.tenant_id)]);
        if(request.method==='POST') {const retry=await authRateLimit(db,await sha256('maintenance:'+String(actor.id)),'maintenance');if(retry!==null){await db.query('COMMIT');return json({error:'Too many configuration requests'},429,headers);}}
        const result=await maintenance(db,env,actor,request.method,path,body);
        await db.query('COMMIT');return json(result.body,result.status,headers);
      }catch(error){await db.query('ROLLBACK');throw error;}
    });
  }
  if(request.method==='POST' && ['/forgot-password','/reset-password'].includes(path)) {
    let input;
    try {input=validateRecovery(await parseBody(request),path==='/reset-password');} catch(error) {return bodyFailure(error,'Invalid recovery request',headers);}
    if(!input)return json({error:'Enter a valid email, a 12-character reset code, and a password of at least 12 characters (maximum 72 bytes).'},400,headers);
    return withDb(env,async db=>{
      let mail:MaintenanceEnv=env;
      if(path==='/forgot-password') {
        const accounts=(await db.query("SELECT tenant_id FROM users WHERE LOWER(email)=$1 AND LOWER(status)='active' LIMIT 2",[input.email])).rows;
        if(accounts.length===1 && accounts[0].tenant_id)mail=await configuredMail(db,env,String(accounts[0].tenant_id));
      }
      const result=path==='/forgot-password'?await recoverPassword(db,mail,input.email):await resetPassword(db,input);
      return json(result.body,result.status,headers);
    });
  }
  if(path==='/change-password' && request.method==='POST') {
    const token=request.headers.has('authorization')?tokenFrom(request):null;
    if(!token)return json({error:'No session'},401,headers);
    let input;
    try{input=validatePasswordChange(await parseBody(request));}catch(error){return bodyFailure(error,'Invalid request',headers);}
    if(!input)return json({error:'Invalid password fields'},400,headers);
    return withDb(env,async db=>{
      const limited=await mutationLimit(db,token,'changePassword',headers);
      if(limited)return limited;
      await db.query('BEGIN');
      try{
        const user=(await db.query("SELECT u.id,u.password_hash FROM auth_sessions s JOIN users u ON u.id=s.user_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' FOR UPDATE OF u,s",[await sha256(token)])).rows[0];
        if(!user){await db.query('ROLLBACK');return json({error:'Invalid session'},401,headers);}
        const result=await changePassword(db,user,input);
        await db.query(result.status===200?'COMMIT':'ROLLBACK');
        return json(result.body,result.status,result.status===200?{...headers,'set-cookie':'session_token=; Path=/; HttpOnly; Secure; SameSite=Lax; Max-Age=0'}:headers);
      }catch(error){await db.query('ROLLBACK');throw error;}
    });
  }
  if(path==='/admin/users' && !['GET','POST'].includes(request.method)) {
    const safe=new Headers(headers);safe.set('cache-control','no-store');safe.set('allow','GET, POST');
    return json({error:'Method not allowed'},405,safe);
  }
  if(path==='/admin/users' && request.method==='GET') {
    const safe=new Headers(headers);safe.set('cache-control','no-store');
    const token=request.headers.has('authorization')?tokenFrom(request):null;
    if(!token)return json({error:'No session'},401,safe);
    try {
      if(env.WORKSPACE_SOURCE_LIMIT) {
        const key=await sha256('account-list:'+(request.headers.get('cf-connecting-ip')??'unknown'));
        if(!(await env.WORKSPACE_SOURCE_LIMIT.limit({key})).success){safe.set('retry-after','60');return json({error:'Too many requests'},429,safe);}
      }
      return await withDb(env,async db=>{
        await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
        try {
          const actor=(await db.query("SELECT u.id,u.roles,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' LIMIT 1",[await sha256(token)])).rows[0];
          if(!actor)return json({error:'Invalid session'},401,safe);
          if(!actor.tenant_id||(request.headers.has('x-tenant-id')&&request.headers.get('x-tenant-id')!==String(actor.tenant_id)))return json({error:'Forbidden'},403,safe);
          const result=await listAccounts(db,actor,new URL(request.url));return json(result.body,result.status,safe);
        }finally {await db.query('ROLLBACK');}
      });
    }catch{return json({error:'Account list unavailable'},503,safe);}
  }
  if(path==='/admin/users' && request.method==='POST') {
    const token=request.headers.has('authorization')?tokenFrom(request):null;
    if(!token) return json({error:'No session'},401,headers);
    let input;
    try{input=validateAccountUpdate(await parseBody(request));}catch(error){return bodyFailure(error,'Invalid request',headers);}
    if(!input) return json({error:'Invalid account fields'},400,headers);
    return withDb(env,async db=>{
      const limited=await mutationLimit(db,token,'manageAccount',headers);
      if(limited)return limited;
      await db.query('BEGIN');
      try{
        const actor=(await db.query("SELECT u.id,u.roles,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' FOR SHARE OF u,s",[await sha256(token)])).rows[0];
        if(!actor){await db.query('ROLLBACK');return json({error:'Invalid session'},401,headers);}
        const tenant=request.headers.get('x-tenant-id');
        if(tenant && tenant!==String(actor.tenant_id)){await db.query('ROLLBACK');return json({error:'Forbidden'},403,headers);}
        const result=await manageAccount(db,actor,input);
        await db.query(result.status===200?'COMMIT':'ROLLBACK');
        return json(result.body,result.status,headers);
      }catch(error){await db.query('ROLLBACK');throw error;}
    });
  }
  if (request.method === 'POST' && path === '/register') {
    // Creation accepts explicit bearer credentials, never ambient cookies.
    const token = request.headers.has('authorization') ? tokenFrom(request) : null;
    if (!token) return json({error:'No session'},401,headers);
    let body: Json;
    try { body = await parseBody(request); } catch(error) { return bodyFailure(error,'Invalid request',headers); }
    const email = typeof body.email === 'string' ? body.email.trim().toLowerCase() : '';
    const password = typeof body.password === 'string' ? body.password : '';
    const role = typeof body.role === 'string' ? body.role : '';
    if (Object.keys(body).some(key => !['email','password','role'].includes(key)) ||
        !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email) || email.length > 254 ||
        password.length < 12 || new TextEncoder().encode(password).length > 72 || !role) {
      return json({error:'Invalid account fields'},400,headers);
    }
    return withDb(env, async db => {
      const limited=await mutationLimit(db,token,'createAccount',headers);
      if(limited)return limited;
      await db.query('BEGIN');
      try {
        const result = await db.query(
          "SELECT u.id,u.roles,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' FOR SHARE OF u,s",
          [await sha256(token)]);
        const actor = result.rows[0];
        const policy = accountPolicy as Record<string,string[]>;
        if (!actor) { await db.query('ROLLBACK'); return json({error:'Invalid session'},401,headers); }
        if (!actor.tenant_id || !Object.hasOwn(policy,String(actor.roles)) || !policy[String(actor.roles)].includes(role)) {
          await db.query('ROLLBACK'); return json({error:'Forbidden'},403,headers);
        }
        const tenantHeader = request.headers.get('x-tenant-id');
        if (tenantHeader && tenantHeader !== String(actor.tenant_id)) {
          await db.query('ROLLBACK'); return json({error:'Forbidden'},403,headers);
        }
        await db.query('SELECT pg_advisory_xact_lock(hashtext($1))',[email]);
        const duplicate = await db.query('SELECT id FROM users WHERE LOWER(email)=$1 LIMIT 1',[email]);
        if (duplicate.rows.length) { await db.query('ROLLBACK'); return json({error:'Account cannot be created'},409,headers); }
        const createdId = crypto.randomUUID();
        const created = await db.query(
          "INSERT INTO users(email,tenant_id,roles,password_hash,status,id,updated_at) VALUES($1,$2,$3,$4,'active',$5,NOW()) RETURNING id,email,tenant_id,roles,status",
          [email,actor.tenant_id,role,await bcrypt.hash(password,12),createdId]);
        if(created.rows.length!==1)throw Error('Invalid account creation result');
        const createdUser = mutatedAccount(created.rows[0],{id:createdId,email,role,status:'active',tenantId:actor.tenant_id});
        await db.query("INSERT INTO auth_account_audit(actor_user_id,target_user_id,tenant_id,action) VALUES($1,$2,$3,'account_created')",
          [actor.id,createdUser.id,actor.tenant_id]);
        await db.query('COMMIT');
        return json({user:createdUser},201,headers);
      } catch(error) {
        await db.query('ROLLBACK');
        if ((error as {code?:string}).code === '23505') return json({error:'Account cannot be created'},409,headers);
        throw error;
      }
    });
  }
  if (request.method === 'POST' && path === '/login') {
    let body: Json;
    try { body = await parseBody(request); } catch(error) { return bodyFailure(error,'Invalid request',headers); }
    const email = typeof body.email === 'string' ? body.email.trim().toLowerCase() : '';
    const password = typeof body.password === 'string' ? body.password : '';
    if (!email || email.length > 254 || !password) return json({ error: 'Email and password are required' }, 400, headers);
    // bcrypt ignores bytes beyond 72; never accept a suffix alias of a password.
    if (new TextEncoder().encode(password).length > 72) return json({error:'Invalid credentials'},401,headers);

    return withDb(env, async (db) => {
      const retryAfter = await loginRateLimit(db, await sha256('login:' + email));
      if (retryAfter !== null) return json({error:'Too many login attempts'},429,
        {...headers,'retry-after':String(retryAfter)});
      const result = await db.query(
        'SELECT id, roles, password_hash, status FROM users WHERE LOWER(email) = $1 LIMIT 2', [email]);
      const user = result.rows[0];
      if (result.rows.length !== 1 || !user || (typeof user.status !== 'string' || user.status.toLowerCase() !== 'active') ||
          typeof user.password_hash !== 'string' || !await bcrypt.compare(password, user.password_hash)) {
        return json({ error: 'Invalid credentials' }, 401, headers);
      }
      const identity = authIdentity(user);
      const token = newToken();
      // Revalidate the checked credential while locking the user until the insert
      // commits. Password/status updates either win first (no session is issued),
      // or wait for this insert and then revoke it in their existing transaction.
      const session = await db.query(
        `INSERT INTO auth_sessions (token_hash, user_id, expires_at)
         SELECT $1, u.id, NOW() + INTERVAL '12 hours' FROM users u
         WHERE u.id=$2 AND u.password_hash=$3 AND LOWER(u.status)='active'
         FOR SHARE OF u RETURNING token_hash`,
        [await sha256(token), user.id, user.password_hash]);
      if (session.rows.length !== 1) return json({error:'Invalid credentials'},401,headers);
      return json({ userId: identity.userId, role: identity.roles, token, status: 'authenticated' }, 200, {
        ...headers,
        'set-cookie': `session_token=${token}; Path=/; HttpOnly; Secure; SameSite=Lax; Max-Age=43200`,
        'cache-control': 'no-store',
      });
    });
  }

  // Registered POST and approved GET compatibility share all validation.
  if (['GET', 'POST'].includes(request.method) && path === '/me') {
    const token = tokenFrom(request);
    if (!token) return json({ error: 'No session' }, 401, headers);
    return withDb(env, async (db) => {
      const result = await db.query(
        "SELECT u.id, u.roles FROM auth_sessions s JOIN users u ON u.id = s.user_id WHERE s.token_hash = $1 AND s.expires_at > NOW() AND LOWER(u.status) = 'active' LIMIT 1",
        [await sha256(token)]);
      const user = result.rows[0];
      if(result.rows.length>1)throw Error('Ambiguous session identity');
      return user
        ? json({ ...authIdentity(user), status: 'authenticated' }, 200, { ...headers, 'cache-control': 'no-store' })
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
