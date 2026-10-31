/** Export only independently read-back metadata; never enable the runtime from a receipt. */
import {readFile,writeFile,mkdir} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {resolve,dirname} from 'node:path';
import {pathToFileURL} from 'node:url';
import {ROOT,CONTRACT,validateContract} from '../tools/governance-production/theme-adoption-preflight.mjs';
const need=(condition,message)=>{if(!condition)throw Error(message);};
export function buildRegistrationExport(catalog,receipt,report,contractSha256,manifestSha256) {
  need(receipt.committed===true&&receipt.independentReadback===true,'A committed independent readback is required');
  need(receipt.runtimeActivated===false&&receipt.roleGrants===0&&receipt.schemaChanges===false,'Unexpected registration side effects');
  need(receipt.screenCode===catalog.registrationTarget.screenCode&&receipt.execution&&/^[a-f0-9]{40}$/.test(receipt.execution.commit),'Missing verified host or source commit');
  need(report.productionChecked===true&&report.writes===0&&report.runtimeVerified===false&&report.productionActivationAllowed===false,'Expected read-only production reconciliation');
  need(report.contractSha256===contractSha256&&report.expectedManifestSha256===manifestSha256,'Stale contract or authority proof');
  need(Array.isArray(report.issues)&&report.issues.every(i=>i.kind==='translation'&&i.status==='review_pending'),'Unresolved production metadata gaps');
  need(report.hosts.some(h=>String(h.screenId)===String(receipt.screenId)&&h.status==='candidate_existing_host'&&h.grantCount>0),'Registered authorized host is missing');
  need(report.components.every(c=>c.status==='existing')&&catalog.requiredExistingComponents.every(code=>report.components.some(c=>c.code===code)),'Registered components are missing');
  need(Object.keys(receipt.controls).length===catalog.controls.length&&new Set(Object.values(receipt.controls).map(String)).size===catalog.controls.length,'Missing or duplicate control IDs');
  need(Object.keys(receipt.resourceIds).length===Object.keys(catalog.resources).length,'Missing resource IDs');
  const controls=catalog.controls.map(control=>{
    const rows=report.controls.filter(c=>c.testId===control.testId);
    need(rows.length===1&&rows[0].status==='candidate_existing_binding'&&rows[0].bindings.some(b=>String(b.screenId)===String(receipt.screenId)&&b.componentCode===control.componentCode),'Missing registered control binding');
    need(Number.isSafeInteger(receipt.controls[control.testId])&&receipt.controls[control.testId]>0,'Invalid registered control ID');
    return {key:control.key,testId:control.testId,componentCode:control.componentCode,controlId:receipt.controls[control.testId],resourceKey:control.resourceKey,allowedValues:control.allowedValues,existingSelector:control.existingSelector};
  });
  const resources=Object.fromEntries(Object.entries(catalog.resources).map(([key,text])=>{
    const rows=report.resources.filter(r=>r.key===key),rid=receipt.resourceIds[key];
    need(Number.isSafeInteger(rid)&&rid>0&&rows.length===1&&rows[0].status==='existing'&&rows[0].ids.map(String).includes(String(rid)),'Missing registered resource binding');
    need(rows[0].translations.length===3&&['en','fr','es'].every(locale=>rows[0].translations.some(t=>t.locale===locale&&['existing_reviewed','review_pending'].includes(t.status))),'Missing or conflicted translations');
    return [key,{resourceId:rid,en:text.en,fr:text.fr,es:text.es,reviewPending:rows[0].translations.some(t=>t.status==='review_pending')}];
  }));
  return {version:1,kind:'verified_metadata_export',contractSha256,manifestSha256,source:receipt.execution,host:{screenId:receipt.screenId,screenCode:receipt.screenCode,route:catalog.registrationTarget.route},controls,resources,runtimeEnabled:false,translationReviewPending:Object.values(resources).some(r=>r.reviewPending),allAppsAdopted:false};
}
async function main() {
  const args=process.argv.slice(2);need(args.length===4&&args[0]==='--receipt'&&args[2]==='--readback','Use --receipt PATH --readback PATH');
  const bytes=await readFile(resolve(ROOT,CONTRACT)),catalog=JSON.parse(bytes);await validateContract(catalog);
  const pin=JSON.parse(await readFile(resolve(ROOT,catalog.authority.manifestFile),'utf8'));
  const receipt=JSON.parse(await readFile(resolve(ROOT,args[1]),'utf8')),report=JSON.parse(await readFile(resolve(ROOT,args[3]),'utf8'));
  const result=buildRegistrationExport(catalog,receipt,report,createHash('sha256').update(bytes).digest('hex'),pin.manifestSha256);
  const out=resolve(ROOT,'packages/primecare_ui/catalogs/theme-workspace.registration.json');await mkdir(dirname(out),{recursive:true});await writeFile(out,JSON.stringify(result,null,2)+'\n');
  console.log(JSON.stringify({output:'packages/primecare_ui/catalogs/theme-workspace.registration.json',controls:result.controls.length,resources:Object.keys(result.resources).length,runtimeEnabled:false,translationReviewPending:result.translationReviewPending}));
}
if(process.argv[1]&&import.meta.url===pathToFileURL(resolve(process.argv[1])).href)await main();
