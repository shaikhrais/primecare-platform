import {build} from 'esbuild';import {readFile,writeFile,mkdir} from 'node:fs/promises';import assert from 'node:assert/strict';
const compiled=await build({entryPoints:['packages/domain/src/workspace_navigation.ts'],bundle:true,write:false,format:'esm',platform:'node'});
const api=await import('data:text/javascript;base64,'+Buffer.from(compiled.outputFiles[0].text).toString('base64'));
export const items=[{id:'work',kind:'group',label:'Work',icon:'folder',children:[
 {id:'home',kind:'item',label:'Home',route:'/app',match:'prefix',subtitle:'Own workspace',badge:'3',icon:'home'},
 {id:'team',kind:'group',label:'Team',children:[{id:'people',kind:'item',label:'People',route:'/app/people'},{id:'disabled',kind:'item',label:'Disabled',route:'/disabled',disabled:true}]},
 {id:'denied',kind:'item',label:'PRIVATE denied destination',route:'/secret'},
]},{id:'other',kind:'group',label:'Other',children:[{id:'report',kind:'item',label:'Report',route:'/report#summary'}]},
{id:'private',kind:'group',label:'PRIVATE denied group',children:[{id:'child',kind:'item',label:'PRIVATE child',route:'/child'}]},
{id:'unavailable',kind:'group',label:'Unavailable',disabled:true,children:[{id:'locked',kind:'item',label:'Locked',route:'/locked'}]}];
export const authority={ids:['work','home','team','people','disabled','other','report','child','unavailable','locked'],routes:['/app','/app/people','/disabled','/report#summary','/child','/locked'],icons:['folder','home']};
const cases=[];for(const current of ['/app','/app/people','/app/people/123','/apple','/report#summary','/report#other','/disabled']){
 for(const ids of [authority.ids,authority.ids.filter(x=>x!=='people'),[]]){const grant={...authority,ids};const nodes=api.buildWorkspaceNavigation(items,grant);cases.push({items,authority:grant,current,expected:nodes,active:api.activeWorkspaceDestination(nodes,current)??null});}
}
const root='packages/flutter_core/test/navigation/fixtures';
if(process.argv.includes('--verify-native')){const out=JSON.parse(await readFile(process.argv.at(-1),'utf8'));assert.deepEqual(out,cases.map(c=>({nodes:c.expected,active:c.active})));console.log('21 native navigation cases match the web permission and active-route oracle.');}
else{await mkdir(root,{recursive:true});await writeFile(root+'/web.json',JSON.stringify(cases));console.log('Generated 21 navigation authority and active-route fixtures.');}
export {api};
