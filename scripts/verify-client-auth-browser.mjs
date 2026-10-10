// Browser smoke uses only the disposable account owned by the production test.
import assert from 'node:assert/strict';
import {chromium} from 'playwright';
export async function verifyClientAuthBrowser(email,password) {
 const browser=await chromium.launch({headless:true});
 let phase='load published Client';
 try {
  const page=await browser.newPage();
  await page.goto('https://primecare-client.pages.dev/',{waitUntil:'networkidle',timeout:60000});
  // Flutter exposes its form through the web semantics tree after activation.
  const placeholder=page.locator('flt-semantics-placeholder');
  if(await placeholder.count())await placeholder.evaluate(element=>element.click());
  phase='find accessible login form';
  const emailField=page.getByRole('textbox',{name:'Email',exact:true});
  await emailField.waitFor({timeout:30000});
  await emailField.click();
  await page.locator('input:focus').fill(email);
  const passwordField=page.getByLabel('Password',{exact:true});
  await passwordField.click();
  await page.locator('input:focus').fill(password);
  phase='submit browser login';
  const loginResponse=page.waitForResponse(response=>response.url().endsWith('/v1/auth/login')&&response.request().method()==='POST');
  await page.getByRole('button',{name:'Sign in',exact:true}).click();
  assert.equal((await loginResponse).status(),200,'Browser login must authenticate');
  await page.getByRole('button',{name:'Sign out',exact:true}).waitFor({timeout:15000});
  phase='submit browser logout';
  const logoutResponse=page.waitForResponse(response=>response.url().endsWith('/v1/auth/logout')&&response.request().method()==='POST');
  await page.getByRole('button',{name:'Sign out',exact:true}).click();
  assert.equal((await logoutResponse).status(),200,'Browser logout must revoke its session');
  await page.getByRole('button',{name:'Sign in',exact:true}).waitFor({timeout:15000});
 }catch(error){
  console.error('Browser verification failed during '+phase);
  // Diagnostic screenshot contains only synthetic QA identity and hidden password.
  const pages=browser.contexts().flatMap(context=>context.pages());
  if(pages[0]) {
    console.error('Field diagnostics: '+JSON.stringify(await pages[0].locator('input').evaluateAll(elements=>elements.map(e=>({type:e.type,length:e.value.length,focused:e===document.activeElement})))));
    await pages[0].screenshot({path:'client-auth-failure.png'}).catch(()=>{});
  }
  throw error;
 }
 finally {await browser.close();}
}
