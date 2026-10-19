/** Transport for the existing governed /v1/auth/login endpoint. */
export async function login(gateway: string, email: string, password: string,
  send: typeof fetch = fetch): Promise<string> {
  const response = await send(`${gateway.replace(/\/+$/, '')}/v1/auth/login`, {
    method: 'POST', headers: { 'content-type': 'application/json' },
    body: JSON.stringify({ email, password }),
  });
  let payload: unknown;
  try { payload = await response.json(); }
  catch { throw new Error(`Invalid authentication response (HTTP ${response.status})`); }
  const data = payload && typeof payload === 'object' ? payload as Record<string, unknown> : {};
  if (!response.ok) throw new Error(typeof data.error === 'string' ? data.error : `HTTP ${response.status}`);
  if (typeof data.token !== 'string' || !data.token.trim()) {
    throw new Error('Authentication response is missing a session token');
  }
  return data.token;
}

export type ConfirmedIdentity = {userId:string;roles:string;status:'authenticated'};

/** Confirm server revocation before a caller commits its browser sign-out. */
export async function signOut(gateway:string,token:string,send:typeof fetch=fetch):Promise<void> {
  const response=await send(`${gateway.replace(/\/+$/, '')}/v1/auth/logout`,{
    method:'POST',headers:{authorization:'Bearer '+token},cache:'no-store',
  });
  if(!response.ok)throw new Error('Session sign-out failed');
  let value:unknown;
  try{value=await response.json();}catch{throw new Error('Invalid sign-out response');}
  if(!value||typeof value!=='object'||Array.isArray(value)||
     (value as Record<string,unknown>).status!=='signed_out')throw new Error('Invalid sign-out response');
}

/** Clean up a newly issued session that cannot be safely committed by the UI. */
export async function revokeProvisionalSession(gateway:string,token:string,send:typeof fetch=fetch):Promise<void> {
  try {await send(`${gateway.replace(/\/+$/, '')}/v1/auth/logout`, {method:'POST',
    headers:{authorization:'Bearer '+token},cache:'no-store',signal:AbortSignal.timeout(5000)});}
  catch {/* Original confirmation/storage failure remains authoritative. */}
}

/** Credential exchange and identity confirmation complete before browser storage. */
export async function authenticate(gateway:string,email:string,password:string,send:typeof fetch=fetch):Promise<{token:string;identity:ConfirmedIdentity}> {
  const token=await login(gateway,email,password,send);
  try {
    const response=await send(`${gateway.replace(/\/+$/, '')}/v1/auth/me`,{headers:{authorization:'Bearer '+token},cache:'no-store'});
    if(!response.ok)throw new Error('Session confirmation failed');
    const value:unknown=await response.json();
    if(!value||typeof value!=='object'||Array.isArray(value))throw new Error('Invalid session identity');
    const identity=value as Record<string,unknown>;
    if(typeof identity.userId!=='string'||! /^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(identity.userId)||
       typeof identity.roles!=='string'||!identity.roles.trim()||identity.roles.length>200||identity.status!=='authenticated')throw new Error('Invalid session identity');
    return {token,identity:identity as ConfirmedIdentity};
  }catch(error){await revokeProvisionalSession(gateway,token,send);throw error;}
}
