import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
test('direct TypeScript producers share a non-cancelling release lock',async()=>{
 for(const name of ['deploy-typescript-websites','psw-workspace','business-plan-cycles','code-admin-look']){
  const text=await readFile('.github/workflows/'+name+'.yml','utf8');
  assert.match(text,/group: primecare-cloudflare-typescript-production[,\n]/,name);
  assert.match(text,/cancel-in-progress: false/,name);
 }
});
test('account metadata stays inside the locked publisher and portal uploads verify current source',async()=>{
 const account=await readFile('.github/workflows/verify-account-mutations.yml','utf8');
 const bind=account.split('\n  bind:\n')[1]?.split('\n  deploy:\n')[0];
 assert.ok(bind&&!bind.includes('--apply')&&!bind.includes('concurrency:'));
 assert.match(account,/bind_account_metadata: true/);
 const deploy=await readFile('.github/workflows/deploy-typescript-websites.yml','utf8');
 assert.match(deploy,/bind_account_metadata:[\s\S]*?type: boolean\n\s+default: false/);
 const build=deploy.split('\n  build:\n')[1]?.split('\n  deploy:\n')[0];
 assert.match(build??'',/if \[ "\$\{\{ inputs.bind_account_metadata \}\}" = true \]; then\n\s+git fetch origin main\n\s+test "\$\(git rev-parse FETCH_HEAD\)" = "\$GITHUB_SHA"/);
 for(const script of ['account_mutations_registration','tenant_accounts_registration','recovery_registration']){assert.ok(!account.includes(script+'.py --apply'));assert.ok(build.includes(script+'.py --apply'));}
 assert.match(deploy,/name: Deploy \$\{\{ matrix\.project \}\}[\s\S]*?set -euo pipefail\n\s+git fetch origin main\n\s+test "\$\(git rev-parse FETCH_HEAD\)" = "\$GITHUB_SHA"[\s\S]*?wrangler@/);
 assert.match(deploy,/name: Verify current main before release verification/);
 const psw=await readFile('.github/workflows/psw-workspace.yml','utf8');assert.match(psw,/typescript_release verify-deploy "websites\/typescript\/dist\/\$project" "\$project"/);
});
