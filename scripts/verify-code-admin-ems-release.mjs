/** Read-only public boundary probes. Never obtains a session or invokes a business action. */
import {readFile,mkdir,writeFile} from 'node:fs/promises';
const contract=JSON.parse(await readFile(new URL('../packages/shared/src/endpoint-management/contract.json',import.meta.url),'utf8'));
const origin='https://primecare-api-gateway.itpro-mohammed.workers.dev';
const results=await Promise.all(contract.operations.map(async op=>{
 const response=await fetch(origin+op.path,{method:'GET',credentials:'omit',redirect:'error',signal:AbortSignal.timeout(15000)});
 const status=response.status;await response.body?.cancel();return {method:'GET',path:op.path,httpStatus:status,anonymousDenied:status===401};
}));
const report={source:process.env.GITHUB_SHA??null,observedAt:new Date().toISOString(),scope:'anonymous GET denial only; not authenticated acceptance or capacity evidence',results,productionReady:false};
await mkdir('test-results/ems',{recursive:true});await writeFile('test-results/ems/release.json',JSON.stringify(report,null,2)+'\n');
console.log('EMS_ANONYMOUS_BOUNDARIES '+JSON.stringify(report));
if(results.some(row=>!row.anonymousDenied))throw Error('EMS anonymous boundary probe failed; inspect the release receipt before retrying');
