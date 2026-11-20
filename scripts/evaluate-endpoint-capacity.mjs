import {readFile,writeFile,rm} from 'node:fs/promises';
import {resolve} from 'node:path';
import {evaluateCapacityRun} from './endpoint-capacity-profile.mjs';
const [input,output]=process.argv.slice(2);
if(!input||!output||!output.endsWith('.json')||resolve(input)===resolve(output)||process.argv.length!==4)throw Error('Usage: node scripts/evaluate-endpoint-capacity.mjs RUN_JSON ASSESSMENT_JSON');
const raw=await readFile(input,'utf8');if(raw.length>2000000)throw Error('Capacity result too large');
const report=evaluateCapacityRun(JSON.parse(raw));
await writeFile(output,JSON.stringify(report,null,2)+'\n');
if(report.benchmark)await writeFile(output.replace(/\.json$/,'')+'.benchmark.json',JSON.stringify(report.benchmark,null,2)+'\n');
else {await rm(output.replace(/\.json$/,'')+'.benchmark.json',{force:true});process.exitCode=2;}
console.log(JSON.stringify({measuredScope:report.measurementScope,passingStages:report.stages.filter(s=>s.passed).length,benchmarkCreated:!!report.benchmark}));
