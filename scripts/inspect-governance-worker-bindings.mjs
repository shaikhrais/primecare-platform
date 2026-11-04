/** Read-only governance Worker binding diagnostics. Values and credentials are never printed. */
const account=process.env.CLOUDFLARE_ACCOUNT_ID,token=process.env.CLOUDFLARE_API_TOKEN;
if(!/^[a-f0-9]{32}$/i.test(account??'')||!token)throw Error('Cloudflare credentials required');
const base='https://api.cloudflare.com/client/v4/accounts/'+account+'/workers/scripts/primecare-governance-api';
async function get(path){const r=await fetch(base+path,{headers:{authorization:'Bearer '+token},signal:AbortSignal.timeout(30000)});const x=await r.json();if(!r.ok||x.success!==true)throw Error('Cloudflare metadata read failed');return x.result;}
const names=bindings=>Array.isArray(bindings)?bindings.map(b=>({name:b.name,type:b.type})).sort((a,b)=>String(a.name).localeCompare(String(b.name))):null;
const settings=await get('/settings');
const deployments=await get('/deployments?per_page=3');
const rows=Array.isArray(deployments?.deployments)?deployments.deployments:[];
const versions=[];
for(const deployment of rows){
 const list=Array.isArray(deployment.versions)?deployment.versions:[];
 for(const item of list){
  const id=item.version_id;
  if(!/^[a-f0-9-]{36}$/i.test(id??'')||versions.some(v=>v.id===id))continue;
  const version=await get('/versions/'+id);
  versions.push({id,bindings:names(version.resources?.bindings)});
 }
}
const health=await fetch('https://primecare-governance-api.itpro-mohammed.workers.dev/health',{signal:AbortSignal.timeout(30000)});
console.log(JSON.stringify({currentBindings:names(settings.bindings),versions,healthStatus:health.status,writes:0}));
