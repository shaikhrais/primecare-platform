/** Prepare reviewable local configs. Never deploy or read/write secrets. */
import {readFile,writeFile} from 'node:fs/promises';
import {pathToFileURL} from 'node:url';
import {join} from 'node:path';
export function endpointAnalyticsConfigs(gateway,governance,account,role,permissions,tenantId){
 if(typeof tenantId!=='string'||!tenantId.trim()||tenantId.length>200||/[\u0000-\u001f]/.test(tenantId)||!/^[a-f0-9]{32}$/i.test(account)||typeof role!=='string'||(permissions?.[role]?.inventory!==true&&role!=='code_admin'))throw Error('Expected account ID, approved EMS/inventory reader role and platform tenant');
 if(gateway?.name!=='primecare-api-gateway'||gateway.main!=='../cloudflare/workers/src/gateway.ts'||governance?.name!=='primecare-governance-api'||governance.main!=='../cloudflare/workers/src/service.ts'||governance.vars?.SERVICE_NAME!=='governance')throw Error('Unexpected Worker identities');
 const g=structuredClone(gateway),v=structuredClone(governance);
 const bindings=g.analytics_engine_datasets??[];
 if(!Array.isArray(bindings)||bindings.some(b=>b.binding==='ENDPOINT_ANALYTICS'&&b.dataset!=='primecare_endpoint_traffic_v1'||b.binding==='ENDPOINT_BODY_ANALYTICS'&&b.dataset!=='primecare_endpoint_body_v1'))throw Error('Conflicting analytics binding');
 g.analytics_engine_datasets=[...bindings.filter(b=>!['ENDPOINT_ANALYTICS','ENDPOINT_BODY_ANALYTICS'].includes(b.binding)),{binding:'ENDPOINT_ANALYTICS',dataset:'primecare_endpoint_traffic_v1'},{binding:'ENDPOINT_BODY_ANALYTICS',dataset:'primecare_endpoint_body_v1'}];
 g.vars={...g.vars,ENDPOINT_TRAFFIC_ENABLED:'1'};
 v.vars={...v.vars,ENDPOINT_ANALYTICS_ACCOUNT_ID:account,ENDPOINT_ANALYTICS_READER_ROLE:role,ENDPOINT_ANALYTICS_READER_TENANT_ID:tenantId};
 return {gateway:g,governance:v};
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href){
 const [directory,account,role,tenantId]=process.argv.slice(2);
 if(!directory||!account||!role||!tenantId||process.argv.length!==6)throw Error('Usage: node scripts/prepare-endpoint-analytics-config.mjs CONFIG_DIRECTORY ACCOUNT_ID READER_ROLE PLATFORM_TENANT_ID');
 const [gateway,governance,registry]=await Promise.all([
  readFile(join(directory,'gateway.jsonc'),'utf8').then(JSON.parse),
  readFile(join(directory,'governance.jsonc'),'utf8').then(JSON.parse),
  readFile(new URL('../cloudflare/workers/src/workspace-registry.json',import.meta.url),'utf8').then(JSON.parse),
 ]);
 const result=endpointAnalyticsConfigs(gateway,governance,account,role,registry.permissions,tenantId);
 for(const [name,config] of Object.entries(result))await writeFile(join(directory,name+'-analytics.jsonc'),JSON.stringify(config,null,2)+'\n');
 console.log('Prepared gateway-analytics.jsonc and governance-analytics.jsonc for review; no deployment performed.');
}
