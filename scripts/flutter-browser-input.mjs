import assert from 'node:assert/strict';
/** Let Flutter finish focusing its native editor, then type real keyboard events. */
export async function fillFlutterField(page,label,value,secret=false) {
 const field=secret?page.getByLabel(label,{exact:true}):page.getByRole('textbox',{name:label,exact:true});
 await field.click();
 await page.evaluate(()=>new Promise(resolve=>requestAnimationFrame(()=>requestAnimationFrame(resolve))));
 const input=page.locator('input:focus');
 await input.waitFor();
 if(secret)assert.equal(await input.getAttribute('type'),'password','Secret editor must have focus');
 await input.fill('');
 await page.evaluate(()=>new Promise(resolve=>requestAnimationFrame(()=>requestAnimationFrame(resolve))));
 await input.pressSequentially(value,{delay:10});
 await page.evaluate(()=>new Promise(resolve=>requestAnimationFrame(()=>requestAnimationFrame(resolve))));
 assert.equal((await input.inputValue()).length,value.length,'Flutter editor retains complete input');
 await input.press('Tab');
 await page.evaluate(()=>new Promise(resolve=>requestAnimationFrame(()=>requestAnimationFrame(resolve))));
}
