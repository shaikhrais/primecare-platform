/** Real deployed browser capture. No request interception, session fabrication or data seeding. */
import {chromium} from '@playwright/test';
import {mkdir,writeFile} from 'node:fs/promises';
const origin='https://primecare-governance.pages.dev',out='test-results/ems/live-browser';
const receipt={captureSource:process.env.GITHUB_SHA??null,servingSource:null,origin,observedAt:new Date().toISOString(),sourceKind:'deployed_browser',authenticated:false,blocker:null,views:[]};
await mkdir(out,{recursive:true});
const browser=await chromium.launch({headless:true});const context=await browser.newContext();
try{
 const stamp=await fetch(origin+'/primecare-build.json?capture='+Date.now(),{cache:'no-store'}).then(r=>r.json());receipt.servingSource=typeof stamp.commit==='string'?stamp.commit:null;
 const page=await context.newPage();
 await page.goto(origin+'/platform/administration#ems',{waitUntil:'domcontentloaded',timeout:60000});
 await page.waitForTimeout(3000);
 if(await page.locator('[data-cy=login-form]').count()){
  const email=process.env.BOOTSTRAP_CODE_ADMIN_EMAIL,password=process.env.BOOTSTRAP_CODE_ADMIN_PASSWORD;
  if(email&&password){
   await page.locator('[data-cy=login-email]').fill(email);await page.locator('[data-cy=login-password]').fill(password);await page.locator('[data-cy=login-submit]').click();
   await Promise.race([page.locator('[data-cy=mfa-form]').waitFor({state:'visible',timeout:20000}),page.locator('[data-cy=platform-nav-ems]').waitFor({state:'visible',timeout:20000})]).catch(()=>{});
   if(await page.locator('[data-cy=mfa-form]').isVisible().catch(()=>false))receipt.blocker='MFA requires the account owner; no MFA enrollment or bypass was attempted.';
  }else receipt.blocker='Existing Code Admin sign-in secrets are unavailable; no account or session was created.';
 }
 if(await page.locator('[data-cy=platform-nav-ems]').count()){
  await page.goto(origin+'/platform/administration#ems',{waitUntil:'domcontentloaded',timeout:60000});
  await page.locator('[data-cy=ems-overview]').waitFor({state:'visible',timeout:30000});await page.waitForTimeout(5000);
  receipt.authenticated=true;
 }else if(!receipt.blocker)receipt.blocker='The deployed app did not expose the authenticated EMS navigation.';
 for(const [name,width,height]of [['desktop',1440,1000],['tablet',820,1180],['mobile',390,844]]){
  await page.setViewportSize({width,height});await page.waitForTimeout(500);
  const file=name+'.png';
  await page.screenshot({path:out+'/'+file,fullPage:true,mask:[page.locator('[data-cy=mfa-seed]'),page.locator('input[type=password]'),page.locator('[data-cy=login-email]')]});
  receipt.views.push({name,width,height,file,path:new URL(page.url()).pathname,emsVisible:await page.locator('[data-cy=ems-overview]').isVisible().catch(()=>false)});
 }
 // A captured login/MFA page is not EMS acceptance.
 if(receipt.authenticated){const summary=await page.locator('[data-cy=ems-summary]').textContent();receipt.emsAccessDenied=/access denied/i.test(summary??'');if(receipt.emsAccessDenied)receipt.blocker='Authenticated account lacks the required EMS grants.';}
} catch {receipt.blocker='Deployed browser capture failed before all requested views completed.';process.exitCode=1;}
finally{await context.close();await browser.close();await writeFile(out+'/receipt.json',JSON.stringify(receipt,null,2)+'\n');console.log('EMS_LIVE_BROWSER '+JSON.stringify(receipt));}
