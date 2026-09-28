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
