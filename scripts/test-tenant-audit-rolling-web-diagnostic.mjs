import assert from 'node:assert/strict';
import {readFile,writeFile,mkdir} from 'node:fs/promises';
import {join} from 'node:path';
import {browser} from './fixtures/platform-admin.mjs';
assert.equal(process.env.GITHUB_ACTIONS,'true');assert.match(process.env.GITHUB_SHA??'',/^[a-f0-9]{40}$/);
const web=process.env.ROLLING_VERSION;assert.ok(['live','safe','partial'].includes(web));const dir=process.env.ROLLING_FIXTURE_DIR;assert.ok(dir&&dir.startsWith(process.env.RUNNER_TEMP+'/'));
const summary={sourceCommit:process.env.GITHUB_SHA,webVersion:web,diagnosticOnly:true,workflowAccepted:false,rollingDeploymentSafe:false,syntheticOnly:true,productionAccess:false,results:[]};
for(const api of ['live','safe','partial'])for(const fixture of JSON.parse(await readFile(join(dir,api+'-responses.json'),'utf8'))){
 const f=browser({role:'tenant_admin',hash:'#audit',locale:'en'});
 f.respond=async url=>url.endsWith('/v1/governance/platform')?Response.json(f.data):url.endsWith('/tenants/tenant-a/audit')?Response.json(fixture.body,{status:fixture.status}):Response.json({users:[],records:[],events:[],partners:[]});
 await f.render();const html=f.root.innerHTML,start=html.indexOf('<ul data-cy="platform-audit">'),audit=start<0?'':html.slice(start,html.indexOf('</ul>',start)),visible=start>=0,notice=audit.includes('data-audit-detail-unavailable="previous_state.status"'),bad=fixture.name==='malformed_current',legacy=fixture.name.startsWith('legacy_');
 const expectedVisible=fixture.status===200&&(web==='live'||(!bad&&!(web==='safe'&&api==='live'&&legacy)));assert.equal(visible,expectedVisible,'Unexpected render/fail-closed outcome: '+web+'/'+api+'/'+fixture.name);
 assert.equal(notice,visible&&web==='partial'&&legacy);assert.equal(audit.includes('RAW_CANARY')||audit.includes('synthetic-actor'),false);
 if(visible){assert.ok(audit.includes('account_updated'));assert.ok(audit.includes('2026-01-01'));if(web!=='live')assert.ok(audit.includes('synthetic-target'));}
 summary.results.push({apiVersion:api,case:fixture.name,apiStatus:fixture.status,auditVisible:visible,unavailableDetailVisible:notice,actorNotDisclosed:true,rawStateNotDisplayed:true,legacySilentlyUnmarked:legacy&&visible&&!notice,newWebRejectsOldMalformedApi:bad&&web!=='live'&&!visible});
}
summary.blockers=[...(web!=='partial'?['old_web_does_not_explain_new_api_unavailable_details']:[]),'cross_version_503_availability','raw_database_vs_normalized_projector_trust_boundary','response_contract_and_localization_approval','actor_policy'];
await mkdir('test-results/tenant-audit-rolling',{recursive:true});await writeFile('test-results/tenant-audit-rolling/web-'+web+'.json',JSON.stringify(summary,null,2)+'\n');
