/** Read-only provider diagnostics: public Worker identities and deployment UUIDs only. */
import {mkdir,writeFile} from 'node:fs/promises';
const account=process.env.CLOUDFLARE_ACCOUNT_ID,token=process.env.CLOUDFLARE_API_TOKEN;
if(!/^[a-f0-9]{32}$/i.test(account??'')||!token)throw Error('CI credentials required');
const report={source:process.env.GITHUB_SHA,observedAt:new Date().toISOString(),providerWrites:0,capacityOriginSecretConfigured:!!process.env.CAPACITY_TEST_ORIGIN,capacitySessionSecretConfigured:!!process.env.CAPACITY_TEST_TOKEN,workers:[],stagingWorkers:[]};
const uuid=v=>typeof v==='string'&&/^[a-f0-9-]{36}$/i.test(v)?v:null;
async function get(path){try{const r=await fetch('https://api.cloudflare.com/client/v4/accounts/'+account+path,{headers:{authorization:'Bearer '+token},redirect:'error',signal:AbortSignal.timeout(15000)});const data=await r.json();return {httpStatus:r.status,result:data.success===true?data.result:null};}catch{return {httpStatus:0,result:null};}}
for(const worker of ['primecare-governance-api','primecare-api-gateway']){
 const requests=await Promise.all(['deployments?per_page=1','deployments?per_page=100','versions?per_page=100','settings'].map(path=>get('/workers/scripts/'+worker+'/'+path)));
 const deployments=result=>Array.isArray(result?.deployments)?result.deployments.slice(0,100).map(d=>({id:uuid(d.id),createdOn:typeof d.created_on==='string'?d.created_on:null,versions:Array.isArray(d.versions)?d.versions.slice(0,2).map(v=>({id:uuid(v.version_id),percentage:typeof v.percentage==='number'?v.percentage:null})):[]})):[];
 const versions=requests[2].result?.items;
 const state={worker,firstPage:{httpStatus:requests[0].httpStatus,deployments:deployments(requests[0].result)},fullPage:{httpStatus:requests[1].httpStatus,deployments:deployments(requests[1].result)},versionList:{httpStatus:requests[2].httpStatus,ids:Array.isArray(versions)?versions.map(v=>uuid(v.id)).filter(Boolean):[],resultIsArray:Array.isArray(requests[2].result)},bodyDatasetBound:requests[3].result?.bindings?.some(b=>b.name==='ENDPOINT_BODY_ANALYTICS'&&b.type==='analytics_engine'&&b.dataset==='primecare_endpoint_body_v1')===true};
 const newest=[...state.fullPage.deployments].sort((a,b)=>Date.parse(b.createdOn)-Date.parse(a.createdOn))[0];
 if(newest?.versions.length===1&&newest.versions[0].id){const detail=await get('/workers/scripts/'+worker+'/versions/'+newest.versions[0].id);state.newestVersionDetail={httpStatus:detail.httpStatus,id:uuid(detail.result?.id)};}
 report.workers.push(state);
}
const listed=await get('/workers/scripts');
if(Array.isArray(listed.result))report.stagingWorkers=listed.result.map(w=>w.id).filter(n=>typeof n==='string'&&/^primecare[-a-z0-9]*$/.test(n)&&/(?:staging|sandbox|test)/.test(n)).slice(0,100);
report.workerListingHttpStatus=listed.httpStatus;
await mkdir('test-results/endpoint-management',{recursive:true});await writeFile('test-results/endpoint-management/deployment-state.json',JSON.stringify(report,null,2)+'\n');console.log('EMS_DEPLOYMENT_STATE '+JSON.stringify(report));
