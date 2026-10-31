import {build} from 'esbuild';
import {readFile,writeFile,mkdir} from 'node:fs/promises';
const result=await build({entryPoints:['packages/primecare_ui/web/workspace-layout.ts'],bundle:true,write:false,format:'iife',globalName:'Workspace'});
const fixture=await readFile('scripts/fixtures/workspace-layout.html','utf8');
const controls=`<aside class="preview-controls" aria-label="Isolated layout preview controls"><h2>Layout lab</h2><p>Original PrimeCare engine · preview only</p>
<label>Navigation <select data-cy="preview-navigation"><option>left</option><option>right</option><option>top</option><option>bottom</option><option>hidden</option></select></label>
<label>Container <select data-cy="preview-container"><option>fullwidth</option><option>boxed</option><option>content</option></select></label>
<label>Toolbar <select data-cy="preview-toolbar"><option>top</option><option>bottom</option></select></label>
<label>Toolbar style <select data-cy="preview-toolbarStyle"><option>sticky</option><option>static</option></select></label>
<label>Footer <select data-cy="preview-footer"><option>static</option><option>sticky</option><option>hidden</option></select></label>
<label>Scroll <select data-cy="preview-scroll"><option>page</option><option>content</option></select></label>
<label>Schedule panel <select data-cy="preview-panel"><option>right</option><option>left</option><option>top</option><option>bottom</option><option>floating</option><option>hidden</option></select></label>
<div><button data-cy="preview-undo">Undo</button><button data-cy="preview-redo">Redo</button><button data-cy="preview-reset">Reset</button><button data-cy="preview-save">Save</button><button data-cy="preview-export">Export</button></div><label>Import JSON <input data-cy="preview-import" type="file" accept=".json,application/json"></label><output role="status" data-cy="preview-status"></output></aside>
<style>.preview-controls{position:relative!important;inset:auto!important;width:100%!important;height:auto!important;max-height:none!important;background:#fff!important;color:#18334d!important;display:flex;gap:12px;flex-wrap:wrap;align-items:end;padding:20px!important;border-bottom:1px solid #dce6ef}.preview-controls h2{margin:0}.preview-controls p{width:100%;margin:0}.preview-controls label{display:grid;gap:6px;font-size:12px}.preview-controls select{padding:10px;border:1px solid #dce6ef;border-radius:8px;background:white}.preview-controls input{max-width:220px}.preview-controls output{width:100%}</style>`;
const behavior=`<script>
const status=document.querySelector('[data-cy=preview-status]');
const sync=()=>{for(const key of ['navigation','container','toolbar','toolbarStyle','footer','scroll'])document.querySelector('[data-cy="preview-'+key+'"]').value=manager.current[key];document.querySelector('[data-cy=preview-panel]').value=manager.current.panels.schedule.dock;};
for(const key of ['navigation','container','toolbar','toolbarStyle','footer','scroll'])document.querySelector('[data-cy="preview-'+key+'"]').onchange=e=>manager.change({...manager.current,[key]:e.target.value});
document.querySelector('[data-cy=preview-panel]').onchange=e=>manager.dockPanel('schedule',e.target.value);
for(const action of ['undo','redo','reset','save'])document.querySelector('[data-cy="preview-'+action+'"]').onclick=()=>{try{manager[action]();sync();status.value=action==='save'?'Saved on this browser.':'';}catch{status.value='Unable to save preferences on this browser.';}};
document.querySelector('[data-cy=preview-export]').onclick=()=>{const url=URL.createObjectURL(new Blob([manager.exportJson()],{type:'application/json'}));const a=document.createElement('a');a.href=url;a.download='PrimeCare_Workspace.json';a.click();setTimeout(()=>URL.revokeObjectURL(url),1000);};
document.querySelector('[data-cy=preview-import]').onchange=async e=>{try{const file=e.target.files[0];if(!file||file.size>32768)throw Error();manager.importJson(await file.text());sync();status.value='Layout imported.';}catch{status.value='Invalid layout file.';}finally{e.target.value='';}};
document.querySelector('#shell').addEventListener('primecare:workspace-layout',sync);sync();
</script>`;
const html=fixture.replace('__PRIMECARE_LAYOUT_BUNDLE__',result.outputFiles[0].text).replace('<div id="shell">',controls+'<div id="shell">').replace('</html>',behavior+'</html>');
await mkdir('docs/appearance/previews',{recursive:true});await writeFile('docs/appearance/previews/workspace-layout.html',html);
console.log('Built original, isolated, self-contained workspace preview.');
