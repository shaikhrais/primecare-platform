/** Dedicated Vapi -> PrimeCare tool credential. This authenticates the provider
 * only, never a caller, tenant, app session, permission or approval. Configure
 * a random 32-byte-or-stronger base64url secret in the server secret store and a
 * reusable Vapi credential; never reuse the Vapi management private API key.
 * Exact Bearer syntax and fixed-length digest comparison avoid prefix/whitespace
 * acceptance. Request URLs, query values, model body and cookies cannot auth.
 */
export function createVapiToolCredentialVerifier({secret}){
 if(typeof secret!=='string'||!/^[A-Za-z0-9_-]{43,128}$/.test(secret))throw Error('Dedicated Vapi tool credential required');
 const encode=new TextEncoder();
 const expected=crypto.subtle.digest('SHA-256',encode.encode(secret));
 return async request=>{
  const authorization=request.headers.get('authorization');
  if(typeof authorization!=='string'||!/^Bearer [A-Za-z0-9_-]{43,128}$/.test(authorization))return false;
  const candidate=new Uint8Array(await crypto.subtle.digest('SHA-256',encode.encode(authorization.slice(7))));
  const stored=new Uint8Array(await expected);let difference=0;
  for(let index=0;index<stored.length;index++)difference|=stored[index]^candidate[index];
  return difference===0;
 };
}
