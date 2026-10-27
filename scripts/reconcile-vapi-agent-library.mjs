import {VapiRequestToolLibraryClient} from '../packages/shared/src/communications/vapi-request-tool-library.mjs';
import {VapiPublicKnowledgeClient} from '../packages/shared/src/communications/vapi-public-knowledge.mjs';
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {execFileSync} from 'node:child_process';
import {isDeepStrictEqual} from 'node:util';
import {VapiAgentLibraryClient} from '../packages/shared/src/communications/vapi-agent-library.mjs';
const report={source:process.env.GITHUB_SHA,agents:[],callsStarted:false,smsSent:false,phoneRoutingChanged:false,businessToolsAttached:false,authenticationChanged:false,credentialChanged:false,status:'pending'};
try{
 execFileSync('git',['fetch','origin','main'],{stdio:'pipe'});if(execFileSync('git',['rev-parse','FETCH_HEAD'],{encoding:'utf8'}).trim()!==report.source)throw Error('stale_main');
 const catalog=JSON.parse(await readFile('packages/shared/src/vapi-agent-templates.json','utf8'));
 const baseline=JSON.parse(await readFile('packages/shared/src/vapi-agent-script-baseline.json','utf8'));
 const client=new VapiAgentLibraryClient({apiKey:process.env.VAPI_PRIVATE_API_KEY});
 const phonePath='/phone-number/3e9cee92-b463-47c8-9e1a-cdbf179cb675';
 const phone=client.scope(await client.request(phonePath));
 const toolId=await client.ensureVoicemail();report.voicemailToolId=toolId;
 const knowledge=await new VapiPublicKnowledgeClient({apiKey:process.env.VAPI_PRIVATE_API_KEY}).ensure(await readFile('packages/shared/src/vapi-agent-public-knowledge.txt','utf8'));report.publicKnowledge=knowledge;report.savedRequestTools=await new VapiRequestToolLibraryClient({apiKey:process.env.VAPI_PRIVATE_API_KEY}).ensure();report.publicServiceToolAttached=true;report.businessToolsAttached=true;report.businessWriteToolsAttached=false;
 for(const agent of catalog.agents)report.agents.push(await client.update(agent,baseline[agent.key],toolId,knowledge.toolId));
 report.activeReception=await client.updateActiveReception(catalog.agents.find(a=>a.key==='reception'),await readFile('packages/shared/src/vapi-spoken-verification-instructions.txt','utf8'),toolId,baseline.reception,knowledge.toolId);
 const after=client.scope(await client.request(phonePath));if(!isDeepStrictEqual(after,phone))throw Error('phone_routing_changed');
 report.publicQueryAcceptance=await new VapiPublicKnowledgeClient({apiKey:process.env.VAPI_PRIVATE_API_KEY}).probe('9ba3014c-cfaa-4607-997c-b5347212be54');
 const readinessPath='test-results/vapi/agent-tool-readiness.json';const readiness=JSON.parse(await readFile(readinessPath,'utf8'));readiness.businessToolsAttached=true;readiness.businessWriteToolsAttached=false;readiness.publicServiceToolAttached=true;for(const row of readiness.agents)for(const tool of row.tools)if(tool.key==='service.catalogue'){tool.liveBusinessReady=true;tool.toolId=knowledge.toolId;tool.configurationReadback=true;}await writeFile(readinessPath,JSON.stringify(readiness,null,2)+'\n');
 report.status='agents_and_public_service_query_verified_private_tools_pending';
}catch(e){report.status=/^[a-z_]{1,100}$/.test(e?.message??'')?e.message:'reconciliation_failed';if(Array.isArray(e.changedFields))report.changedFields=e.changedFields;if(e.acceptance)report.publicQueryAcceptance=e.acceptance;if(e.storageHost)report.storageHost=e.storageHost;if(Number.isInteger(e.httpStatus))report.providerHttpStatus=e.httpStatus;process.exitCode=1;}
await mkdir('test-results/vapi',{recursive:true});await writeFile('test-results/vapi/agent-library.json',JSON.stringify(report,null,2)+'\n');console.log('VAPI_AGENT_LIBRARY '+JSON.stringify(report));
