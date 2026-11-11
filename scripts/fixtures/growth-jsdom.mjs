import {build} from 'esbuild';
import {JSDOM} from 'jsdom';
import {readFile,mkdtemp,writeFile} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {pathToFileURL} from 'node:url';

// Actual renderer, shell and presentation startup; synthetic HTTP and DOM only.
// This fixture is not browser/layout acceptance or production verification.
if(process.env.PRODUCTION_DATABASE_URL||process.env.GOVERNANCE_DATABASE_URL||process.env.DB_URL)
 throw Error('Production credentials forbidden in managed growth fixtures');
const built=await build({stdin:{contents:`
 export {renderGrowth} from './websites/typescript/src/growth/dashboard';
 export {presentPlatformFixture} from './scripts/fixtures/platform-browser-bootstrap';
 import {registry} from './packages/shared/src/growth/contract';
 export const growthTheme=registry.visual.theme;
`,resolveDir:process.cwd()},bundle:true,write:false,platform:'node',format:'esm'});
const file=join(await mkdtemp(join(tmpdir(),'managed-growth-jsdom-')),'growth.mjs');
await writeFile(file,built.outputFiles[0].text);
const actual=await import(pathToFileURL(file).href);
export const renderGrowth=actual.renderGrowth;
const css=await readFile('websites/typescript/src/styles.css','utf8');
const responsive=css.match(/--primecare-responsive-styles\s*:\s*(1)\s*[;}]/)?.[1];
if(!responsive)throw Error('Actual portal stylesheet must expose its responsive connection');

export function createGrowthDOM(url){
 const dom=new JSDOM('<div id="app"></div>',{url});
 for(const key of ['window','document','location','history','sessionStorage','localStorage',
  'HTMLElement','HTMLInputElement','HTMLSelectElement','HTMLButtonElement','HTMLDetailsElement',
  'HTMLFormElement','HTMLAnchorElement','HTMLTextAreaElement','HTMLDialogElement','Element','Node',
  'FormData','MutationObserver','Event','CustomEvent','KeyboardEvent','MouseEvent','AbortController','AbortSignal'])
  globalThis[key]=dom.window[key];
 globalThis.getComputedStyle=dom.window.getComputedStyle.bind(dom.window);
 // JSDOM does not implement viewport scrolling. These tests assert data/draft
 // behavior; real browser suites retain responsive and scrolling acceptance.
 dom.window.HTMLElement.prototype.scrollTo=()=>{};
 dom.window.HTMLElement.prototype.scrollIntoView=()=>{};
 document.documentElement.style.setProperty('--primecare-responsive-styles',responsive);
 return dom;
}
export function presentGrowth(root,gateway){
 return actual.presentPlatformFixture(root,actual.growthTheme,gateway,
  ()=>actual.renderGrowth(root,gateway));
}
export function closeGrowthDOM(dom){
 dom.window.dispatchEvent(new dom.window.Event('pagehide'));
 dom.window.close();
}
