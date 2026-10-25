import {test} from 'node:test';import assert from 'node:assert/strict';import {readFileSync} from 'node:fs';
import {PostgresInternalCallEndpointPolicy} from '../cloudflare/workers/src/business-tasks/internal-call-endpoint-policy.ts';
const pin=JSON.parse(readFileSync('tools/governance-production/production-pin.json')),actor={id:'fixture-user',tenantId:'fixture-tenant'};
test('native calling keeps every inherited grant check while preserving indexed scalar keys',async()=>{
 const queries=[];let allowed=true;
 const policy=new PostgresInternalCallEndpointPolicy({async connect(){return {async query(sql,values){queries.push({sql,values});return {rows:sql.startsWith('SELECT manifest')?[{manifest_sha256:pin.manifestSha256}]:sql.startsWith('SELECT DISTINCT')&&allowed?[{role_id:'7',screen_id:'234',api_id:'16545'}]:[]};},release(){}};}});
 const request=new Request('https://fixture.invalid/v1/calls/command',{method:'POST'});await policy.authorize(actor,'call.command',request);
 const query=queries.find(q=>q.sql.startsWith('SELECT DISTINCT'));assert.ok(query.sql.includes('ap."role_id"=r."id"'));assert.ok(query.sql.includes('ap."api_id"'));assert.ok(query.sql.includes('r."role_code"=u.roles::text'));assert.ok(!query.sql.includes('to_jsonb(ap."role_id")'));
 for(const required of ['api_permissions','role_screen_permissions','screen_api_links','can_access','can_view','LOWER(u.status)','LOWER(t.status)','COUNT(*)','permission_key','endpoint_code'])assert.ok(query.sql.includes(required));
 assert.equal(query.values[5],'INTERNAL_CALL_COMMAND');allowed=false;await assert.rejects(policy.authorize(actor,'call.command',request),/Forbidden/);
 const count=queries.length;await assert.rejects(policy.authorize(actor,'call.media',request),/Forbidden/);assert.equal(queries.length,count);
});
