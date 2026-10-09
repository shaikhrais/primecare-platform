/** Only reviewed canonical contracts may suppress a mutation diagnostic body. */
import {readFileSync} from 'node:fs';
export const BODYLESS_CONTRACTS={
 'DELETE /v1/user/sessions':'docs/api/self-sessions-batch-6.openapi.json',
 'DELETE /v1/admin/users/{userId}/sessions':'docs/api/account-batch-3.openapi.json',
 'POST /v1/client/booking-requests/{requestId}/cancel':'docs/api/client-booking-lifecycle-batch-19.openapi.json',
};
export function isBodylessDiagnostic(api){
 const source=BODYLESS_CONTRACTS[api];if(!source)return false;
 const [method,route]=api.split(' '),spec=JSON.parse(readFileSync(new URL('../'+source,import.meta.url),'utf8'));
 const operation=spec.paths?.[route]?.[method.toLowerCase()];
 if(!operation||Object.hasOwn(operation,'requestBody'))throw Error('Reviewed bodyless diagnostic contract changed: '+api);
 return true;
}
