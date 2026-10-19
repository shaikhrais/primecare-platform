import assert from 'node:assert/strict';
import {readdir,readFile,writeFile} from 'node:fs/promises';
import {join} from 'node:path';
const directory=process.argv[2]??'test-results/contrast';
const statuses=['axe_pass_after_scroll','axe_pass_with_control_probe','supplemental_graphic_measurement','supplemental_text_measurement','supplemental_control_measurement','unresolved','violation'];
const summary={statesReviewed:0,candidateOccurrences:0,statuses:Object.fromEntries(statuses.map(key=>[key,0])),unresolvedByTag:{},minimumGraphicContrast:null,minimumTextContrast:null,minimumControlContrast:null,states:[]};
for(const file of (await readdir(directory)).filter(file=>file.endsWith('.json')&&file!=='summary.json').sort()){
 const report=JSON.parse(await readFile(join(directory,file),'utf8'));
 assert.equal(report.candidateCount,report.outcomes.length,file+': missing outcomes');summary.statesReviewed++;summary.candidateOccurrences+=report.candidateCount;
 const state={file,candidates:report.candidateCount,unresolved:0};
 for(const outcome of report.outcomes){
  assert.ok(statuses.includes(outcome.status),file+': unexpected status');summary.statuses[outcome.status]++;
  if(outcome.status==='unresolved'){state.unresolved++;const tag=/^<(\w+)/.exec(outcome.html??'')?.[1]??'unknown';summary.unresolvedByTag[tag]=(summary.unresolvedByTag[tag]??0)+1;}
  for(const [status,key] of [['supplemental_graphic_measurement','minimumGraphicContrast'],['supplemental_text_measurement','minimumTextContrast'],['supplemental_control_measurement','minimumControlContrast']])if(outcome.status===status){assert.ok([3,4.5].includes(outcome.threshold),'Unsupported contrast threshold');assert.ok(Number.isFinite(outcome.contrast)&&outcome.contrast>=outcome.threshold);summary[key]=Math.min(summary[key]??Infinity,outcome.contrast);}
 }
 summary.states.push(state);
}
assert.ok(summary.statesReviewed>0,'No contrast-review reports found');
await writeFile(join(directory,'summary.json'),JSON.stringify(summary,null,2)+'\n');
const {states,...totals}=summary;console.log(JSON.stringify(totals,null,2));
assert.equal(summary.statuses.violation,0,'Confirmed contrast failures remain');
