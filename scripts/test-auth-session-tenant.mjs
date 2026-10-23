import {test} from 'node:test';
import assert from 'node:assert/strict';
import {sessionTenant} from '../cloudflare/workers/src/auth-session-tenant.mjs';
test('session tenant claim is a snapshot of native scope and ignores request-shaped overrides',()=>{
 const row={tenant_id:'native-tenant',tenantId:'forged',headers:{'x-tenant-id':'forged'}};
 const result=sessionTenant(row);row.tenant_id='changed';assert.deepEqual(result,{tenantId:'native-tenant'});
});
test('legacy missing scope never invents tenant authority',()=>{
 for(const tenant_id of [null,undefined])assert.deepEqual(sessionTenant({tenant_id,tenantId:'forged'}),{});
});
test('malformed native tenant claims fail without coercion',()=>{
 for(const tenant_id of ['',0,1,true,{},[],' a','a ','a\n','x'.repeat(201),'a/b','a.b'])assert.throws(()=>sessionTenant({tenant_id}));
});
