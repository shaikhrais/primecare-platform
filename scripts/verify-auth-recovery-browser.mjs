import assert from 'node:assert/strict';
import {chromium} from 'playwright';
import {fillFlutterField} from './flutter-browser-input.mjs';
/** Drives recovery/reset through the published shared Flutter screen. Never captures reset codes. */
export async function openRecoveryBrowser(email) {
 const browser=await chromium.launch({headless:true});
 try {
  const page=await browser.newPage();
  page.setDefaultTimeout(30000);
  await page.goto(process.env.AUTH_UI_URL || 'https://primecare-client.pages.dev/',{waitUntil:'networkidle',timeout:60000});
  const placeholder=page.locator('flt-semantics-placeholder');
  if(await placeholder.count())await placeholder.evaluate(element=>element.click());
  const fill=(label,value)=>fillFlutterField(page,label,value);
  const secret=(label,value)=>fillFlutterField(page,label,value,true);
  await page.getByRole('button',{name:'Forgot password?',exact:true}).click();
  await fill('Email',email);
  const recovered=page.waitForResponse(r=>r.url().endsWith('/v1/auth/forgot-password')&&r.request().method()==='POST');
  await page.getByRole('button',{name:'Send recovery instructions',exact:true}).click();
  const status=(await recovered).status();
  assert.equal(status,200,'Browser recovery request accepted');
  await page.getByRole('textbox',{name:'Reset code',exact:true}).waitFor();
  return {status,
   async reset(code,password){
    let phase='fill reset code';
    try {
    await fill('Reset code',code);phase='fill new password';await secret('New password',password);
    phase='submit reset form';
    const response=page.waitForResponse(r=>r.url().endsWith('/v1/auth/reset-password')&&r.request().method()==='POST');
    await page.getByRole('button',{name:'Reset password',exact:true}).click();
    phase='wait reset response';
    const result=await response;
    assert.equal(result.status(),200,'Browser reset request accepted');
    await page.getByRole('button',{name:'Sign in',exact:true}).waitFor();
    return {status:result.status(),data:await result.json()};
    }catch(error){
     console.error('UI recovery phase: '+phase);
     console.error('UI input diagnostics: '+JSON.stringify(await page.locator('input').evaluateAll(elements=>elements.map(e=>({type:e.type,length:e.value.length,focused:e===document.activeElement})))));
     for(const message of ['Email is required','Reset code is required','New password is required','Enter the 12-character reset code from your email','Authentication unavailable. Please try again.']) {
      if(await page.getByText(message,{exact:true}).count()) console.error('UI validation: '+message);
     }
     throw error;
    }
   },
   async loginLogout(password){
    await fill('Email',email);await secret('Password',password);
    const login=page.waitForResponse(r=>r.url().endsWith('/v1/auth/login')&&r.request().method()==='POST');
    await page.getByRole('button',{name:'Sign in',exact:true}).click();
    assert.equal((await login).status(),200,'Browser login after recovery');
    await page.getByRole('button',{name:'Sign out',exact:true}).waitFor();
    const logout=page.waitForResponse(r=>r.url().endsWith('/v1/auth/logout')&&r.request().method()==='POST');
    await page.getByRole('button',{name:'Sign out',exact:true}).click();
    assert.equal((await logout).status(),200,'Browser logout after recovery');
    await page.getByRole('button',{name:'Sign in',exact:true}).waitFor();
   }, close:()=>browser.close(),
  };
 }catch(error){await browser.close();throw error;}
}
