import {reviewContrast} from './contrast-review.mjs';
import assert from 'node:assert/strict';
import {createRequire} from 'node:module';
import {mkdir,writeFile} from 'node:fs/promises';
const require=createRequire(import.meta.url);
/** Automated checks complement explicit keyboard tests; incomplete results require human review. */
export async function scanAccessibility(page,name){
 if(!await page.evaluate(()=>Boolean(window.axe)))await page.addScriptTag({path:require.resolve('axe-core/axe.min.js')});
 const results=await page.evaluate(()=>window.axe.run(document,{runOnly:{type:'tag',values:['wcag2a','wcag2aa','wcag21a','wcag21aa','wcag22aa']}}));
 await mkdir('test-results/accessibility',{recursive:true});
 await writeFile('test-results/accessibility/'+name+'.json',JSON.stringify(results,null,2));
 assert.deepEqual(results.violations.map(v=>({id:v.id,impact:v.impact,nodes:v.nodes.map(n=>({target:n.target,summary:n.failureSummary}))})),[],'Automated accessibility violations: '+name);
 if(process.env.ACCESSIBILITY_CONTRAST_REVIEW==='1')await reviewContrast(page,name);
 return {passes:results.passes.length,incomplete:results.incomplete.length};
}
