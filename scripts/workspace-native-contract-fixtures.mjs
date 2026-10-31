/** Cross-runtime contract oracle. No production data or credentials. */
import {build} from 'esbuild';
import {readFile,writeFile,mkdir} from 'node:fs/promises';
import assert from 'node:assert/strict';
const compiled=await build({entryPoints:['packages/domain/src/workspace_layout.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {defaultWorkspaceLayout,validateWorkspaceLayout}=await import('data:text/javascript;base64,'+Buffer.from(compiled.outputFiles[0].text).toString('base64'));
const ids=['note','summary'],profiles=[];
for(const navigation of ['left','right','top','bottom','hidden'])
for(const container of ['fullwidth','boxed','content'])
for(const toolbar of ['top','bottom'])
for(const toolbarStyle of ['sticky','static'])
for(const scroll of ['page','content'])
for(const footer of ['static','sticky','hidden']){
 const p=defaultWorkspaceLayout(ids);Object.assign(p,{navigation,container,toolbar,toolbarStyle,scroll,footer});
 p.panels.note.dock=['left','right','top','bottom','floating','hidden'][profiles.length%6];
 p.panels.summary={dock:'floating',x:10000,y:10000,width:1200,height:1200};
 p.navigationWidth=profiles.length%2?160:400;p.maxWidth=profiles.length%2?960:1920;
 profiles.push(validateWorkspaceLayout(p,ids));
}
const root='packages/flutter_core/test/workspace/fixtures';
if(process.argv.includes('--verify-native')){
 const native=JSON.parse(await readFile(root+'/native.json','utf8'));
 assert.equal(native.length,360);assert.deepEqual(native.map(p=>validateWorkspaceLayout(p,ids)),profiles);
 console.log('360 native exports accepted by the web contract without setting loss.');
}else{await mkdir(root,{recursive:true});await writeFile(root+'/web.json',JSON.stringify({panelIds:ids,profiles}));console.log('Generated 360 validated web profiles for native roundtrip checks.');}
