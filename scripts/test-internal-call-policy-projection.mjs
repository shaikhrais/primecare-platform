import assert from 'node:assert/strict';import pg from 'pg';import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {PostgresCommunicationPolicyBase} from '../cloudflare/workers/src/business-tasks/access-policy.ts';
const url=new URL(process.env.TWILIO_SMS_TEST_DATABASE_URL??'');if(!['localhost','127.0.0.1'].includes(url.hostname)||url.username!=='twilio_fixture'||url.pathname!=='/twilio_sms_test'||process.env.PRODUCTION_DATABASE_URL)throw Error('Disposable native policy database required');
const pin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8')),definition=JSON.parse(await readFile('tools/governance-production/communication-access-policy.json','utf8'));if(!/^[a-z0-9_]+$/.test(pin.schema))throw Error('Pinned fixture schema required');
const pool=new pg.Pool({connectionString:url.href,max:2}),schema='"'+pin.schema+'"';let owned=false;
class ProjectionProbe extends PostgresCommunicationPolicyBase{async verify(){return this.inspect(async(_db,boxes)=>boxes.length);}}
try{
 assert.equal((await pool.query('SELECT to_regnamespace($1) AS name',[pin.schema])).rows[0].name,null);await pool.query('CREATE SCHEMA '+schema);owned=true;
 await pool.query('CREATE TABLE '+schema+'.govt_source_manifest(manifest_sha256 text NOT NULL)');await pool.query('INSERT INTO '+schema+'.govt_source_manifest VALUES($1)',[pin.manifestSha256]);
 for(const representation of ['native-text','json-string','tagged-text']){
  const type=representation==='native-text'?'text':'jsonb';await pool.query('CREATE TABLE '+schema+'.govt_platform_hierarchy_policy(id '+type+',definition '+type+',requirement '+type+',unrelated_large_document text)');
  const encode=value=>representation==='native-text'?value:JSON.stringify(representation==='tagged-text'?{t:'text',v:value}:value);
  for(const doc of Object.values(definition))await pool.query('INSERT INTO '+schema+".govt_platform_hierarchy_policy VALUES($1,$2,$3,repeat('unrelated-data',100000))",[encode(doc.id),encode(JSON.stringify(doc)),encode(doc.requirement)]);
  const probe=new ProjectionProbe(pool);assert.equal(await probe.verify(),definition.directory.mailboxes.length);
  await pool.query('UPDATE '+schema+'.govt_source_manifest SET manifest_sha256=$1',['0'.repeat(64)]);await assert.rejects(probe.verify(),/policy unavailable/);await pool.query('UPDATE '+schema+'.govt_source_manifest SET manifest_sha256=$1',[pin.manifestSha256]);
  await pool.query('UPDATE '+schema+'.govt_platform_hierarchy_policy SET requirement=$1',[encode('operator-edited')]);await assert.rejects(probe.verify(),/policy unavailable/);
  await pool.query('DROP TABLE '+schema+'.govt_platform_hierarchy_policy');
 }
 await pool.query('CREATE TABLE '+schema+'.govt_platform_hierarchy_policy(id jsonb,definition jsonb,requirement jsonb)');
 for(const doc of Object.values(definition))await pool.query('INSERT INTO '+schema+'.govt_platform_hierarchy_policy VALUES($1,$2,$3)',[JSON.stringify({t:'blob',v:doc.id}),JSON.stringify({t:'text',v:JSON.stringify(doc)}),JSON.stringify({t:'text',v:doc.requirement})]);
 await assert.rejects(new ProjectionProbe(pool).verify(),/policy unavailable/);
 const report={source:process.env.GITHUB_SHA,nativePostgres:true,representations:['native-text','json-string','tagged-text'],largeUnrelatedFieldsPreserved:true,manifestDriftDenied:true,policyDriftDenied:true,unknownTagDenied:true,passed:true};await mkdir('test-results/internal-calls',{recursive:true});await writeFile('test-results/internal-calls/policy-projection.json',JSON.stringify(report,null,2)+'\n');console.log('INTERNAL_CALL_POLICY_PROJECTION '+JSON.stringify(report));
}finally{if(owned)await pool.query('DROP SCHEMA '+schema+' CASCADE');await pool.end();}
