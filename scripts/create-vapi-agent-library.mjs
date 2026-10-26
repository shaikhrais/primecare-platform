import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {VapiAdminClient} from '../packages/shared/src/communications/vapi-admin.mjs';
const catalog=JSON.parse(await readFile('packages/shared/src/vapi-agent-templates.json','utf8'));
const report={source:process.env.GITHUB_SHA,agents:[],callsStarted:false,phoneRoutingChanged:false,businessToolsAttached:false,status:'pending'};
try{
 const client=new VapiAdminClient({apiKey:process.env.VAPI_PRIVATE_API_KEY,orgId:'9e1d8550-4b84-4472-a782-67557fe73944',templateId:'5ae2ab0c-fad0-454c-8cf7-64b81c91c850'});
 for(const a of catalog.agents){let inventory=await client.inventory();const matches=inventory.assistants.filter(x=>x.name===a.name);if(matches.length>1)throw Object.assign(Error(),{code:'ambiguous_existing_agent'});
 let saved,reused=false;
 if(matches.length===1){saved=matches[0];if(saved.prompt!==a.prompt||saved.firstMessage!==a.firstMessage)throw Object.assign(Error(),{code:'existing_agent_configuration_differs'});reused=true;}
 else{saved=(await client.createAgent({name:a.name,firstMessage:a.firstMessage,prompt:a.prompt})).assistant;}
 inventory=await client.inventory();const readback=inventory.assistants.find(x=>x.id===saved.id);if(!readback||readback.name!==a.name||readback.prompt!==a.prompt||readback.firstMessage!==a.firstMessage)throw Object.assign(Error(),{code:'readback_failed'});
 report.agents.push({key:a.key,id:saved.id,name:a.name,reused,saved:true,configurationReadback:true,defaultTools:a.defaultTools,requiredCapabilities:a.requiredCapabilities,businessConfiguration:'needed',callTested:false});
 }
 report.status='saved_configuration_verified';
}catch(e){report.status=/^[a-z_]{1,80}$/.test(e?.code??'')?e.code:'creation_failed';process.exitCode=1;}
await mkdir('test-results/vapi',{recursive:true});await writeFile('test-results/vapi/agent-library.json',JSON.stringify(report,null,2)+'\n');console.log('VAPI_AGENT_LIBRARY '+JSON.stringify(report));
