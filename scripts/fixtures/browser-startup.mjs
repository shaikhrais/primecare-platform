/** Fail promptly on real startup errors, retaining the actual browser readiness assertion. */
export async function waitForFixtureStartup(page, navigate, {selector='[data-cy="platform-language"]',timeoutMs=10000}={}) {
 if(!Number.isFinite(timeoutMs)||timeoutMs<=0)throw Error('A finite positive fixture startup timeout is required');
 let timer;
 const listeners=[];
 const failure=new Promise((_,reject)=>{
  for(const [name,describe]of [
   ['pageerror',error=>`Browser fixture startup failed: ${error?.message??String(error)}`],
   ['crash',()=> 'Browser fixture page crashed during startup'],
   ['close',()=> 'Browser fixture page closed during startup'],
  ]){
   const listener=value=>reject(Error(describe(value)));
   listeners.push([name,listener]);page.on(name,listener);
  }
  timer=setTimeout(()=>reject(Error(`Browser fixture startup: ${selector} not ready within ${timeoutMs} ms`)),timeoutMs);
 });
 try{
  await Promise.race([(async()=>{await navigate();await page.locator(selector).waitFor({state:'attached',timeout:timeoutMs});})(),failure]);
 }finally{
  clearTimeout(timer);
  for(const [name,listener]of listeners)page.off(name,listener);
 }
}
