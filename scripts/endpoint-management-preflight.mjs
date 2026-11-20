/** Read-only production diagnostics. Never print credentials, bindings or tenant values. */
import {mkdir,writeFile} from 'node:fs/promises';
import {pathToFileURL} from 'node:url';
import {readFileSync} from 'node:fs';
const permissions=JSON.parse(readFileSync(new URL('../cloudflare/workers/src/workspace-registry.json',import.meta.url),'utf8')).permissions;
const workers={gateway:'primecare-api-gateway',governance:'primecare-governance-api'};
export function assessEndpointManagementSettings(gateway,governance,expectedAccount){
 const valid=settings=>settings&&Array.isArray(settings.bindings)&&settings.bindings.every(b=>b&&typeof b.name==='string'&&typeof b.type==='string')&&new Set(settings.bindings.map(b=>b.name)).size===settings.bindings.length;
 if(!valid(gateway)||!valid(governance))throw Error('Invalid Worker settings');
 const find=(s,name)=>s.bindings.find(b=>b.name===name);
 const plain=(s,name)=>{const b=find(s,name);return b?.type==='plain_text'?b.text:undefined;};
 const dataset=find(gateway,'ENDPOINT_ANALYTICS');
 const role=plain(governance,'ENDPOINT_ANALYTICS_READER_ROLE');
 const checks={gatewayCollectionEnabled:plain(gateway,'ENDPOINT_TRAFFIC_ENABLED')==='1',
  datasetBound:dataset?.type==='analytics_engine'&&dataset.dataset==='primecare_endpoint_traffic_v1',
  readerAccountConfigured:/^[a-f0-9]{32}$/i.test(plain(governance,'ENDPOINT_ANALYTICS_ACCOUNT_ID')??'')&&(!expectedAccount||plain(governance,'ENDPOINT_ANALYTICS_ACCOUNT_ID')===expectedAccount),
  readerRoleConfigured:typeof role==='string'&&permissions[role]?.inventory===true,
  readerTenantConfigured:typeof plain(governance,'ENDPOINT_ANALYTICS_READER_TENANT_ID')==='string'&&!!plain(governance,'ENDPOINT_ANALYTICS_READER_TENANT_ID').trim(),
  readerSecretConfigured:find(governance,'ENDPOINT_ANALYTICS_READ_TOKEN')?.type==='secret_text'};
 const remedies={gatewayCollectionEnabled:'Enable ENDPOINT_TRAFFIC_ENABLED on the gateway.',datasetBound:'Bind ENDPOINT_ANALYTICS to primecare_endpoint_traffic_v1.',readerAccountConfigured:'Configure the Analytics Engine account ID on governance.',readerRoleConfigured:'Select an inventory-authorized platform reporting role.',readerTenantConfigured:'Bind the reporting grant to the approved platform tenant.',readerSecretConfigured:'Configure a dedicated Account Analytics Read token as ENDPOINT_ANALYTICS_READ_TOKEN.'};
 return {checks,configured:Object.values(checks).every(Boolean),blockers:Object.entries(checks).filter(([,ok])=>!ok).map(([key])=>({key,action:remedies[key]}))};
}
export async function inspectEndpointManagement(env,send=fetch){
 const report={source:env.GITHUB_SHA??null,observedAt:new Date().toISOString(),providerWrites:0,configuration:null,health:null,blockers:[]};
 const account=env.CLOUDFLARE_ACCOUNT_ID,token=env.CLOUDFLARE_API_TOKEN;
 if(!/^[a-f0-9]{32}$/i.test(account??'')||!token){report.blockers.push({key:'providerCredentials',action:'Configure the existing Cloudflare account and deployment read credentials in the production environment.'});return report;}
 async function get(worker){
  const response=await send(`https://api.cloudflare.com/client/v4/accounts/${account}/workers/scripts/${worker}/settings`,{headers:{authorization:'Bearer '+token},redirect:'error',signal:AbortSignal.timeout(15000)});
  if(!response.ok)throw Error('Metadata unavailable');
  const raw=await response.json();if(raw.success!==true||!raw.result)throw Error('Metadata unavailable');return raw.result;
 }
 try{
  const [gateway,governance]=await Promise.all([get(workers.gateway),get(workers.governance)]);
  report.configuration=assessEndpointManagementSettings(gateway,governance,account);
  report.blockers.push(...report.configuration.blockers);
 }catch{report.blockers.push({key:'metadataRead',action:'Verify Cloudflare Worker metadata read permission and inspect the production release settings.'});}
 try{
  const response=await send('https://primecare-api-gateway.itpro-mohammed.workers.dev/health',{redirect:'error',signal:AbortSignal.timeout(15000)});
  report.health={httpStatus:response.status,services:null};
  if(response.status===200||response.status===503){
   const body=await response.json();
   if(body.runtime==='cloudflare-worker-typescript'&&body.services&&typeof body.services==='object'&&!Array.isArray(body.services)){
    const entries=Object.entries(body.services);
    if(entries.length>0&&entries.length<=30&&entries.every(([name,status])=>/^[a-z][a-z0-9-]{0,39}$/.test(name)&&typeof status==='boolean'))report.health.services=Object.fromEntries(entries);
   }
  }else await response.body?.cancel();
  if(response.status!==200||!report.health.services||Object.values(report.health.services).some(v=>v!==true))report.blockers.push({key:'gatewayHealth',action:'Resolve the gateway or reported service health failure before load testing.'});
 }catch{report.blockers.push({key:'gatewayReachability',action:'Verify gateway access from the production runner.'});}
 return report;
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href){
 const report=await inspectEndpointManagement(process.env);
 await mkdir('test-results/endpoint-management',{recursive:true});
 await writeFile('test-results/endpoint-management/preflight.json',JSON.stringify(report,null,2)+'\n');
 console.log('ENDPOINT_MANAGEMENT_PREFLIGHT '+JSON.stringify(report));
}
