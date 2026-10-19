import {chromium} from 'playwright';
export function launchCareBrowser(){
 return chromium.launch({headless:true,...(process.env.GROWTH_BROWSER_EXECUTABLE?{executablePath:process.env.GROWTH_BROWSER_EXECUTABLE,args:['--no-sandbox','--disable-dev-shm-usage',...(process.env.CARE_BROWSER_SOFTWARE_ONLY==='1'?['--no-zygote','--disable-gpu','--disable-software-rasterizer']:[])]}:{})});
}
