import {readFileSync} from 'node:fs';
const read=name=>JSON.parse(readFileSync('cloudflare/workers/src/'+name+'-registry.json','utf8'));
const registries={auth:read('self-records'),provider:read('provider-records'),client:read('client-records')};
const special={
 '/v1/client/bookings':{table:'bookings',ownerField:'client_id'},
 '/v1/client/booking-requests':{table:'booking_requests',ownerField:'client_id'},
 '/v1/client/invoices':{table:'invoices',ownerField:'client_id',decimals:['subtotal','tax','total']},
 '/v1/client/visits':{table:'visits',ownerField:'client_id'},
 '/v1/provider/documents':{table:'provider_documents',ownerField:'provider_id',tenantMode:'provider'},
 '/v1/provider/availability':{table:'provider_availability',ownerField:'provider_id'}
};
export function aliasFixture(alias){
 const registered=registries[alias.service].find(r=>r.path===alias.targetPath);
 const result=special[alias.canonical]??(registered&&{table:registered.table,ownerField:registered.ownerField??(alias.service==='auth'?'user_id':alias.service==='provider'?'provider_id':'client_id'),tenantMode:registered.tenantThroughUser?'user':registered.tenantThroughProvider?'provider':'direct'});
 if(!result)throw Error('No audited alias fixture relationship for '+alias.canonical);
 return {tenantMode:'direct',...result};
}
