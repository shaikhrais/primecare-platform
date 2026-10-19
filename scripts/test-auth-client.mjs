import { build } from 'esbuild';
import assert from 'node:assert/strict';
import { test } from 'node:test';
const result = await build({ entryPoints: ['websites/typescript/src/auth-client.ts'], bundle: true,
  write: false, platform: 'node', format: 'esm' });
const { login } = await import('data:text/javascript;base64,' + Buffer.from(result.outputFiles[0].text).toString('base64'));
test('uses the gateway login route and preserves credential payload', async () => {
  const token = await login('https://gateway.test/', 'fixture@example.invalid', 'synthetic-test-value', async (url, init) => {
    assert.equal(url, 'https://gateway.test/v1/auth/login');
    assert.equal(init.method, 'POST');
    assert.deepEqual(JSON.parse(init.body), { email: 'fixture@example.invalid', password: 'synthetic-test-value' });
    return Response.json({ token: 'synthetic-token' });
  });
  assert.equal(token, 'synthetic-token');
});
test('rejects missing, blank, and invalid session tokens', async () => {
  for (const payload of [{}, {token:''}, {token:' '}, {token:42}, null]) {
    await assert.rejects(login('https://gateway.test', '', '', async () => Response.json(payload)), /missing a session token/);
  }
});
test('preserves invalid-credential failure', async () => {
  await assert.rejects(login('https://gateway.test', '', '', async () => Response.json({error:'Invalid credentials'}, {status:401})), /Invalid credentials/);
});
test('rejects malformed upstream response', async () => {
  await assert.rejects(login('https://gateway.test', '', '', async () => new Response('<html>error</html>', {status:502})), /Invalid authentication response/);
});
test('propagates connection failure', async () => {
  await assert.rejects(login('https://gateway.test', '', '', async () => { throw new Error('Network unavailable'); }), /Network unavailable/);
});

const {authenticate}=await import('data:text/javascript;base64,'+Buffer.from(result.outputFiles[0].text).toString('base64'));
test('confirmation returns identity only after authenticated me response',async()=>{
 const calls=[];const session=await authenticate('https://gateway.test/','synthetic@example.invalid','synthetic',async(url,init)=>{calls.push(url);return url.endsWith('/login')?Response.json({token:'synthetic-token'}):Response.json({userId:'synthetic-user',roles:'psw',status:'authenticated'});});
 assert.equal(session.identity.roles,'psw');assert.equal(session.token,'synthetic-token');assert.deepEqual(calls,['https://gateway.test/v1/auth/login','https://gateway.test/v1/auth/me']);
});
test('failed or malformed identity revokes provisional session without masking failure',async()=>{
 for(const me of [()=>Response.json({error:'unavailable'},{status:503}),()=>Response.json({userId:'x',roles:'psw'}),()=>Response.json({userId:'x',roles:[],status:'authenticated'}),()=>{throw Error('Network unavailable');}]){
  const calls=[];await assert.rejects(authenticate('https://gateway.test','synthetic@example.invalid','synthetic',async(url,init)=>{calls.push(url);if(url.endsWith('/login'))return Response.json({token:'synthetic-token'});if(url.endsWith('/me'))return me();assert.equal(init.method,'POST');assert.equal(init.headers.authorization,'Bearer synthetic-token');throw Error('Synthetic logout outage');}));
  assert.deepEqual(calls,['https://gateway.test/v1/auth/login','https://gateway.test/v1/auth/me','https://gateway.test/v1/auth/logout']);
 }
});
