import {chromium} from 'playwright';
import {mkdir,writeFile} from 'node:fs/promises';
const output=process.argv[2];await mkdir(output,{recursive:true});
const browser=await chromium.launch({headless:true});const results=[];
for(const [device,width,height] of [['desktop',1440,1000],['tablet',820,1180],['mobile',390,844]])for(const mode of ['light','dark']){
 const page=await browser.newPage({viewport:{width,height},deviceScaleFactor:1});const errors=[],external=[];
 page.on('pageerror',e=>{errors.push(e.message);console.error('Reference page error:',e.message);});
 await page.route('**/*',route=>{const url=new URL(route.request().url());if(['127.0.0.1','localhost'].includes(url.hostname)||['data:','blob:'].includes(url.protocol))return route.continue();external.push(url.origin);return route.abort();});
 await page.goto('http://127.0.0.1:4317/?mode='+mode,{waitUntil:'domcontentloaded',timeout:120000});
 try{await page.getByText('Theme Settings',{exact:true}).waitFor({timeout:60000});}catch(error){await page.screenshot({path:output+'/reference-failure.png'});await writeFile(output+'/reference-failure.json',JSON.stringify({errors,external,body:await page.locator('body').innerText()},null,2));throw error;}await page.evaluate(()=>document.fonts.ready);
 const panel=page.locator('.MuiDialog-paper').last();await panel.screenshot({path:`${output}/fuse-layout-${device}-${mode}.png`,animations:'disabled'});
 const metrics=await panel.evaluate(root=>[root,...root.querySelectorAll('.FuseSettings-formGroup,.FuseSettings-formGroupTitle,.MuiTypography-root,.MuiFormControlLabel-root,.MuiRadio-root,.MuiSwitch-root,.MuiInputBase-root')].map(el=>{const s=getComputedStyle(el),r=el.getBoundingClientRect();return {tag:el.tagName,classes:el.className,text:(el.textContent??'').trim().slice(0,90),box:{x:r.x,y:r.y,width:r.width,height:r.height},style:Object.fromEntries(['fontFamily','fontSize','fontWeight','lineHeight','padding','margin','borderRadius','backgroundColor','color','gap'].map(k=>[k,s[k]]))};}));
 const tile=page.getByText('Main Palette',{exact:true});await tile.scrollIntoViewIfNeeded();await tile.evaluate(el=>{const group=el.closest('.FuseSettings-formGroup');if(!group)throw Error('Theme group missing');let parent=group.parentElement;while(parent&&parent.scrollHeight<=parent.clientHeight)parent=parent.parentElement;if(parent)parent.scrollTop+=group.getBoundingClientRect().top-parent.getBoundingClientRect().top;});await panel.screenshot({path:`${output}/fuse-theme-${device}-${mode}.png`,animations:'disabled'});
 if(device==='desktop'){
  await tile.click();const editor=page.locator('.MuiDialog-paper').filter({hasText:'Edit palette'}).last();await editor.waitFor();await editor.screenshot({path:`${output}/fuse-editor-${mode}.png`,animations:'disabled'});
  await writeFile(`${output}/editor-metrics-${mode}.json`,JSON.stringify(await editor.evaluate(el=>{const s=getComputedStyle(el),r=el.getBoundingClientRect();return {width:r.width,height:r.height,font:s.fontFamily,fontSize:s.fontSize,radius:s.borderRadius,inputs:[...el.querySelectorAll('input')].map(i=>{const r=i.getBoundingClientRect();return {type:i.type,width:r.width,height:r.height};})};}),null,2));
 }
 results.push({device,mode,width,height,errors,external,metrics});await page.close();
}
await browser.close();await writeFile(output+'/measurements.json',JSON.stringify(results,null,2));
if(results.some(r=>r.errors.length||r.external.length))throw Error('Reference reported errors or attempted external traffic; inspect measurements.');
console.log('Original Fuse settings captured in six viewports/modes with computed measurements.');
