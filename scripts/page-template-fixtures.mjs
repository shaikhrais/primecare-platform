import {build} from 'esbuild';import {mkdir,writeFile,readFile} from 'node:fs/promises';import assert from 'node:assert/strict';
const bundle=await build({entryPoints:['packages/domain/src/page_template.ts'],bundle:true,write:false,format:'esm',platform:'node'});
export const api=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
export const authority={ids:['page_one','page_two','home','current'],routes:['/one','/two?tab=details','/']};
export function page(id='page_one',route='/one',layout=api.defaultPageLayout()){return {id,route,title:'Registered title <safe>',breadcrumbs:[{id:'home',label:'Home',route:'/'},{id:'denied',label:'PRIVATE breadcrumb',route:'/secret'},{id:'current',label:'Current'}],layout};}
export const cases=[];
for(const template of ['simple','carded'])for(const scroll of ['normal','page','content'])for(const mode of ['none','permanent','temporary','responsive']){
 const layout={...api.defaultPageLayout(),template,scroll,left:{mode,width:280,open:mode==='permanent'},right:{mode,width:240,open:false},chrome:{navigation:mode!=='none',toolbar:scroll!=='page',footer:template==='simple'}};
 const routes=[page('page_one','/one',layout),page('page_two','/two?tab=details')];
 for(const current of ['/one#anchor','/two?tab=details','/two?tab=other','/secret']){
  for(const grant of [authority,{...authority,ids:[]},{...authority,routes:authority.routes.filter(r=>r!=='/one')}]){const expected=api.buildPageRoutes(routes,grant);cases.push({routes,authority:grant,current,expected,resolved:api.resolvePageRoute(expected,current)?.id??null});}
 }
}
const dir='packages/flutter_core/test/page/fixtures';
if(process.argv.includes('--verify-native')){const out=JSON.parse(await readFile(process.argv.at(-1),'utf8'));assert.deepEqual(out,cases.map(c=>({routes:c.expected,resolved:c.resolved})));console.log(`${cases.length} native page cases match the web oracle.`);}
else{await mkdir(dir,{recursive:true});await writeFile(dir+'/web.json',JSON.stringify(cases));console.log(`Generated ${cases.length} page route/layout cases.`);}
