const releaseSource='ca1d9edd6942ff5d960d7267a10c551c2f33a8cd';
const releaseVersion='cefb0515-632a-437a-89f7-168c244fa33f';
const activeVersion='ce2df651-30f7-4d1d-8bc4-8fa6689dff33';
const activeDeployment='4ffd3df8-8b0c-4106-ad03-31eecc881047';
const allowed=new Set([
 '.github/workflows/inspect-governance-worker-bindings.yml',
 '.github/workflows/inspect-preference-activation.yml',
 '.github/workflows/psw-workspace.yml',
 '.github/workflows/record-theme-migration-implementation.yml',
 '.github/workflows/run-auth-preference-candidate.yml',
 '.github/workflows/auth-preference-candidate.yml',
 'scripts/deploy-approved-admin-governance.mjs',
 'scripts/inspect-governance-worker-bindings.mjs',
 'scripts/test-tenant-dashboard-theme-migration.mjs',
 'tools/governance-production/inspect-preference-activation.mjs',
 'tools/governance-production/record-theme-migration-implementation.mjs',
 'scripts/deploy-auth-preference-code.mjs',
 'scripts/auth-reconciled-source.mjs',
 'scripts/test-auth-reconciled-source.mjs',
]);
/** Accept only the exact tested release and its secret-generated identical code version. */
export function verifyReconciledAuth({before,run,job,log,release,active,changedPaths}){
 const deployIndex=log.indexOf('Deployed primecare-auth-api triggers');
 const versionIndex=log.indexOf('Current Version ID: '+releaseVersion,deployIndex);
 const secretIndex=log.indexOf('Success! Uploaded secret DB_URL',versionIndex);
 const nextWorker=log.indexOf('Uploaded primecare-client-api',versionIndex);
 if(before?.id!==activeDeployment||before.versions?.length!==1||before.versions[0].version_id!==activeVersion||before.versions[0].percentage!==100||
 run?.id!==41776405861||run.head_sha!==releaseSource||run.head_branch!=='main'||run.path!=='.github/workflows/release-screen-text.yml'||run.conclusion!=='success'||
 job?.id!==126398355208||job.run_id!==41776405861||job.name!=='apis / deploy'||job.conclusion!=='success'||
 deployIndex<0||versionIndex<deployIndex||secretIndex<versionIndex||(nextWorker>=0&&secretIndex>nextWorker)||
 release?.id!==releaseVersion||active?.id!==activeVersion||!release.resources?.script?.etag||release.resources.script.etag!==active.resources?.script?.etag||
 !Array.isArray(changedPaths)||changedPaths.some(path=>!allowed.has(path)))throw Error('Auth release lineage could not be verified');
 return {releaseSource,releaseVersion,activeVersion,activeDeployment,scriptHashMatches:true};
}

const recoveryAllowed=new Set([
 'scripts/worker-deployment-receipt.mjs','scripts/test-worker-deployment-receipt.mjs',
 'scripts/deploy-auth-preference-code.mjs','scripts/auth-reconciled-source.mjs',
 'scripts/test-auth-reconciled-source.mjs','scripts/compare-active-auth-candidate.mjs',
 '.github/workflows/compare-active-auth-candidate.yml','.github/workflows/run-auth-preference-candidate.yml',
]);
/** Accept the interrupted upload only when an independent, single-module byte comparison passed. */
export function verifyRebuiltAuthRecovery({before,run,job,receipt,changedPaths}){
 const activeDeployment='7b767814-e099-474e-8705-9cb149ebe171',activeVersion='79ff92d4-d11e-4999-be30-46a5e2365626',source='339350f178a64a49a7a3c7ccaff4fbed1022998d';
 if(before?.id!==activeDeployment||before.versions?.length!==1||before.versions[0].version_id!==activeVersion||before.versions[0].percentage!==100||
 run?.id!==41828175403||run.head_sha!=='7b9b0ac9954bffd780f94422d51924a05f5b0e20'||run.head_branch!=='main'||run.path!=='.github/workflows/compare-active-auth-candidate.yml'||run.conclusion!=='success'||
 job?.id!==126568192234||job.run_id!==41828175403||job.name!=='compare'||job.conclusion!=='success'||
 receipt?.source!==source||receipt.activeDeployment!==activeDeployment||receipt.activeVersion!==activeVersion||receipt.moduleCount!==1||receipt.matchingModules!==1||receipt.contentMatches!==true||receipt.preferenceRuntimeEnabled!==false||receipt.writes!==0||
 !Array.isArray(changedPaths)||changedPaths.some(path=>!recoveryAllowed.has(path)))throw Error('Interrupted auth upload could not be verified');
 return {source,activeDeployment,activeVersion,independentModuleMatch:true};
}
