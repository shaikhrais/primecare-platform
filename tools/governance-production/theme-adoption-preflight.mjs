/** Read-only adoption preflight. A proposal and a source inventory never grant live authority. */
import {readFile,writeFile,mkdir} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {spawn} from 'node:child_process';
import {createInterface} from 'node:readline';
import {fileURLToPath,pathToFileURL} from 'node:url';
import {dirname,resolve,relative} from 'node:path';
export const ROOT=resolve(dirname(fileURLToPath(import.meta.url)),'../..');
export const CONTRACT='tools/governance-production/theme-adoption-contract.json';
const digest=bytes=>createHash('sha256').update(bytes).digest('hex');
const requireValue=(value,message)=>{if(!value)throw Error(message);};
const unique=(items,key)=>{const values=items.map(key);requireValue(new Set(values).size===values.length,'Duplicate adoption identity');};
const insideRoot=path=>typeof path==='string'&&!path.startsWith('/')&&!path.split('/').includes('..');
export async function validateContract(catalog,root=ROOT) {
  requireValue(catalog?.version===1&&catalog.kind==='proposal_not_production_registry','Expected an adoption proposal');
  requireValue(catalog.status==='registration_preparation_only'&&catalog.runtimeExposure===false&&catalog.registrationWriteTool==='tools/governance-production/theme_adoption_registration.py','Proposal cannot claim registration or runtime activation');
  requireValue(catalog.authority?.productionRequired===true&&catalog.authority.sqliteFallback===false&&catalog.authority.schemaChanges===false&&catalog.authority.businessDataWrites===false&&catalog.authority.newRoleGrants===false,'Unexpected authority scope');
  const plan=JSON.parse(await readFile(resolve(root,'docs/task-progress/primecare-theme-implementation-batches.json'),'utf8'));
  const batchIds=new Set(plan.batches.map(b=>b.id));
  requireValue(batchIds.size===catalog.batchIds.length&&catalog.batchIds.every(id=>batchIds.has(id)),'Batch coverage differs');
  const inventoryPath=catalog.referenceInventory?.path;requireValue(insideRoot(inventoryPath),'Invalid reference path');
  const bytes=await readFile(resolve(root,inventoryPath));requireValue(digest(bytes)===catalog.referenceInventory.sha256,'Reference inventory drift');
  const inventory=JSON.parse(bytes);
  requireValue(catalog.features?.length>0&&catalog.controls?.length>0,'Empty adoption contract');
  unique(catalog.features,f=>f.id);unique(catalog.controls,c=>c.testId);
  const features=new Map(catalog.features.map(f=>[f.id,f]));
  requireValue(JSON.stringify([...inventory.coreFamilies].sort())===JSON.stringify(catalog.features.filter(f=>f.category==='core_family').map(f=>f.title).sort()),'Missing reference core family');
  for(const feature of catalog.features) {
    requireValue(/^[a-z][A-Za-z0-9.-]+$/.test(feature.id)&&batchIds.has(feature.batch),'Invalid feature identity or batch');
    requireValue(feature.productionStatus==='not_checked'&&feature.runtimeStatus==='not_verified'&&feature.requiresGovernance===true,'Unproven feature status');
    requireValue(['source_present_unverified','no_mapped_equivalent'].includes(feature.sourceStatus),'Invalid source status');
    requireValue((feature.sourceStatus==='source_present_unverified')===(feature.sourceEvidence.length>0),'Source evidence/status mismatch');
    for(const source of feature.sourceEvidence) {
      requireValue(insideRoot(source.path)&&digest(await readFile(resolve(root,source.path)))===source.sha256,'Mapped PrimeCare source changed');
    }
  }
  const mappings=catalog.referenceInventory.fileMappings;
  requireValue(Object.keys(mappings).length===inventory.files.length&&catalog.referenceInventory.sourceCount===inventory.files.length,'Incomplete reference file coverage');
  for(const file of inventory.files) {
    const mapped=mappings[file.id];requireValue(mapped&&mapped.source===file.source&&mapped.referenceSha256===file.sha256&&features.has(mapped.featureId)&&mapped.disposition==='candidate_mapping_unverified','Invalid reference file mapping');
  }
  const imports=catalog.referenceInventory.muiImports;
  unique(imports,i=>i.name);requireValue(JSON.stringify(imports.map(i=>i.name).sort())===JSON.stringify([...inventory.muiImports].sort()),'Incomplete component/import inventory');
  requireValue(imports.every(i=>batchIds.has(i.batch)&&['framework_type_reference','component_or_style_inventory_unverified'].includes(i.disposition)),'Invalid imported component disposition');
  const resourceKeys=Object.keys(catalog.resources);
  for(const [key,text] of Object.entries(catalog.resources)) {
    requireValue(/^themeWorkspace\.[A-Za-z][A-Za-z0-9]*$/.test(key),'Invalid resource namespace');
    requireValue(Object.keys(text).sort().join(',')==='approved,en,es,fr,reviewed'&&text.reviewed===false&&text.approved===false,'Unreviewed resources cannot be marked approved');
    for(const lang of ['en','fr','es'])requireValue(typeof text[lang]==='string'&&text[lang].trim()&&text[lang].length<=1000&&!/[<>]/.test(text[lang]),'Missing or unsafe translation');
  }
  for(const control of catalog.controls) {
    requireValue(/^(appearance|workspace-layout)-[a-z][a-z0-9-]*$/.test(control.testId)&&resourceKeys.includes(control.resourceKey),'Invalid control binding');
    requireValue(catalog.requiredExistingComponents.includes(control.componentCode)&&control.hostScreenIds.length===0&&control.registrationStatus==='not_checked','A proposal cannot invent production bindings');
    requireValue(control.permissionPolicy==='inherit_existing_authorized_host_no_new_grants','Unexpected permission grant');
    requireValue(control.allowedValues===null||(Array.isArray(control.allowedValues)&&control.allowedValues.length>0&&control.allowedValues.every(v=>typeof v==='string'&&/^[a-z]+$/.test(v))&&new Set(control.allowedValues).size===control.allowedValues.length),'Invalid control choices');
  }
  for(const path of [...catalog.existingSourceHosts,...catalog.tokenSources]){requireValue(insideRoot(path),'Invalid source path');await readFile(resolve(root,path));}
  return {features:catalog.features.length,coreFamilies:inventory.coreFamilies.length,referenceFiles:inventory.files.length,componentImports:imports.length,proposedControls:catalog.controls.length,resources:resourceKeys.length,translations:resourceKeys.length*3};
}
/** Reconcile exact natural keys. Never overwrite a translation, invent an ID or infer runtime success. */
export function reconcileSnapshot(catalog,snapshot) {
  const resources=[],controls=[],components=[],hosts=[],issues=[];
  const id=value=>String(value);
  const active=value=>Number(value)===1;
  for(const code of catalog.requiredExistingComponents) {
    const rows=snapshot.components.filter(r=>r.component_code===code);
    const status=rows.length>1?'ambiguous':rows.length===0?'missing':!active(rows[0].active)?'inactive':'existing';
    components.push({code,status,ids:rows.map(r=>r.id)});if(status!=='existing')issues.push({kind:'component',key:code,status});
  }
  for(const [key,text] of Object.entries(catalog.resources)) {
    const rows=snapshot.resources.filter(r=>r.resource_key===key);
    const item={key,status:rows.length>1?'ambiguous':rows.length===0?'missing':!active(rows[0].active)?'inactive':'existing',ids:rows.map(r=>r.resource_id),translations:[]};
    if(item.status==='existing')for(const locale of ['en','fr','es']) {
      const language=snapshot.languages.filter(r=>r.language_code===locale&&active(r.enabled));
      let status=language.length!==1?'language_missing_or_ambiguous':null;
      const values=status?[]:snapshot.translations.filter(r=>id(r.resource_id)===id(rows[0].resource_id)&&id(r.language_id)===id(language[0].language_id));
      status??=values.length>1?'ambiguous':values.length===0?'missing':values[0].translated_text!==text[locale]?'conflict':!active(values[0].reviewed)||!active(values[0].approved)?'review_pending':'existing_reviewed';
      item.translations.push({locale,status});if(status!=='existing_reviewed')issues.push({kind:'translation',key,locale,status});
    }
    if(item.status!=='existing')issues.push({kind:'resource',key,status:item.status});resources.push(item);
  }
  const candidates=new Set(snapshot.screens.filter(r=>catalog.existingSourceHosts.includes(r.actual_file_path)).map(r=>id(r.id)));
  for(const row of snapshot.controls)if(catalog.existingSourceHosts.includes(row.file_path))candidates.add(id(row.screen_id));
  for(const screen of snapshot.screens.filter(r=>candidates.has(id(r.id)))) {
    const grants=snapshot.permissions.filter(r=>id(r.screen_id)===id(screen.id)&&active(r.can_view));
    const status=!active(screen.active)?'inactive':!grants.length?'no_existing_view_grant':'candidate_existing_host';
    hosts.push({screenId:screen.id,screenCode:screen.screen_code,route:screen.route_path,status,grantCount:grants.length});
  }
  for(const control of catalog.controls) {
    const bindings=snapshot.controls.filter(r=>r.data_cy===control.testId);
    const valid=bindings.filter(r=>candidates.has(id(r.screen_id))&&hosts.some(h=>id(h.screenId)===id(r.screen_id)&&h.status==='candidate_existing_host'));
    const duplicate=valid.some((r,i)=>valid.findIndex(v=>id(v.screen_id)===id(r.screen_id))!==i);
    const status=duplicate?'ambiguous':!bindings.length?'missing':!valid.length?'host_unresolved':valid.some(r=>r.component_type!==control.componentCode)?'component_conflict':'candidate_existing_binding';
    controls.push({testId:control.testId,status,bindings:valid.map(r=>({screenId:r.screen_id,componentCode:r.component_type}))});
    if(status!=='candidate_existing_binding')issues.push({kind:'control',key:control.testId,status});
    for(const row of valid) {
      const required=snapshot.requiredElements.filter(r=>id(r.screen_id)===id(row.screen_id)&&r.test_id===control.testId);
      if(required.length!==1)issues.push({kind:'required_element',key:control.testId,screenId:row.screen_id,status:required.length?'ambiguous':'missing'});
    }
  }
  if(!hosts.some(h=>h.status==='candidate_existing_host'))issues.push({kind:'host',status:'no_registered_host_resolved'});
  return {mode:'production-read-only',writes:0,productionChecked:true,registrationCandidatesSatisfied:issues.length===0,productionActivationAllowed:false,runtimeVerified:false,components,hosts,controls,resources,issues,...(snapshot.discovery?{discovery:snapshot.discovery}:{})};
}
const TABLE_COLUMNS={
  primecare_ui_component_registry:['id','component_code','active'],languages:['language_id','language_code','enabled'],language_resources:['resource_id','resource_key','active'],language_resource_values:['resource_id','language_id','translated_text','reviewed','approved'],screen_components:['screen_id','component_type','data_cy','file_path'],screen_required_elements:['screen_id','test_id'],screens:['id','screen_code','route_path','actual_file_path','active'],role_screen_permissions:['role_id','screen_id','can_view']
};
const quote=name=>'"'+name.replaceAll('"','""')+'"';
/** Compile a single allowlisted read from the authoritative imported schema. */
export function compileRead(ready,table,filter,values) {
  const columns=TABLE_COLUMNS[table];requireValue(columns&&columns.includes(filter)&&Array.isArray(values)&&values.length>0,'Unscoped metadata read');
  const meta=ready.manifest.tables.find(t=>t.name===table);requireValue(meta,'Missing registered metadata relation');
  const expressions=columns.map(name=>{
    const c=meta.columns.find(c=>c.name===name);requireValue(c&&c.storage_types.length<=1,'Missing or mixed metadata column');const q=quote(name);
    if(c.storage_types.length===1)return q;
    // Empty import columns store explicitly tagged values added by scoped writers.
    return `CASE WHEN ${q} IS NULL OR ${q}->>'t'='null' THEN NULL WHEN ${q}->>'t' IN ('text','integer') AND jsonb_typeof(${q}->'v')='string' THEN ${q}->>'v' ELSE (1/(length(${q}::text)-length(${q}::text)))::text END AS ${q}`;
  });
  const marks=values.map((_,i)=>'$'+(i+1)).join(',');
  return {sql:`SELECT * FROM (SELECT ${expressions.join(',')} FROM ${quote(ready.pin.schema)}.${quote('govt_'+table)}) AS source WHERE ${quote(filter)} IN (${marks})`,parameters:values};
}
/** Bounded metadata discovery resolves existing names; it never creates host IDs. */
export function compileDiscovery(ready,table) {
  const column=table==='screens'?'screen_code':table==='primecare_ui_component_registry'?'component_code':null;
  requireValue(column,'Unscoped metadata discovery');
  const request=compileRead(ready,table,column,['__discovery_projection_only__']);
  const base=request.sql.slice(0,request.sql.lastIndexOf(' WHERE '));
  const fields=table==='screens'?['screen_code','actual_file_path']:['component_code'];
  const patterns=table==='screens'?['%theme%','%appearance%','%layout%']:['%dropdown%','%select%','%theme%','%layout%'];
  return {sql:base+' WHERE ('+fields.map(field=>'('+patterns.map((_,i)=>quote(field)+' ILIKE $'+(i+1)).join(' OR ')+')').join(' OR ')+') LIMIT 100',parameters:patterns};
}
async function productionSnapshot(catalog) {
  const child=spawn(process.execPath,[resolve(ROOT,'tools/governance-production/read-bridge.mjs')],{cwd:ROOT,stdio:['pipe','pipe','ignore']});
  const lines=createInterface({input:child.stdout})[Symbol.asyncIterator]();
  async function receive() {
    let timer;try {const item=await Promise.race([lines.next(),new Promise((_,reject)=>{timer=setTimeout(()=>reject(Error('READER_TIMEOUT')),30000);})]);requireValue(!item.done,'READER_CLOSED');return JSON.parse(item.value);}finally{clearTimeout(timer);}
  }
  try {
    const ready=await receive();if(!ready.ready)throw Error(/^[A-Z0-9_]+$/.test(ready.code)?ready.code:'READER_UNAVAILABLE');
    const pin=JSON.parse(await readFile(resolve(ROOT,'tools/governance-production/production-pin.json'),'utf8'));
    requireValue(ready.pin.manifestSha256===pin.manifestSha256&&ready.pin.schema===pin.schema,'MANIFEST_MISMATCH');
    async function select(table,filter,values) {
      const rows=[];for(let i=0;i<values.length;i+=64) {
        const request=compileRead(ready,table,filter,values.slice(i,i+64));child.stdin.write(JSON.stringify({op:'query',...request})+'\n');
        const result=await receive();if(!result.ok)throw Error('METADATA_READ_FAILED');
        rows.push(...result.rows.map(row=>Object.fromEntries(result.fields.map((field,j)=>[field.name,row[j]]))));
      }return rows;
    }
    async function discover(table) {
      child.stdin.write(JSON.stringify({op:'query',...compileDiscovery(ready,table)})+'\n');const result=await receive();if(!result.ok)throw Error('METADATA_DISCOVERY_FAILED');
      return result.rows.map(row=>Object.fromEntries(result.fields.map((field,j)=>[field.name,row[j]])));
    }
    const components=await select('primecare_ui_component_registry','component_code',catalog.requiredExistingComponents);
    const languages=await select('languages','language_code',['en','fr','es']);
    const resources=await select('language_resources','resource_key',Object.keys(catalog.resources));
    const translations=await select('language_resource_values','resource_id',resources.map(r=>r.resource_id));
    const controls=await select('screen_components','data_cy',catalog.controls.map(c=>c.testId));
    const requiredElements=await select('screen_required_elements','test_id',catalog.controls.map(c=>c.testId));
    const sourceHosts=await select('screens','actual_file_path',catalog.existingSourceHosts);
    const ids=[...new Set([...sourceHosts.map(r=>String(r.id)),...controls.map(r=>String(r.screen_id))])];
    const screens=await select('screens','id',ids);
    const permissions=await select('role_screen_permissions','screen_id',ids);
    const discovery={screens:await discover('screens'),components:await discover('primecare_ui_component_registry'),limitPerRelation:100,authoritativeBindings:false};
    return {components,languages,resources,translations,controls,requiredElements,screens,permissions,discovery};
  }finally{if(child.stdin.writable)child.stdin.end('{"op":"close"}\n');child.kill();}
}
export async function main(argv=process.argv.slice(2)) {
  const mode=argv[0],outIndex=argv.indexOf('--out');
  requireValue(['--check','--production'].includes(mode)&&((argv.length===1)||(argv.length===3&&outIndex===1)),'Use --check or --production, optionally --out PATH');
  const bytes=await readFile(resolve(ROOT,CONTRACT));const catalog=JSON.parse(bytes);const counts=await validateContract(catalog);
  const pin=JSON.parse(await readFile(resolve(ROOT,catalog.authority.manifestFile),'utf8'));
  let report={mode:'source-check',status:'source_contract_validated',contractSha256:digest(bytes),expectedManifestSha256:pin.manifestSha256,counts,productionChecked:false,productionActivationAllowed:false,runtimeVerified:false,writes:0};
  if(mode==='--production')try {report={...report,...reconcileSnapshot(catalog,await productionSnapshot(catalog)),status:'production_reconciled'};if(!report.registrationCandidatesSatisfied)report.status='registration_gaps';}catch(error){report={...report,mode:'production-read-only',status:'blocked',blocker:/^[A-Z0-9_]+$/.test(error.message)?error.message:'PREFLIGHT_FAILED'};}
  if(outIndex!==-1) {const out=resolve(ROOT,argv[outIndex+1]);requireValue(!relative(ROOT,out).startsWith('..')&&out!==resolve(ROOT,CONTRACT),'Output must be a separate repository-local report');await mkdir(dirname(out),{recursive:true});await writeFile(out,JSON.stringify(report,null,2)+'\n');}
  console.log(JSON.stringify(report));if(mode==='--production'&&report.status!=='production_reconciled')process.exitCode=2;return report;
}
if(process.argv[1]&&import.meta.url===pathToFileURL(resolve(process.argv[1])).href)await main();
