/** Await a fixture's first intercepted request without hiding a failed browser bootstrap. */
export async function waitForFixtureRequest(page, requestArrived, navigate, {label='Fixture request',timeoutMs=10000}={}) {
 if(!Number.isFinite(timeoutMs)||timeoutMs<=0)throw Error('A finite positive fixture request timeout is required');
 let timer;
 const listeners=[];
 const failure=new Promise((_,reject)=>{
  for(const [name,describe]of [
   ['pageerror',error=>`${label}: browser bootstrap failed: ${error?.message??String(error)}`],
   ['crash',()=>`${label}: page crashed before the request arrived`],
   ['close',()=>`${label}: page closed before the request arrived`],
  ]){
   const listener=value=>reject(Error(describe(value)));
   listeners.push([name,listener]);page.on(name,listener);
  }
  timer=setTimeout(()=>reject(Error(`${label}: no request arrived within ${timeoutMs} ms`)),timeoutMs);
 });
 try{
  await Promise.race([(async()=>{await navigate();await requestArrived;})(),failure]);
 }finally{
  clearTimeout(timer);
  for(const [name,listener]of listeners)page.off(name,listener);
 }
}
