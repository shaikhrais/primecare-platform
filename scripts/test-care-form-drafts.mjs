import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {launchCareBrowser} from './care-browser-launch.mjs';
const {outputFiles}=await build({entryPoints:['websites/typescript/src/care/form-drafts.ts'],bundle:true,platform:'browser',format:'iife',globalName:'CareDrafts',write:false});
const browser=await launchCareBrowser();
async function inspect(run){const page=await browser.newPage();try{await page.setContent('<main id="app"></main>');await page.addScriptTag({content:outputFiles[0].text});return await page.evaluate(run);}finally{await page.close();}}
try{
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
}finally{await browser.close();}
