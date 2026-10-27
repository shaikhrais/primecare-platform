import {resolveClientInformationTool} from '../packages/shared/src/communications/vapi-client-information-tool.mjs';
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {execFileSync} from 'node:child_process';
import {VapiAgentLibraryClient,savedAgents} from '../packages/shared/src/communications/vapi-agent-library.mjs';
import {VapiPublicKnowledgeClient} from '../packages/shared/src/communications/vapi-public-knowledge.mjs';
// Recheck all saved roles after the current-call client-information release.
const report={source:process.env.GITHUB_SHA,status:'pending',agents:[],authenticationChanged:false,callsStarted:false,smsSent:false,businessWrites:false,configurationChanged:false,privateActionsLive:false};
try{
 execFileSync('git',['fetch','origin','main'],{stdio:'pipe'});
 if(execFileSync('git',['rev-parse','FETCH_HEAD'],{encoding:'utf8'}).trim()!==report.source)throw Error('stale_main');
 const replayPath=process.argv[2]==='--replay'&&process.argv[3];if(process.argv.length>2&&replayPath!=='docs/business/evidence/vapi-client-information-conversations-recorded-20261027.json')throw Error('unapproved_replay_source');
 const replay=replayPath?JSON.parse(await readFile(replayPath,'utf8')):null;
 if(replay&&(!Array.isArray(replay.agents)||replay.agents.length!==8||new Set(replay.agents.map(a=>a.agentKey)).size!==8))throw Error('invalid_replay_receipt');report.replayedSavedChats=!!replay;
 const catalog=JSON.parse(await readFile('packages/shared/src/vapi-agent-templates.json','utf8'));
 const client=new VapiAgentLibraryClient({apiKey:process.env.VAPI_PRIVATE_API_KEY}),knowledge=new VapiPublicKnowledgeClient({apiKey:process.env.VAPI_PRIVATE_API_KEY});
 const previousVerificationInstruction=await readFile('packages/shared/src/vapi-spoken-verification-instructions-baseline.txt','utf8');
 const verificationId='764dd85f-fafd-45c1-9352-45867ed94371',verificationInstruction=await readFile('packages/shared/src/vapi-spoken-verification-instructions.txt','utf8');
 const clientInformation=await resolveClientInformationTool(client);
 const approvedIds=['3c5ee8ee-8f7c-4adf-a90f-cba2809ed43b','8fda5a14-5833-4000-95f4-b6406351c0cd'];
 const requiredIds=[...approvedIds,...(clientInformation?[clientInformation.toolId]:[])];
 const preflight=async agent=>{
  const row=client.scope(await client.request('/assistant/'+savedAgents[agent.key]));
  const authenticated=(row.model?.toolIds??[]).includes(verificationId),expectedPrompt=agent.prompt+(authenticated?'\n\n'+verificationInstruction:'');
  if(row.id!==savedAgents[agent.key]||row.name!==agent.name||row.model?.messages?.filter(m=>m.role==='system').length!==1||!([expectedPrompt,...(authenticated?[agent.prompt+'\n\n'+previousVerificationInstruction]:[])].includes(row.model.messages.find(m=>m.role==='system').content))||row.firstMessage!==agent.firstMessage||row.server?.url||row.hooks?.length||row.model.functions?.length||row.model.tools?.some(t=>t.type!=='endCall')||row.model.toolIds?.length!==requiredIds.length+(authenticated?1:0)||requiredIds.some(id=>!row.model.toolIds.includes(id)))throw Error('unreviewed_assistant_configuration');
  // Web chat has no canonical PSTN call; the verification endpoint cannot send SMS from these synthetic chats.
  for(const id of approvedIds){const tool=client.scope(await client.request('/tool/'+id));if(tool.id!==id||tool.server?.url||tool.type!==(id===approvedIds[0]?'query':'voicemail'))throw Error('unreviewed_tool_configuration');if(tool.type==='query'&&(tool.function?.name!=='primecare_service_information'||tool.knowledgeBases?.length!==1||tool.knowledgeBases[0].fileIds?.length!==1||tool.knowledgeBases[0].fileIds[0]!=='40b4d2df-67a4-402c-814b-4cc67592942c'))throw Error('unreviewed_public_source');}
 };
 // Live chats only; no phone calls, tool writes, provider patches or auth changes.
 for(const agent of catalog.agents){
  const entry={agentKey:agent.key,assistantId:savedAgents[agent.key],scriptVersion:agent.scriptVersion};report.agents.push(entry);
  const previous=replay?.agents.find(a=>a.agentKey===agent.key);if(replay&&(!previous||previous.assistantId!==entry.assistantId||!previous.publicInformation?.chatId||!previous.unavailableAction?.chatId))throw Error('invalid_replay_receipt');
  await preflight(agent);entry.configurationReadback=true;entry.publicInformation=await knowledge.probe(entry.assistantId,previous?{chatId:previous.publicInformation.chatId}:undefined);
  await preflight(agent);entry.unavailableAction=await knowledge.probeUnavailable(agent.key,previous?{chatId:previous.unavailableAction.chatId}:undefined);
  await preflight(agent);entry.configurationUnchanged=true;
 }
 report.status='all_eight_agent_chat_checks_passed_private_actions_not_live';
}catch(e){report.status=/^[a-z_]{1,100}$/.test(e?.message??'')?e.message:'agent_acceptance_failed';if(e.acceptance)report.failure=e.acceptance;process.exitCode=1;}
await mkdir('test-results/vapi',{recursive:true});await writeFile('test-results/vapi/agent-conversations.json',JSON.stringify(report,null,2)+'\n');console.log('VAPI_AGENT_CONVERSATIONS '+JSON.stringify(report));
