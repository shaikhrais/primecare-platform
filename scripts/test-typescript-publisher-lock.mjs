import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
test('all direct TypeScript production producers share a non-cancelling release lock',async()=>{
 for(const name of ['deploy-typescript-websites','psw-workspace','business-plan-cycles','code-admin-look']){
  const text=await readFile('.github/workflows/'+name+'.yml','utf8');
  assert.match(text,/group: primecare-cloudflare-typescript-production[,\n]/,name);
  assert.match(text,/cancel-in-progress: false/,name);
 }
});
test('account metadata and every matrix portal upload reject stale main before writes',async()=>{
 const account=await readFile('.github/workflows/verify-account-mutations.yml','utf8');
 const guard=account.indexOf('name: Verify current main before account registration'),write=account.indexOf('name: Bind existing account processes');
 assert.ok(guard>=0&&write>guard);
 const deploy=await readFile('.github/workflows/deploy-typescript-websites.yml','utf8');
 assert.match(deploy,/name: Deploy \$\{\{ matrix\.project \}\}[\s\S]*?set -euo pipefail\n\s+git fetch origin main\n\s+test "\$\(git rev-parse FETCH_HEAD\)" = "\$GITHUB_SHA"[\s\S]*?wrangler@/);
 assert.match(deploy,/name: Verify current main before release verification/);
});
