// Run API fixtures and record their scope honestly. No production-ready flag is set.
import {execFileSync} from 'node:child_process';
import {readFileSync,writeFileSync,mkdirSync,readdirSync} from 'node:fs';
import {createHash} from 'node:crypto';
const suites=['test-governance-api.mjs','test-account-list-api.mjs','test-workspace.mjs','test-auth-maintenance.mjs','test-auth-recovery.mjs','test-auth-api.mjs','test-auth-client.mjs','test-auth-bootstrap.mjs','test-auth-management.mjs','test-auth-password.mjs','test-auth-schema.mjs','test-auth-cleanup.mjs','test-auth-source.mjs'];
const output=execFileSync(process.execPath,['--test',...suites.map(f=>'scripts/'+f)],{encoding:'utf8'});
const count=Number(/(?:#|ℹ) tests (\d+)/.exec(output)?.[1]);
const fail=Number(/(?:#|ℹ) fail (\d+)/.exec(output)?.[1]);
if(!count||fail!==0)throw Error('Cannot establish passing fixture evidence');
const sources=[...readdirSync('cloudflare/workers/src').filter(f=>/\.(ts|json)$/.test(f)).sort().map(f=>'cloudflare/workers/src/'+f),...suites.map(f=>'scripts/'+f)];
const hashes=Object.fromEntries(sources.map(p=>[p,createHash('sha256').update(readFileSync(p)).digest('hex')]));
const evidence={scope:'local_unit_fixtures',passed:count,failed:fail,productionVerified:false,postgresVerified:false,sourceHashes:hashes};
mkdirSync('docs/api',{recursive:true});writeFileSync('docs/api/batch-test-evidence.json',JSON.stringify(evidence,null,2)+'\n');
execFileSync('python3',['scripts/record-api-batch-evidence.py'],{stdio:'inherit'});
console.log(`${count} API fixture tests passed; runtime and PostgreSQL gates remain separate.`);
