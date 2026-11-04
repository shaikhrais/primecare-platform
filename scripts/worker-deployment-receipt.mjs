/** Bind a CI source identity to the exact uploaded and independently active Worker version. */
const uuid=/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
export function uploadedWorkerVersion(output){
 const ids=[...String(output).matchAll(/Current Version ID:\s*([0-9a-f-]{36})/gi)].map(m=>m[1]);
 if(ids.length!==1||!uuid.test(ids[0]))throw Error('Unambiguous uploaded Worker version required');
 return ids[0];
}
export async function verifyWorkerDeployment({api,worker,service,source,versionId,previousDeploymentId}){
 if(!/^[0-9a-f]{40}$/.test(source??'')||!uuid.test(versionId??'')||!uuid.test(previousDeploymentId??'')||!['auth','governance'].includes(service)||worker!=='primecare-'+service+'-api')throw Error('Exact deployment provenance required');
 const base='/workers/scripts/'+worker;
 const check=raw=>{const active=raw?.deployments?.[0];if(!active||!uuid.test(active.id??'')||active.id===previousDeploymentId||!Number.isFinite(Date.parse(active.created_on))||active.versions?.length!==1||active.versions[0].version_id!==versionId||active.versions[0].percentage!==100)throw Error('Uploaded version is not the sole active deployment');return active;};
 const active=check(await api(base+'/deployments?per_page=1'));
 const version=await api(base+'/versions/'+versionId);
 if(version?.id!==versionId)throw Error('Uploaded version readback mismatch');
 const confirmed=check(await api(base+'/deployments?per_page=1'));
 if(confirmed.id!==active.id)throw Error('Deployment changed during verification');
 return {format:1,source,worker,service,deploymentId:active.id,versionId,trafficPercent:100,createdOn:active.created_on,independentlyReadDeployment:true,sourceAssociation:'verified CI checkout and exact Wrangler upload version',registeredGovernanceArtifactId:null,grantAssociationApproved:false};
}

/** Allow provider propagation while still requiring the exact uploaded version at 100%. */
export async function verifyWorkerDeploymentEventually(input,{attempts=4,wait=()=>new Promise(resolve=>setTimeout(resolve,2000))}={}){
 let lastError;
 for(let attempt=0;attempt<attempts;attempt++){
  try{return await verifyWorkerDeployment(input);}catch(error){lastError=error;}
  if(attempt+1<attempts)await wait();
 }
 throw lastError;
}
