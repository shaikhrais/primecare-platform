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
