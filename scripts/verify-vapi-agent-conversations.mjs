import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {execFileSync} from 'node:child_process';
import {VapiAgentLibraryClient,savedAgents} from '../packages/shared/src/communications/vapi-agent-library.mjs';
import {VapiPublicKnowledgeClient} from '../packages/shared/src/communications/vapi-public-knowledge.mjs';
const report={source:process.env.GITHUB_SHA,status:'pending',agents:[],authenticationChanged:false,callsStarted:false,smsSent:false,businessWrites:false,configurationChanged:false,privateActionsLive:false};
try{
 execFileSync('git',['fetch','origin','main'],{stdio:'pipe'});
 if(execFileSync('git',['rev-parse','FETCH_HEAD'],{encoding:'utf8'}).trim()!==report.source)throw Error('stale_main');
 const catalog=JSON.parse(await readFile('packages/shared/src/vapi-agent-templates.json','utf8'));
 const client=new VapiAgentLibraryClient({apiKey:process.env.VAPI_PRIVATE_API_KEY}),knowledge=new VapiPublicKnowledgeClient({apiKey:process.env.VAPI_PRIVATE_API_KEY});
 const approvedIds=['3c5ee8ee-8f7c-4adf-a90f-cba2809ed43b','8fda5a14-5833-4000-95f4-b6406351c0cd'];
 const preflight=async agent=>{
  const row=client.scope(await client.request('/assistant/'+savedAgents[agent.key]));
  if(row.id!==savedAgents[agent.key]||row.name!==agent.name||row.model?.messages?.filter(m=>m.role==='system').length!==1||row.model.messages.find(m=>m.role==='system').content!==agent.prompt||row.firstMessage!==agent.firstMessage||row.server?.url||row.hooks?.length||row.model.functions?.length||row.model.tools?.some(t=>t.type!=='endCall')||row.model.toolIds?.length!==2||approvedIds.some(id=>!row.model.toolIds.includes(id)))throw Error('unreviewed_assistant_configuration');
  for(const id of approvedIds){const tool=client.scope(await client.request('/tool/'+id));if(tool.id!==id||tool.server?.url||tool.type!==(id===approvedIds[0]?'query':'voicemail'))throw Error('unreviewed_tool_configuration');if(tool.type==='query'&&(tool.function?.name!=='primecare_service_information'||tool.knowledgeBases?.length!==1||tool.knowledgeBases[0].fileIds?.length!==1||tool.knowledgeBases[0].fileIds[0]!=='40b4d2df-67a4-402c-814b-4cc67592942c'))throw Error('unreviewed_public_source');}
 };
 // Live chats only; no phone calls, tool writes, provider patches or auth changes.
 for(const agent of catalog.agents){
  const entry={agentKey:agent.key,assistantId:savedAgents[agent.key],scriptVersion:agent.scriptVersion};report.agents.push(entry);
  await preflight(agent);entry.configurationReadback=true;entry.publicInformation=await knowledge.probe(entry.assistantId);
  await preflight(agent);entry.unavailableAction=await knowledge.probeUnavailable(agent.key);
  await preflight(agent);entry.configurationUnchanged=true;
 }
 report.status='all_eight_agent_chat_checks_passed_private_actions_not_live';
}catch(e){report.status=/^[a-z_]{1,100}$/.test(e?.message??'')?e.message:'agent_acceptance_failed';if(e.acceptance)report.failure=e.acceptance;process.exitCode=1;}
await mkdir('test-results/vapi',{recursive:true});await writeFile('test-results/vapi/agent-conversations.json',JSON.stringify(report,null,2)+'\n');console.log('VAPI_AGENT_CONVERSATIONS '+JSON.stringify(report));
