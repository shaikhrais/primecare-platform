import {createHash} from 'node:crypto';
import {readFileSync} from 'node:fs';
const paths=[
 'cloudflare/workers/src/security/mfa-keyring.mjs','cloudflare/workers/src/security/mfa-key-rotation.mjs',
 'cloudflare/workers/src/security/mfa-secret.mjs','cloudflare/workers/src/security/totp.mjs',
 'cloudflare/workers/src/security/mfa-keyring-policy.json','cloudflare/workers/src/service-application.ts',
 'scripts/generate-cloudflare-worker-config.mjs','scripts/mfa-keyring-source.mjs',
];
/** Public source fingerprint only. Never read environment keys or account data. */
export function mfaKeyringSource(){
 const hash=createHash('sha256');for(const path of paths)hash.update(path).update('\0').update(readFileSync(new URL('../'+path,import.meta.url))).update('\0');return hash.digest('hex');
}
