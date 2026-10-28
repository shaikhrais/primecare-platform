/** Actual marketing renderer; controlled HTTP, no production records or provider sends. */
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {JSDOM} from 'jsdom';
import {mkdtemp,writeFile} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {pathToFileURL} from 'node:url';
import {emptyGrowthReadModel} from './fixtures/growth-read-model.mjs';

const bundle=await build({entryPoints:['websites/typescript/src/growth/dashboard.ts'],bundle:true,write:false,platform:'node',format:'esm'});
const file=join(await mkdtemp(join(tmpdir(),'growth-report-drafts-')),'dashboard.mjs');
await writeFile(file,bundle.outputFiles[0].text);
const {renderGrowth}=await import(pathToFileURL(file).href);
const tick=()=>new Promise(resolve=>setImmediate(resolve));

for(const mode of ['report','statement','report-pdf','statement-pdf','failed-report','changed-tenant','changed-role','create-campaign'])await test('CEO unfinished campaign and lead drafts: '+mode,async()=>{
 const dom=new JSDOM('<div id="app"></div>',{url:'https://primecare-clinic.pages.dev/growth?enable-semantics=true'});
 for(const key of ['window','document','location','history','sessionStorage','localStorage','HTMLElement','HTMLInputElement','HTMLSelectElement','HTMLButtonElement','HTMLDetailsElement','HTMLFormElement','Element','Node','FormData'])globalThis[key]=dom.window[key];
 globalThis.getComputedStyle=dom.window.getComputedStyle.bind(dom.window);
 sessionStorage.setItem('primecare_session','synthetic-session');
 const data=structuredClone(emptyGrowthReadModel);Object.assign(data.capabilities,{createLead:true,createCampaign:true,manageCampaignMoney:true});data.canReport=true;
 data.canEditPlan=true;data.canManageIntake=true;
 data.business={canBusiness:true,marketing:{period:{start:'2026-10-01',endExclusive:'2026-11-01'},netReceiptsCents:'0',contributionCents:'0',advertisingCents:'0',managementCents:'0'},financeKinds:[],partnerLeads:[],clientLeads:[],partners:[],handoffs:[],careReady:false,entries:[],summary:{netReceipts:'0',outstanding:'0',expenses:'0',cashBalance:'0',payingCAC:null,payingClients:0}};
 let reads=0;const calls=[],downloads=[],errors=[];
 dom.window.addEventListener('error',event=>errors.push(event.message));
 dom.window.HTMLAnchorElement.prototype.click=function(){downloads.push(this.download);};
 globalThis.fetch=async(url,options)=>{
  calls.push({url,method:options.method});
  if(url.includes('/pdf?'))return new Response('%PDF-1.4 synthetic fixture',{headers:{'content-type':'application/pdf'}});
  if(url.includes('/performance?')||url.includes('/marketing-statement?'))return mode==='failed-report'?Response.json({error:'unavailable'},{status:503}):Response.json({locale:'en',columns:[],rows:[],generatedAt:'2026-10-28T12:00:00Z',scope:'Synthetic tenant',title:'Synthetic performance'});
  if(options.method==='POST')return Response.json({id:'synthetic-campaign'},{status:201});
  reads++;const next=structuredClone(data);if(mode==='changed-tenant'&&reads>1)next.identity.tenantId='different-synthetic-tenant';if(mode==='changed-role'&&reads>1)next.identity.role='marketing';return Response.json(next);
 };
 const root=document.querySelector('#app'),el=id=>root.querySelector('[data-cy="'+id+'"]');
 try{
  await renderGrowth(root,'https://gateway.test');
  for(const [key,target] of [['business_ops','business'],['plan','plan'],['intake','intake']]){
   assert.equal(el('growth-nav-'+key)?.dataset.growthTarget,target,'business workflow has a direct authorized navigation entry');
   assert.equal(el('growth-'+target)?.id,'growth-'+target);
  }
  el('growth-campaign-name').value='Unfinished local referral campaign';
  el('growth-lead-name').value='Unfinished enquiry';
  el('growth-campaign-reference').value='Synthetic reference';
  if(mode.endsWith('-pdf'))el(mode==='statement-pdf'?'growth-marketing-statement-pdf':'growth-report-pdf').click();
  else {const form=el(mode==='create-campaign'?'growth-campaign-form':mode==='statement'?'growth-marketing-statement-form':'growth-report-form');form.dispatchEvent(new window.Event('submit',{bubbles:true,cancelable:true}));}
  for(let n=0;n<10;n++)await tick();
  const retain=['report','statement','report-pdf','statement-pdf','failed-report'].includes(mode);
  assert.equal(el('growth-campaign-name').value,retain?'Unfinished local referral campaign':'');
  if(retain)assert.equal(el('growth-lead-name').value,'Unfinished enquiry');
  if(mode==='report')assert.ok(el('growth-report-table'),'successful report remains visible');
  if(mode==='statement')assert.ok(el('growth-marketing-statement-table'),'monthly statement remains visible');
  if(mode.endsWith('-pdf'))assert.equal(downloads[0],mode==='statement-pdf'?'marketing-statement-2026-10.pdf':'growth-performance.pdf');
  if(mode==='changed-tenant')assert.equal(el('growth-lead-name').value,'','drafts never cross tenant scope');
  if(mode==='create-campaign')assert.equal(calls.filter(c=>c.method==='POST').length,1,'successful create is not replayed');
  assert.deepEqual(errors,[]);
 }finally{dom.window.close();}
});
