import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {execFileSync} from 'node:child_process';
import {isDeepStrictEqual} from 'node:util';
import {VapiAgentLibraryClient} from '../packages/shared/src/communications/vapi-agent-library.mjs';
const report={source:process.env.GITHUB_SHA,agents:[],callsStarted:false,smsSent:false,phoneRoutingChanged:false,businessToolsAttached:false,status:'pending'};
try{
 execFileSync('git',['fetch','origin','main'],{stdio:'pipe'});if(execFileSync('git',['rev-parse','FETCH_HEAD'],{encoding:'utf8'}).trim()!==report.source)throw Error('stale_main');
 const catalog=JSON.parse(await readFile('packages/shared/src/vapi-agent-templates.json','utf8'));
 const baseline=JSON.parse(await readFile('packages/shared/src/vapi-agent-script-baseline.json','utf8'));
 const client=new VapiAgentLibraryClient({apiKey:process.env.VAPI_PRIVATE_API_KEY});
 const phonePath='/phone-number/3e9cee92-b463-47c8-9e1a-cdbf179cb675';
 const phone=client.scope(await client.request(phonePath));
 const toolId=await client.ensureVoicemail();report.voicemailToolId=toolId;
 for(const agent of catalog.agents)report.agents.push(await client.update(agent,baseline[agent.key],toolId));
 report.activeReception=await client.updateActiveReception(catalog.agents.find(a=>a.key==='reception'),await readFile('packages/shared/src/vapi-spoken-verification-instructions.txt','utf8'),toolId);
 const after=client.scope(await client.request(phonePath));if(!isDeepStrictEqual(after,phone))throw Error('phone_routing_changed');
 report.status='scripts_and_native_tools_verified_business_dependencies_pending';
}catch(e){report.status=/^[a-z_]{1,100}$/.test(e?.message??'')?e.message:'reconciliation_failed';if(Array.isArray(e.changedFields))report.changedFields=e.changedFields;process.exitCode=1;}
await mkdir('test-results/vapi',{recursive:true});await writeFile('test-results/vapi/agent-library.json',JSON.stringify(report,null,2)+'\n');console.log('VAPI_AGENT_LIBRARY '+JSON.stringify(report));
