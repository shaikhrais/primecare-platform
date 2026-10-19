import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {readFile} from 'node:fs/promises';
import {launchCareBrowser} from './care-browser-launch.mjs';
const {outputFiles}=await build({entryPoints:['websites/typescript/src/care/form-drafts.ts'],bundle:true,platform:'browser',format:'iife',globalName:'CareDrafts',write:false});
const handover=await build({entryPoints:['websites/typescript/src/care/handover-followup-view.ts'],bundle:true,platform:'browser',format:'iife',globalName:'CareHandover',write:false});
const {locales}=JSON.parse(await readFile('packages/shared/src/care/registry.json','utf8'));
async function inspect(run,arg){const browser=await launchCareBrowser();try{const page=await browser.newPage();await page.setContent('<main id="app"></main>');await page.addScriptTag({content:outputFiles[0].text});await page.addScriptTag({content:handover.outputFiles[0].text});return await page.evaluate(run,arg);}finally{await browser.close();}}
 await test('care drafts retain every selected prerequisite, evidence and checkbox across translated redraw',async()=>{
  const result=await inspect(()=>{
   const root=document.getElementById('app'),markup=label=>`<form data-cy="care-followup-form"><label>${label}<select name="prerequisiteIds" multiple><option value="a" selected>A</option><option value="b" selected>B</option><option value="c">C</option></select></label><input name="note" value="Signed &amp; factual evidence"><input name="checked" type="checkbox"><input name="consent" type="checkbox" checked></form>`;
   root.innerHTML=markup('Prerequisites');const saved=CareDrafts.captureDrafts(root);root.innerHTML=markup('Préalables');CareDrafts.restoreDrafts(root,saved);
   const f=root.querySelector('form');return {ids:[...f.elements.namedItem('prerequisiteIds').selectedOptions].map(o=>o.value),note:f.elements.namedItem('note').value,checked:f.elements.namedItem('checked').checked,consent:f.elements.namedItem('consent').checked};
  });assert.deepEqual(result,{ids:['a','b'],note:'Signed & factual evidence',checked:false,consent:true});
 });
 await test('care drafts retain an empty multiple selection and explicitly unchecked fields',async()=>{
  const result=await inspect(()=>{const root=document.getElementById('app');root.innerHTML='<form data-cy="care-followup-form"><select name="ids" multiple><option value="a">A</option></select><input name="checked" type="checkbox"></form>';const saved=CareDrafts.captureDrafts(root);root.querySelector('option').selected=true;root.querySelector('input').checked=true;CareDrafts.restoreDrafts(root,saved);return {ids:[...root.querySelector('select').selectedOptions].map(o=>o.value),checked:root.querySelector('input').checked};});assert.deepEqual(result,{ids:[],checked:false});
 });
 await test('care draft restoration cannot recreate removed options or overwrite a replacement choice with an absent ID',async()=>{
  const result=await inspect(()=>{const root=document.getElementById('app');root.innerHTML='<form data-cy="care-followup-form"><select name="ids" multiple><option value="a" selected>A</option><option value="b" selected>B</option></select><select name="owner"><option value="old" selected>Old owner</option></select></form>';const saved=CareDrafts.captureDrafts(root);root.innerHTML='<form data-cy="care-followup-form"><select name="ids" multiple><option value="a">A</option><option value="c">C</option></select><select name="owner"><option value="">Choose</option><option value="new">New owner</option></select></form>';CareDrafts.restoreDrafts(root,saved);return {ids:[...root.querySelector('select').selectedOptions].map(o=>o.value),count:root.querySelector('select').options.length,owner:root.querySelector('[name=owner]').value};});assert.deepEqual(result,{ids:['a'],count:2,owner:''});
 });
 await test('care drafts restore only matching forms and ignore removed forms and fields',async()=>{
  const result=await inspect(()=>{const root=document.getElementById('app');root.innerHTML='<form data-cy="one"><input name="note" value="First"><input name="removed" value="Old"></form><form data-cy="two"><input name="note" value="Second"></form>';const saved=CareDrafts.captureDrafts(root);root.innerHTML='<form data-cy="one"><input name="note" value="Blank"></form><form data-cy="three"><input name="note" value="New"></form>';CareDrafts.restoreDrafts(root,saved);return [...root.querySelectorAll('input')].map(i=>i.value);});assert.deepEqual(result,['First','New']);
 });
 await test('actual handover form retains receiving visit and submission fields across EN/FR/ES redraws',async()=>{
  const result=await inspect(locales=>{
   const root=document.getElementById('app'),data={handovers:{canCreate:true,targets:[{id:'target-a',visit_id:'visit-a',requested_start_at:'2026-10-20T12:00:00Z'},{id:'target-b',visit_id:'visit-b',requested_start_at:'2026-10-21T12:00:00Z'}],records:[]}};
   const render=lang=>{root.innerHTML=CareHandover.handoverView(key=>{if(!(key in locales[lang]))throw Error('Missing translation: '+lang+'/'+key);return locales[lang][key];},data);};
   render('en');const fields={targetCaseId:'target-b',summary:'Synthetic summary & continuity',outstanding:'Synthetic pending review',precautions:'Synthetic approved plan precautions',note:'Synthetic author evidence'};
   for(const [name,value] of Object.entries(fields))root.querySelector('[data-cy="care-handover-form"]').elements.namedItem(name).value=value;
   const submissions=[];
   for(const lang of ['fr','es','en']){const saved=CareDrafts.captureDrafts(root);render(lang);CareDrafts.restoreDrafts(root,saved);const form=root.querySelector('[data-cy="care-handover-form"]');submissions.push({lang,fields:Object.fromEntries(new FormData(form)),valid:form.checkValidity(),button:root.querySelector('[data-cy="care-handover-save"]').textContent});}
   return {fields,submissions};
  },locales);
  for(const submission of result.submissions){assert.deepEqual(submission.fields,result.fields);assert.equal(submission.valid,true);assert.equal(submission.button,locales[submission.lang].handover_create);}
 });
 await test('handover redraw cannot restore a removed receiving visit or a revoked create form',async()=>{
  const result=await inspect(locales=>{
   const root=document.getElementById('app'),data={handovers:{canCreate:true,targets:[{id:'removed-target',visit_id:'removed-visit',requested_start_at:'2026-10-20T12:00:00Z'}],records:[]}};
   const render=()=>{root.innerHTML=CareHandover.handoverView(key=>locales.en[key],data);};
   render();root.querySelector('[data-cy="care-handover-target"]').value='removed-target';root.querySelector('[data-cy="care-handover-summary"]').value='Synthetic unsent summary';const saved=CareDrafts.captureDrafts(root);
   data.handovers.targets=[];render();CareDrafts.restoreDrafts(root,saved);const target=root.querySelector('[data-cy="care-handover-target"]'),afterRemoval={value:target.value,hasRemoved:[...target.options].some(o=>o.value==='removed-target'),summary:root.querySelector('[data-cy="care-handover-summary"]').value};
   data.handovers.canCreate=false;render();CareDrafts.restoreDrafts(root,saved);return {afterRemoval,forms:root.querySelectorAll('[data-cy="care-handover-form"]').length};
  },locales);
  assert.deepEqual(result,{afterRemoval:{value:'',hasRemoved:false,summary:'Synthetic unsent summary'},forms:0});
 });
