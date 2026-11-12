import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';
const built=await build({entryPoints:['packages/primecare_ui/web/work-modules.ts'],bundle:true,write:false,format:'esm',platform:'node'});
const {PrimeWorkModule,WorkModuleSession,workMonth}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
const scope={tenantId:'calendar-fixture',userId:'calendar-actor',role:'tenant_admin',dataset:'live'};
for(const locale of ['en','fr','es'])for(let firstWeekday=0;firstWeekday<7;firstWeekday++)test(`calendar headings and date names follow ${locale}, first weekday ${firstWeekday}`,async()=>{
 const {document}=parseHTML('<html><head></head><body><main></main></body></html>');
 const item={id:'Task-A',version:1,title:'Existing all-day task',body:'Retained instructions',date:'2026-11-05',lane:'open',meta:'',actions:[]};
 let writes=0;
 const session=new WorkModuleSession(scope,'calendar',{read:async()=>({scope,module:'calendar',items:[item],lanes:[{id:'open',label:'Open'}],offset:0,total:1,partial:false}),mutate:async()=>{writes++;throw Error('No scheduling change expected');},readItem:async()=>{throw Error('No item read expected');},dispose(){}});
 await session.load();
 const root=document.querySelector('main'),view=new PrimeWorkModule(root,session,{locale,year:2026,month:11,firstWeekday});
 await session.load();assert.equal(session.status,'ready');
 try{
  const dates=workMonth(2026,11,firstWeekday),headings=[...root.querySelectorAll('[data-work-weekday]')];assert.equal(headings.length,7);
  for(let i=0;i<7;i++){
   const date=new Date(dates[i].date+'T00:00:00Z');
   assert.equal(headings[i].textContent,new Intl.DateTimeFormat(locale,{weekday:'narrow',timeZone:'UTC'}).format(date));
   const name=new Intl.DateTimeFormat(locale,{weekday:'long',timeZone:'UTC'}).format(date);
   assert.equal(headings[i].getAttribute('aria-label'),name);assert.equal(headings[i].getAttribute('title'),name);
  }
  assert.equal(root.querySelectorAll('[data-cy^="work-modules-date-2026-"]').length,42);
  const day=root.querySelector('[data-cy="work-modules-date-2026-11-05"]');assert.equal(day.getAttribute('aria-label'),new Intl.DateTimeFormat(locale,{dateStyle:'full',timeZone:'UTC'}).format(new Date('2026-11-05T00:00:00Z')));
  assert.equal(day.querySelector('h3').textContent,new Intl.NumberFormat(locale).format(5));
  assert.equal(day.querySelector('[data-work-card] h3').textContent,item.title);assert.equal(session.current.snapshot.items[0].date,item.date);assert.equal(writes,0);
 }finally{view.dispose();session.dispose();}
});
