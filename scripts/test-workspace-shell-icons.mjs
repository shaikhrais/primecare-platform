import test from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';
// Isolate unrelated mount services; exercise the real shell binder and shared icon factory.
const stubs={
 './workspace-customizer':'export const prepareWorkspaceRender=()=>{},clearWorkspaceCustomizer=()=>{};',
 './layout-customizer':'export const mountLayoutCustomizer=()=>{},clearLayoutCustomizer=()=>{},mountPresentationLayout=()=>{};',
 './media-look':'export class BaseMediaLook{};export const applyMediaTokens=()=>{};',
 './sidebar':'export const bindSidebar=()=>{};',
 './navigation':'export const mountNavigation=()=>{};',
};
const bundle=await build({stdin:{contents:"export {bindShell} from './packages/primecare_ui/web/shell';export {shellIcon} from './packages/primecare_ui/web/icons';",resolveDir:process.cwd()},bundle:true,write:false,platform:'node',format:'esm',plugins:[{name:'unrelated-mounts',setup(build){build.onResolve({filter:/^\.\/(workspace-customizer|layout-customizer|media-look|sidebar|navigation)$/},args=>({path:args.path,namespace:'fixture'}));build.onLoad({filter:/.*/,namespace:'fixture'},args=>({contents:stubs[args.path],loader:'ts'}));}}]});
const {bindShell,shellIcon}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
function fixture(direction='ltr'){
 const {document,window}=parseHTML('<html><body><div id="app"><div data-cy="global-navigation"></div><button data-cy="platform-account-link">Account</button><button data-cy="platform-refresh">Refresh</button><button data-cy="platform-logout">Sign out</button></div></body></html>');
 let resolved=direction;Object.defineProperty(document,'defaultView',{configurable:true,value:{getComputedStyle:()=>({direction:resolved})}});
 globalThis.document=document;globalThis.Node=window.Node;globalThis.Element=window.Element;
 const root=document.getElementById('app'),action=root.querySelector('[data-cy=platform-logout]');
 const bind=()=>bindShell(root,'Existing title','en','actor',()=>[]);
 return {root,action,bind,direction:value=>{resolved=value;}};
}
const mirrored=action=>!!action.querySelector('svg g[transform*="scale(-1 1)"]');
test('resolved RTL root mirrors logout even with English locale',()=>{
 const f=fixture('rtl');f.bind();assert.equal(mirrored(f.action),true);assert.equal(f.action.textContent,'Sign out');
 assert.equal(f.action.querySelector('svg').getAttribute('aria-hidden'),'true');assert.equal(f.action.querySelector('svg').classList.contains('shell-icon'),true);
});
test('rebinding refreshes shared direction without replacing the control or its callback',()=>{
 const f=fixture();let clicks=0;f.action.addEventListener('click',()=>clicks++);f.bind();assert.equal(mirrored(f.action),false);
 f.direction('rtl');f.bind();assert.equal(mirrored(f.action),true);assert.equal(f.root.querySelector('[data-cy=platform-logout]')===f.action,true);
 f.action.click();assert.equal(clicks,1);assert.equal(f.action.textContent,'Sign out');
 f.direction('ltr');f.bind();assert.equal(mirrored(f.action),false);assert.equal(f.action.querySelectorAll('svg').length,1);
});
test('an existing shared mirrored icon is normalized to resolved LTR',()=>{
 const f=fixture();f.action.insertAdjacentHTML('afterbegin',shellIcon('logout',{rtl:true}));f.bind();assert.equal(mirrored(f.action),false);
});
test('caller-owned custom SVG and its accessible control name remain untouched',()=>{
 const f=fixture('rtl');f.action.insertAdjacentHTML('afterbegin','<svg data-custom="true"></svg>');const custom=f.action.querySelector('svg');f.bind();
 assert.equal(f.action.querySelector('svg')===custom,true);assert.equal(f.action.textContent,'Sign out');
});
test('non-directional shared action icons retain identical geometry in RTL',()=>{
 const f=fixture();f.bind();const before=['platform-account-link','platform-refresh'].map(id=>f.root.querySelector(`[data-cy=${id}] svg`).outerHTML);
 f.direction('rtl');f.bind();assert.deepEqual(['platform-account-link','platform-refresh'].map(id=>f.root.querySelector(`[data-cy=${id}] svg`).outerHTML),before);
});
