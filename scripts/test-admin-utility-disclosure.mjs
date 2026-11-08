import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {browser} from './fixtures/workspace-owned-children.mjs';
import {Element as ParsedElement} from './fixtures/tenant-review-dom.mjs';

// Actual workspace rendering and handlers, with explicit synthetic transport and
// a visibility-enforcing disclosure model. This is not native browser acceptance.
const source=await readFile('evidence/test-admin-reports-browser.mjs','utf8');
const AsyncFunction=Object.getPrototypeOf(async()=>{}).constructor;
const definitions=[
 {control:'account',step:'Change own password',end:"await page.locator('[data-cy=current-password]')"},
 {control:'logout',step:'Sign out',end:"await page.locator('[data-cy=login-submit]')"},
];
function action(definition){
 const step=source.indexOf("await step('"+definition.step+"'");assert.ok(step>=0);
 const start=source.indexOf('async()=>{',step)+'async()=>{'.length;
 const end=source.indexOf(definition.end,start);assert.ok(end>start);
 return new AsyncFunction('page',source.slice(start,end));
}
async function fixture({open=false,fail='',decoy=false}={}){
 const f=await browser({role:'admin'});await f.render();
 const doc={changed(){}},markup=new ParsedElement(doc);doc.documentElement=markup;
 markup.innerHTML=f.root.innerHTML;
 const utility=markup.querySelector('[data-cy=shell-utilities]');assert.ok(utility);
 assert.equal(utility.tagName,'DETAILS');assert.equal(utility.hasAttribute('open'),false,'Actual workspace markup starts closed');
 assert.equal(utility.children.filter(child=>child.tagName==='SUMMARY').length,1,'Single direct summary');
 for(const control of ['account','logout']){
  const node=markup.querySelector('[data-cy=workspace-'+control+']');assert.ok(node);
  assert.equal(node.closest('details'),utility,'Actual control belongs to the utility disclosure');
 }
 utility.open=open;
 if(decoy){const node=new ParsedElement(doc,'button');node.setAttribute('data-cy','workspace-account');markup.prepend(node);}
 const clicks=[],beforeSession=f.storage.getItem('primecare_session');
 const visible=node=>{for(let parent=node.parentElement;parent;parent=parent.parentElement)if(parent.tagName==='DETAILS'&&!parent.open&&node!==parent.children.find(child=>child.tagName==='SUMMARY'))return false;return true;};
 const locator=(root,selector)=>{
  const nodes=selector===':scope > summary'?root.children.filter(child=>child.tagName==='SUMMARY'):root.querySelectorAll(selector);
  assert.equal(nodes.length,1,'Locator must resolve exactly one scoped target: '+selector);const node=nodes[0];
  return {
   locator:child=>locator(node,child),
   evaluate:async fn=>{if(fail==='evaluate')throw Error('Synthetic disclosure state failure');return fn(node);},
   click:async options=>{
    assert.equal(options,undefined,'Normal interaction only');assert.equal(visible(node),true,'Control hidden by closed details');
    if(node.tagName==='SUMMARY'){
     assert.equal(node.parentElement,utility,'Only the direct utility summary is opened');
     if(fail==='summary')throw Error('Synthetic summary interaction failure');
     clicks.push('summary');utility.open=!utility.open;return;
    }
    if(fail==='action')throw Error('Synthetic utility interaction failure');
    const id=node.getAttribute('data-cy');assert.ok(['workspace-account','workspace-logout'].includes(id));clicks.push(id);
    const bound=f.root.querySelector('[data-cy='+id+']');assert.equal(typeof bound.onclick,'function');
    await bound.onclick({currentTarget:bound,preventDefault(){}});
   },
  };
 };
 return {...f,utility,clicks,beforeSession,page:{locator:selector=>locator(markup,selector)}};
}
function unchanged(f){assert.equal(f.storage.getItem('primecare_session'),f.beforeSession);assert.deepEqual(f.assigned,[]);assert.deepEqual(f.pushes,[]);assert.equal(globalThis.__boundary.signouts.length,0);}

for(const definition of definitions)for(const open of [false,true])test('normal '+definition.control+' interaction, utility initially open='+open,async()=>{
 const f=await fixture({open});await action(definition)(f.page);
 assert.deepEqual(f.clicks,[...(!open?['summary']:[]),'workspace-'+definition.control]);
 if(definition.control==='account'){
  assert.equal(new URL(f.pushes.at(-1),'https://fixture.invalid').pathname,'/success');
  assert.equal(f.storage.getItem('primecare_session'),f.beforeSession);assert.equal(globalThis.__boundary.signouts.length,0);
 }else{
  assert.equal(f.storage.getItem('primecare_session'),null);assert.equal(globalThis.__boundary.signouts.length,1);
  assert.equal(new URL(f.assigned.at(-1),'https://fixture.invalid').pathname,'/login');
 }
});
for(const definition of definitions)test('original unscoped '+definition.control+' callback fails while closed without state changes',async()=>{
 const f=await fixture();const original=new AsyncFunction('page',`await page.locator('[data-cy=workspace-${definition.control}]').click();`);
 await assert.rejects(original(f.page),/Control hidden by closed details/);assert.deepEqual(f.clicks,[]);unchanged(f);
});
for(const definition of definitions)for(const open of [false,true])for(const fail of (open?['evaluate','action']:['evaluate','summary','action']))test(definition.control+' propagates '+fail+' failure while open='+open+' without completing the action',async()=>{
 const f=await fixture({fail,open});await assert.rejects(action(definition)(f.page),/Synthetic .* failure/);
 assert.deepEqual(f.clicks,fail==='action'&&!open?['summary']:[]);unchanged(f);
});
test('Account remains scoped to utilities despite an unrelated same-ID decoy',async()=>{
 const f=await fixture({decoy:true});await action(definitions[0])(f.page);assert.deepEqual(f.clicks,['summary','workspace-account']);
 assert.equal(new URL(f.pushes.at(-1),'https://fixture.invalid').pathname,'/success');assert.equal(f.storage.getItem('primecare_session'),f.beforeSession);
});
for(const accountOpen of [false,true])for(const logoutOpen of [false,true])test('fresh-login disclosures remain independent '+accountOpen+'/'+logoutOpen,async()=>{
 const account=await fixture({open:accountOpen});await action(definitions[0])(account.page);const logout=await fixture({open:logoutOpen});await action(definitions[1])(logout.page);
 assert.deepEqual(account.clicks,[...(!accountOpen?['summary']:[]),'workspace-account']);assert.deepEqual(logout.clicks,[...(!logoutOpen?['summary']:[]),'workspace-logout']);assert.equal(logout.storage.getItem('primecare_session'),null);
});
test('admin acceptance enforces this regression without removing original browser acceptance',async()=>{
 const workflow=await readFile('.github/workflows/admin-website-acceptance.yml','utf8');
 assert.ok(workflow.split('permissions:')[0].includes('scripts/test-admin-utility-disclosure.mjs'));
 assert.match(workflow,/node --test[^\n]+scripts\/test-admin-utility-disclosure\.mjs/);
 assert.match(workflow,/run: node evidence\/test-admin-reports-browser\.mjs/);assert.match(workflow,/contents: read/);
});
