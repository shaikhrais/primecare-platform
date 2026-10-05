// Run API fixtures and record their scope honestly. No production-ready flag is set.
import {execFileSync} from 'node:child_process';
import {readFileSync,writeFileSync,mkdirSync,readdirSync,mkdtempSync,rmSync} from 'node:fs';
import {createHash} from 'node:crypto';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
function runFixtures(suites){
 const directory=mkdtempSync(join(tmpdir(),'primecare-api-fixtures-'));
 try{return execFileSync(process.execPath,['--test',...suites.map(f=>'scripts/'+f)],{encoding:'utf8',env:{...process.env,TMPDIR:directory,TMP:directory,TEMP:directory}});}
 finally{rmSync(directory,{recursive:true,force:true});}
}
const suites=['test-client-records-api.mjs','test-client-booking-lifecycle-api.mjs','test-legacy-domain-api.mjs','test-provider-self-api.mjs','test-client-self-api.mjs','test-self-sessions-api.mjs','test-account-admin-api.mjs','test-governance-api.mjs','test-account-list-api.mjs','test-workspace.mjs','test-auth-maintenance.mjs','test-auth-recovery.mjs','test-auth-api.mjs','test-auth-client.mjs','test-auth-bootstrap.mjs','test-auth-management.mjs','test-auth-password.mjs','test-auth-schema.mjs','test-auth-cleanup.mjs','test-auth-source.mjs'];
let output=runFixtures(suites);
let count=Number(/(?:#|ℹ) tests (\d+)/.exec(output)?.[1]);
let fail=Number(/(?:#|ℹ) fail (\d+)/.exec(output)?.[1]);
if(!count||fail!==0)throw Error('Cannot establish passing fixture evidence');
const sources=[...readdirSync('cloudflare/workers/src').filter(f=>/\.(ts|json)$/.test(f)).sort().map(f=>'cloudflare/workers/src/'+f),...suites.map(f=>'scripts/'+f)];
const hashes=Object.fromEntries(sources.map(p=>[p,createHash('sha256').update(readFileSync(p)).digest('hex')]));
const evidence={scope:'local_unit_fixtures',passed:count,failed:fail,productionVerified:false,postgresVerified:false,sourceHashes:hashes};
mkdirSync('docs/api',{recursive:true});writeFileSync('docs/api/batch-test-evidence.json',JSON.stringify(evidence,null,2)+'\n');
execFileSync('python3',['scripts/record-api-batch-evidence.py'],{stdio:'inherit'});
// Recording unit status changes the generated metadata snapshot. Regenerate
// and test that final snapshot, then bind evidence to its exact source hashes.
execFileSync('python3',['scripts/generate-api-execution-inventory.py'],{stdio:'inherit'});
output=runFixtures(suites);
count=Number(/(?:#|ℹ) tests (\d+)/.exec(output)?.[1]);fail=Number(/(?:#|ℹ) fail (\d+)/.exec(output)?.[1]);
if(!count||fail!==0)throw Error('Final generated snapshot fixtures failed');
evidence.passed=count;evidence.sourceHashes=Object.fromEntries(sources.map(p=>[p,createHash('sha256').update(readFileSync(p)).digest('hex')]));
writeFileSync('docs/api/batch-test-evidence.json',JSON.stringify(evidence,null,2)+'\n');
execFileSync('python3',['scripts/record-api-batch-evidence.py'],{stdio:'inherit'});
console.log(`${count} API fixture tests passed; runtime and PostgreSQL gates remain separate.`);
